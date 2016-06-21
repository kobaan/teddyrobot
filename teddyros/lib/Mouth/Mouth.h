#include "LedControl.h"

#ifndef mouth_h
#define mouth_h

class Mouth
{
  public:
	long mouthtimer;
	int mouthcounter;

byte test0[] = {
B10001,
B00001,
B00001,
B00001,
B00001,
B00001,
B00001
};

byte test1[] = {
B00010,
B10010,
B00010,
B00010,
B00010,
B00010,
B00010
};

byte test2[] = {
B00100,
B00100,
B10100,
B00100,
B00100,
B00100,
B00100
};

byte test3[] = {
B01000,
B01000,
B01000,
B11000,
B01000,
B01000,
B01000
};

byte test4[] = {
B10000,
B10000,
B10000,
B10000,
B10000,
B10000,
B10000
};

byte test5[] = {
B01000,
B01000,
B01000,
B01000,
B11000,
B01000,
B01000
};

byte test6[] = {
B00100,
B00100,
B00100,
B00100,
B00100,
B10100,
B00100
};

byte test7[] = {
B00010,
B00010,
B00010,
B00010,
B00010,
B00010,
B10010
};

byte test8[] = {
B00001,
B00001,
B00001,
B00001,
B00001,
B00001,
B00001
};

byte test9[] = {
B11111,
B00000,
B00000,
B00000,
B00000,
B00000,
B00000
};

byte test10[] = {
B00000,
B11111,
B00000,
B00000,
B00000,
B00000,
B00000
};

byte test11[] = {
B00000,
B00000,
B11111,
B00000,
B00000,
B00000,
B00000
};

byte test12[] = {
B00000,
B00000,
B00000,
B11111,
B00000,
B00000,
B00000
};

byte test13[] = {
B00000,
B00000,
B00000,
B00000,
B11111,
B00000,
B00000
};

byte test14[] = {
B00000,
B00000,
B00000,
B00000,
B00000,
B11111,
B00000
};

byte test15[] = {
B00000,
B00000,
B00000,
B00000,
B00000,
B00000,
B11111
};

byte test[] = {
B11111,
B11111,
B11111,
B11011,
B11111,
B11111,
B11111
};

byte mouth1[] = {
B00110,
B00101,
B00101,
B00101,
B00101,
B00101,
B00110
};

byte mouth2[] = {
B00110,
B01001,
B01001,
B01001,
B01001,
B01001,
B00110
};

byte mouth3[] = {
B00000,
B00100,
B00010,
B00010,
B00010,
B00100,
B00000
};

	void setSprite(byte *sprite);
	void Setup(int dataPin, int clkPin, int csPin, int numDevices);
	void Update();

  private:
	LedControl lc;

};

#endif
