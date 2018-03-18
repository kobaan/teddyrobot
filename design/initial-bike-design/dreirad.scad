/*
    Model Dreirad
    

*/

//drivebase main wheel
main_wheel_radius=50;
main_wheel_tap=5;
main_wheel_width=26;
main_wheel_inner=40;
main_wheel_delete=10;
main_wheel_axe=15;
front_wheel_offset=115;

module main_wheel() {
  difference() {
  union() {
  difference() {
	translate([0,0,-main_wheel_width/2]) cylinder(main_wheel_width,main_wheel_radius,main_wheel_radius);
	union() {
		translate([0,0,main_wheel_delete-main_wheel_delete/2-1]) cylinder(main_wheel_delete,main_wheel_inner,main_wheel_inner);
		translate([0,0,-main_wheel_delete-main_wheel_delete/2+1]) cylinder(main_wheel_delete,main_wheel_inner,main_wheel_inner);
	}
  }
  translate([0,0,-main_wheel_width/2]) cylinder(main_wheel_width+main_wheel_delete,main_wheel_axe/2,main_wheel_axe/2);
  }
  translate([0,0,-main_wheel_width/2-1]) cylinder(main_wheel_width+main_wheel_delete+1,main_wheel_tap/2,main_wheel_tap/2);
  }
}

//drivebase caster wheel
caster_wheel_radius=25;
caster_wheel_width=20;
caster_wheel_offset=25;
caster_wheel_mountx=30;
caster_wheel_mounty=50;
caster_wheel_mountz=2;
caster_wheel_cylinder_radius=35/2;
caster_wheel_cylinder_height=8;
caster_wheel_base_width=35;
caster_wheel_base_length=50;
caster_wheel_base_height=35;
caster_wheel_axe_offset=7;
caster_wheel_axe=5;
caster_wheel_axe_length=25;
caster_wheel_tap=7;
caster_wheel_tap_offset=5;

module caster_wheel() {
	//alternate-different-size
	//color ("lightgreen") translate([0,137,0]) scale([6.3,6.3,6.3]) rotate ([90,0,270]) import("casterwheel.stl");
	difference() {
	union() {
	// wheel
	rotate ([0,90,0]) translate ([0,0,-caster_wheel_width/2]) cylinder(caster_wheel_width,caster_wheel_radius,caster_wheel_radius);
	// axe
	rotate ([0,90,0]) translate ([0,0,-caster_wheel_axe_length/2]) cylinder(caster_wheel_axe_length,caster_wheel_axe/2,caster_wheel_axe/2);
	// mount plate
	translate ([0,caster_wheel_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height]) cube ([caster_wheel_mountx,caster_wheel_mounty,caster_wheel_mountz],true);
	// cylinder
	translate ([0,caster_wheel_offset,caster_wheel_base_height-caster_wheel_axe_offset-caster_wheel_mountz/2]) cylinder (caster_wheel_cylinder_height,caster_wheel_cylinder_radius,caster_wheel_cylinder_radius);
	// base plate
	hull() {
		translate ([0,caster_wheel_offset-caster_wheel_tap_offset*2,caster_wheel_base_width/2-caster_wheel_axe_offset+caster_wheel_axe/2+12]) cube ([caster_wheel_base_width,caster_wheel_base_length,15],true);
		translate ([0,caster_wheel_offset-caster_wheel_tap_offset*2-15,caster_wheel_base_width/2-caster_wheel_axe_offset+caster_wheel_axe/2]) cube ([caster_wheel_base_width,15,caster_wheel_base_height],true);
	}
	// filler socket for caster wheel mount plate
	//color ("red") translate ([0,caster_wheel_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height+caster_wheel_mountz+2.5]) cube ([caster_wheel_mountx,caster_wheel_mounty,6+caster_wheel_mountz],true);
   // wider filler socket with sink for caster wheel mount plate
	color ("green") translate ([0,caster_wheel_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height+caster_wheel_mountz+3]) cube ([caster_wheel_mountx+4,caster_wheel_mounty+4,15+caster_wheel_mountz],true);
   }
	// TAPS
	union() {
		translate ([-caster_wheel_mountx/2+caster_wheel_tap_offset,caster_wheel_offset-caster_wheel_mounty/2+caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-10]) cylinder (caster_wheel_mountz+20+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2);
		translate ([caster_wheel_mountx/2-caster_wheel_tap_offset,caster_wheel_offset-caster_wheel_mounty/2+caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-10]) cylinder (caster_wheel_mountz+20+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2);
		translate ([-caster_wheel_mountx/2+caster_wheel_tap_offset,caster_wheel_offset+caster_wheel_mounty/2-caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-10]) cylinder (caster_wheel_mountz+20+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2);
		translate ([caster_wheel_mountx/2-caster_wheel_tap_offset,caster_wheel_offset+caster_wheel_mounty/2-caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-10]) cylinder (caster_wheel_mountz+20+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2);
   // caster wheel mount sink
	color ("blue") translate ([0,caster_wheel_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height+caster_wheel_mountz-15]) cube ([caster_wheel_mountx,caster_wheel_mounty,20+caster_wheel_mountz],true);
	}
	}
}



//motors
motor_length=86.6;
motor_thickness=30;
motor_axe=5;
motor_shaft=10;
motor_shaft_offset=5.5;
motor_shaft_length=2.5;
motor_axe_length=10;
motor_tapm3=3;
motor_tap_distance=12.5;
motor_tap_degrees=60;

module motor() {
  union() {
	translate ([0,0,0]) rotate([0,90,0]) cylinder(motor_length-motor_axe_length,motor_thickness/2,motor_thickness/2);
	translate ([-motor_shaft_length,0,-motor_shaft_offset]) rotate([0,90,0]) cylinder(motor_shaft_length,motor_shaft/2,motor_shaft/2);
	translate ([-motor_axe_length,0,-motor_shaft_offset]) rotate([0,90,0]) cylinder(motor_axe_length,motor_axe/2,motor_axe/2);
  }
}


//motorbracket http://www.robot-electronics.co.uk/htm/emg30.htm
bracket_length=74;
bracket_width=45;
bracket_tapm3=3;
bracket_tapm10=10;
bracket_m10_distance=15;
bracket_axe_distance=30.5;
bracket_tap_distance=7;
bracket_thickness=2;
bracket_height=25;

