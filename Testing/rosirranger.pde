#if defined(ARDUINO) && ARDUINO >= 100
  #include "Arduino.h"
#else
  #include <WProgram.h>
#endif

/* 
 * rosserial IR Ranger Example  
 * 
 * This example is calibrated for the Sharp GP2D120XJ00F.
 */

/* === ROS setup === */
#include <ros.h>
#include <ros/time.h>
#include <std_msgs/Bool.h>
#include <sensor_msgs/Range.h>
ros::NodeHandle  nh;
/* === END - ROS setup === */

/* === IR Ranger === */
sensor_msgs::Range irrange_msg;
const int ir_analog_pin = 0;
unsigned long irrange_timer;
bool ir_enabled = 0;
char irframeid[] = "/ir_ranger";
void irswitch_callback(const std_msgs::Bool &ir_cmd){
  ir_enabled=ir_cmd.data;
}
ros::Subscriber<std_msgs::Bool> irswitch("ir_switch" , irswitch_callback);
ros::Publisher pub_IRrange( "IR_Range_data", &irrange_msg);
/*
 * getIRRange()
 * samples the analog input from the ranger and converts it into meters.
 */
float getIRRange(int pin_num){
    int sample;
    // Get data
    sample = analogRead(pin_num)/4;
    // if the ADC reading is too low, 
    //   then we are really far away from anything
    if(sample < 10)
        return 254;     // max range
    // Magic numbers to get cm
    sample= 1309/(sample-3);
    return (sample - 1)/100; //convert to meters
}
void IRsetup(){
  nh.subscribe(irswitch);
  nh.advertise(pub_IRrange);
  irrange_msg.radiation_type = sensor_msgs::Range::INFRARED;
  irrange_msg.header.frame_id =  irframeid;
  irrange_msg.field_of_view = 0.01;
  irrange_msg.min_range = 0.1;
  irrange_msg.max_range = 0.8;
}
void IRupdate(){
  // publish the range value every 50 milliseconds
  //   since it takes that long for the sensor to stabilize
  if ( (millis()-irrange_timer) > 50){
    irrange_msg.range = getIRRange(ir_analog_pin);
    irrange_msg.header.stamp = nh.now();
    pub_IRrange.publish(&irrange_msg);
    irrange_timer =  millis();
  }
}
/* === END - IR Ranger === */


void setup()
{
  nh.initNode();
  IRsetup();
}

void loop()
{
  if (ir_enabled) IRupdate();
  nh.spinOnce();
  delay(1); // just to give the loop a little break
}







