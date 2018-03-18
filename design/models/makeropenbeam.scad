/*

*/

//makerbeam 10x10
module makerbeam(beamlength) {
   width=10;
   edge=(width-3)/2; //3.5
   thick=1;
   inedge=edge-thick; // 2.5
   depth=3;
   middle=2;
   inwidth=(width-middle)/2; //4
	translate([-width/2,-width/2,0])
	linear_extrude(height=beamlength, center=true, convexity=10, twist=0)
	polygon( points=[[0,0],[0,edge],[thick,edge],[thick,inedge],[depth,inwidth],[depth,inwidth+middle],[thick,width-inedge],[thick,width-inedge-thick],[0,width-inedge-thick],[0,width],[edge,width],[edge,width-thick],[inedge,width-thick],[inwidth,width-depth],[inwidth+middle,width-depth],[width-inedge,width-thick],[width-inedge-thick,width-thick],[width-inedge-thick,width],[width,width],[width,width-inedge-thick],[width-thick,width-inedge-thick],[width-thick,width-inedge],[width-depth,inwidth+middle],[width-depth,inwidth],[width-thick,inedge],[width-thick,edge],[width,edge],[width,0],[width-inedge-thick,0],[width-inedge-thick,thick],[width-inedge,thick],[inwidth+middle,depth],[inwidth,depth],[inedge,thick],[edge,thick],[edge,0]] );
}

//makerbeam(20);

//openbeam 15x15
module openbeam(beamlength) {
   width=15;
   edge=(width-3.2)/2; //5.8
   thick=1.5;
   inedge=edge-thick; // 2.5
   depth=4.6;
   middle=2;
   inwidth=(width-middle)/2; //4
   tap=2.7/2;
	$fn=20;
    
   difference() {
	translate([-width/2,-width/2,0])
	linear_extrude(height=beamlength, center=true, convexity=10, twist=0)
	polygon( points=[[0,0],[0,edge],[thick,edge],[thick,inedge],[depth,inwidth],[depth,inwidth+middle],[thick,width-inedge],[thick,width-inedge-thick],[0,width-inedge-thick],[0,width],[edge,width],[edge,width-thick],[inedge,width-thick],[inwidth,width-depth],[inwidth+middle,width-depth],[width-inedge,width-thick],[width-inedge-thick,width-thick],[width-inedge-thick,width],[width,width],[width,width-inedge-thick],[width-thick,width-inedge-thick],[width-thick,width-inedge],[width-depth,inwidth+middle],[width-depth,inwidth],[width-thick,inedge],[width-thick,edge],[width,edge],[width,0],[width-inedge-thick,0],[width-inedge-thick,thick],[width-inedge,thick],[inwidth+middle,depth],[inwidth,depth],[inedge,thick],[edge,thick],[edge,0]] );
	translate([0,0,-beamlength/2-1]) cylinder(r=tap, h=beamlength+2);
	}
}

translate([0,-100+15/2,0]) rotate([0,0,0]) openbeam(200);
translate([0,100-15/2,0]) rotate([0,0,0]) openbeam(200);
translate([0,0,-100-15/2]) rotate([90,0,0]) openbeam(200);
translate([0,0,100+15/2]) rotate([90,0,0]) openbeam(200);


/*
3.5=6.4
6.5=9.7
2.5=5.4
7.5=7.4
*/