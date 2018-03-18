/*
3D Druck Universal Platinenhalter
Platine allein, keine Sink, wg. Befestigung R�ckseite 85x115
2.5mm outline

1.5mm height inner
+ 1.5mm height upper

Befestigungsnase auf R�ckseite
komplette breite height 10mm

keine Bohrl�cher vorab
*/

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
