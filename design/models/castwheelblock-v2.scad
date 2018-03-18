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

	difference() {
	union() {
   // wider filler socket with sink for caster wheel mount plate
	color ("green") translate ([0,caster_wheel_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height+caster_wheel_mountz+3]) cube ([caster_wheel_mountx+4,caster_wheel_mounty+4,15+caster_wheel_mountz],true);
   


   }
	// TAPS
	union() {
		translate ([-caster_wheel_mountx/2+caster_wheel_tap_offset,caster_wheel_offset-caster_wheel_mounty/2+caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-10]) cylinder (caster_wheel_mountz+20+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2,$fn=100);
		translate ([caster_wheel_mountx/2-caster_wheel_tap_offset,caster_wheel_offset-caster_wheel_mounty/2+caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-10]) cylinder (caster_wheel_mountz+20+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2,$fn=100);
		translate ([-caster_wheel_mountx/2+caster_wheel_tap_offset,caster_wheel_offset+caster_wheel_mounty/2-caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-10]) cylinder (caster_wheel_mountz+20+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2,$fn=100);
		translate ([caster_wheel_mountx/2-caster_wheel_tap_offset,caster_wheel_offset+caster_wheel_mounty/2-caster_wheel_tap_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height-10]) cylinder (caster_wheel_mountz+20+caster_wheel_mountz,caster_wheel_tap/2,caster_wheel_tap/2,$fn=100);
   // caster wheel mount sink
	color ("blue") translate ([0,caster_wheel_offset,caster_wheel_base_height-caster_wheel_axe_offset+caster_wheel_cylinder_height+caster_wheel_mountz-15]) cube ([caster_wheel_mountx,caster_wheel_mounty,20+caster_wheel_mountz],true);
	}
	}
}

rotate([0,180,0]) translate([0,-25,-49.5])  caster_wheel();