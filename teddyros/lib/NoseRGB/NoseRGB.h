#ifndef NoseRGB_h
#define NoseRGB_h

class NoseRGB
{
  public:

    // 300Ohm Resistor for LEDS on 5V was OK
    int RedLED;//Connect Red led to Digital pin 9
    int GreenLED;//Connect Green led to Digital pin 11
    int BlueLED; //Connect Blue led to Digital pin 8
    // initilaize PWM with 0=off
    int RedPWM;
    int GreenPWM;
    int BluePWM;

    void init(int RedLED, int GreenLED, int BlueLED); // output pins
    void clearRGB();
    void randomRGB();
    void setRGB(int RedPWM=0,int GreenPWM=0,int BluePWM=0);
    void test();
};

#endif
