/*
 * ROS Arduino implementation of TeddyRobot
 *
 * (c)2012-2014 Andreas Kobara <abusch@gmx.net>
 */

#include <stdio.h>
#include <stdlib.h>

// Arduino hardware PIN usage
#include "analog_pins.h"
#include "digital_pins.h"

// ROS base libraries
#include <Arduino.h>
#include <ros.h>
#include <ros/time.h>

// ROS messages
#include <std_msgs/Bool.h>
#include <std_msgs/Empty.h>
#include <std_msgs/UInt8.h>
#include <std_msgs/UInt16.h>
#include <std_msgs/ColorRGBA.h>
#include <std_msgs/MultiArrayLayout.h>
#include <std_msgs/MultiArrayDimension.h>
#include <std_msgs/UInt8MultiArray.h>
#include <geometry_msgs/Vector3.h>
#include <sensor_msgs/Range.h>
#include <teddy_odom/PID.h>
#include <teddy_odom/Speed.h>

// Arduino standard hardware libraries
#include "LCD03.h"
#include "LedControl.h"
#include "Adafruit_PWMServoDriver.h"

// Teddy custom arduino libraries
#include "mouthcontrol3.h"
#include "motorcontrol.h"
#include "diff_controller.h"

/**********************/
/* Extension Registry */
/**********************/
ros::NodeHandle nh;
LCD03 lcd;
LedControl mouth = LedControl(ARDUPIN_LEDMUX_DATA, ARDUPIN_LEDMUX_CLK, ARDUPIN_LEDMUX_SEL, 1);
/****************************/
/* END - Extension Registry */
/****************************/

/*****************************************/
/* Heartbeat and Loopcounters - optional */
/*****************************************/
#define HEARTBEAT_RATE           1     // Hz
const int HEARTBEAT_INTERVAL = 1000 / HEARTBEAT_RATE;
unsigned long nexthb = HEARTBEAT_INTERVAL;
bool is_heartbeat_LED_on = 0;
unsigned int loopcounter = 0;
std_msgs::UInt16 loopcounter_msg;
ros::Publisher pub_loopcounter("loopcounter", &loopcounter_msg);
/***********************************************/
/* END - Heartbeat and Loopcounters - optional */
/***********************************************/

/***********************/
/* Sonar configuration */
/***********************/
bool isSonarEnabled = 0;                // enable/disable sonar status
const int PING_INTERVAL = 200;          // Milliseconds between sensor pings (29ms is about the min to avoid cross-sensor echo).
const int SONAR_INTERVAL = 500;         // Milliseconds between sonar ros messages
const int SONAR_MAX_DISTANCE = 200;     // set fixed sonar distance
//
unsigned long ping_timer;
unsigned int cm[4];         // Where the ping distances are fetched.
unsigned int cm_store[4];   // Where the ping distances are stored.
//
void sonarFetch() {                     // Fetch sonar data via I2C
  Wire.requestFrom(0x09, 4);
  int wait = 50;
  while(wait && Wire.available() < 4) {wait--;};
  for (uint8_t i = 0; i < 4; i++) { cm[i] = 0; }
  if (wait>0) { // fetch real I2C data of sonar values if no timeout occured (4 bytes received)
  cm[0] = Wire.read();
  cm[1] = Wire.read();
  cm[2] = Wire.read();
  cm[3] = Wire.read();
  }
  for (uint8_t i = 0; i < 4; i++) { cm_store[i] = cm[i]; }
} // END - sonarFetch()

void sonarEnableCb(const std_msgs::Bool &sonarEnableMsg) {
  isSonarEnabled = sonarEnableMsg.data;
  Wire.begin();
  Wire.beginTransmission(0x09);
  Wire.write(isSonarEnabled);
  Wire.endTransmission();
}

