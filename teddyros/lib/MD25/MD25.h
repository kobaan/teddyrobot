#ifndef MD25_h
#define MD25_h

#define CMD                 0x10			      // Command register
#define MODE                0x0F			      // Mode register
#define ACCELOFF	    0x30			      // disable acceleration
#define ACCELON	 	    0x31			      // enable acceleration
#define MD25ADDRESS         0x58                              // Address of the MD25
#define SOFTWAREREG         0x0D                              // Byte to read the software version, Values of 0 eing sent using write have to be cast as a byte to stop them being misinterperted as NULL
#define SPEED1              (byte)0x00                        // Byte to send speed to first motor
#define SPEED2              0x01                              // Byte to send speed to second motor
#define ENCODERONE          0x02                              // Byte to read motor encoder 1
#define ENCODERTWO          0x06                              // Byte to read motor encoder 2
#define VOLTREAD            0x0A                              // Byte to read battery volts
#define CURR1READ           0x0B                              // Byte to read current of motor1
#define CURR2READ           0x0C                              // Byte to read current of motor2
#define RESETENCODERS       0x20

class MD25
{
  public:
	void init();
	void Update();
	char getSoft();
	void encodeReset();
	void setMode(int mode);
	void enableAcceleration(bool accel);
	long encoder1();
	long encoder2();
	int volts();
	int current1();
	int current2();
	void stopMotor();
	void setM1Speed(int speed);
	void setM2Speed(int speed);
};

#endif
