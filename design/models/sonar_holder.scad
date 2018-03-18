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
 translate([0,0,-10]) rotate([-90-6,180,180]) 
	union() {
	translate([-hcsr04_length/2+hcsr04_trans_radius+hcsr04_board_thickness/2,0,hcsr04_board_thickness]) cylinder(hcsr04_height-hcsr04_board_thickness,hcsr04_trans_radius,hcsr04_trans_radius);
	translate([hcsr04_length/2-hcsr04_trans_radius-hcsr04_board_thickness/2,0,hcsr04_board_thickness]) cylinder(hcsr04_height-hcsr04_board_thickness,hcsr04_trans_radius,hcsr04_trans_radius);
	translate([0,0,hcsr04_board_thickness/2]) cube([hcsr04_length,hcsr04_width,hcsr04_board_thickness],true);
	hull() {
		translate([-hcsr04_quartz_distance/2,hcsr04_width/2-hcsr04_quartz_height,hcsr04_board_thickness]) cylinder(hcsr04_quartz_height,hcsr04_quartz_radius,hcsr04_quartz_radius,$fn=100);
		translate([hcsr04_quartz_distance/2,hcsr04_width/2-hcsr04_quartz_height,hcsr04_board_thickness]) cylinder(hcsr04_quartz_height,hcsr04_quartz_radius,hcsr04_quartz_radius,$fn=100);
	}	
  }
}


module sonar_holder() {
difference() {
	//mount horiz
	color ("green") translate([0,1,1.5/2]) cube([50,30,1.5],true);
	union() {
	//taps
	color("blue") translate([-15,8,-2]) cylinder(h=5,r=1.5,$fn=100);
	color("blue") translate([0,8,-2]) cylinder(h=5,r=4,$fn=100);
	color("blue") translate([15,8,-2]) cylinder(h=5,r=1.5,$fn=100);
 	}
}

difference() {
	//mount vert
	color ("orange") translate([0,-9,-20/2]) cube([50,10,20],true);
 	hcsr04();
}

color ("red") translate([-25,0,-20]) rotate ([0,90,0]) linear_extrude(height = 2.5) polygon([[0,-4],[-20,16],[-20,-4]]);
color ("red") translate([25-2.5,0,-20]) rotate ([0,90,0]) linear_extrude(height = 2.5) polygon([[0,-4],[-20,16],[-20,-4]]);
}

translate ([0,0,3/2]) rotate([0,180,0]) sonar_holder();