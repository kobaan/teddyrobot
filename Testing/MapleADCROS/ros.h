#ifndef _ROS_H_
#define _ROS_H_
#include "ros/node_handle.h"
#include "MapleHardware.h"

namespace ros
{
    typedef NodeHandle_<MapleHardware> NodeHandle;
}
#endif

