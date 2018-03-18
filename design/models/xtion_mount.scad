
height=3;
length=42;
width=38;
x_offset=8.5;
x2_offset=19;
wall=2;

color ("blue") translate([0,0,height]) import("xtion-mount-wide.stl");
module mount() {
hull() {
translate([x_offset,0,height/2]) cube([length,width,height],true);
translate([x2_offset,0,height/2]) cube([length/2,width*2,height],true);
}
color ("red") translate([x2_offset+9.5,0,10/2+height]) cube([wall,width*2,10],true);
color ("red") translate([x2_offset-2.7,0,10/2+height]) cube([wall,width*2,10],true);
}

$fn=60;
difference() {
mount();
union() {
color ("green") translate([-8,8,-1]) cylinder(r=2.5/2, h=15);
color ("green") translate([-8,-8,-1]) cylinder(r=2.5/2, h=15);
color ("green") translate([8,-8,-1]) cylinder(r=2.5/2, h=15);
color ("green") translate([8,8,-1]) cylinder(r=2.5/2, h=15);
color ("green") translate([22.5,-12,-1]) cylinder(r=2.5/2, h=15);
color ("green") translate([22.5,12,-1]) cylinder(r=2.5/2, h=15);
color ("green") translate([22.5,-32,-1]) cylinder(r=2.5/2, h=15);
color ("green") translate([22.5,32,-1]) cylinder(r=2.5/2, h=15);
}
}

//simulate makerbeam rail
//#color ("grey") translate([22.5,0,height+10/2]) cube([10,80,10],true);