unsigned long sonar_timer;
ros::Subscriber<std_msgs::Bool> sonarEnableSub("/sonar_enable", sonarEnableCb);
sensor_msgs::Range sonar_front_range_msg;
sensor_msgs::Range sonar_left_range_msg;
sensor_msgs::Range sonar_right_range_msg;
sensor_msgs::Range sonar_rear_range_msg;
ros::Publisher pub_sonar_front("sonar_front", &sonar_front_range_msg);
ros::Publisher pub_sonar_left("sonar_left", &sonar_left_range_msg);
ros::Publisher pub_sonar_right("sonar_right", &sonar_right_range_msg);
ros::Publisher pub_sonar_rear("sonar_rear", &sonar_rear_range_msg);
char sonar_front_frameid[] = "/sonar_front_frame";
char sonar_left_frameid[] = "/sonar_left_frame";
char sonar_right_frameid[] = "/sonar_right_frame";
char sonar_rear_frameid[] = "/sonar_rear_frame";
/*****************************/
/* END - Sonar configuration */
/*****************************/

/***************************/
/* MIC/Mouth configuration */
/***************************/
unsigned long mic_timer;
const int MIC_INTERVAL = 300;
const int MOUTH_INTERVAL = 130;
const int mic_threshold=400;       //level to trigger detected noise
int next_mic=0; // cycle through mics to spare time in the loop
unsigned int mic_lr_count=1; // sample counter until averaged
unsigned int mic_c_count=1;
unsigned long mic_avg_l_sample=0; //averaged samples
unsigned long mic_avg_r_sample=0;
unsigned long mic_avg_c_sample=0;
int mic_l_sample=300;            //the value read from microphone each time
int mic_r_sample=300;            //the value read from microphone each time
int mic_c_sample=300;            //the value read from microphone each time

geometry_msgs::Vector3 mic_noise;
ros::Publisher pub_mics("mics", &mic_noise);
/***************************/
/* END - MIC configuration */
/***************************/

/****************************/
/* AMP Volume configuration */
/****************************/
#define MAX9744_I2CADDR 0x4B
uint8_t setVolume = 0;

void volumeCmdCb(const std_msgs::UInt8 &volumeMsg) {
  uint8_t volume = volumeMsg.data;
  // ignore setting the same volume again
  if (volume == setVolume) return;
  if (volume > 63) volume = 63;
  if (volume == 0) {
    // mute and shutdown on zero volume
    digitalWrite(ARDUPIN_AMP_MUTE, LOW);
    digitalWrite(ARDUPIN_AMP_SHUT, LOW);
    setVolume=0;
    return;
  } else {
    // re-enable amp if previously shutdown
    if (setVolume == 0) {
      digitalWrite(ARDUPIN_AMP_SHUT, HIGH);
      digitalWrite(ARDUPIN_AMP_MUTE, HIGH);
    }
  }
  Wire.beginTransmission(MAX9744_I2CADDR);
  Wire.write(volume);
  // update locate volume variable if successful set
  if (Wire.endTransmission() == 0) setVolume=volume;
}

ros::Subscriber<std_msgs::UInt8> ampVolumeSub("/ampVolume", volumeCmdCb);
/***************************/
/* END - AMP configuration */
/***************************/

/***********************/
/* Power configuration */
/***********************/
const int POWER_INTERVAL = 300;
unsigned long power_timer;
geometry_msgs::Vector3 power;
ros::Publisher pub_power("power", &power);
/*****************************/
/* END - Power configuration */
/*****************************/

/********************/
/* IR configuration */
/********************/
unsigned long ir_timer;
const int IR_INTERVAL = 200;
sensor_msgs::Range ir_range_msg;
ros::Publisher pub_ir_range( "ir_range", &ir_range_msg);
char ir_frameid[] = "/ir_ranger";
/**************************/
/* END - IR configuration */
/**************************/

