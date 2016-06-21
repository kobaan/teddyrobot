#include "Arduino.h"
#include "NoseRGB.h"

void NoseRGB::clearRGB()
{
  analogWrite(RedLED,  0); // turn off R-LED
  analogWrite(GreenLED,0); // turn off G-LED
  analogWrite(BlueLED, 0); // turn off B-LED
}

void NoseRGB::init(int RedLED=9, int GreenLED=11, int BlueLED=8)
{
  // Maple setup of PWM Pins
  pinMode(RedLED,  OUTPUT);
  pinMode(GreenLED,OUTPUT);
  pinMode(BlueLED, OUTPUT);
  analogWrite(RedLED,  0); // turn off R-LED on init
  analogWrite(GreenLED,0); // turn off G-LED on init
  analogWrite(BlueLED, 0); // turn off B-LED on init
}

void NoseRGB::randomRGB()
{
  analogWrite(RedLED,  random(255));
  analogWrite(GreenLED,random(255));
  analogWrite(BlueLED, random(255));
}

void NoseRGB::setRGB(int RedPWM, int GreenPWM, int BluePWM)
{
  analogWrite(RedLED,   RedPWM);
  analogWrite(GreenLED, GreenPWM);
  analogWrite(BlueLED,  BluePWM);
}

void NoseRGB::test()
{
  randomRGB();
  delay(1000);
  setRGB(255,0,0);
  delay(100);
  setRGB(0,255,0);
  delay(100);
  setRGB(0,0,255);
  delay(100);
}
