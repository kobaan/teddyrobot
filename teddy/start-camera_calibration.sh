#!/bin/bash
. /opt/ros/indigo/setup.bash

export ROS_PACKAGE_PATH=/home/kobaan/ros_ws1/src:/opt/ros/indigo/share
export ROS_LOG_DIR=/run/shm/rosLogs
mkdir -p $ROS_LOG_DIR


#export ROS_MASTER_URI=http://10.1.1.210:11311

roslaunch /teddy/launch/stereo.launch & disown

rosrun camera_calibration cameracalibrator.py --size 8x6 --square 0.108 right:=/camera/right/image_raw left:=/camera/left/image_raw right_camera:=/camera/right left_camera:=/camera/left

# insert results into:
# /opt/ros/indigo/share/gscam/examples/pseye_left.ini
# /opt/ros/indigo/share/gscam/examples/pseye_right.ini
# so /teddy/launch/stereo.launch can read it