/**********************/
/* Nose configuration */
/**********************/
void noseRGBCb(const std_msgs::ColorRGBA &noseRGBMsg) {
  analogWrite(ARDUPIN_PWM_NOSE_R,int(noseRGBMsg.r));
  analogWrite(ARDUPIN_PWM_NOSE_G,int(noseRGBMsg.g));
  analogWrite(ARDUPIN_PWM_NOSE_B,int(noseRGBMsg.b));
}
ros::Subscriber<std_msgs::ColorRGBA> noseRGBSub("/setNoseColor", noseRGBCb);
/****************************/
/* END - Nose configuration */
/****************************/

/*********************/
/* PID configuration */
/*********************/
#define PID_RATE 30
const int PID_INTERVAL = 1000 / PID_RATE;
unsigned long pid_timer = PID_INTERVAL;
void setPIDCb(const teddy_odom::PID &setPIDMsg) {
  Kp = setPIDMsg.Kp;
  Ki = setPIDMsg.Ki;
  Kd = setPIDMsg.Kd;
  Ko = setPIDMsg.Ko;
}
ros::Subscriber<teddy_odom::PID> pidSetupSub("/setPID", setPIDCb);
/***************************/
/* END - PID configuration */
/***************************/

/***************************/
/* PWM/Servo configuration */
/***************************/
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x40);
#define SERVOMIN  150 // this is the 'minimum' pulse length count (out of 4096)
#define SERVOMAX  600 // this is the 'maximum' pulse length count (out of 4096)
uint8_t servoData[2];
void servoCmdCb(const std_msgs::UInt8MultiArray &servoRGBMsg) {
  //using message for two uint8 channel, degree
  memcpy(servoRGBMsg.data,servoData,2*sizeof(uint8_t));
  uint16_t pulselen = map(servoData[1], 0, 180, SERVOMIN, SERVOMAX);
  pwm.setPWM(servoData[0], 0, pulselen);
}
ros::Subscriber<std_msgs::UInt8MultiArray> servoRGBSub("/setServoPWM", servoCmdCb);
/*********************************/
/* END - PWM/Servo configuration */
/*********************************/

/**********************************/
/* Neopixel Eyelids configuration */
/**********************************/
#define EYEI2CADDR 17
unsigned long eyelidtimer;
const int EYELID_INTERVAL = 300;
void eyelidRGBCb(const std_msgs::ColorRGBA &eyelidRGBMsg) {
  if ( (millis()-eyelidtimer) > EYELID_INTERVAL) {
    Wire.beginTransmission(EYEI2CADDR);
    Wire.write(uint8_t(eyelidRGBMsg.a));
    Wire.write(uint8_t(eyelidRGBMsg.r));
    Wire.write(uint8_t(eyelidRGBMsg.g));
    Wire.write(uint8_t(eyelidRGBMsg.b));
    Wire.endTransmission();
    eyelidtimer=millis();
  }
}
ros::Subscriber<std_msgs::ColorRGBA> eyelidRGBSub("/setEyeColor", eyelidRGBCb);
/********************************/
/* END - Neopixel configuration */
/********************************/

/*******************************/
/* Motor/Encoder configuration */
/*******************************/
unsigned long md25_watchdog_timer;
unsigned long encoder_timer;
#define AUTO_STOP_INTERVAL 10000
const int ENCODER_INTERVAL = 200;
long lastMotorCommand = AUTO_STOP_INTERVAL;
int16_t desiredSpeedLeft, desiredSpeedRight;
void motorCmdCb(const teddy_odom::Speed &motorCmdMsg) {
  desiredSpeedLeft = motorCmdMsg.left;
  desiredSpeedRight = motorCmdMsg.right;
  lastMotorCommand = millis();
  if (desiredSpeedLeft==0 && desiredSpeedRight==0) {
        moving=0;
        setMotorSpeeds(0,0);
  } else { moving=1; }
  leftPID.TargetTicksPerFrame = desiredSpeedLeft;
  rightPID.TargetTicksPerFrame = desiredSpeedRight;
}
ros::Subscriber<teddy_odom::Speed> motorCmdSub("/setSpeeds", motorCmdCb);
geometry_msgs::Vector3 motorVA;
ros::Publisher pub_motorva("motorva", &motorVA);
geometry_msgs::Vector3 encoder;
ros::Publisher pub_encoders("encoders", &encoder);
void encoderResetCb(const std_msgs::Empty &encoderResetMsg) {
  resetEncoders();
}
ros::Subscriber<std_msgs::Empty> encoderResetSub("/encoders_reset", encoderResetCb);
/*************************************/
/* END - Motor/Encoder configuration */
/*************************************/

