#ifndef ROS_MAPLE_HARDWARE_H_
#define ROS_MAPLE_HARDWARE_H_

#include <maple.h>
#include <WProgram.h>
#include <HardwareSerial.h>

class MapleHardware {
  public:
    MapleHardware(HardwareSerial* io , long baud= 57600){
      iostream = io;
      baud_ = baud;
    }
    MapleHardware()
    {
      iostream = &SerialUSB;
      baud_ = 57600;
    }
    MapleHardware(MapleHardware& h){
      this->iostream = iostream;
      this->baud_ = h.baud_;
    }
  
    void setBaud(long baud){
      this->baud_= baud;
    }
  
    int getBaud(){return baud_;}

    void init(){
      iostream->begin(baud_);
    }

    int read(){return iostream->read();};
    void write(uint8_t* data, int length){
      for(int i=0; i<length; i++)
        iostream->write(data[i]);
    }

    unsigned long time(){return millis();}

  protected:
    HardwareSerial* iostream;
    long baud_;
};

#endif
