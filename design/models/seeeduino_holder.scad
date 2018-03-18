/*
3D Druck Seeeduino Platinenhalter
PLatine allein, keine Sink, wg. Befestigung R�ckseite 47x68
2.5mm outline

1.5mm height inner
+ 1.5mm height upper

Befestigungsnase auf R�ckseite
komplette breite height 10mm

keine Bohrl�cher vorab
*/

seeed_board_length=47;
seeed_board_width=68;
seeed_board_height=1.5;
seeed_board_outline=2.5;
seeed_board_holder=10;
module seeed_board_holder() {
	translate ([0,0,seeed_board_outline/2]) cube([seeed_board_length+seeed_board_outline*2,seeed_board_width+seeed_board_outline*2,seeed_board_outline],true);
	translate ([seeed_board_length/2,(-seeed_board_width-seeed_board_outline*2)/2,seeed_board_height]) cube([seeed_board_outline,seeed_board_width+seeed_board_outline*2,seeed_board_holder]);
}
//seeed_board_holder();

