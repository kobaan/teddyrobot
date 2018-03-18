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
caster_wheel_base_height=40;
caster_wheel_axe_offset=7;
caster_wheel_axe=5;
caster_wheel_axe_length=25;
caster_wheel_tap=7;
caster_wheel_tap_offset=5;

module caster_wheel() {
/*
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
*/
	// filler socket for caster wheel mount plate
	color ("red") translate ([0,caster_wheel_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height+caster_wheel_mountz+2.5]) cube ([caster_wheel_mountx,caster_wheel_mounty,6+caster_wheel_mountz],true);
/*   }
	// TAPS
	union() {
		translate ([-caster_wheel_mountx/2+caster_wheel_tap_offset,caster_wheel_offset-caster_wheel_mounty/2+caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-1]) cylinder (caster_wheel_mountz+7+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2);
		translate ([caster_wheel_mountx/2-caster_wheel_tap_offset,caster_wheel_offset-caster_wheel_mounty/2+caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-1]) cylinder (caster_wheel_mountz+7+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2);
		translate ([-caster_wheel_mountx/2+caster_wheel_tap_offset,caster_wheel_offset+caster_wheel_mounty/2-caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-1]) cylinder (caster_wheel_mountz+7+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2);
		translate ([caster_wheel_mountx/2-caster_wheel_tap_offset,caster_wheel_offset+caster_wheel_mounty/2-caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-1]) cylinder (caster_wheel_mountz+7+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2);
	}
	}
*/
}

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

module upper_holder() {
 union() {
translate([0,-37,148]) color ("red") linear_extrude(height = 3, center = false, convexity = 10, twist = 0, $fn = 100) polygon([[-40,-40],[40,-40],[75,50],[-75,50]]);
color ("blue") translate([0,13,143.5]) cube([150,3,15],true);
 }
}

module bat_holder() {
bat_holder_length=150;
bat_holder_width=3;
bat_holder_height=115;
bat_holder_bottom_width=16;
color ("blue") translate([0,79,86]) cube([bat_holder_length,bat_holder_width,bat_holder_height],true);
color ("green") translate([0,88,30]) cube([bat_holder_length,bat_holder_bottom_width,bat_holder_width],true);
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


translate([0,-25,-42]) caster_wheel();