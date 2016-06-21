#include "Arduino.h"
#include "MD25.h"
#include "motorcontrol.h"

MD25 drive;
bool LEFT = 1;
bool RIGHT = 0;

  /* Wrap the motor driver initialization */
  void initMotorController() {
    drive.init();
    drive.setMode(1);
    drive.enableAcceleration(0);
  }
  /* Wrap the drive motor set speed function */
  void setMotorSpeed(bool i, int spd) {
    if (i == LEFT) drive.setM2Speed(spd);
    else drive.setM1Speed(spd);
  }
  // A convenience function for setting both motor speeds
  void setMotorSpeeds(int leftSpeed, int rightSpeed) {
    // emergency stop on wrong values
    if ((leftSpeed > 127) || (rightSpeed > 127)) {
      leftSpeed=0; rightSpeed=0; moving=0;
    }
    if ((leftSpeed < -128) || (rightSpeed < -128)) {
      leftSpeed=0; rightSpeed=0; moving=0;
    }
    setMotorSpeed(LEFT, leftSpeed);
    setMotorSpeed(RIGHT, rightSpeed);
  }
  /* Wrap the encoder reading function */
  long readEncoder(bool i) {
    if (i == LEFT) return (long)drive.encoder2();
    else return (long)drive.encoder1();
  }
  /* Wrap the encoder reset function */
  void resetEncoders() {
    drive.encodeReset();
  }
  /* Wrap the motor voltage function */
  int getMotorVolts() {
    return drive.volts();
  }
  /* Wrap the motor1 current function */
  int getMotor1Current() {
    return drive.current1();
  }
  /* Wrap the motor2 current function */
  int getMotor2Current() {
    return drive.current2();
  }
