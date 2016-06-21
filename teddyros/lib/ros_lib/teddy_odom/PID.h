#ifndef _ROS_teddy_odom_PID_h
#define _ROS_teddy_odom_PID_h

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "ros/msg.h"

namespace teddy_odom
{

  class PID : public ros::Msg
  {
    public:
      int8_t Kp;
      int8_t Ki;
      int8_t Kd;
      int8_t Ko;

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      union {
        int8_t real;
        uint8_t base;
      } u_Kp;
      u_Kp.real = this->Kp;
      *(outbuffer + offset + 0) = (u_Kp.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->Kp);
      union {
        int8_t real;
        uint8_t base;
      } u_Ki;
      u_Ki.real = this->Ki;
      *(outbuffer + offset + 0) = (u_Ki.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->Ki);
      union {
        int8_t real;
        uint8_t base;
      } u_Kd;
      u_Kd.real = this->Kd;
      *(outbuffer + offset + 0) = (u_Kd.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->Kd);
      union {
        int8_t real;
        uint8_t base;
      } u_Ko;
      u_Ko.real = this->Ko;
      *(outbuffer + offset + 0) = (u_Ko.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->Ko);
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      union {
        int8_t real;
        uint8_t base;
      } u_Kp;
      u_Kp.base = 0;
      u_Kp.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->Kp = u_Kp.real;
      offset += sizeof(this->Kp);
      union {
        int8_t real;
        uint8_t base;
      } u_Ki;
      u_Ki.base = 0;
      u_Ki.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->Ki = u_Ki.real;
      offset += sizeof(this->Ki);
      union {
        int8_t real;
        uint8_t base;
      } u_Kd;
      u_Kd.base = 0;
      u_Kd.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->Kd = u_Kd.real;
      offset += sizeof(this->Kd);
      union {
        int8_t real;
        uint8_t base;
      } u_Ko;
      u_Ko.base = 0;
      u_Ko.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->Ko = u_Ko.real;
      offset += sizeof(this->Ko);
     return offset;
    }

    const char * getType(){ return "teddy_odom/PID"; };
    const char * getMD5(){ return "0744240a8f71904a976e66e3115caabd"; };

  };

}
#endif