/****************/
/* MAIN - Setup */
/****************/
void setup()
{
  // PIN - Setup
  pinMode(ARDUPIN_HEARTBEAT_LED, OUTPUT);
  digitalWrite(ARDUPIN_HEARTBEAT_LED, LOW);
  pinMode(ARDUPIN_ANALOG_MIC_L, INPUT);
  pinMode(ARDUPIN_ANALOG_MIC_C, INPUT);
  pinMode(ARDUPIN_ANALOG_MIC_R, INPUT);
  pinMode(ARDUPIN_ANALOG_VOLTAGE, INPUT);
  pinMode(ARDUPIN_ANALOG_CURRENT, INPUT);
  pinMode(ARDUPIN_ANALOG_IR, INPUT);

  // LCD - Setup
  lcd.begin(20, 4); // Initialize a 20x4 LCD
  lcd.backlight(); // Turn on the backlight
  lcd.clear(); // Clear the LCD

  // AMP - Setup
  pinMode(ARDUPIN_AMP_MUTE, OUTPUT);
  pinMode(ARDUPIN_AMP_SHUT, OUTPUT);

  // Nose - Setup
  pinMode(ARDUPIN_PWM_NOSE_R, OUTPUT);
  pinMode(ARDUPIN_PWM_NOSE_G, OUTPUT);
  pinMode(ARDUPIN_PWM_NOSE_B, OUTPUT);
  analogWrite(ARDUPIN_PWM_NOSE_R,0);
  analogWrite(ARDUPIN_PWM_NOSE_G,0);
  analogWrite(ARDUPIN_PWM_NOSE_B,0);

  // Mouth - Setup
  mouth.shutdown(0,false); // disable max7221 powersave
  mouth.setIntensity(0,15); // set brightness
  mouth.clearDisplay(0); // turn off all lights
  mouthtimer=millis();
  mouthcounter=0;

  // Neopixel Eyelids - Setup
  eyelidtimer=millis();

  // IR - Setup
  ir_range_msg.radiation_type = sensor_msgs::Range::INFRARED;
  ir_range_msg.header.frame_id =  ir_frameid;
  ir_range_msg.field_of_view = 0.001;
  ir_range_msg.min_range = 0.1;
  ir_range_msg.max_range = 0.8;

  // PWM/Servo - Setup
  pwm.setPWMFreq(300); // digital servo PWM refresh frequency

  // SONAR - Setup
  sonar_front_range_msg.radiation_type = sensor_msgs::Range::ULTRASOUND;
  sonar_front_range_msg.header.frame_id =  sonar_front_frameid;
  sonar_front_range_msg.field_of_view = 0.523598775;
  sonar_front_range_msg.min_range = 0.02;
  sonar_front_range_msg.max_range = (float)SONAR_MAX_DISTANCE/100;
  //
  sonar_left_range_msg.radiation_type = sensor_msgs::Range::ULTRASOUND;
  sonar_left_range_msg.header.frame_id =  sonar_left_frameid;
  sonar_left_range_msg.field_of_view = 0.523598775;
  sonar_left_range_msg.min_range = 0.02;
  sonar_left_range_msg.max_range = (float)SONAR_MAX_DISTANCE/100;
  //
  sonar_right_range_msg.radiation_type = sensor_msgs::Range::ULTRASOUND;
  sonar_right_range_msg.header.frame_id =  sonar_right_frameid;
  sonar_right_range_msg.field_of_view = 0.523598775;
  sonar_right_range_msg.min_range = 0.02;
  sonar_right_range_msg.max_range = (float)SONAR_MAX_DISTANCE/100;
  //
  sonar_rear_range_msg.radiation_type = sensor_msgs::Range::ULTRASOUND;
  sonar_rear_range_msg.header.frame_id =  sonar_rear_frameid;
  sonar_rear_range_msg.field_of_view = 0.523598775;
  sonar_rear_range_msg.min_range = 0.02;
  sonar_rear_range_msg.max_range = (float)SONAR_MAX_DISTANCE/100;
  //
  for (uint8_t i = 0; i < 4; i++) { cm_store[i] = 0; }

  // Motor/Encoder - Setup
  initMotorController();

  // ROS - Setup
  nh.getHardware()->setBaud(250000); // communicate with rosserial_python/serial_node.py with 250000 baud
  nh.initNode();
  nh.advertise(pub_ir_range);
  nh.subscribe(sonarEnableSub);
  nh.subscribe(encoderResetSub);
  nh.subscribe(pidSetupSub);
  nh.subscribe(motorCmdSub);
  nh.subscribe(noseRGBSub);
  nh.subscribe(eyelidRGBSub);
  nh.subscribe(servoRGBSub);
  nh.subscribe(ampVolumeSub);
  nh.advertise(pub_loopcounter);
  nh.advertise(pub_sonar_front);
  nh.advertise(pub_sonar_left);
  nh.advertise(pub_sonar_right);
  nh.advertise(pub_sonar_rear);
  nh.advertise(pub_encoders);
  nh.advertise(pub_motorva);
  nh.advertise(pub_power);
  nh.advertise(pub_mics);

} // END - setup()
/********************/
/* END MAIN - Setup */
/********************/

