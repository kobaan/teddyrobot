#ifndef _ROS_teddy_odom_RGB_h
#define _ROS_teddy_odom_RGB_h

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "ros/msg.h"

namespace teddy_odom
{

  class RGB : public ros::Msg
  {
    public:
      int8_t r;
      int8_t g;
      int8_t b;

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      union {
        int8_t real;
        uint8_t base;
      } u_r;
      u_r.real = this->r;
      *(outbuffer + offset + 0) = (u_r.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->r);
      union {
        int8_t real;
        uint8_t base;
      } u_g;
      u_g.real = this->g;
      *(outbuffer + offset + 0) = (u_g.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->g);
      union {
        int8_t real;
        uint8_t base;
      } u_b;
      u_b.real = this->b;
      *(outbuffer + offset + 0) = (u_b.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->b);
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      union {
        int8_t real;
        uint8_t base;
      } u_r;
      u_r.base = 0;
      u_r.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->r = u_r.real;
      offset += sizeof(this->r);
      union {
        int8_t real;
        uint8_t base;
      } u_g;
      u_g.base = 0;
      u_g.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->g = u_g.real;
      offset += sizeof(this->g);
      union {
        int8_t real;
        uint8_t base;
      } u_b;
      u_b.base = 0;
      u_b.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->b = u_b.real;
      offset += sizeof(this->b);
     return offset;
    }

    const char * getType(){ return "teddy_odom/RGB"; };
    const char * getMD5(){ return "4c4c42c6380fba82a0d3693912d7a219"; };

  };

}
#endif
