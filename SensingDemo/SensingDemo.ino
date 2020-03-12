#define ACC_X A2
#define ACC_Y A1
#define ACC_Z A0
#define DIST A7
#define JOYSTICK_X A3
#define JOYSTICK_Y A4
#define JOYSTICK_BTN 5
#define PHOTOCELL A5

void setup()  {
  // put your setup code here, to run once:
  Serial.begin(9600);
  analogReadResolution(12);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print("A ");
  Serial.print(String(mapFloat(analogRead(ACC_X), 0, 4096, -1, 1)) + " ");
  Serial.print(String(mapFloat(analogRead(ACC_Y), 0, 4096, -1, 1)) + " ");
  Serial.println(String(mapFloat(analogRead(ACC_Z), 0, 4096, -1, 1)));

  Serial.print("J ");
  Serial.print(String(mapFloat(analogRead(JOYSTICK_X), 0, 4096, -1, 1)) + " ");
  Serial.print(String(mapFloat(analogRead(JOYSTICK_Y), 0, 4096, -1, 1)) + " ");
  Serial.println(String(digitalRead(JOYSTICK_BTN)));

  Serial.print("D ");
  Serial.println(String(mapFloat(analogRead(DIST), 0, 4096, 0, 1)));

  Serial.print("P ");
  Serial.println(String(mapFloat(analogRead(PHOTOCELL), 0, 4096, 0, 1)));

  delay(100);
}

float mapFloat(float x, float in_min, float in_max, float out_min, float out_max)
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
