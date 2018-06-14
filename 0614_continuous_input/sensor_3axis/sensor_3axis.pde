// Three-axis Graphing sketch


// This program takes ASCII-encoded strings containing floating point numbers
// from the serial port at 9600 baud and graphs them. It expects values in the
// range -1.0 to 1.0, followed by a newline, or newline and carriage return

// Created 20 Apr 2005
// Updated 18 Jan 2008 by Tom Igoe
// Adapted 16 Sep 2014 by Bjoern Hartmann for mbed
// This example code is in the public domain.

import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
float lastX =0.f, lastY=0.f, lastZ=0.f;
float minVal=-1.0;
float maxVal=1.0;

float xAccScreen = 0;
float yAccScreen = 0;
float zAccScreen = 0;


void setup () {
  // set the window size:
  size(400, 300);        

  // List all the available serial ports
  println(Serial.list());
  // Open whatever port is the one you're using.
  myPort = new Serial(this, "/dev/tty.usbmodem1421", 9600);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background:
  background(0);
}
void draw () {
  // everything happens in the serialEvent()
  stroke(255,0,0);
  line(xPos-1,lastX,xPos,xAccScreen);
  
  stroke(0,196,0);
  line(xPos-1,lastY,xPos,yAccScreen);
  
  stroke(0,0,255);
  line(xPos-1,lastZ,xPos,zAccScreen);
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  float xAcc = float(myPort.readStringUntil(' '));
  float yAcc = float(myPort.readStringUntil(' '));
  float zAcc = float(myPort.readStringUntil('\n'));
  
  println(xAcc);
    
  //draw x line in red
  xAccScreen = height - map(xAcc, minVal, maxVal, 0, height);

  //draw y line in green
  yAccScreen = height - map(yAcc, minVal, maxVal, 0, height);

  //draw z line in blue
  zAccScreen = height - map(zAcc, minVal, maxVal, 0, height);

  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    background(200);
  } else {
    // increment the horizontal position:
    xPos++;
  }
  
  lastX = xAccScreen;
  lastY = yAccScreen;
  lastZ = zAccScreen;
    
}
