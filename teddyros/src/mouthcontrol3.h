#ifndef mouthcontrol_h
#define mouthcontrol_h

long mouthtimer;
int mouthcounter;

byte test0[] = {
B00010,
B00001,
B00001,
B00001,
B00001,
B00001,
B00010
};

byte test1[] = {
B00110,
B00001,
B00001,
B00001,
B00001,
B00001,
B00110
};

byte test2[] = {
B00100,
B00011,
B00001,
B00001,
B00001,
B00011,
B00100
};

byte test3[] = {
B00100,
B00010,
B00001,
B00001,
B00001,
B00010,
B00100
};

byte test4[] = {
B00100,
B00010,
B00010,
B00001,
B00010,
B00010,
B00100
};

byte test5[] = {
B00100,
B00010,
B00010,
B00010,
B00010,
B00010,
B00100
};

byte test6[] = {
B00100,
B00100,
B00010,
B00010,
B00010,
B00100,
B00100
};

byte test7[] = {
B00100,
B00100,
B00100,
B00010,
B00100,
B00100,
B00100
};

byte test8[] = {
B00100,
B00100,
B00100,
B00100,
B00100,
B00100,
B00100
};

byte test9[] = {
B00000,
B00100,
B00100,
B00100,
B00100,
B00100,
B00000
};

byte test10[] = {
B00000,
B00000,
B00100,
B00100,
B00100,
B00000,
B00000
};

byte test11[] = {
B00000,
B00000,
B00000,
B00100,
B00000,
B00000,
B00000
};

byte test12[] = {
B00000,
B00000,
B00000,
B00000,
B00000,
B00000,
B00000
};

byte test13[] = {
B00000,
B00000,
B00000,
B00000,
B00000,
B00000,
B00000
};

byte test14[] = {
B00000,
B00000,
B00000,
B00000,
B00000,
B00000,
B00000
};

byte test15[] = {
B00000,
B00000,
B00000,
B00000,
B00000,
B00000,
B00000
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

byte mouth4[] = {
B00000,
B00000,
B00100,
B00010,
B00100,
B00000,
B00000
};

byte mouth5[] = {
B00000,
B00100,
B00010,
B00100,
B00000,
B00000,
B00000
};

byte mouth6[] = {
B00000,
B00000,
B00000,
B00100,
B00010,
B00100,
B00000
};

byte mouth7[] = {
B00000,
B00000,
B00010,
B00101,
B00010,
B00000,
B00000
};

byte mouth8[] = {
B00000,
B00010,
B00101,
B00101,
B00101,
B00010,
B00000
};

byte mouth9[] = {
B00100,
B01010,
B01001,
B01001,
B01001,
B01010,
B00100
};

byte mouth10[] = {
B00100,
B00010,
B00001,
B00001,
B00001,
B00010,
B00100
};

byte mouth11[] = {
B00000,
B00010,
B00001,
B00001,
B00001,
B00010,
B00000
};

byte mouth12[] = {
B00000,
B00000,
B00001,
B00001,
B00001,
B00000,
B00000
};

//mouth13 is empty
byte mouth13[] = {
B00000,
B00000,
B00000,
B00000,
B00000,
B00000,
B00000
};


// mouth standyby = mouth 13
// mic noise = mouth 13,7,4 middle 5 right 6 left
// smileanim = mouth 13,12,11,10,10,10,11,12,13
// speakanim = mouth 13,4,3,2,3,2,3,4,3,2,3,4,13

void setSprite(byte *sprite, LedControl lc);

void setSprite(byte *sprite, LedControl lc){
    for(int r = 0; r < 7; r++){ // we only use 7 rows
        lc.setRow(0, r, sprite[r]<<3); // shift 3 bits as we use only 5 columns
    }
}

#endif // mouthcontrol_h
