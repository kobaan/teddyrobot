	pixylength=2.12*25.4; //L inch->mm
	pixywidth=1.75*25.4; //W inch->mm
	camheight=0.8*25.4; //H inch->mm
	pixyheight=1.5; //H PCB
	pixyholediameter=3;
	pixyholedistance=3;
	camradius=8;
	cambaseheight=10;
	cambasewidth=18;
	campcboffset=10;

module pixyholes() {
		union() {
			translate([-pixylength/2+pixyholedistance,-pixywidth/2+pixyholedistance,-1]) rotate([0,0,0]) cylinder(r=pixyholediameter/2,h=pixyheight+20);
			translate([pixylength/2-pixyholedistance,-pixywidth/2+pixyholedistance,-1]) rotate([0,0,0]) cylinder(r=pixyholediameter/2,h=pixyheight+20);
			translate([-pixylength/2+pixyholedistance,pixywidth/2-pixyholedistance,-1]) rotate([0,0,0]) cylinder(r=pixyholediameter/2,h=pixyheight+20);
			translate([pixylength/2-pixyholedistance,pixywidth/2-pixyholedistance,-1]) rotate([0,0,0]) cylinder(r=pixyholediameter/2,h=pixyheight+20);
		}
}

module pixycam() {
	translate([-0.25*25.4,campcboffset,0]) cylinder(r=camradius,h=camheight);
	translate([-cambasewidth/2-0.25*25.4,-cambasewidth/2+campcboffset,0]) cube([cambasewidth,cambasewidth,cambaseheight]);
	difference() {
		translate([-pixylength/2,-pixywidth/2,0]) cube([pixylength,pixywidth,pixyheight]);
		pixyholes();
	};
}

center_offset=30;


mount_thickness=2;
cammount_height=pixywidth+2*mount_thickness;
cammount_inline=16;
cammount_outline=center_offset*2+camheight+cambaseheight;

$fn=20;

module outerbox() {
minkowski() {
cube([cammount_outline/2-9,cammount_height/2,cammount_outline/2-9],true);
translate([0,13,0]) rotate([90,0,0]) cylinder(r=cammount_outline/4-3,h=cammount_height/2);
}
}

module innerbox() {
minkowski() {
cube([cammount_outline/2-10,cammount_height/2+2,cammount_outline/2-10],true);
translate([0,13,0]) rotate([90,0,0]) cylinder(r=cammount_outline/4-5,h=cammount_height/2+2);
}
}

translate([0,0,cammount_height/2-1]) rotate ([90,0,0]) difference() {
outerbox();
union() {
innerbox();
rotate([0,0,0]) translate ([0,0,center_offset]) pixycam();
rotate([0,90,0]) translate ([0,0,center_offset]) pixycam();
rotate([0,180,0]) translate ([0,0,center_offset]) pixycam();
rotate([0,270,0]) translate ([0,0,center_offset]) pixycam();
rotate([0,0,0]) translate ([0,0,center_offset]) pixyholes();
rotate([0,90,0]) translate ([0,0,center_offset]) pixyholes();
rotate([0,180,0]) translate ([0,0,center_offset]) pixyholes();
rotate([0,270,0]) translate ([0,0,center_offset]) pixyholes();
}
}