module motor_bracket_taps() {
  union() {
	// motor axe tap M10
	translate ([bracket_width/2-bracket_m10_distance,0,-bracket_thickness]) cylinder(bracket_thickness+2,bracket_tapm10/2,bracket_tapm10/2);
   //FIXME insert 3 M3 taps from motor holder here
	// 4 M3 TAPS
	translate ([-bracket_width/2-1,-bracket_length/2+bracket_tap_distance,bracket_height-bracket_tap_distance]) rotate ([0,90,0]) cylinder(bracket_thickness+2,bracket_tapm3/2,bracket_tapm3/2);
	translate ([-bracket_width/2-1,bracket_length/2-bracket_tap_distance,bracket_height-bracket_tap_distance]) rotate ([0,90,0]) cylinder(bracket_thickness+2,bracket_tapm3/2,bracket_tapm3/2);
	translate ([-bracket_width/2-1,-bracket_length/2+bracket_tap_distance,bracket_tap_distance-bracket_tapm3/2]) rotate ([0,90,0]) cylinder(bracket_thickness+2,bracket_tapm3/2,bracket_tapm3/2);
	translate ([-bracket_width/2-1,bracket_length/2-bracket_tap_distance,bracket_tap_distance-bracket_tapm3/2]) rotate ([0,90,0]) cylinder(bracket_thickness+2,bracket_tapm3/2,bracket_tapm3/2);
  }
}

module motor_bracket() {
  difference() {
  union() {
  	translate ([0,bracket_length/2-bracket_width/2,-bracket_thickness/2]) cylinder(bracket_thickness,bracket_width/2,bracket_width/2);
	translate ([-bracket_width/2/2,0,0]) cube([bracket_width/2,bracket_length,bracket_thickness],true);
	cube([bracket_width,bracket_width/2+4,bracket_thickness],true);
	translate ([0,-bracket_length/2+bracket_width/2,-bracket_thickness/2]) cylinder(bracket_thickness,bracket_width/2,bracket_width/2);
	translate ([-bracket_width/2+bracket_thickness/2,0,bracket_height/2-bracket_thickness/2]) cube([bracket_thickness,bracket_length,bracket_height],true);
  }
  motor_bracket_taps();
  }
}

module mounted_motor() {
  union() {
	motor();
	translate ([-bracket_thickness/2,0,bracket_thickness]) rotate ([0,90,0]) motor_bracket();
  }
}

// base_plate
base_plate_rear_width=(motor_length-motor_axe_length)*2+46.8;
base_plate_rear_length=200;
base_plate_front_width=caster_wheel_mountx*2;
base_plate_front_length=front_wheel_offset+base_plate_rear_length/2-15;
base_plate_thickness=4;

module base_plate() {
	hull() {
		color ("blue") translate ([0,0,0]) cube ([base_plate_rear_width,base_plate_rear_length,base_plate_thickness],true);
		color ("green") translate ([0,base_plate_front_length/2,0]) cube ([base_plate_front_width,base_plate_front_length,base_plate_thickness],true);
	}
}

rear_wheel_offset=25;

module model() {
	union() {
	// left motor
	translate ([-motor_length+motor_axe_length-1-20.4,-rear_wheel_offset,0]) mounted_motor();
	// right motor
	translate ([motor_length-motor_axe_length+1+20.4,-rear_wheel_offset,0]) rotate([0,0,180]) mounted_motor();
	// left wheel
	translate ([-motor_length-main_wheel_width/2-main_wheel_tap+motor_axe_length-1-20.4,-rear_wheel_offset,0]) rotate ([0,90,0]) main_wheel();
	// right wheel
	translate ([motor_length+main_wheel_width/2+main_wheel_tap-motor_axe_length+1+20.4,-rear_wheel_offset,0]) rotate ([0,270,0]) main_wheel();
	// caster wheel
	color ("lightblue") translate ([0,front_wheel_offset,-(main_wheel_radius-caster_wheel_radius)]) caster_wheel();
	// base_plate
	translate ([0,0,26]) base_plate();
	}
}


// ultrasonic sensor HC-SR04 2-500cm (use 2-200cm)
hcsr04_length=45;
hcsr04_width=20;
hcsr04_height=15;
hcsr04_trans_radius=8;
hcsr04_quartz_radius=1.5;
hcsr04_quartz_height=3;
hcsr04_quartz_distance=9;
hcsr04_board_thickness=1.5;
module hcsr04() {
	translate([-hcsr04_length/2+hcsr04_trans_radius+hcsr04_board_thickness/2,0,hcsr04_board_thickness]) cylinder(hcsr04_height-hcsr04_board_thickness,hcsr04_trans_radius,hcsr04_trans_radius);
	translate([hcsr04_length/2-hcsr04_trans_radius-hcsr04_board_thickness/2,0,hcsr04_board_thickness]) cylinder(hcsr04_height-hcsr04_board_thickness,hcsr04_trans_radius,hcsr04_trans_radius);
	translate([0,0,hcsr04_board_thickness/2]) cube([hcsr04_length,hcsr04_width,hcsr04_board_thickness],true);
	hull() {
		translate([-hcsr04_quartz_distance/2,hcsr04_width/2-hcsr04_quartz_height,hcsr04_board_thickness]) cylinder(hcsr04_quartz_height,hcsr04_quartz_radius,hcsr04_quartz_radius);
		translate([hcsr04_quartz_distance/2,hcsr04_width/2-hcsr04_quartz_height,hcsr04_board_thickness]) cylinder(hcsr04_quartz_height,hcsr04_quartz_radius,hcsr04_quartz_radius);
	}	
}
//hcsr04();


// ultrasonic sensor SRF08 3-600cm (use on head)
srf08_length=17*2.54;
srf08_width=20;
srf08_height=5.6*2.54;
srf08_board_thickness=0.6*2.54;
srf08_trans_radius=6.4*2.54/2;
srf08_led_radius=1.8*2.54/2;
srf08_led_height=4;
srf08_tap_radius=1.3*2.54/2;
module srf08() {
	difference() {
	union() {
	translate([-srf08_length/2+srf08_trans_radius+srf08_board_thickness,0,srf08_board_thickness]) cylinder(srf08_height-srf08_board_thickness,srf08_trans_radius,srf08_trans_radius);
	translate([srf08_length/2-srf08_trans_radius-srf08_board_thickness,0,srf08_board_thickness]) cylinder(srf08_height-srf08_board_thickness,srf08_trans_radius,srf08_trans_radius);
	translate([0,0,srf08_board_thickness/2]) cube([srf08_length,srf08_width,srf08_board_thickness],true);
	translate([0,srf08_width/2-srf08_led_radius*1.5,srf08_board_thickness]) cylinder(srf08_led_height-srf08_board_thickness,srf08_led_radius,srf08_led_radius);
	}
	union() {
		translate([srf08_length/2-2.5,srf08_width/2-2.5,-.5]) cylinder(srf08_board_thickness+1,srf08_tap_radius,srf08_tap_radius);
		translate([-srf08_length/2+2.5,-srf08_width/2+2.5,-.5]) cylinder(srf08_board_thickness+1,srf08_tap_radius,srf08_tap_radius);
		translate([0,-srf08_width/2+2,-.5]) cylinder(srf08_board_thickness+1,.5,.5);
		translate([2,-srf08_width/2+2,-.5]) cylinder(srf08_board_thickness+1,.5,.5);
		translate([4,-srf08_width/2+2,-.5]) cylinder(srf08_board_thickness+1,.5,.5);
		translate([-2,-srf08_width/2+2,-.5]) cylinder(srf08_board_thickness+1,.5,.5);
		translate([-4,-srf08_width/2+2,-.5]) cylinder(srf08_board_thickness+1,.5,.5);
	}
	}
}
//srf08();

