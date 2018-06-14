#define JOYSTICK_X A1
#define JOYSTICK_Y A2

void setup() {
  // put your setup code here, to run once:
  pinMode(JOYSTICK_X, INPUT);
  pinMode(JOYSTICK_Y, INPUT);
  Serial.begin(9600);
}

float result = 0.f;

void loop() {
  // put your main code here, to run repeatedly:
  result = (float) analogRead(JOYSTICK_X);
  result = mapfloat(result, 0, 1023, -1, 1);
  Serial.println(String(result));
  delay(50);
}

float mapfloat(float x, float in_min, float in_max, float out_min, float out_max)
{
 return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
