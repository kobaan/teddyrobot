#ifndef motorcontrol_h
#define motorcontrol_h

extern bool moving;
extern bool LEFT;
extern bool RIGHT;
void initMotorController();
void setMotorSpeed(bool i, int spd);
void setMotorSpeeds(int leftSpeed, int rightSpeed);
long readEncoder(bool i);
void resetEncoders();
int getMotorVolts();
int getMotor1Current();
int getMotor2Current();

#endif // motorcontrol_h
