// makerbeam 90 degrees cornerbracket

width=10;
length=10;
height=1.5;
tapradius=3/2;
$fn=100;

module tap() {
 translate([length/1.5,width/2,-height]) cylinder(r=tapradius,h=3*height);
}

module wing() {
 difference() {
  cube([length, width,height]);
  tap();
 }
}

module cornerbracket() {
 wing();
 translate([height,0,0]) rotate([0,-90,0]) wing();
}

cornerbracket();

