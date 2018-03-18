#include <ros.h>
#include <rosserial_maple/Adc.h>

ros::NodeHandle nh;
rosserial_maple::Adc adc_msg;
ros::Publisher p("adc", &adc_msg);

const int analogInputPin0 = 15;
const int analogInputPin1 = 16;
const int analogInputPin2 = 17;
const int analogInputPin3 = 18;
const int analogInputPin4 = 19;
const int analogInputPin5 = 20;

void setup() {
  pinMode(analogInputPin0, INPUT_ANALOG);
  pinMode(analogInputPin1, INPUT_ANALOG);
  pinMode(analogInputPin2, INPUT_ANALOG);
  pinMode(analogInputPin3, INPUT_ANALOG);
  pinMode(analogInputPin4, INPUT_ANALOG);
  pinMode(analogInputPin5, INPUT_ANALOG);
  nh.initNode();
  nh.advertise(p);
}

//We average the analog reading to elminate some of the noise
int averageAnalog(int pin){
  int v=0;
  for(int i=0; i<4; i++) v+= analogRead(pin);
  return v/4;
}

long adc_timer;

void loop() {
  adc_msg.adc0 = averageAnalog(analogInputPin0);
  adc_msg.adc1 = averageAnalog(analogInputPin1);
  adc_msg.adc2 = averageAnalog(analogInputPin2);
  adc_msg.adc3 = averageAnalog(analogInputPin3);
  adc_msg.adc4 = averageAnalog(analogInputPin4);
  adc_msg.adc5 = averageAnalog(analogInputPin5);

  if(SerialUSB.isConnected() && (SerialUSB.getDTR() || SerialUSB.getRTS())) {
    p.publish(&adc_msg);
    //Debug
    SerialUSB.println(adc_msg.adc0);
  }
  nh.spinOnce();
}
