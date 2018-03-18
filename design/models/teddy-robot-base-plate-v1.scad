/*

Teddy Robot upper torso

//servo ax12a
// 50x32
// M2 taps
// 

*/


thick=3;
servo_width=32;
servo_length=50;
servo_hole_dist=8;
servo_tap_dia=2.5;
servo_frame=5;
upper_width=servo_length+20;
upper_length=servo_length+20;
upper_height=servo_length+20;
frame_width=10;
bottom_width=servo_length*2+40;
bottom_length=servo_length*2+60;
tap_height=thick+6;
servo2_length=42;


module bolts() {
 translate([0,50,7.5]) rotate([90,0,0]) cylinder(100,3/2,3/2);
 translate([-50,0,7.5]) rotate([0,90,0]) cylinder(100,3/2,3/2);
}

module taps() {
 // servo taps
 union() {
  // tap bottom left
  translate([-8,2.5,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  // tap bottom right
  translate([8,2.5,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  // tap block left
  translate([-16+2.5,8,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  translate([-16+2.5,16,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  translate([-16+2.5,24,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  translate([-16+2.5,32,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  // tap block right
  translate([16-2.5,8,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  translate([16-2.5,16,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  translate([16-2.5,24,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  translate([16-2.5,32,-2]) cylinder(tap_height,servo_tap_dia/2,servo_tap_dia/2);
  // extra holes
  translate([-24,1,-2]) cylinder(tap_height,frame_width/2,frame_width/2);
  translate([24,1,-2]) cylinder(tap_height,frame_width/2,frame_width/2);
  translate([-24,49,-2]) cylinder(tap_height,frame_width/2,frame_width/2);
  translate([24,49,-2]) cylinder(tap_height,frame_width/2,frame_width/2);
 }
}

module top() {
 difference() {
  // upper servo plate
  color ("black") translate([-upper_width/2,-upper_length/2,thick+upper_height]) cube([upper_width,upper_length,thick]);
  // servo diff
  union() {
   color ("lightblue") translate([-(servo_width-servo_frame*2)/2,-(servo_length-servo_frame*2)/2,thick+upper_height-1]) cube([servo_width-servo_frame*2,servo_length-servo_frame*2,thick+2]);
   color ("lightgreen") translate([0,-(servo_length-servo_frame*2)/2-servo_frame,thick+upper_height-1]) taps();
  }
 }
}

// walls
module walls() {
 difference() {
  union() {
   // left
   color ("blue") translate([-upper_width/2,-upper_length/2,thick]) cube([thick,upper_length,upper_height]);
   // right
   color ("yellow") translate([upper_width/2-thick,-upper_length/2,thick]) cube([thick,upper_length,upper_height]);
    // front
   color ("orange") translate([-upper_width/2,-upper_length/2,thick]) cube([upper_width,thick,upper_height]);
   // back
   color ("pink") translate([-upper_width/2,upper_length/2-thick,thick]) cube([upper_width,thick,upper_height]);
  }
  // diff
  union() {
   // deletion cube X
   color ("red") translate([-upper_width,-servo2_length/2,frame_width+thick]) cube([upper_width*2,servo2_length,upper_height-frame_width*2]);
   // deletion cube Y
   color ("green") translate([-servo2_length/2,-upper_length,frame_width+thick]) cube([servo2_length,upper_length*2,upper_height-frame_width*2]);
  // add bolts()
  bolts();
  }
 }
}

module bottom() {
  // bottom plate
  difference() {
   union() {
    translate([-(bottom_length-2*frame_width)/2,-(bottom_width-2*frame_width)/2,0])  
    minkowski() {
     color ("darkgreen")
     cube([bottom_length-2*frame_width,bottom_width-2*frame_width,thick/2]);
     cylinder(r=frame_width,h=thick/2);
    }
    color ("white") translate([-(upper_width-4*thick+2*thick)/2+1,-(upper_length-4*thick+2*thick)/2+1,0]) cube([upper_width-4*thick+2*thick-2,upper_length-4*thick+2*thick-2,10+thick]);
   }
  union() {
   translate([-(upper_width-4*thick)/2,-(upper_length-4*thick)/2,-1]) color ("brown") cube([upper_width-4*thick,upper_length-4*thick,thick+20]);
   bolts();
  }
 }
}



// draw

// print part 1
/*
translate([0,0,upper_height+2*thick]) rotate([180,0,0]) union() {
top();
walls();
}
*/


// print part 2
bottom();
