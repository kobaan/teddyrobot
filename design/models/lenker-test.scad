caster_wheel_mountx=30;
front_wheel_offset=115;

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
	color ("red") translate([0,0,sharp_thickness/2-15]) cube([sharp_distance,sharp_width1,sharp_thickness+30],true);
	color ("yellow") translate([-sharp_distance/2,0,-30]) cylinder(sharp_thickness+30,sharp_length_radius,sharp_length_radius);
	color ("yellow") translate([sharp_distance/2,0,-30]) cylinder(sharp_thickness+30,sharp_length_radius,sharp_length_radius);
	// cube1 to PCB
	color ("green") translate([0,0,(sharp_height1-sharp_height2)/2]) cube([sharp_length1,sharp_width1,sharp_height1-sharp_height2],true);
	// cube2 to cube1
	color ("blue") translate([0,0,sharp_height1/2]) cube([sharp_length1,sharp_width2,sharp_height1-sharp_height3+30],true);
	// cube3 sender
	color ("orange") translate([-sharp_length1/2+sharp_length_sender/2,0,sharp_height1/2]) cube([sharp_length_sender-sharp_inner*2,sharp_width2-sharp_inner*2,sharp_height1],true);
	// cube3 receiver (bigger one)
	color ("pink") translate([sharp_length1/2-sharp_length_receiver/2,0,sharp_height1/2]) cube([sharp_length_receiver-sharp_inner*2,sharp_width2-sharp_inner*2,sharp_height1],true);
	}
	union() {
	// taps
	*color ("brown") translate([-sharp_distance/2,0,-1]) cylinder(sharp_thickness+1.5,sharp_tap_radius,sharp_tap_radius);
	*color ("brown") translate([sharp_distance/2,0,-1]) cylinder(sharp_thickness+1.5,sharp_tap_radius,sharp_tap_radius);
	*color ("brown") translate([-sharp_length1/2+sharp_length_sender/2,0,sharp_height1-1]) cylinder(2,sharp_tap_radius+1.2,sharp_tap_radius+1.2);
	*color ("brown") translate([sharp_length1/2-sharp_length_sender/2,0,sharp_height1-1]) cylinder(2,sharp_tap_radius+1.2,sharp_tap_radius+1.2);
	}
	}
}





module lenker() {
difference() {
translate ([0,0,-50]) union(){

translate([0,0,0]) cylinder(95,15,15);

hull() {
translate([0,8,68+13+5]) rotate ([30,0,0]) cube([48,24,20],true);
translate([0,0,68+17+5]) cube([48,20,10],true);
translate([-70,5,100-20+5]) rotate ([0,90,0]) cylinder(140,10,10);
}


*translate([66,1+5,100-20+5]) rotate ([30,90,0]) cylinder(35,10,10); 
*translate([-96,154-170+5,100-20+5]) rotate ([-30,90,0]) cylinder(35,10,10); 
//vert
//translate([0,1,0]) rotate ([0,0,0]) cylinder(100,10,10); 

}

translate([0,18,-24-base_plate_thickness+5-50]) union() {
 translate([0,-15,112+5]) rotate([-30,180,0]) sharp();
}

}
}


module print_part1() {
difference() {
translate([]) rotate([90,0,0]) lenker();
translate ([0,0,-25]) cube([150,140,50],true);
}
}

module print_part2() {
difference() {
translate([]) rotate([90,0,0]) lenker();
translate ([0,0,25]) cube([150,140,50],true);
}
}


//print_part1();
//rotate ([180,0,0]) 
//print_part2();
rotate ([180,0,0]) print_part2();
