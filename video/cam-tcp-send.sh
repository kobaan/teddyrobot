gst-launch v4l2src device=/dev/video2 ! video/x-raw-yuv,width=1280,height=720,framerate=\(fraction\)5/1 ! ffmpegcolorspace ! jpegenc ! multipartmux ! tcpserversink host=1.1.1.210 port=5000
