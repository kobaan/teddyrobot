#include "Arduino.h"
#include <Wire.h>
#include "MD25.h"

void MD25::init(){
  Wire.begin();
  encodeReset();                                            // Cals a function that resets the encoder values to 0
}

void MD25::setM1Speed(int speed){
    Wire.beginTransmission(MD25ADDRESS);                    // Drive motor 2 at speed value stored in x
    Wire.write(SPEED1);
    Wire.write(speed);
    Wire.endTransmission();
}

void MD25::setM2Speed(int speed){
    Wire.beginTransmission(MD25ADDRESS);                    // Drive motor 2 at speed value stored in x
    Wire.write(SPEED2);
    Wire.write(speed);
    Wire.endTransmission();
}

char MD25::getSoft(){                                       // Function that gets the software version
  Wire.beginTransmission(MD25ADDRESS);                      // Send byte to read software version as a single byte
  Wire.write(SOFTWAREREG);
  Wire.endTransmission();

  Wire.requestFrom(MD25ADDRESS, 1);                         // request 1 byte form MD25
  while(Wire.available() < 1);                              // Wait for it to arrive
  char software = Wire.read();                              // Read it in
  return(software);
}

void MD25::encodeReset(){                                   // This function resets the encoder values to 0
  Wire.beginTransmission(MD25ADDRESS);
  Wire.write(CMD);
  Wire.write(RESETENCODERS);                                // Putting the value 0x20 to reset encoders
  Wire.endTransmission();
}

void MD25::enableAcceleration(bool accel){                  // This function turns on/off auto acceleration
  Wire.beginTransmission(MD25ADDRESS);
  Wire.write(CMD);
  if (accel==1) { Wire.write(ACCELON); }                                       
  else { Wire.write(ACCELOFF); }
  Wire.endTransmission();
}

void MD25::setMode(int mode){                               // This function sets the drive mode (0-128-255/-128-0-127/and others)
  Wire.beginTransmission(MD25ADDRESS);
  Wire.write(MODE);
  Wire.write(mode);                                         // Putting the value 0x01 to change from default to -128-0-127 mode
  Wire.endTransmission();
}

long MD25::encoder1(){                                      // Function to read and display value of encoder 1 as a long
  Wire.beginTransmission(MD25ADDRESS);                      // Send byte to get a reading from encoder 1
  Wire.write(ENCODERONE);
  Wire.endTransmission();

  Wire.requestFrom(MD25ADDRESS, 4);                         // Request 4 bytes from MD25
  while(Wire.available() < 4);                              // Wait for 4 bytes to arrive
  long poss1 = Wire.read();                                 // First byte for encoder 1, HH.
  poss1 <<= 8;
  poss1 += Wire.read();                                     // Second byte for encoder 1, HL
  poss1 <<= 8;
  poss1 += Wire.read();                                     // Third byte for encoder 1, LH
  poss1 <<= 8;
  poss1  +=Wire.read();                                     // Fourth byte for encoder 1, LL
  return(poss1);
}

long MD25::encoder2(){                                      // Function to read and display velue of encoder 2 as a long
  Wire.beginTransmission(MD25ADDRESS);
  Wire.write(ENCODERTWO);
  Wire.endTransmission();

  Wire.requestFrom(MD25ADDRESS, 4);                         // Request 4 bytes from MD25
  while(Wire.available() < 4);                              // Wait for 4 bytes to become available
  long poss2 = Wire.read();
  poss2 <<= 8;
  poss2 += Wire.read();
  poss2 <<= 8;
  poss2 += Wire.read();
  poss2 <<= 8;
  poss2  +=Wire.read();
  return(poss2);
}

int MD25::volts(){                                          // Function to read and display battery volts as a single byte
  Wire.beginTransmission(MD25ADDRESS);                      // Send byte to read volts
  Wire.write(VOLTREAD);
  Wire.endTransmission();

  Wire.requestFrom(MD25ADDRESS, 1);
  while(Wire.available() < 1);
  int MD25Volts = Wire.read();
  return(MD25Volts);
}

int MD25::current1(){                                       // Function to read and display current of motor1 as a single byte
  Wire.beginTransmission(MD25ADDRESS);                      // Send byte to read current
  Wire.write(CURR1READ);
  Wire.endTransmission();

  Wire.requestFrom(MD25ADDRESS, 1);
  while(Wire.available() < 1);
  int MD25Curr1 = Wire.read();
  return(MD25Curr1);
}

int MD25::current2(){                                       // Function to read and display current of motor2 as a single byte
  Wire.beginTransmission(MD25ADDRESS);                      // Send byte to read current
  Wire.write(CURR2READ);
  Wire.endTransmission();

  Wire.requestFrom(MD25ADDRESS, 1);
  while(Wire.available() < 1);
  int MD25Curr2 = Wire.read();
  return(MD25Curr2);
}

void MD25::stopMotor(){                                    // Function to stop motors
  Wire.beginTransmission(MD25ADDRESS);
  Wire.write(SPEED2);
  Wire.write(0);                                           // Sends a value of 0 to motors, given using drive mode 1
  Wire.endTransmission();

  Wire.beginTransmission(MD25ADDRESS);
  Wire.write(SPEED1);
  Wire.write(0);
  Wire.endTransmission();
}
