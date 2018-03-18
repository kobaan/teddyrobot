  var viewer;
  function left_stream() {
    document.getElementById("stream").innerHTML="Left Camera";
    delete window.viewer;
    window.viewer = new MJPEGCANVAS.Viewer({
      divID : 'stream',
      host : 'onyx1.local',
      port : '873',
      width : 320,
      height : 240,
      quality : 50,
      topic : '/camera/left/image_raw'
    });
  }
  function right_stream() {
    document.getElementById("stream").innerHTML="Right Camera";
    delete window.viewer;
    window.viewer = new MJPEGCANVAS.Viewer({
      divID : 'stream',
      host : 'onyx1.local',
      port : '873',
      width : 320,
      height : 240,
      quality : 50,
      topic : '/camera/right/image_raw'
    });
  }
  function disparity_stream() {
    document.getElementById("stream").innerHTML="Disparity View";
    delete window.viewer;
    window.viewer = new MJPEGCANVAS.Viewer({
      divID : 'stream',
      host : 'onyx1.local',
      port : '873',
      width : 320,
      height : 240,
      quality : 50,
      topic : '/camera/disparity/image_raw'
    });
  }
  function depth_stream() {
    document.getElementById("stream").innerHTML="Depth View";
    delete window.viewer;
    window.viewer = new MJPEGCANVAS.Viewer({
      divID : 'stream',
      host : 'onyx1.local',
      port : '873',
      width : 320,
      height : 240,
      quality : 50,
      topic : '/camera/depth/image_raw'
    });
  }
  function ptz_stream() {
    document.getElementById("stream").innerHTML="Pan/Tilt/Zoom Camera";
    delete window.viewer;
    window.viewer = new MJPEGCANVAS.Viewer({
      divID : 'stream',
      host : 'onyx1.local',
      port : '873',
      width : 320,
      height : 240,
      quality : 50,
      topic : '/camera/ptz/image_raw'
    });
  }

  function disable_stream() {
    delete window.viewer;
    document.getElementById("stream").innerHTML="Video disabled";
  }
