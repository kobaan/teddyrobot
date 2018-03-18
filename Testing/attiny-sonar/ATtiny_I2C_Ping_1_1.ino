/*

This sketch runs on an ATtiny85/45 connected to an Arduino running ATtiny_I2C_Ping_Receiver_1_1.ino. 

This sketch gets distance data from an HC-SR04 and transmits it to the Arduino when requested

For details on this sketch and instructions on making this low cost I2C PING sensor, see the link below.
http://projectsfromtech.blogspot.com/2014/01/i2c-hc-sr04-sonar-module-attiny85-i2c.html

 
 Last Updated: 1/9/2014
 Matthew
 http://projectsfromtech.blogspot.com/
 

*/



#include <TinyWireS.h>              // Requires fork by Rambo with onRequest support
#include <TinyNewPing.h>            // NewPing library modified for ATtiny

const byte SensorOnePin = 3;        // Sensor 1 is connected to PB3
const int I2CSlaveAddress = 7;      // I2C Address.

byte Distance;                              // Where the Distance is stored (8 bit unsigned)

#define MAX_DISTANCE 200 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.


NewPing SensorOne (SensorOnePin, SensorOnePin, MAX_DISTANCE);       // Define the Sensor
 

void setup()
{
  delay(100);

  TinyWireS.begin(I2CSlaveAddress);      // Begin I2C Communication
  TinyWireS.onRequest(transmit);         // When requested, call function transmit()

}


void loop()
{
    Distance = SensorOne.ping_cm();        // Get distance in cm. Could be changed to 
    //Distance = SensorOne.ping_median(5)/US_ROUNDTRIP_CM;       // Take the median of 5 readings

    delay(30);                             // Delay to avoid interference from last ping

}  //end loop()



void transmit()
{
  TinyWireS.send(Distance);                 // Send last recorded distance for current sensor
}