// infrared sensor Sharp GP2Y0A21YK 10-80cm (front fallsensor)
sharp_distance=37;
sharp_width1=17.6;
sharp_width2=8.4;
sharp_width2=7.2;
sharp_height1=15.5;
sharp_height2=6.3;
sharp_height3=2;
sharp_inner=0.6;
sharp_length1=29.5;
sharp_length_receiver=16.3;
sharp_length_sender=7.5;
sharp_optic_distance=4.15;
sharp_length_radius=3.75;
sharp_tap_radius=3.2/2;
sharp_thickness=2;
module sharp() {
	difference() {
	union() {
	// base PCB
	color ("red") translate([0,0,sharp_thickness/2]) cube([sharp_distance,sharp_width1,sharp_thickness],true);
	color ("yellow") translate([-sharp_distance/2,0,0]) cylinder(sharp_thickness,sharp_length_radius,sharp_length_radius);
	color ("yellow") translate([sharp_distance/2,0,0]) cylinder(sharp_thickness,sharp_length_radius,sharp_length_radius);
	// cube1 to PCB
	color ("green") translate([0,0,(sharp_height1-sharp_height2)/2]) cube([sharp_length1,sharp_width1,sharp_height1-sharp_height2],true);
	// cube2 to cube1
	color ("blue") translate([0,0,sharp_height1/2]) cube([sharp_length1,sharp_width2,sharp_height1-sharp_height3],true);
	// cube3 sender
	color ("orange") translate([-sharp_length1/2+sharp_length_sender/2,0,sharp_height1/2]) cube([sharp_length_sender-sharp_inner*2,sharp_width2-sharp_inner*2,sharp_height1],true);
	// cube3 receiver (bigger one)
	color ("pink") translate([sharp_length1/2-sharp_length_receiver/2,0,sharp_height1/2]) cube([sharp_length_receiver-sharp_inner*2,sharp_width2-sharp_inner*2,sharp_height1],true);
	}

	union() {
	// taps
	color ("brown") translate([-sharp_distance/2,0,-1]) cylinder(sharp_thickness+1.5,sharp_tap_radius,sharp_tap_radius);
	color ("brown") translate([sharp_distance/2,0,-1]) cylinder(sharp_thickness+1.5,sharp_tap_radius,sharp_tap_radius);
	color ("brown") translate([-sharp_length1/2+sharp_length_sender/2,0,sharp_height1-1]) cylinder(2,sharp_tap_radius+1.2,sharp_tap_radius+1.2);
	color ("brown") translate([sharp_length1/2-sharp_length_sender/2,0,sharp_height1-1]) cylinder(2,sharp_tap_radius+1.2,sharp_tap_radius+1.2);
	}
	}
}
//sharp();

// microphone sensor Breakout Board for ADMP401 MEMS Microphone Sparkfun BOB-09868
mems_length=15;
mems_width=10;
mems_thickness=1;
module micromems() {
	difference() {
	union() {
	translate([0,0,mems_thickness/2]) cube([mems_length,mems_width,mems_thickness],true);
	translate([-4.5,0,mems_thickness]) cube([4,6,mems_thickness],true);
	translate([0,0,mems_thickness]) cube([2,3,mems_thickness],true);
	}
	union() {
	translate([6.5,2,-1]) cylinder(3,0.5,0.5);
	translate([6.5,0,-1]) cylinder(3,0.5,0.5);
	translate([6.5,-2,-1]) cylinder(3,0.5,0.5);
	}
	}
}
//micromems();

// current sensor ACS711
acs_length=20;
acs_width=15;
acs_height=1.5;
acs_tap1=1.4*2.54/2;
acs_tap2=0.86*2.54/2;
acs_tap3=0.8*2.54/2;
acs_tap4=1/2;
module currentsensor() {
	difference() {
	union() {
	translate([0,0,acs_height/2]) cube([acs_length,acs_width,acs_height],true);
	translate([-1,0,acs_height]) cube([3,4,acs_height*2],true);
	}
	union() {
	translate([7.5,5,-1]) cylinder(acs_height+1.5,acs_tap1,acs_tap1); 
	translate([7.5,-5,-1]) cylinder(acs_height+1.5,acs_tap1,acs_tap1); 
	translate([3.5,5.5,-1]) cylinder(acs_height+1.5,acs_tap2,acs_tap2); 
	translate([3.5,-5.5,-1]) cylinder(acs_height+1.5,acs_tap2,acs_tap2); 
	translate([-5,5.5,-1]) cylinder(acs_height+1.5,acs_tap3,acs_tap3); 
	translate([-5,-5.5,-1]) cylinder(acs_height+1.5,acs_tap3,acs_tap3); 
	translate([-8.5,4,-1]) cylinder(acs_height+1.5,acs_tap4,acs_tap4); 
	translate([-8.5,2,-1]) cylinder(acs_height+1.5,acs_tap4,acs_tap4); 
	translate([-8.5,0,-1]) cylinder(acs_height+1.5,acs_tap4,acs_tap4); 
	translate([-8.5,-2,-1]) cylinder(acs_height+1.5,acs_tap4,acs_tap4); 
	translate([-8.5,-4,-1]) cylinder(acs_height+1.5,acs_tap4,acs_tap4); 
	}
	}
}
//currentsensor();

// Mediatek GPS
module gps() {
	import ("MediatekMT3329.stl");
}
//gps();

// Pololu AHRS MinIMU9v2
minimu_length=20;
minimu_width=13;
minimu_height=3;
minimu_tap1=1.2;
minimu_tap2=0.5;
module minimu() {
	difference() {
	translate([0,0,minimu_height/2]) cube([minimu_length,minimu_width,minimu_height],true);
	union() {
	translate([minimu_length/2-2,minimu_width/2-2,-1]) cylinder(minimu_height+2,minimu_tap1,minimu_tap1);
	translate([-minimu_length/2+1,-minimu_width/2+1.5,-1]) cylinder(minimu_height+2,minimu_tap2,minimu_tap2);
	translate([-minimu_length/2+1,-minimu_width/2+9,-1]) cylinder(minimu_height+2,minimu_tap2,minimu_tap2);
	translate([-minimu_length/2+1,0,-1]) cylinder(minimu_height+2,minimu_tap2,minimu_tap2);
	translate([-minimu_length/2+1,+minimu_width/2-9,-1]) cylinder(minimu_height+2,minimu_tap2,minimu_tap2);
	translate([-minimu_length/2+1,+minimu_width/2-1.5,-1]) cylinder(minimu_height+2,minimu_tap2,minimu_tap2);
	}
	}
}
//minimu();

