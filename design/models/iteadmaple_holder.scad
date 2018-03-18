/*
3D Druck ITeadMaple Platinenhalter
Platine allein, keine Sink, wg. Befestigung R�ckseite 54x69
2.5mm outline

1.5mm height inner
+ 1.5mm height upper

Befestigungsnase auf R�ckseite
komplette breite height 10mm

keine Bohrl�cher vorab
*/

maple_board_length=54;
maple_board_width=69;
maple_board_height=1.5;
maple_board_outline=2.5;
maple_board_holder=10;
module maple_board_holder() {
	translate ([0,0,maple_board_outline/2]) cube([maple_board_length+maple_board_outline*2,maple_board_width+maple_board_outline*2,maple_board_outline],true);
	translate ([maple_board_length/2,(-maple_board_width-maple_board_outline*2)/2,maple_board_height]) cube([maple_board_outline,maple_board_width+maple_board_outline*2,maple_board_holder]);
}
//maple_board_holder();
