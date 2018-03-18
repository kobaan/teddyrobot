// makeblock beam parametric

/* length holes
Beam0824-016	16	2	Blue	Gold
Beam0824-032	32	4	Blue	Gold
Beam0824-048	48	6	Blue	Gold
Beam0824-064	64	8	Blue	Gold
Beam0824-080	80	10	Blue	Gold
Beam0824-096	96	12	Blue	Gold
Beam0824-112	112	14	Blue	Gold
Beam0824-128	128	16	Blue	Gold
Beam0824-144	144	18	Blue	Gold
Beam0824-160	160	20	Blue	Gold
Beam0824-176	176	22	Blue	Gold
Beam0824-192	192	24	Blue	Gold
Beam0824-496	496	30	Blue	Gold
*/

tap_dia=4/2;
base_height=8;
overcut=2;
quality=20;

module connector_tap() {
	union() {
		// top taps
		translate([8,0,0]) cylinder(r=tap_dia,h=base_height+overcut,center=true,$fn=quality);
		translate([-8,0,0]) cylinder(r=tap_dia,h=base_height+overcut,center=true,$fn=quality);

		// tap phasing
		translate([8,0,4+2+0.1]) cylinder(r1=tap_dia+1/2,r2=0.1,h=2+0.2,center=true,$fn=quality);
		translate([-8,0,4+2+0.1]) cylinder(r1=tap_dia+1/2,r2=0.1,h=2+0.2,center=true,$fn=quality);

	} // union
}

module beam0824_016() {
	base_middle_height=1.5;
	base_width=24;
	base_length=16;

	tap_side_dia=3.2/2;
	base_single_width=10;

	tap_distance=8;
	tap_phase=90;
	tap_phase_depth=2;

   m4_core=3.2;
   grip=0.4;
   steigung=0.35;

	difference() {
	union() {
		difference() {
		union() {
			// beam
			translate([base_single_width/2+2,0,0]) cube([base_single_width,base_length,base_height],true);
			translate([-base_single_width/2-2,0,0]) cube([base_single_width,base_length,base_height],true);
			translate([0,0,-(base_height-base_middle_height)/2]) cube([base_width,base_length,base_middle_height],true);
		} // union
		union() {
			// no infill
			translate([base_single_width/2+2,0,0]) cube([base_single_width-base_middle_height*2,base_length+overcut,base_height-base_middle_height*2],true);
			translate([-base_single_width/2-2,0,0]) cube([base_single_width-base_middle_height*2,base_length+overcut,base_height-base_middle_height*2],true);
		} // union
		} // difference
		translate([8,0,0]) cube([base_middle_height*2,base_length,base_height],true);
		translate([-8,0,0]) cube([base_middle_height*2,base_length,base_height],true);	
	} // union
	union() {	
		connector_tap();

		// side taps
		translate([8,0,0]) rotate([90,0,0]) cylinder(r=tap_side_dia,h=base_length+overcut,center=true,$fn=quality);
		translate([-8,0,0]) rotate([90,0,0]) cylinder(r=tap_side_dia,h=base_length+overcut,center=true,$fn=quality);
	} // union
	} // difference
	union() {
	translate([(4-grip)/2,0,-steigung]) cube([grip,base_length,steigung],true);
	translate([-(4-grip)/2,0,-steigung]) cube([grip,base_length,steigung],true);
	translate([(4-grip)/2,0,-3*steigung]) cube([grip,base_length,steigung],true);
	translate([-(4-grip)/2,0,-3*steigung]) cube([grip,base_length,steigung],true);
	translate([(4-grip)/2,0,-5*steigung]) cube([grip,base_length,steigung],true);
	translate([-(4-grip)/2,0,-5*steigung]) cube([grip,base_length,steigung],true);
	translate([(4-grip)/2,0,steigung]) cube([grip,base_length,steigung],true);
	translate([-(4-grip)/2,0,steigung]) cube([grip,base_length,steigung],true);
	translate([(4-grip)/2,0,3*steigung]) cube([grip,base_length,steigung],true);
	translate([-(4-grip)/2,0,3*steigung]) cube([grip,base_length,steigung],true);
	translate([(4-grip)/2,0,5*steigung]) cube([grip,base_length,steigung],true);
	translate([-(4-grip)/2,0,5*steigung]) cube([grip,base_length,steigung],true);
	translate([(4-grip)/2,0,7*steigung]) cube([grip,base_length,steigung],true);
	translate([-(4-grip)/2,0,7*steigung]) cube([grip,base_length,steigung],true);

	translate([(4-grip)/2,0,9*steigung]) cube([grip,base_length,steigung],true);
	translate([-(4-grip)/2,0,9*steigung]) cube([grip,base_length,steigung],true);
	} // union
}

module beam0824_032() {
	union() {
		translate([0,-16/2,0]) beam0824_016();
		translate([0,16/2,0]) beam0824_016();
	} // union

	
}

module beam0824_048() {
	translate([0,-8,0])
	union() {
		translate([0,-16/2,0]) beam0824_016();
		translate([0,32/2,0]) beam0824_032();
	} // union
}

module beam0824_064() {
	union() {
		translate([0,-32/2,0]) beam0824_032();
		translate([0,32/2,0]) beam0824_032();
	} // union

	
}

module beam0824_080() {
	translate([0,-8,0])
	union() {
		translate([0,-32/2,0]) beam0824_032();
		translate([0,48/2,0]) beam0824_048();
	} // union
}

module beam0824_096() {
	union() {
		translate([0,-48/2,0]) beam0824_048();
		translate([0,48/2,0]) beam0824_048();
	} // union

	
}

module beam0824_112() {
	translate([0,-8,0])
	union() {
		translate([0,-48/2,0]) beam0824_048();
		translate([0,64/2,0]) beam0824_064();
	} // union
}

module beam0824_128() {
	union() {
		translate([0,-64/2,0]) beam0824_064();
		translate([0,64/2,0]) beam0824_064();
	} // union

	
}

module beam0824_144() {
	translate([0,-8,0])
	union() {
		translate([0,-64/2,0]) beam0824_064();
		translate([0,80/2,0]) beam0824_080();
	} // union
}

module beam0824_160() {
	union() {
		translate([0,-80/2,0]) beam0824_080();
		translate([0,80/2,0]) beam0824_080();
	} // union

	
}

module beam0824_176() {
	translate([0,-24,0])
	union() {
		translate([0,-64/2,0]) beam0824_064();
		translate([0,112/2,0]) beam0824_112();
	} // union
}

module beam0824_192() {
	union() {
		translate([0,-96/2,0]) beam0824_096();
		translate([0,96/2,0]) beam0824_096();
	} // union

	
}

module beam0824_496() {
	translate([0,0,0])
	union() {
		translate([0,-192/2-112/2,0]) beam0824_192();
		translate([0,0,0]) beam0824_112();
		translate([0,192/2+112/2,0]) beam0824_192();

	} // union
}

//beam0824_016();
//beam0824_032();
//beam0824_048();
beam0824_064();
//beam0824_080();
//beam0824_096();
//beam0824_112();
//beam0824_128();
//beam0824_144();
//beam0824_160();
//beam0824_176();
//beam0824_192();
//beam0824_496();

