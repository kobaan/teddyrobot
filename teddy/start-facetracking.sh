#!/bin/bash
export ROS_PACKAGE_PATH=/home/kobaan/ros_ws1/src:/opt/ros/indigo/share
export ROS_LOG_DIR=/run/shm/rosLogs
mkdir -p $ROS_LOG_DIR


#export ROS_MASTER_URI=http://10.1.1.210:11311

#on cubie: /teddy/start-dynamixel.sh
#on pyongyang: /teddy/start-stereo.sh
#on pyongyang: /teddy/start-mjpeg_server.sh to see on PTZ cam: http://teddy.spacetechnology.net/robot/teddy/index.html
cd /home/kobaan/ros_ws1/src/teddy_tracking/src
python ./teddy_face_tracker.py & disown
python ./teddy_tracking.py & disown
