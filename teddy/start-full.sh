#!/bin/bash
cd /teddy
./start-roscore.sh
./start-stereo.sh
./start-stereo_image_proc.sh
./start-mjpeg_server.sh
./start-websocket.sh
./start-rosserial.sh
./start-gpsclient.sh
./start-odom.sh
