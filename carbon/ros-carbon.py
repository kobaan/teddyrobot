#!/usr/bin/env python
import socket
import time
import rospy
from std_msgs.msg import String, UInt16
from geometry_msgs.msg import Vector3

CARBON_SERVER = '10.1.1.155'
CARBON_PORT = 2003

motorva_last = 0
power_last = 0
encoders_last = 0
loopcounter_last = 0

def listener():
    rospy.init_node('roscarbon', anonymous=True)
    rospy.Subscriber("power", Vector3, power_cb)
    rospy.Subscriber("motorva", Vector3, motorva_cb)
    rospy.Subscriber("encoders", Vector3, encoders_cb)
    rospy.Subscriber("loopcounter", UInt16, loopcounter_cb)
    rospy.spin()

def send_msg(msg):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.sendto(msg, (CARBON_SERVER, CARBON_PORT))

def loopcounter_cb(msg):
    global loopcounter_last
    timestamp = int(time.time())
    if (timestamp - loopcounter_last > 15):
        sensor = "ros.arduino.loop.counter"
        message = "%s %s %d\n" % (sensor, msg.data, timestamp)
        loopcounter_last = timestamp 
        #rospy.loginfo(message)
        send_msg(message)

def encoders_cb(msg):
    global encoders_last
    timestamp = int(time.time())
    if (timestamp - encoders_last > 15):
        sensor = "ros.movement.encoder.left"
        message = "%s %s %d\n" % (sensor, msg.x, timestamp)
        #rospy.loginfo(message)
        send_msg(message)
        sensor = "ros.movement.encoder.right"
        message = "%s %s %d\n" % (sensor, msg.y, timestamp)
        encoders_last = timestamp 
        #rospy.loginfo(message)
        send_msg(message)

def motorva_cb(msg):
    global motorva_last
    timestamp = int(time.time())
    if (timestamp - motorva_last > 15):
        sensor = "ros.power.motor.left.ampere"
        message = "%s %s %d\n" % (sensor, round(msg.x,2), timestamp)
        #rospy.loginfo(message)
        send_msg(message)
        sensor = "ros.power.motor.right.ampere"
        message = "%s %s %d\n" % (sensor, round(msg.y,2), timestamp)
        #rospy.loginfo(message)
        send_msg(message)
        sensor = "ros.power.motor.voltage"
        message = "%s %s %d\n" % (sensor, round(msg.z,2), timestamp)
        motorva_last = timestamp 
        #rospy.loginfo(message)
        send_msg(message)

def power_cb(msg):
    global power_last
    timestamp = int(time.time())
    if (timestamp - power_last > 15):
        sensor = "ros.power.battery.voltage"
        message = "%s %s %d\n" % (sensor, round(msg.x/1023*5*4*109/100,2), timestamp)
        #rospy.loginfo(message)
        send_msg(message)
        sensor = "ros.power.battery.ampere"
        message = "%s %s %d\n" % (sensor, round((msg.y-512)/41*90/100,2), timestamp)
        #rospy.loginfo(message)
        send_msg(message)
        sensor = "ros.power.battery.watts"
        watts = round(msg.x/1023*5*4*109/100*(msg.y-512)/41*90/100,2)
        message = "%s %s %d\n" % (sensor, watts, timestamp)
        power_last = timestamp
        #rospy.loginfo(message)
        send_msg(message)

if __name__ == '__main__':
     listener()   
