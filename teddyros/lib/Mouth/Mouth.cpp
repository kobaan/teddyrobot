#include "Mouth.h"

void Mouth::setSprite(byte *sprite){
    for(int r = 0; r < 7; r++){ // we only use 7 rows
        lc.setRow(0, r, sprite[r]<<3); // shift 3 bits as we use only 5 columns
    }
}

void Mouth::Setup(int dataPin=4, int clkPin=5, int csPin=6, int numDevices=1) {
  lc = LedControl(dataPin, clkPin, csPin, numDevices);
  // The MAX72XX is in power-saving mode on startup,
  // we have to do a wakeup call
  lc.shutdown(0,false);
  // Set the brightness to a medium values
  lc.setIntensity(0, 15);
  // and clear the display
  lc.clearDisplay(0);
  mouthtimer=millis();
  mouthcounter=0;
}

void Mouth::Update() {
  if ((millis()-mouthtimer)>=130) {
	mouthtimer=millis();
    switch(mouthcounter) {
      case 0:  setSprite(test0); break;
      case 1:  setSprite(test1); break;
      case 2:  setSprite(test2); break;
      case 3:  setSprite(test3); break;
      case 4:  setSprite(test4); break;
      case 5:  setSprite(test5); break;
      case 6:  setSprite(test6); break;
      case 7:  setSprite(test7); break;
      case 8:  setSprite(test8); break;
      case 9:  setSprite(test9); break;
      case 10:  setSprite(test10); break;
      case 11:  setSprite(test11); break;
      case 12:  setSprite(test12); break;
      case 13:  setSprite(test13); break;
      case 14:  setSprite(test14); break;
      case 15:  setSprite(test15); break;
    }
   mouthcounter++;
   if (mouthcounter>=15) mouthcounter=0;
  }
}
