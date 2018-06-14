#define ACC_X A1
#define ACC_Y A2
#define ACC_Z A3

void setup() {
  // put your setup code here, to run once:
  pinMode(ACC_X, INPUT);
  pinMode(ACC_Y, INPUT);
  pinMode(ACC_Z, INPUT);
  Serial.begin(9600);
}

float acc[3] = {0., 0., 0.};

void loop() {
  // put your main code here, to run repeatedly:
  acc[0] = (float) analogRead(ACC_X);
  acc[1] = (float) analogRead(ACC_Y);
  acc[2] = (float) analogRead(ACC_Z);

  acc[0] = mapfloat(acc[0], 0, 1023, -1, 1);
  acc[1] = mapfloat(acc[1], 0, 1023, -1, 1);
  acc[2] = mapfloat(acc[2], 0, 1023, -1, 1);
  
  Serial.println(String(acc[0]) + " " + String(acc[1]) + " " + String(acc[2]));
  delay(33);
}

float mapfloat(float x, float in_min, float in_max, float out_min, float out_max)
{
 return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
