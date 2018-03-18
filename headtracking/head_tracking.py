#!/usr/bin/env python


import rospy
from sensor_msgs.msg import JointState, RegionOfInterest, CameraInfo
from math import radians

class head_track():
    def __init__(self):
        rospy.init_node("head_track")
        rospy.on_shutdown(self.shutdown)

        """ Publish the movement commands on the /cmd_joints topic using the
            JointState message type. """
        self.head_pub = rospy.Publisher("/cmd_joints", JointState)

        self.rate = rospy.get_param("~rate", 10)

        """ The pan/tilt thresholds indicate how many pixels the ROI needs to be off-center
            before we make a movement. """
        self.pan_threshold = int(rospy.get_param("~pan_threshold", 5))
        self.tilt_threshold = int(rospy.get_param("~tilt_threshold", 5))

        """ The k_pan and k_tilt parameter determine how responsive the servo movements are.
            If these are set too high, oscillation can result. """
        self.k_pan = rospy.get_param("~k_pan", 7.0)
        self.k_tilt = rospy.get_param("~k_tilt", 5.0)

        self.max_pan = rospy.get_param("~max_pan", radians(145))
        self.min_pan = rospy.get_param("~min_pan", radians(-145))
        self.max_tilt = rospy.get_param("~max_tilt", radians(90))
        self.min_tilt = rospy.get_param("~min_tilt", radians(-90))
        
        #self.pan_stepsize = rospy.get_param("~pan_stepsize", radians(300/1024))
        #self.tilt_stepsize = rospy.get_param("~tilt_stepsize", radians(300/1024))
        self.pan_stepsize = rospy.get_param("~pan_stepsize", radians(1))
        self.tilt_stepsize = rospy.get_param("~tilt_stepsize", radians(1))
        
        r = rospy.Rate(self.rate)

        self.head_cmd = JointState()
        self.joints = ["head_pan_joint", "head_tilt_joint"]
        self.head_cmd.name = self.joints
        self.head_cmd.position = [0, 0]
        self.head_cmd.velocity = [0, 0]
        self.head_cmd.header.stamp = rospy.Time.now()
        self.head_cmd.header.frame_id = 'head_pan_joint'

        """ Center the head and pan servos at the start. """
        for i in range(3):
            self.head_pub.publish(self.head_cmd)
            rospy.sleep(1)

        self.tracking_seq = 0
        self.last_tracking_seq = -1

        rospy.Subscriber('roi', RegionOfInterest, self.setPanTiltSpeeds)
        rospy.Subscriber('camera/left/camera_info', CameraInfo, self.getCameraInfo)

        while not rospy.is_shutdown():
            """ Publish the pan/tilt movement commands. """
            self.head_cmd.header.stamp = rospy.Time.now()
            self.head_cmd.header.frame_id = 'head_pan_joint'
            if self.last_tracking_seq != self.tracking_seq:
                self.last_tracking_seq = self.tracking_seq
                self.head_pub.publish(self.head_cmd)
            r.sleep()

    def setPanTiltSpeeds(self, msg):
        """ When OpenCV loses the ROI, the message stops updating.  Use this counter to
            determine when it stops. """
        self.tracking_seq += 1

        """ Check to see if we have lost the ROI. """
        if msg.width == 0 or msg.height == 0 or msg.width > self.image_width / 2 or msg.height > self.image_height / 2:
            return

        """ Compute the center of the ROI """
        COG_x = msg.x_offset + msg.width / 2 - self.image_width / 2
        COG_y = msg.y_offset + msg.height / 2 - self.image_height / 2

        """ Pan the camera only if the displacement of the COG exceeds the threshold. """
        if abs(COG_x) > self.pan_threshold:
            if COG_x > 0:
                if self.head_cmd.position[0] >= self.min_pan:
                    self.head_cmd.position[0] -= self.pan_stepsize
            else:
                if self.head_cmd.position[0] < self.max_pan:
                    self.head_cmd.position[0] += self.pan_stepsize

        if abs(COG_y) > self.tilt_threshold:
            if COG_y > 0:
                if self.head_cmd.position[1] >= self.min_tilt:
                    self.head_cmd.position[1] -= self.tilt_stepsize
            else:
                if self.head_cmd.position[1] < self.max_tilt:
                    self.head_cmd.position[1] += self.tilt_stepsize

    def getCameraInfo(self, msg):
        self.image_width = msg.width
        self.image_height = msg.height

    def shutdown(self):
        rospy.loginfo("Shutting down head tracking node...")

if __name__ == '__main__':
    try:
        head_track()
    except rospy.ROSInterruptException:
        rospy.loginfo("Head tracking node is shut down.")

