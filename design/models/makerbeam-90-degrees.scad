// makerbeam 90 degrees angle

width=10;
length1=30;
length2=20;
height=1.5;
tapradius=3/2;
$fn=100;

module tap() {
 translate([width/2,width/2,-height]) cylinder(r=tapradius,h=3*height);
}

module wing1() {
 difference() {
  cube([length1,width,height]);
  union() {
   tap();
   translate([width,0,0]) tap();
   translate([2*width,0,0]) tap();
  }
 }
}

module wing2() {
 difference() {
  cube([length2,width,height]);
  union() {
   tap();
   translate([width,0,0]) tap();
  }
 }
}

module angle() {
 wing1();
 translate([width,0,0]) rotate([0,0,90]) wing2();
}

angle();



