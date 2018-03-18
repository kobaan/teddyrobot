/*
  Cubieboard - Case v1
  http://www.thingiverse.com/thing:40144
  by kobaan
  based on buZztiaan's Fake Cubieboard http://www.thingiverse.com/thing:39337
*/

// parametrics
board_width=106;
board_depth=64;
board_height=20;
board_thick=1;
wall_thick=1;
tap_dia=3;
tap_dist=3;
tap_left=23;
tap_right=tap_dist;
tap_height=25;
ether_depth=16;
ether_width=16;
ether_height=13;
hdmi_width=16;
usb_width=14;
usb_height=16.5;
usb_depth=20;
plugbar_width=50;
plugbar_depth=6;
plugbar_height=7;

// crosscheck import STL of cubieboard
//color ("darkgreen") translate([-board_width/2+1.5,-board_depth/2,1+board_thick+wall_thick]) import("Cubieboard_v9.stl");

// taps
module taps() {
 union() {
  translate([board_width/2-3-tap_dist-0.7,board_depth/2-3-tap_dist,-1]) cylinder(tap_height+2,tap_dia/2,tap_dia/2);
  translate([tap_left-board_width/2+2.5,board_depth/2-3-tap_dist,-1]) cylinder(tap_height+2,tap_dia/2,tap_dia/2);
  translate([board_width/2-3-tap_dist-0.7,-board_depth/2+2+tap_dist,-1]) cylinder(tap_height+2,tap_dia/2,tap_dia/2);
  translate([tap_left-board_width/2+2.5,-board_depth/2+2+tap_dist,-1]) cylinder(tap_height+2,tap_dia/2,tap_dia/2);
 }
}

// plugbars
module plugbars() {
 union() {
  translate([-6.5,-board_depth/2+2,-7]) cube([plugbar_width,plugbar_depth,plugbar_height+2]);
  translate([-6.5,board_depth/2-plugbar_depth-2,-7]) cube([plugbar_width,plugbar_depth,plugbar_height+2]);
 }
}

// ether
module ether() {
 translate([board_width/2-ether_width,-23.5,2.5]) cube([ether_width+2,ether_depth+0.5+2,ether_height+2]);
}

// usb
module usb() {
 translate([-23,-40,1]) cube([usb_width+2,usb_depth+2,usb_height+2]);
}

// audio
module audio() {
 translate([34.5,7.5,-5]) cube([19+2,7+2,13+2]);
}

// ir
module ir() {
 translate([-38,25,1]) cube([5+2,7.5+2,11.5+2]);
}

// dcjack
module dcjack() {
 translate([-54,19.5,1]) cube([5+2,7+2,7+2]);
}

// usbfel
module usbfel() {
 translate([45,-5,-5]) cube([10+2,7.5+2,10.5+2]);
 translate([-54,5,1]) cube([5+2,7.5+2,4.5+2]);
}

// hdmi
module hdmi() {
 translate([-55,-11.5,1]) cube([15+2,15+2,6+2]);
}

// power
module power() {
 translate([-55,5,1]) cube([10+2,7+2,4+2]);
}

// sata
module sata() {
 translate([-25,23.5,1]) cube([16+2,4.5+2,19+2]);
}

// satapwr
module satapwr() {
 translate([-34,15.5,1]) cube([7+2,4.5+2,19+2]);
}

// sdcard
module sdcard() {
 translate([-47,-35,1]) cube([15+2,15+2,4+2]);
}

// deletion bottom plate
module delbottom() {
 union() {
   taps();
   plugbars();
   audio();
   usbfel();
 }
}

// deletion upper plate
module delupper() {
 union() {
  taps();
  sata();
  satapwr();
 }
}

// deletion left wall
module delleft() {
 union() {
  dcjack();
  hdmi();
  power();
 }
}

// deletion right wall
module delright() {
 union() {
  ether();
  audio();
  usbfel();
 }
}

// deletion front wall
module delfront() {
 union() {
  usb();
  sdcard();
 }
}

// deletion rear wall
module delrear() {
 union() {
  ir();
 }
}


// bottom plate
module bottom() {
 difference() {
  union() {
   translate([-board_width/2,-board_depth/2,0]) cube([board_width,board_depth,wall_thick]);
  }
  delbottom();
 }
}

// upper plate
module upper() {
 difference() {
  union() {
   translate([-board_width/2,-board_depth/2,board_height]) cube([board_width,board_depth,wall_thick]);
  }
  delupper();
 }
}

// left wall
module left() {
 difference() {
  union() {
   color ("green") translate([-board_width/2,-board_depth/2,wall_thick]) cube([wall_thick,board_depth,board_height]);
  }
  delleft();
 }
}

// right wall
module right() {
 difference() {
  union() {
   color ("pink") translate([board_width/2-wall_thick,-board_depth/2,wall_thick]) cube([wall_thick,board_depth,board_height]);
  }
  delright();
 }
}

// front wall
module front() {
 difference() {
  union() {
   color ("blue") translate([-board_width/2,-board_depth/2,wall_thick]) cube([board_width,wall_thick,board_height]);
  }
  delfront();
 }
}

// rear wall
module rear() {
 difference() {
  union() {
   color ("orange") translate([-board_width/2,board_depth/2-wall_thick,wall_thick]) cube([board_width,wall_thick,board_height]);
  }
  delrear();
 }
}




// 3d print part 1 - case
bottom();
left();
right();
front();
rear();


// 3d print part 2 - cover
//upper();
translate([0,board_depth+5,-board_height]) upper();

// Debug
//taps();
//plugbars();
//ether();
//usb();
//audio();
//ir();
//sata();
//satapwr();
//dcjack();
//usbfel();
//hdmi();
//sdcard();
//power();