//We average the analog reading to eliminate some of the noise
int averageAnalog(int pin){
 int v=0;
      for(int i=0; i<4; i++) v+= analogRead(pin);
      return v/4;
} // END - averageAnalog()

float getIrRange(int pin_num){
    int sample;
    sample = averageAnalog(pin_num)/4;
    // if the ADC reading is too low,
    //   then we are really far away from anything
    if(sample < 10)
        return 254;     // max range
    // Magic numbers to get cm
    sample= (6787/(sample-3))-4;
    return (float)sample/100; //convert to meters
} // END - getIrRange()

/***************/
/* MAIN - Loop */
/***************/
void loop()
{
  // Heartbeat - Loop and LCD Update
  loopcounter++;
  if (millis() > nexthb) {
    if (is_heartbeat_LED_on) {
      digitalWrite(ARDUPIN_HEARTBEAT_LED, LOW);
      is_heartbeat_LED_on = 0;
    } else {
      digitalWrite(ARDUPIN_HEARTBEAT_LED, HIGH);
      is_heartbeat_LED_on = 1;
        // Clear as long as we do not print all 16 digits per line
        lcd.clear();
        // Set the cursor to the top left
        lcd.home();
        // Print the uptime in millis
        lcd.print("Uptime/sec: "); lcd.print(millis()/1000); lcd.newLine();
        lcd.print("Loops/HB: "); lcd.print(loopcounter); lcd.newLine();
        lcd.print("Motor L:"); lcd.print(desiredSpeedLeft);
        lcd.print(" R:"); lcd.print(desiredSpeedRight); lcd.newLine();
        lcd.print("E L:"); lcd.print((int)encoder.x);
        lcd.print(" R:"); lcd.print((int)encoder.y);
        loopcounter_msg.data=loopcounter;
        pub_loopcounter.publish(&loopcounter_msg);
    }
    //Serial.println("heartbeat");
    nexthb += HEARTBEAT_INTERVAL;
    loopcounter=0;
  }

  //MIC - Noise detection - runs all times to catch enough samples
  switch (next_mic) {
	case 1:
        	// analogread very close in time left and right mics
                mic_l_sample += analogRead(ARDUPIN_ANALOG_MIC_L);
                mic_r_sample += analogRead(ARDUPIN_ANALOG_MIC_R);
                mic_l_sample += analogRead(ARDUPIN_ANALOG_MIC_L);
                mic_r_sample += analogRead(ARDUPIN_ANALOG_MIC_R);
                mic_l_sample += analogRead(ARDUPIN_ANALOG_MIC_L);
                mic_r_sample += analogRead(ARDUPIN_ANALOG_MIC_R);
                mic_l_sample += analogRead(ARDUPIN_ANALOG_MIC_L);
                mic_r_sample += analogRead(ARDUPIN_ANALOG_MIC_R);
                mic_lr_count += 4;
		next_mic++;
		break;
	case 2:
		mic_c_sample += averageAnalog(ARDUPIN_ANALOG_MIC_C);
		mic_c_count++;
		next_mic=0;
		break;
	default:
		next_mic++;
	}
  if ( (millis()-mic_timer) > MIC_INTERVAL){
	mic_avg_c_sample = mic_c_sample/mic_c_count;
	mic_avg_l_sample = mic_l_sample/mic_lr_count;
	mic_avg_r_sample = mic_r_sample/mic_lr_count;
    if (mic_avg_c_sample>mic_threshold || mic_avg_l_sample>mic_threshold || mic_avg_r_sample>mic_threshold) {
      mic_noise.x = (float)mic_avg_l_sample;
      mic_noise.y = (float)mic_avg_r_sample;
      mic_noise.z = (float)mic_avg_c_sample;
      pub_mics.publish(&mic_noise);
    }
    mic_c_count=mic_lr_count=1;
    mic_c_sample=mic_l_sample=mic_r_sample=300;
    mic_timer += MIC_INTERVAL;
  } // END - MIC Noise sampling

  // Power - Loop
  if ( (millis()-power_timer) > POWER_INTERVAL){
    power.x = (float)averageAnalog(ARDUPIN_ANALOG_CURRENT);
    power.y = (float)averageAnalog(ARDUPIN_ANALOG_VOLTAGE);
    power.z = (float)0.0;
    pub_power.publish(&power);
    power_timer += POWER_INTERVAL;
  }

  // IR - Loop
  if ( (millis()-ir_timer) > IR_INTERVAL){
    ir_timer += IR_INTERVAL;
    ir_range_msg.range = getIrRange(ARDUPIN_ANALOG_IR);
    ir_range_msg.header.stamp = nh.now();
    pub_ir_range.publish(&ir_range_msg);
  }

  // SONAR - Loop
  if (isSonarEnabled) {
      if ( (millis()-ping_timer) > PING_INTERVAL){
        ping_timer += PING_INTERVAL;
        sonarFetch();
      }
    //
    //FIXME only publish on value change maybe better ?
    if ( (millis()-sonar_timer) > SONAR_INTERVAL) {
      sonar_front_range_msg.range = (float) cm_store[0]/100;
      sonar_front_range_msg.header.stamp = nh.now();
      pub_sonar_front.publish(&sonar_front_range_msg);
      sonar_left_range_msg.range = (float) cm_store[1]/100;
      sonar_left_range_msg.header.stamp = sonar_left_range_msg.header.stamp;
      pub_sonar_left.publish(&sonar_left_range_msg);
      sonar_right_range_msg.range = (float) cm_store[2]/100;
      sonar_right_range_msg.header.stamp = sonar_right_range_msg.header.stamp;
      pub_sonar_right.publish(&sonar_right_range_msg);
      sonar_rear_range_msg.range = (float) cm_store[3]/100;
      sonar_rear_range_msg.header.stamp = sonar_rear_range_msg.header.stamp;
      pub_sonar_rear.publish(&sonar_rear_range_msg);
      sonar_timer = millis() + SONAR_INTERVAL;
    }
  } // END - if(isSonarEnabled)

  // PID - Loop
  if (millis() > pid_timer) {;
    // set motor speeds according to PID state
    updatePID();
    // Publish motor 1+2 current and voltage
    motorVA.x = (float)getMotor1Current()/10;
    motorVA.y = (float)getMotor2Current()/10;
    motorVA.z = (float)getMotorVolts()/10;
    pub_motorva.publish(&motorVA);
    pid_timer += PID_INTERVAL;;
  }

  // Motor/Encoder - Loop
  // Check to see if we have exceeded the auto-stop interval
  if ((millis() - lastMotorCommand) > AUTO_STOP_INTERVAL) {;
    setMotorSpeeds(0, 0);
    moving = 0;
  }
  if ( (millis()-encoder_timer) > ENCODER_INTERVAL) {
    encoder_timer += ENCODER_INTERVAL;
    encoder.z = 0.0;
    //multiply with -1.0 to negate the encoder values
    // positive values are now forward instead of reverse
    encoder.x = -1.0*(float)readEncoder(LEFT);
    encoder.y = -1.0*(float)readEncoder(RIGHT);
    pub_encoders.publish(&encoder);
  }
  if ( (millis()-md25_watchdog_timer) > 1600) {
    //FIXME: seems only to work with a motor/speed command
    int motorVolts=getMotorVolts();
    md25_watchdog_timer = millis() + 1600;
  }

  // Mouth - Loop
  if ( (millis()-mouthtimer) > MOUTH_INTERVAL) {
        mouthtimer=millis();
        if (true) { // placeholder for "isSpeaking"
        switch(mouthcounter) {
          case 0:  setSprite(mouth13,mouth); break;
          case 1:  setSprite(mouth4,mouth); break;
          case 2:  setSprite(mouth3,mouth); break;
          case 3:  setSprite(mouth2,mouth); break;
          case 4:  setSprite(mouth3,mouth); break;
          case 5:  setSprite(mouth2,mouth); break;
          case 6:  setSprite(mouth3,mouth); break;
          case 7:  setSprite(mouth4,mouth); break;
          case 8:  setSprite(mouth3,mouth); break;
          case 9:  setSprite(mouth2,mouth); break;
          case 10:  setSprite(mouth3,mouth); break;
          case 11:  setSprite(mouth4,mouth); break;
          case 12:  setSprite(mouth13,mouth); break;
          case 13:  setSprite(mouth13,mouth); break;
          case 14:  setSprite(mouth13,mouth); break;
          case 15:  setSprite(mouth13,mouth); break;
        }
       mouthcounter++;
       if (mouthcounter>=15) mouthcounter=0;
       }
/*
    switch(mouthcounter) {
      case 0:  setSprite(test0,mouth); break;
      case 1:  setSprite(test1,mouth); break;
      case 2:  setSprite(test2,mouth); break;
      case 3:  setSprite(test3,mouth); break;
      case 4:  setSprite(test4,mouth); break;
      case 5:  setSprite(test5,mouth); break;
      case 6:  setSprite(test6,mouth); break;
      case 7:  setSprite(test7,mouth); break;
      case 8:  setSprite(test8,mouth); break;
      case 9:  setSprite(test9,mouth); break;
      case 10:  setSprite(test10,mouth); break;
      case 11:  setSprite(test11,mouth); break;
      case 12:  setSprite(test12,mouth); break;
      case 13:  setSprite(test13,mouth); break;
      case 14:  setSprite(test14,mouth); break;
      case 15:  setSprite(test15,mouth); break;
    }
*/
  }

  // ROS - SPIN
  nh.spinOnce();

} // END - loop()
/*******************/
/* END MAIN - Loop */
/*******************/
