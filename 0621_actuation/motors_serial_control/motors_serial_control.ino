#include <Servo.h>

Servo s;
String inputString;
#include <AccelStepper.h>

AccelStepper stepper(AccelStepper::DRIVER, 6, 5);

int val = 0;

void setup() {
  Serial.begin(9600);
  s.attach(9);
  stepper.setMaxSpeed(1500);
  stepper.setAcceleration(1000);
}

void loop() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    inputString += inChar;
    if (inChar == '\n') {
      val = inputString.toInt();
      s.write(val);                  // sets the servo position according to the scaled value
      stepper.moveTo(val);  // move stepper
      analogWrite(10, map(val, 0, 1023, 0, 255));  // move dc brush motor
      Serial.println(inputString);
      inputString = "";
    }
  }
  stepper.run();
}
