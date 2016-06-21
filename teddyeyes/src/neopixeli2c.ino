/* left and right 12 Pixel LED Ring
start is upper left counterclockwise
Steps for blink starting from full on:

Step 0)
  **
 *  *
*    *
*    *
 *  *
  **
["1,1,1,1,1,1,1,1,1,1,1,1"]

Step 1)

 *  *
*    *
*    *
 *  *
  **
["0,1,1,1,1,1,1,1,1,1,1,0"]

Step 2)

*    *
*    *
 *  *
  **
["0,0,1,1,1,1,1,1,1,1,0,0"]

Step 3)

*    *
 *  *
  **
["0,0,0,1,1,1,1,1,1,0,0,0"]

Step 4)

 *  *
  **
["0,0,0,0,1,1,1,1,0,0,0,0"]

Step 5)

  **
["0,0,0,0,0,1,1,0,0,0,0,0"]

Step 6)

  to full off 
["0,0,0,0,0,0,0,0,0,0,0,0"]

Step 7)
  **
 *  *
*    *
  brows only 
["1,1,1,0,0,0,0,0,0,1,1,1"]

Eyes left and right are symmetric handled
as well as one eye itself is vertically symmetric
*/
/*
using this light library
https://github.com/cpldcpu/light_ws2812/tree/master/light_ws2812_Arduino/light_WS2812
*/

// arduino slave internal
#include <Wire.h>
#include <WS2812.h>
WS2812 LED(24); // 12+12 Neopixel Ring
cRGB color;
cRGB dark;

#define EYES_OFF 0
#define EYES_ON 1
#define EYES_BLINK 2
#define EYES_OPEN 3
#define EYES_CLOSE 4
#define EYES_BROWS 5

uint8_t eyeMode = EYES_CLOSE; // Start with eyes closed
uint8_t animState = 0; // current eyes animation state

#define I2CADDR 17
void setEyeState(uint8_t eyestate, cRGB color);

unsigned long blink_check_timer;
const int BLINK_INTERVAL = 20;

void setup() {
	color.r = 1; color.g = 1; color.b = 1;
	dark.r=0; dark.g=0; dark.b=0;
	LED.setOutput(6); // Digital Pin 6
	blink_check_timer=millis();
	eyeMode=EYES_OPEN;
	color.r = 5;
	color.g = 0;
	color.b = 0;
	Wire.begin(I2CADDR);
	Wire.onReceive(receiveEvent);
}

void receiveEvent(int numBytes)
{
  if(Wire.available()>=4)
  {
    eyeMode = (uint8_t)Wire.read();
    color.r = (uint8_t)Wire.read();
    color.g = (uint8_t)Wire.read();
    color.b = (uint8_t)Wire.read();
  }
}

void blinkEyes()
{
  static int blinkTimer = 0;
  // if Eyes are enabled
  if( eyeMode == EYES_ON )
  {
    // if it's time to blink
    if( 0 == blinkTimer )
    {
      // create a new random blink timer
      blinkTimer = (rand()%180)+20; // Range 20 to 200 * 20ms
      // start the blink animation state
      eyeMode = EYES_BLINK;
      animState = 0;	// start with all pixels on - state 0
    }
    else
    {
      // not yet time to blink - decrease blink timer
      blinkTimer--;
    }
  }
  // Open eyes stage by stage on each call of blinkEyes()
  if( eyeMode == EYES_OPEN )
  {
    // Open Eye in stages ( start at stage 5, count down to 0 )
    setEyeState(animState,color);
    LED.sync();
    if( 0 == animState )
    {
      eyeMode = EYES_ON;	// fully on now, stay on (until the next blink time)
    }
    else
    {
      animState--; // next animation step open eye more
    }
  }
  // Eyes are open and shall blink stage by stage on each call of blinkEyes()
  else if( eyeMode == EYES_BLINK )
  {
    // Close Eye in stages ( start at stage 0, count up to 5 ), and then open again
    setEyeState(animState,color);
    LED.sync();
    if( 6 == animState )
    {
      eyeMode = EYES_OPEN;	// eyes fully closed now, so set to open again
    }
    else
    {
      animState++;
    }
  }
  // Show Eyebrows only
  else if( eyeMode == EYES_BROWS )
  {
    // Only show eye brows
    animState = 7; 
    setEyeState(animState,color);
    LED.sync();
  }
  // Eyes are commanded to close and stay closed
  else if( eyeMode == EYES_CLOSE )
  {
    // Close Eye in stages ( start at stage 0, count up to 5 )
    setEyeState(animState,color);
    LED.sync();
    if( 6 == animState )
    {
      eyeMode = EYES_OFF;	// eyes fully closed now - stay closed
    }
    else
    {
      animState++; // next animation step close eye more
    }
  }
}

// set the different animation states for blink eyes or eye brows or off
void setEyeState(uint8_t eyestate, cRGB col) {
	uint16_t pos;
	for (pos = 0; pos < 24; ++pos){
		LED.set_crgb_at(pos,dark);
	}
	switch (eyestate) {
	case 0: // all on in color
		for (pos = 0; pos < 24; ++pos){
			LED.set_crgb_at(pos,col);
		}
		break;
	case 1: // except line 1
		for (pos = 1; pos < 11; ++pos){
			LED.set_crgb_at(pos,col);
		}
		for (pos = 13; pos < 23; ++pos){
			LED.set_crgb_at(pos,col);
		}
		break;
	case 2: // except line 1+2
		for (pos = 2; pos < 10; ++pos){
			LED.set_crgb_at(pos,col);
		}
		for (pos = 14; pos < 22; ++pos){
			LED.set_crgb_at(pos,col);
		}
		break;
	case 3: // except line 1-3
		for (pos = 3; pos < 9; ++pos){
			LED.set_crgb_at(pos,col);
		}
		for (pos = 15; pos < 21; ++pos){
			LED.set_crgb_at(pos,col);
		}
		break;
	case 4: // except line 1-4
		for (pos = 4; pos < 8; ++pos){
			LED.set_crgb_at(pos,col);
		}
		for (pos = 16; pos < 20; ++pos){
			LED.set_crgb_at(pos,col);
		}
		break;
	case 5: // except line 1-5
		LED.set_crgb_at(5,col);
		LED.set_crgb_at(6,col);
		LED.set_crgb_at(17,col);
		LED.set_crgb_at(18,col);
		break;
	case 6: // all off
		/* do nothing since clear is default now
		for (pos = 0; pos < 24; ++pos){
			LED.set_crgb_at(pos,0);
		}
		*/
		break;
	case 7: // eye brows lines 1-3 on
		LED.set_crgb_at(0,col);
		LED.set_crgb_at(1,col);
		LED.set_crgb_at(2,col);
		LED.set_crgb_at(11,col);
		LED.set_crgb_at(10,col);
		LED.set_crgb_at(9,col);
		LED.set_crgb_at(12,col);
		LED.set_crgb_at(13,col);
		LED.set_crgb_at(14,col);
		LED.set_crgb_at(23,col);
		LED.set_crgb_at(22,col);
		LED.set_crgb_at(21,col);
		break;
	}
}

void loop() {
	// try to run BlinkEyes Routine every 20ms to see if
	// it's time to blink or to continue the blink animation
	if ( (millis()-blink_check_timer) > BLINK_INTERVAL){
		blinkEyes();
 		blink_check_timer += BLINK_INTERVAL;
 	}
}

