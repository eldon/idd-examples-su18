// Graphing sketch

// This program takes ASCII-encoded strings from the serial port at 9600 baud
// and graphs them. It expects values in the range 0 to 1023, followed by a
// newline, or newline and carriage return

// created 20 Apr 2005
// updated 24 Nov 2015
// by Tom Igoe
// This example code is in the public domain.

import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
float inFloat = 0;
float threshold = 0;

void setup () {
  // set the window size:
  size(400, 300);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, "/dev/tty.usbmodem1421", 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set initial background:
  background(0);
  redrawThreshold();
}

void draw () {
  // draw the line:
  
  line(xPos, height, xPos, height - inFloat);

  // at the edge of the screen, go back to the beginning:
  if (xPos >= width) {
    xPos = 0;
    background(0);
    redrawThreshold();
  } else {
    // increment the horizontal position:
    xPos++;
  }
}

void keyPressed() {
if (key == CODED) {
    if (keyCode == UP) {
      threshold+=0.05;
    } else if (keyCode == DOWN) {
      threshold-=0.05;
    } 
    redrawThreshold();  
  }
}

void redrawThreshold() {
  background(236,240,241);
  stroke(52,73,94);
  float ty = height-map(threshold,-1.0,1.0,0,height);
  line(0,ty,width,ty);
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inFloat = float(inString);
    
    if(inFloat < threshold) {
      stroke(61,126,155);
    } else {
        stroke(231,76,70);
    }
  
    
    inFloat = map(inFloat, -1.0, 1.0, 0, height);
  }
}
