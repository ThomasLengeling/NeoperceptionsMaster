/**
 * Simple Write Array.
 *
 * Check if the mouse is over a rectangle and writes an array of ints to the serial port.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int mask = 0x000000FF;

int maxLED = 12;
int maxGarments = 5;

int[] LEDArray = new int[26]; // id, rgb * 12  

float alphaInc = 0;

void setup()
{

  size(510, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[Serial.list().length -1  ];
  printArray( Serial.list());
  println(portName);

  myPort = new Serial(this, portName, 115200);
}

void draw() {

  background(255);

  turnOn(255, 0, (int)map(mouseX, 0, width, 0, height), int(alphaInc));
  sendMsg();
  
  alphaInc += 1;
  if (alphaInc >=255) {
    alphaInc = 0;
  }
  
  println(alphaInc);
}

void keyPressed() {
  if (key == '1') {
    turnOff();
    setMsg(0, 255, 0, 0, 1, 0);
  }

  if (key == '2') {
    turnOff();
    setMsg(11, 255, 0, 0, 1, 0);
  }

  if (key == '3') {
    turnOff();
  }

  if (key == '4') {
    //turnOff();
    turnOn(255, 0, 0, 50);
  }

  if (key == '5') {
    //turnOff();
    turnOn(255, 0, 0, 150);
  }

  if (key == '6') {
    //turnOff();
    turnOn(255, 0, 0, 200);
  }

  if (key == '7') {
    //turnOff();
    turnOn(255, 0, 0, 255);
  }

  if (key == '8') {
    setMsg(5, 0, 0, 255, 1, 0);
  }
  sendMsg();
}



void turnOff() {
  for (int i = 0; i < maxGarments; i++) {
    setMsg(0, 0, 0, 0, 1, i);
  }
}

void turnOn(int r, int g, int b, int a) {
  for (int i = 0; i < maxGarments; i++) {
    setMsg(r, g, b, a, 1, i);
  }
}


void setMsg(int r, int g, int b, int a, int on, int garmentId) {
  int gIndex = garmentId*5;
  LEDArray[gIndex] = on;
  LEDArray[gIndex + 1] = r;
  LEDArray[gIndex + 2] = g;
  LEDArray[gIndex + 3] = b;
  LEDArray[gIndex + 4] = a;
}

byte[] generate_msg_1(int[] v) {
  byte[] result = new byte[26];
  result[0] = byte('<');
  for (int i = 0; i < 25; i ++) {
    result[i+1] = byte(v[i] & mask);
  }
  return result;
}


void sendMsg() {
  byte[] msg = generate_msg_1(LEDArray); 
  myPort.write(msg);
  println(msg);
}
