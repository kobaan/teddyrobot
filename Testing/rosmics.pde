#include <Sprite.h>
#include <Matrix.h>


byte nNoSoundIterations=0;
byte lastMicArrayIndex=0;
byte lastMouthIndex=0;
long micsUpdateTime=0;
long mouthUpdateTime=0;

MATRIX_DIN_PIN=4;
MATRIX_CLK_PIN=5;
MATRIX_LOAD_PIN=6;
MIC0_ANALOG_PIN=16;
MIC1_ANALOG_PIN=17;
MIC2_ANALOG_PIN=18;
MIC3_ANALOG_PIN=19;

Matrix ledmatrix = Matrix(MATRIX_DIN_PIN, MATRIX_CLK_PIN, MATRIX_LOAD_PIN, 1);

MEMSMics::MEMSMics()
{
}

MEMSMics::~MEMSMics()
{
}

MEMSMics::init()
{
  //Serial.begin(115200);
  //Serial.flush();

  for(int i=0;i<20;i++)
  {
    mics[0][i]=0;
    mics[1][i]=0;
    mics[2][i]=0;
  }
  
  //mouth movements animations
  Sprite mouth1 = Sprite(7, 5,
    B0000000,
    B0000000,
    B1000001,
    B0111110,
    B0000000    
  );
  
  Sprite mouth2 = Sprite(7, 5,
    B0000000,
    B0111110,
    B1000001,
    B0111110,
    B0000000
  );

  Sprite mouth3 = Sprite(7, 5,
    B0111110,
    B1000001
    B1000001,
    B0111110,
    B0000000
  );

  Sprite mouth4 = Sprite(7, 5,
    B0111110,
    B1111111
    B1111111,
    B0111110,
    B0000000
  );
  
  Sprite mouth5 = Sprite(7, 5,
    B0000000,
    B0111110,
    B1111111,
    B0111110,
    B0000000
  );

  //Inicializacin del array de movimiento de la boca que tiene 12 elementos
  for(byte i=0;i<6;i++) movementMouth[i]=i;
  for(byte i=0;i<5;i++) movementMouth[6+i]=4-i;
  movementMouth[11]=6;
  isMouthMoving=true;
  micsUpdateTime=mouthUpdateTime=millis();
}

void MEMSMics::updateMics()
{
  lastMicArrayIndex=(lastMicArrayIndex+1)%20;
  mics[0][lastMicArrayIndex]=analogRead(MIC0_ANALOG_PIN);
  mics[1][lastMicArrayIndex]=analogRead(MIC1_ANALOG_PIN);
  mics[2][lastMicArrayIndex]=analogRead(MIC2_ANALOG_PIN);
  mics[3][lastMicArrayIndex]=analogRead(MIC3_ANALOG_PIN);
  
  // mouth control
  int maxLevel=0;
  unsigned int minLevel=0xFFFF;
  for(int k=0;k<20;k++)
  {
    maxLevel=max(maxLevel,mics[3][k]);
    minLevel=min(minLevel,(unsigned int)mics[3][k]);
  }
  
  // debug mic levels
  SerialUSB.println("maxLevel: ");
  SerialUSB.print(maxLevel);
  SerialUSB.println("minLevel: ");
  SerialUSB.print(minLevel);
  SerialUSB.println("oldMicLevel: ");
  SerialUSB.print(oldMicLevel);
  SerialUSB.println();
  
  maxLevel-=minLevel;
  oldMicLevel=0;
  if(maxLevel>200)
  {
    oldMicLevel=(min(1200,((maxLevel-200)))*5);
    if(!isMouthMoving)
    {
      lastMouthIndex=0;
      isMouthMoving=true;
      mouthUpdateTime=millis();
    }
    nNoSoundIterations=0;
  }
  else if(isMouthMoving)
  {
    nNoSoundIterations++;
    if(nNoSoundIterations>20)
    {
      nNoSoundIterations=0;
      isMouthMoving=false;
      lastMouthIndex=0;
    }
  }
}

void MEMSMics::updateMouth()
{
}

void MEMSMics::spinOnce()
{
  long now=millis();
  
  // Update Mics
  updateMics();
  
  // Update Mouth
  updateMouth();
  
  if(now-mouthUpdateTime>50)
  {
    mouthUpdateTime+=50;
    if(isMouthMoving)
    {
      switch (min(oldMicLevel/240,4))
      {
      case 1:	ledmatrix.write(0,0,mouth1);
      		break;
      case 2:	ledmatrix.write(0,0,mouth2);
      		break;
      case 3:	ledmatrix.write(0,0,mouth3);
      		break;
      case 4:	ledmatrix.write(0,0,mouth4);
      		break;
      default:	ledmatrix.clear;	
      		break;
      }
    }
    else
    {
    	ledmatrix.clear;
    }
  }
}

MEMSMics mems = MEMSMics();

void setup()
{
	pinMode(MIC0_ANALOG_PIN, INPUT_ANALOG);
	pinMode(MIC1_ANALOG_PIN, INPUT_ANALOG);
	pinMode(MIC2_ANALOG_PIN, INPUT_ANALOG);
	pinMode(MIC3_ANALOG_PIN, INPUT_ANALOG);
	pinMode(MATRIX_DIN_PIN, OUTPUT);
	pinMode(MATRIX_CLK_PIN, OUTPUT);
	pinMode(MATRIX_LOAD_PIN, OUTPUT);
}

void loop()
{
	mems.spinonce();
}