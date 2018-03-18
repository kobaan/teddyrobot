/*

This sketch runs on an Arduino connected to an ATtiny85/45 running ATtiny_I2C_Ping_1_1.ino

The data received is HC-SR04 PING sensor data in centimeters

For details on this sketch and instructions on making this low cost I2C PING sensor, see the link below.
http://projectsfromtech.blogspot.com/2014/01/i2c-hc-sr04-sonar-module-attiny85-i2c.html

 
 Last Updated: 1/9/2014
 Matthew
 http://projectsfromtech.blogspot.com/
 
 
 */


#include <Wire.h>

byte Distance;                              // Where the Distance is stored (8 bit unsigned)


void setup()
{
  Wire.begin();
  Serial.begin(57600);
  Serial.println("Setup");
}



void loop()
{
  Wire.requestFrom(7, 1);                  // The TinyWire library only allows for one byte to be requested at a time
  while (Wire.available() == 0)  ;         // Wait until there is data in the I2C buffer

  Distance = Wire.read();                  // Read the first (and hopefully only) byte in the I2C buffer
  Serial.println(Distance);
  delay(30);                               // The sensor only updates every 30 ms. Asking for new data quicker than that is useless


}







