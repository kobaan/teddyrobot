#!/bin/bash
. /opt/ros/indigo/setup.bash

export ROS_PACKAGE_PATH=/home/kobaan/ros_ws1/src:/opt/ros/indigo/share
export ROS_LOG_DIR=/run/shm/rosLogs
mkdir -p $ROS_LOG_DIR


#export ROS_MASTER_URI=http://10.1.1.210:11311

rosrun gpsd_client gpsd_client _host:=10.1.1.222 _port:=2947 & disown
