/*
3D Druck MD25 Platinenhalter
inner sink 52x63
2.5mm outline

1.5mm height inner
+ 1.5mm height upper

Befestigungsnasen
left + right 10mm + 10mm height 10mm
mitte 20mm height 10mm

keine Bohrl�cher vorab
*/

md25_board_length=52;
md25_board_width=63;
md25_board_height=1.5;
md25_board_outline=2.5;
md25_board_holder=10;
module md25_board_holder() {
	difference() {
		translate ([0,0,md25_board_height])  cube([md25_board_length+md25_board_outline*2,md25_board_width+md25_board_outline*2,md25_board_height*2],true);
		translate ([0,0,md25_board_height*2]) cube([md25_board_length,md25_board_width,md25_board_height+2],true);
	}
	translate ([md25_board_length/2,md25_board_width/2+md25_board_outline-md25_board_holder,md25_board_height*2]) cube([md25_board_outline,md25_board_holder,md25_board_holder]);
	translate ([md25_board_length/2,-md25_board_holder,md25_board_height*2]) cube([md25_board_outline,md25_board_holder*2,md25_board_holder]);
	translate ([md25_board_length/2,-md25_board_width/2-md25_board_outline,md25_board_height*2]) cube([md25_board_outline,md25_board_holder,md25_board_holder]);
}
//md25_board_holder();