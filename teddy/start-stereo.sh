#!/bin/bash
. /opt/ros/indigo/setup.bash

export ROS_PACKAGE_PATH=/home/kobaan/ros_ws1/src:/opt/ros/indigo/share
export ROS_LOG_DIR=/run/shm/rosLogs
mkdir -p $ROS_LOG_DIR


#export ROS_MASTER_URI=http://1.1.1.210:11311

roslaunch /teddy/launch/stereo.launch & disown