// powersupply module Pololu 4.5-42V to 5V/7A
pololu5v_length=16.8*2.54;
pololu5v_width=4.6*2.54;
pololu5v_height=5;
pololu5v_thickness=1.5;
pololu5v_tap1=0.55*2.54;
pololu5v_tap2=1/2;
module pololu5v() {
	difference() {
	union() {
	translate([0,0,pololu5v_thickness/2]) cube([pololu5v_length,pololu5v_width,pololu5v_thickness],true);
	translate([0,0,pololu5v_height/2]) cube([pololu5v_length-7*2,pololu5v_width-1.5*2,pololu5v_height],true);
	}
	union() {
	translate([-pololu5v_length/2+2,pololu5v_width/2-3,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap1,pololu5v_tap1); 
	translate([pololu5v_length/2-2,-pololu5v_width/2+3,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap1,pololu5v_tap1); 
	translate([-pololu5v_length/2+2,-pololu5v_width/2+3,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap1,pololu5v_tap1); 
	translate([pololu5v_length/2-2,pololu5v_width/2-3,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap1,pololu5v_tap1); 
	translate([pololu5v_length/2-5,pololu5v_width/2-10,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap2,pololu5v_tap2); 
	translate([pololu5v_length/2-5,pololu5v_width/2-7.5,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap2,pololu5v_tap2); 
	translate([pololu5v_length/2-5,pololu5v_width/2-4.5,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap2,pololu5v_tap2); 
	translate([pololu5v_length/2-5,pololu5v_width/2-2,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap2,pololu5v_tap2); 
	translate([-pololu5v_length/2+5,pololu5v_width/2-10,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap2,pololu5v_tap2); 
	translate([-pololu5v_length/2+5,pololu5v_width/2-7.5,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap2,pololu5v_tap2); 
	translate([-pololu5v_length/2+5,pololu5v_width/2-4.5,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap2,pololu5v_tap2); 
	translate([-pololu5v_length/2+5,pololu5v_width/2-2,-1]) cylinder(pololu5v_thickness+1.5,pololu5v_tap2,pololu5v_tap2); 
	}
	}
}
//pololu5v();

// powersupply module LT1086 5V to 3.3V/1.5A
lt1086_depth=3.2;
lt1086_width=9.9;
lt1086_height=9.2;
lt1086_pin_length=4.1;
lt1086_heat_depth=1.3;
lt1086_heat_height=6.5;
lt1086_heat_width=lt1086_width;
lt1086_tap_radius=1.8;
module lt1086() {
	translate([0,0,lt1086_height/2]) cube([lt1086_width,lt1086_depth,lt1086_height],true);
	difference() {
	translate([0,-lt1086_heat_depth/2,lt1086_height+lt1086_heat_height/2]) cube([lt1086_heat_width,lt1086_heat_depth,lt1086_heat_height],true);
	translate([0,-lt1086_heat_depth/2+2,lt1086_height+lt1086_heat_height/2]) rotate([90,0,0]) cylinder(4,lt1086_tap_radius,lt1086_tap_radius);
	}
	translate([0,0,-lt1086_pin_length/2]) cube([1,1,lt1086_pin_length],true);
	translate([3.3,0,-lt1086_pin_length/2]) cube([1,1,lt1086_pin_length],true);
	translate([-3.3,0,-lt1086_pin_length/2]) cube([1,1,lt1086_pin_length],true);
}
//lt1086();

// powersupply module Traco 4.5-42V to 9V/1.5A
traco_depth=7.6;
traco_width=11.7;
traco_height=10.2;
traco_pin_length=4.1;
module traco9v() {
	translate([0,0,traco_height/2]) cube([traco_width,traco_depth,traco_height],true);
	translate([0,0,-traco_pin_length/2]) cube([1,1,traco_pin_length],true);
	translate([3.3,0,-traco_pin_length/2]) cube([1,1,traco_pin_length],true);
	translate([-3.3,0,-traco_pin_length/2]) cube([1,1,traco_pin_length],true);
}
//traco9v();

// powersupply module LT1085 6-25V to 5V/5A (OPTIONAL for Servos)
lt1085_depth=3.2;
lt1085_width=9.9;
lt1085_height=9.2;
lt1085_pin_length=4.1;
lt1085_heat_depth=1.3;
lt1085_heat_height=6.5;
lt1085_heat_width=lt1085_width;
lt1085_tap_radius=1.8;
module lt1085() {
	translate([0,0,lt1085_height/2]) cube([lt1085_width,lt1085_depth,lt1085_height],true);
	difference() {
	translate([0,-lt1085_heat_depth/2,lt1085_height+lt1085_heat_height/2]) cube([lt1085_heat_width,lt1085_heat_depth,lt1085_heat_height],true);
	translate([0,-lt1085_heat_depth/2+2,lt1085_height+lt1085_heat_height/2]) rotate([90,0,0]) cylinder(4,lt1085_tap_radius,lt1085_tap_radius);
	}
	translate([0,0,-lt1085_pin_length/2]) cube([1,1,lt1085_pin_length],true);
	translate([3.3,0,-lt1085_pin_length/2]) cube([1,1,lt1085_pin_length],true);
	translate([-3.3,0,-lt1085_pin_length/2]) cube([1,1,lt1085_pin_length],true);
}
//lt1085();

// USB bluetooth dongle
bt_radius=15/2;
bt_height=5;
bt_usb_height=3;
bt_usb_length=12;
bt_usb_width=10;
module bluetooth() {
	translate([-bt_usb_length/2,0,0]) cube([bt_usb_length,bt_usb_width,bt_usb_height],true);
	intersection() {
	translate([bt_radius/2,0,0]) cube([bt_radius,bt_radius*2,bt_height],true);
	translate([0,0,-bt_height/2]) cylinder(bt_height,bt_radius,bt_radius);
	}
}
//bluetooth();


// 3W mini audio stereo amplifier DFRobot DFR0119 
amp_length=24;
amp_width=15.5;
amp_thickness=1.5;
amp_tap1=0.55*2.54;
amp_tap2=1/2;
module amplifier() {
	difference() {
	union() {
	translate([0,0,amp_thickness/2]) cube([amp_length,amp_width,amp_thickness],true);
	translate([0,0,amp_thickness]) cube([amp_length,amp_width-7,amp_thickness*2],true);
	}
	union() {
	translate([10,6,-1]) cylinder(amp_thickness+1.5,amp_tap1,amp_tap1); 
	translate([-10,6,-1]) cylinder(amp_thickness+1.5,amp_tap1,amp_tap1); 
	translate([11,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([9,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([7,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([5,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([3,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([1,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([-1,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([-3,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([-5,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([-7,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	translate([-9,-6.5,-1]) cylinder(amp_thickness+1.5,amp_tap2,amp_tap2); 
	}
	}
}
//amplifier();


// Speaker 18mm 4 Ohm, 2,0 W, Pololu 1258
speaker_length=18;
speaker_width=18;
speaker_height=9;
speaker_inner_radius=13/2;
speaker_outer_radius=17/2;
speaker_tap_radius=0.5;
speaker_board_length=13;
speaker_board_width=13;
speaker_board_height=1.5;
speaker_mount_height=1.5;
module speaker() {
	difference() {
	union() {
	translate([0,0,speaker_mount_height/2]) cube([speaker_length,speaker_width,speaker_mount_height],true);
	translate([0,0,speaker_mount_height+speaker_board_height-speaker_height]) cylinder(speaker_height,speaker_outer_radius,speaker_outer_radius);
	translate([0,-2,speaker_mount_height+speaker_board_height/2-speaker_height]) cube([speaker_board_length,speaker_board_width,speaker_mount_height],true);
	}
	union() {
		translate([-speaker_length/2+speaker_mount_height,-speaker_width/2+speaker_mount_height,-speaker_mount_height-1]) cylinder(speaker_mount_height*2+2,speaker_tap_radius,speaker_tap_radius);
		translate([-speaker_length/2+speaker_mount_height,speaker_width/2-speaker_mount_height,-speaker_mount_height-1]) cylinder(speaker_mount_height*2+2,speaker_tap_radius,speaker_tap_radius);
		translate([speaker_length/2-speaker_mount_height,-speaker_width/2+speaker_mount_height,-speaker_mount_height-1]) cylinder(speaker_mount_height*2+2,speaker_tap_radius,speaker_tap_radius);
		translate([speaker_length/2-speaker_mount_height,speaker_width/2-speaker_mount_height,-speaker_mount_height-1]) cylinder(speaker_mount_height*2+2,speaker_tap_radius,speaker_tap_radius);
		translate([0,0,speaker_height-5]) sphere(r=speaker_inner_radius);
	}
	}
}
//speaker();

// LCD03
lcd4x20_board_length=98;
lcd4x20_board_width=60;
lcd4x20_height_board=5;
lcd4x20_length=98;
lcd4x20_width=40;
lcd4x20_height=10;
lcd_i2c_length=48;
lcd_i2c_width=30;
lcd_i2c_height=15;
lcd_i2c_offset=8;
lcd4x20_tap=3/2;
module lcd03() {
   difference() {
        union() {
		translate([0,0,lcd_i2c_height+lcd4x20_height_board+lcd4x20_height/2]) cube([lcd4x20_length,lcd4x20_width,lcd4x20_height],true);
		translate([0,0,lcd_i2c_height+lcd4x20_height_board/2]) cube([lcd4x20_board_length,lcd4x20_board_width,lcd4x20_height_board],true);
		translate([lcd_i2c_length/2-lcd_i2c_offset,-lcd_i2c_width/2,lcd_i2c_height/2]) cube([lcd_i2c_length,lcd_i2c_width,lcd_i2c_height],true);
	}
	union() {
		translate([lcd4x20_length/2-3,-lcd4x20_board_width/2+3,0]) cylinder(lcd_i2c_height*2,lcd4x20_tap,lcd4x20_tap);
		translate([-lcd4x20_length/2+3,-lcd4x20_board_width/2+3,0]) cylinder(lcd_i2c_height*2,lcd4x20_tap,lcd4x20_tap);
		translate([lcd4x20_length/2-3,lcd4x20_board_width/2-3,0]) cylinder(lcd_i2c_height*2,lcd4x20_tap,lcd4x20_tap);
		translate([-lcd4x20_length/2+3,lcd4x20_board_width/2-3,0]) cylinder(lcd_i2c_height*2,lcd4x20_tap,lcd4x20_tap);
	}
   }
}
//lcd03();

usb_hub_length=44;
usb_hub_width=44;
usb_hub_height=9;
module usbhub() {
	translate([0,0,0]) cube([usb_hub_length,usb_hub_width,usb_hub_height],true);
}
//usbhub();

// NoseRGB LED DFR-DFR0106 Light Disc with 7 SMD RGB LED  DFRobot DFR0106
nose_radius=14;
nose_board_height=1;
nose_led_height=1;
nose_led_radius=2;
nose_led_width=6;
nose_tap_radius=0.5;
module noseRGB() {
	//FIXME add driver IC
	difference() {
	union() {
	translate([0,0,0]) cylinder(nose_board_height,nose_radius,nose_radius);
	translate([0,0,nose_board_height]) cylinder(nose_led_height,nose_led_radius,nose_led_radius);
	translate([0,0,nose_board_height]) cube([nose_led_width,nose_led_width,nose_led_height],true);

	for (nose_rotation=[0:5]) {
	rotate ([0,0,nose_rotation*60]) union() {
	translate([nose_led_width*1.5,0,nose_board_height]) cylinder(nose_led_height,nose_led_radius,nose_led_radius);
	translate([nose_led_width*1.5,0,nose_board_height]) cube([nose_led_width,nose_led_width,nose_led_height],true);
	}
	}
	}
	union() {
		translate([1.9,-nose_radius+1.2,-2]) cylinder(4,nose_tap_radius,nose_tap_radius);
		translate([0.65,-nose_radius+1,-2]) cylinder(4,nose_tap_radius,nose_tap_radius);
		translate([-0.65,-nose_radius+1,-2]) cylinder(4,nose_tap_radius,nose_tap_radius);
		translate([-1.9,-nose_radius+1.2,-2]) cylinder(4,nose_tap_radius,nose_tap_radius);
	}
	}
}
//noseRGB();

// Mouth Matrix + driver
matrix_length=53;
matrix_width=37.65;
matrix_height=8.45;
matrix_header_distance=38.1;
matrix_header_height=3;
matrix_pin_spacing=2.54;
matrix_dot_radius=2.5;
module mouthmatrix() {
	difference(){
	union() {
	translate([0,0,(matrix_height-matrix_header_height)/2]) cube([matrix_length,matrix_width,matrix_height-matrix_header_height],true);
	translate([-matrix_header_distance/2,2.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([-matrix_header_distance/2,1.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([-matrix_header_distance/2,0.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([-matrix_header_distance/2,-0.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([-matrix_header_distance/2,-1.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([-matrix_header_distance/2,-2.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([matrix_header_distance/2,2.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([matrix_header_distance/2,1.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([matrix_header_distance/2,0.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([matrix_header_distance/2,-0.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([matrix_header_distance/2,-1.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	translate([matrix_header_distance/2,-2.5,-1]) cylinder(matrix_header_height,matrix_dot_radius/5,matrix_dot_radius/5);
	}
	union() {
	translate([23,16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([23,8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([23,0,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([23,-8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([23,-16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);

	translate([16,16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([16,8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([16,0,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([16,-8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([16,-16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);

	translate([8,16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([8,8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([8,0,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([8,-8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([8,-16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);

	translate([0,16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([0,8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([0,0,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([0,-8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([0,-16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);

	translate([-8,16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-8,8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-8,0,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-8,-8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-8,-16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);

	translate([-16,16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-16,8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-16,0,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-16,-8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-16,-16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);

	translate([-23,16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-23,8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-23,0,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-23,-8,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	translate([-23,-16,matrix_height/2]) cylinder(2,matrix_dot_radius,matrix_dot_radius);
	}
	}
}
//mouthmatrix();

// speech module EMIC2 + level shifter
emic2_length=38.1;
emic2_width=31.7;
emic2_height=9.4;
emic2_thickness=1.5;
emic2_tap=1/2;
module emic2() {
	difference() {
	union() {
	translate([0,0,emic2_thickness/2]) cube([emic2_length,emic2_width,emic2_thickness],true);
	translate([-3,7,6/2]) cube([5,7,6],true);
	translate([-5,-7,emic2_height/2]) cube([7,15,emic2_height],true);
	translate([10,8,2]) cube([10,10,3],true);
	translate([10,-8,2]) cube([10,10,3],true);
	}
	union() {
	translate([-emic2_length/2+2,-5.6,-1]) cylinder(emic2_thickness+1.5,emic2_tap,emic2_tap); 
	translate([-emic2_length/2+2,-3.4,-1]) cylinder(emic2_thickness+1.5,emic2_tap,emic2_tap); 
	translate([-emic2_length/2+2,-1.2,-1]) cylinder(emic2_thickness+1.5,emic2_tap,emic2_tap); 
	translate([-emic2_length/2+2,1.2,-1]) cylinder(emic2_thickness+1.5,emic2_tap,emic2_tap); 
	translate([-emic2_length/2+2,3.4,-1]) cylinder(emic2_thickness+1.5,emic2_tap,emic2_tap); 
	translate([-emic2_length/2+2,5.6,-1]) cylinder(emic2_thickness+1.5,emic2_tap,emic2_tap); 
	}
	}
}
//emic2();

// dynamixel AX-12A
module ax12a() {
	import ("ax12a.stl");
}
//ax12a();

// pedal servo
module servo() {
	import ("servo1.stl");
}

// cubieboard
module cubieboard() {
	import ("Cubieboard_v9.stl");
}
//cubieboard();

// power supply akkumulator LiFePo4
// Conrad Vision LFP1210, 12V 10Ah LiFePO 4 Battery, Rechargeable
// http://www.conrad.com/ce/en/product/251471/Vision-LFP1210-12V-10Ah-LiFePO-4-Battery-Rechargeable/?ref=detview1&rt=detview1&rb=2
lifepo_length=150;
lifepo_width=65;
lifepo_height=107;
module lifepo4() {
	translate([0,0,lifepo_height/2])cube([lifepo_length,lifepo_width,lifepo_height],true);
}
//lifepo4();

// motor controller MD25
md25_board_length=52;
md25_board_width=63;
md25_board_height=1.5;
module md25() {
	translate([0,0,md25_board_height/2]) cube([md25_board_length,md25_board_width,md25_board_height],true);
}
//md25();

// ITeadMaple Board
maple_board_length=54;
maple_board_width=69;
maple_board_height=1.5;
module maple() {
	translate([0,0,maple_board_height/2]) cube([maple_board_length,maple_board_width,maple_board_height],true);
}
//maple();

// Seeeduino Mega board
seeed_board_length=47;
seeed_board_width=68;
seeed_board_height=1.5;
module seeeduino() {
	translate([0,0,seeed_board_height/2]) cube([seeed_board_length,seeed_board_width,seeed_board_height],true);
}
//seeeduino();

// UCFF mainboard (Optional)
ucff_length=4*2.54;
ucff_width=4*2.54;
ucff_heigth1=0.8*2.54;
ucff_heigth2=1.2*2.54;
module ucff() {
	translate ([0,0,ucff_heigth1/2]) cube([ucff_length,ucff_width,ucff_heigth1],true);
	translate ([0,0,0]) cube([ucff_length/2,ucff_width,ucff_heigth2],true);
}
//ucff();

universal_board_length=85;
universal_board_width=115;
universal_board_height=1.5;
universal_board_outline=2.5;
universal_board_holder=10;
module universal_board_holder() {
	translate ([0,0,universal_board_height/2]) cube([universal_board_length+universal_board_outline*2,universal_board_width+universal_board_outline*2,universal_board_height],true);
	translate ([universal_board_length/2,(-universal_board_width-universal_board_outline*2)/2,universal_board_height]) cube([universal_board_outline,universal_board_width+universal_board_outline*2,universal_board_holder]);
	translate ([-universal_board_length/2-universal_board_outline,(-universal_board_width-universal_board_outline*2)/2,universal_board_height]) cube([universal_board_outline,universal_board_width+universal_board_outline*2,universal_board_holder]);
	translate ([-universal_board_length/2-universal_board_outline,(-universal_board_width-universal_board_outline*2)/2,universal_board_height]) cube([universal_board_length+universal_board_outline*2,universal_board_outline,universal_board_holder]);
	translate ([-universal_board_length/2-universal_board_outline,universal_board_width/2,universal_board_height]) cube([universal_board_length+universal_board_outline*2,universal_board_outline,universal_board_holder]);
}
//universal_board_holder();


module imagination() {
union(){
// head
intersection() {
translate([0,-10,300]) sphere(85, $fa=5, $fs=0.1); 
translate([0,10,300]) sphere(85, $fa=5, $fs=0.1); 
}
// ears
translate([60,0,350]) sphere(25, $fa=5, $fs=0.1); 
translate([-60,0,350]) sphere(25, $fa=5, $fs=0.1); 
// nose
translate([0,60,270]) sphere(30, $fa=5, $fs=0.1); 
// eyes
translate([35,65,310]) sphere(10, $fa=5, $fs=0.1); 
translate([-35,65,310]) sphere(10, $fa=5, $fs=0.1); 
}
union() {
// body
translate([0,0,95]) sphere(110, $fa=5, $fs=0.1); 
translate([0,0,135]) sphere(110, $fa=5, $fs=0.1); 
// arms
translate([62,10,130]) rotate ([0,97,95]) cylinder(160,28,20);
translate([-62,10,130]) rotate ([0,97,85]) cylinder(160,28,20); 
// shoulders
translate([62,20,130]) sphere(25, $fa=5, $fs=0.1); 
translate([-62,20,130]) sphere(25, $fa=5, $fs=0.1); 
// hands
translate([52,167,115]) sphere(20, $fa=5, $fs=0.1); 
translate([-52,167,115]) sphere(20, $fa=5, $fs=0.1); 
// steering
translate([-70,170,100]) rotate ([0,90,0]) cylinder(140,10,10); 
translate([66,171,100]) rotate ([30,90,0]) cylinder(35,10,10); 
translate([-96,154,100]) rotate ([-30,90,0]) cylinder(35,10,10); 
translate([0,171,0]) rotate ([0,0,0]) cylinder(100,10,10); 
// feet
translate([40,70,40]) sphere(50, $fa=5, $fs=0.1); 
translate([-40,70,40]) sphere(50, $fa=5, $fs=0.1); 
}
}

//internal electronics
module internal_electronics() {
//battery
translate([0,45,28]) color ("grey") lifepo4(); 

//board holders
//board1 - cubieboard or ucff
union() {
translate([38,-35,88]) rotate([90,0,75])
union() { universal_board_holder(); translate([30,-50,20]) rotate([0,0,90]) color ("brown") cubieboard(); }
}

//board2 seeeduino+motorcontroller
union() {
translate([8,-35,88]) rotate([90,0,90])
union() { universal_board_holder(); translate([0,30,8]) rotate([0,0,90]) color ("red") seeeduino(); translate([0,-25,8]) rotate([0,0,90]) color ("darkgreen") md25(); }
}

//usbhub on back of board2+3
 color ("lightblue") translate([0,-85,90]) rotate([90,0,0]) usbhub();

//board3 audio+maple
union() {
translate([-22,-35,88]) rotate([90,0,90])
union() {
 universal_board_holder();
 translate([0,15,8]) rotate([0,0,90]) color ("red") maple();
 color ("darkgreen") translate([-20,-35,8]) rotate([0,0,270]) emic2();
 color ("darkblue") translate([7,-42,8]) rotate([0,0,270]) amplifier();
 //FIXME levelshifter needs own module
 color ("lightblue") translate([18,-29,8]) rotate([0,0,270]) cube([25,20,2]);
}
}

//board4 - power+lcd
union() {
translate([-52,-35,88]) rotate([90,0,105]) 
union() {
 universal_board_holder(); 
 color ("green") translate([-10,40,8]) rotate([0,0,90]) currentsensor();
 color ("red") translate([-30,30,8]) rotate([0,0,90]) pololu5v();
 color ("red") translate([-30,-5,8]) rotate([0,0,90]) traco9v();
 color ("red") translate([-30,-25,8]) rotate([0,0,90]) lt1085();
 color ("red") translate([-30,-45,8]) rotate([0,0,90]) lt1086();
 color ("orange") translate([-3,-10,15]) rotate([0,180,180]) lcd03();
 //FIXME Matrix-Driver Module
 color ("pink") translate([15,-35,8]) cube([40,30,5],true);
 //FIXME Dynamixel Driver Module
 color ("lightblue") translate([18,38,8]) cube([30,30,5],true);
}
 }
//servos
color ("red") translate([0,-9,225]) scale([10,10,10]) rotate([0,0,270]) ax12a();
color ("blue") translate([0,-9,285]) scale([10,10,10]) rotate([0,90,0]) ax12a();
/* FIXME not yet used servos
color ("lightgreen") translate([-74,-45,28]) scale([1,1,1]) rotate([0,0,90]) servo();
color ("green") translate([97,-45,28]) scale([1,1,1]) rotate([0,0,90]) servo();
*/
}

//***
face_chassis_height=3;
face_chassis_width=60;
face_chassis_length=140;
face_chassis_length2=20;
face_chassis_width2=10;
face_chassis_height2=6;
face_chassis_length3=80;
face_chassis_width3=70;

module face_chassis_base() {
 translate ([-face_chassis_length/2,-face_chassis_width/2,0]) {
  cube([face_chassis_length,face_chassis_width,face_chassis_height]);
 }
}

module face_chassis_base2() {
 translate ([-face_chassis_length3/2,-face_chassis_width3-face_chassis_width/2,0]) {
  cube([face_chassis_length3,face_chassis_width3,face_chassis_height]);
 }
}

module face_chassis_delcube() {
  rotate([0,0,45]) translate([0,0,-1]) cube([43,43,5]);
}

module face_chassis_delcube2() {
  color ("blue") rotate([0,0,45]) translate([0,0,-1]) cube([10,10,5]);
}

module face_chassis_cube1() {
  color ("red") cube([face_chassis_length2,face_chassis_width2,face_chassis_height2]);
}

module face_chassis_cube2() {
 color ("blue") cube([face_chassis_length2*2,face_chassis_width2,face_chassis_height2]);
}

module face_chassis_mouth_inner() {
 translate ([-23,-90,-1]) cube([46,40,5]);
 color ("green") translate ([-28,-90,2]) cube([56,40,3]);
}

module face_chassis_steg1() {
 translate ([-face_chassis_length/2,0,0]) {
  face_chassis_cube1();
 }
 translate ([face_chassis_length/2-face_chassis_length2,0,0]) {
  face_chassis_cube1();
 }
 translate ([-face_chassis_length2,0,0]) {
  face_chassis_cube2();
 }
}

module face_chassis_steg2() {
 translate ([0,face_chassis_width/2-face_chassis_width2,0]) {
  face_chassis_steg1();
 }
}

module face_chassis_nose() {
 difference() {
  translate ([0,-30,0]) cylinder(face_chassis_height2+10,15,15);
  translate ([0,-30,face_chassis_height2+10-3]) cylinder(face_chassis_height2+10,12.5,12.5);
 }
}


module face_chassis() {
 difference() {
union() {
// nose podest for 20mm LED
color ("orange") face_chassis_nose();

//upper base - 45deg sides
difference()
{
 face_chassis_base();
 union() {
  translate ([-face_chassis_length/2,-face_chassis_width,0]) face_chassis_delcube();
  translate ([face_chassis_length/2,-face_chassis_width,0]) face_chassis_delcube();
 }
}

//lower base - mouth - edges
difference() {
 difference()
 {
  face_chassis_base2();
  union() {
   translate ([-face_chassis_length2-20,-face_chassis_width-47,0]) face_chassis_delcube2();
   translate ([face_chassis_length2+20,-face_chassis_width-47,0]) face_chassis_delcube2();
  }
 }
 face_chassis_mouth_inner();
}

// stability for bolts
face_chassis_steg1();
face_chassis_steg2();
}
  union() {
  translate ([0,-30,-1]) cylinder(face_chassis_height2+20,10,10);
  translate ([-35,0,-1]) cylinder(face_chassis_height2+20,10,10);
  translate ([35,0,-1]) cylinder(face_chassis_height2+20,10,10);
  }
 }
}
//***

//****

face_mount_h=3;
face_mount_m=2.5;
module face_mount() {

difference() {
//base plate
color ("yellow") translate([-85/2,-56/2,0]) cube([85,56,face_mount_h]);
//holes
union() {
translate ([-19+26/2-8,16,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2+8,16,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);

translate ([-19+26/2-8,8,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2,8,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2+8,8,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);

translate ([-19+26/2-8,0,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2,0,-1]) cylinder(face_mount_h+2,3,3);
translate ([-19+26/2+8,0,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);

translate ([-19+26/2-8,-8,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2,-8,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2+8,-8,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);

translate ([-19+26/2-8,-16,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2+8,-16,-1]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
}
}

//horizontal wall
difference() {
color ("orange") translate([-85/2,25,0]) cube([85,face_mount_h,20]);
union() {
translate ([-19+26/2-8,56/2+1,10+face_mount_h]) rotate([90,0,0]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2+8,56/2+1,10+face_mount_h]) rotate([90,0,0]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
}
}



difference() {
color ("blue") translate([-85/2,-28,0]) cube([85,face_mount_h,20]);
union() {
translate ([-19+26/2-8,-56/2+face_mount_h+1,10+face_mount_h]) rotate([90,0,0]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
translate ([-19+26/2+8,-56/2+face_mount_h+1,10+face_mount_h]) rotate([90,0,0]) cylinder(face_mount_h+2,face_mount_m/2,face_mount_m/2);
}
}

//vertikal wall
color ("black") translate([-42.5,-56/2,0]) cube([face_mount_h,56,20]);
color ("pink") translate([39.50,-56/2,0]) cube([face_mount_h,56,20]);
color ("pink") translate([-42.5/2-10,-56/2,3]) cube([face_mount_h,56,3]);
color ("pink") translate([42.5/2-1.5,-56/2,3]) cube([face_mount_h,56,3]);

//middle parts
color ("darkgreen") translate([-19,25-face_mount_h,face_mount_h]) cube([26,face_mount_h,face_mount_h]);
color ("red") translate([-19,-28+face_mount_h,face_mount_h]) cube([26,face_mount_h,face_mount_h]);

}

//****

//*****
module sensors() {
 //rear sonar (+6 degrees = 20cm higher at 2m distance + 8cm of sensor height)
 translate([0,-86,15]) rotate([-90-6,180,180]) hcsr04();
 //front sonar (+6 degrees = 20cm higher at 2m distance + 8cm of sensor height)
 translate([0,187,15]) rotate([-90-6,180,0]) hcsr04();
 //left sonar (+6 degrees = 20cm higher at 2m distance + 8cm of sensor height)
 translate([-75,108,15]) rotate([-90-6,180,52]) hcsr04();
 //right sonar (+6 degrees = 20cm higher at 2m distance + 8cm of sensor height)
 translate([75,108,15]) rotate([-90-6,180,-52]) hcsr04();
 //front infrared
 translate([0,180,100]) rotate([-30,180,0]) sharp();
 //left speaker
 translate([35,65,148]) rotate([-125,-90,0]) color("grey") speaker();
 //right speaker
 translate([-35,65,148]) rotate([-55,-90,0]) color("grey") speaker();
}
module sensor_cones() {
 //rear sonar detection cone
 %translate([0,-106,17]) rotate([90-6,0,0]) cylinder(2000,2.8,280);
 //front sonar detection cone
 %translate([0,207,17]) rotate([90-6,0,180]) cylinder(2000,2.8,280);
 //left sonar detection cone
 %translate([-92,123,17]) rotate([90-6,0,180+52]) cylinder(2000,2.8,280);
 //right sonar detection cone
 %translate([92,123,17]) rotate([90-6,0,180-52]) cylinder(2000,2.8,280);
 //front infrared detection cone
 %translate([0,190,85]) rotate([-30,180,0]) cylinder(800,0.5,25);
}
//*****

//******
module upper_holder() {
 union() {
translate([0,-37,208]) color ("red") linear_extrude(height = 3, center = false, convexity = 10, twist = 0, $fn = 100) polygon([[-40,-40],[40,-40],[75,50],[-75,50]]);
//color ("blue") translate([0,13,143.5]) cube([150,3,15],true);
 }
}

module nuc_holder() {
//nuc
translate([0,-37,148]) color ("black") translate([0,40,55/2+3]) cube([122,122,55],true);
translate([0,-37,148]) difference() {
 union() {
color ("red") linear_extrude(height = 3, center = false, convexity = 10, twist = 0, $fn = 100) polygon([[-40,-40],[40,-40],[75,50],[-75,50]]);
color ("blue") translate([39,-29,60/2]) rotate([0,0,69]) cube([20,10,60],true);
color ("yellow") translate([-39,-29,60/2]) rotate([0,0,-69]) cube([20,10,60],true);
color ("green") translate([65,38,60/2]) rotate([0,0,69]) cube([20,10,60],true);
color ("orange") translate([-65,38,60/2]) rotate([0,0,-69]) cube([20,10,60],true);
//NUC and screwing deletions
 }
union() {
color ("black") translate([0,40,55/2+3]) cube([122,122,55],true);
color ("red") translate([-67.5,37,20/2+3]) rotate([0,0,-69]) cube([10,6,20],true);
color ("dark green") translate([67.5,37,20/2+3]) rotate([0,0,69]) cube([10,6,20],true);
color ("red") translate([-67.5,37,20/2-3+40]) rotate([0,0,-69]) cube([10,6,20],true);
color ("dark green") translate([67.5,37,20/2-3+40]) rotate([0,0,69]) cube([10,6,20],true);
color ("white") translate([-42,-30,20/2+3]) rotate([0,0,-69]) cube([10,6,20],true);
color ("white") translate([42,-30,20/2+3]) rotate([0,0,69]) cube([10,6,20],true);
color ("white") translate([-42,-30,20/2-3+40]) rotate([0,0,-69]) cube([10,6,20],true);
color ("white") translate([42,-30,20/2-3+40]) rotate([0,0,69]) cube([10,6,20],true);
}
}
}


module bat_holder() {
bat_holder_length=150;
bat_holder_width=3;
bat_holder_height=115;
bat_holder_bottom_width=16;
color ("blue") translate([0,79,86]) cube([bat_holder_length,bat_holder_width,bat_holder_height],true);
color ("green") translate([0,88,30]) cube([bat_holder_length,bat_holder_bottom_width,bat_holder_width],true);
translate([0,88,31]) rotate([0,0,0]) color ("orange") minimu();
}

module bat_upper() {
bat_upper_length=150;
bat_upper_width=3;
bat_upper_height=15;
bat_upper_bottom_width=60;
color ("lightblue") translate([0,16.5,143.5]) cube([bat_upper_length,bat_upper_width,bat_upper_height],true);
color ("lightblue") translate([0,75.5,139.7]) cube([bat_upper_length,bat_upper_width,bat_upper_height-7.5],true);
color ("green") translate([0,46,137.5]) cube([bat_upper_length,bat_upper_bottom_width,bat_upper_width],true);
}

//******


// dreirad
translate([0,0,-120]) union() {
// plot body on top of dreirad
% difference() {
	imagination();
	hull() {
		color ("blue") translate ([0,0,-5]) cube ([base_plate_rear_width,base_plate_rear_length,60],true);
		color ("green") translate ([0,base_plate_rear_length/2,-5]) cube ([base_plate_front_width,base_plate_front_length,60],true);
	}
}
 model();
 union() {
 translate([0,25,310]) rotate([90,0,180]) face_chassis();
 // micro left
 translate([-71,27,330]) rotate([-180,90,0]) micromems();
 //micro right
 translate([70,27,330]) rotate([0,90,0]) micromems();
 // micro front
 translate([0,40,330]) rotate([0,90,90]) micromems();
 // mouthmatrix
//FIXME mouthmatrix wrong values TA711 instead 2111
 translate([0,40,243]) rotate([90,0,180]) mouthmatrix();
 // noseRGB
 translate([0,42,280]) rotate([90,0,180]) noseRGB();
 }
 union() {
 translate([0,-15,310]) rotate([0,180,90]) face_mount();
 translate([20,-35,310]) gps();
 }
 internal_electronics();
 sensors();
 //sensor_cones();
 upper_holder();
 nuc_holder();
 bat_holder();
 bat_upper();
}
