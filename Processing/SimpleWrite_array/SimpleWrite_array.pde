/**
 * Simple Write Array.
 *
 * Check if the mouse is over a rectangle and writes an array of ints to the serial port.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int mask = 0x000000FF;

int maxLED = 12;

int[] LEDArray = new int[37]; // id, rgb * 12  

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
/*
byte[] generate_msg(int[] v) {
 byte[] result = new byte[7];
 result[0] = byte('<');
 for (int i = 0; i < 6; i ++) {
 result[i+1] = byte(v[i] & mask);
 }
 return result;
 }
 */

byte[] generate_msg_1(int[] v) {
  byte[] result = new byte[20];
  result[0] = byte('<');
  result[1] = byte(v[0] & mask);
  for (int i = 0; i < 18; i ++) {
    result[i+2] = byte(v[i + 1] & mask);
  }
  return result;
}

byte[] generate_msg_2 (int[] v) {
  byte[] result = new byte[20];
  result[0] = byte('>');
  result[1] = byte(v[0] & mask);
  for (int i = 0; i < 18; i ++) {
    result[i + 2] = byte(v[i + 1 + 18] & mask);
  }
  return result;
}

void draw() {

  background(255);

  /*
   val[0] = index
   val[1] =  R
   val[2] =  G
   val[3] =  B
   val[3] =  A
   val[4] = garmet index
   */

  //setMsg(0, (int)map(mouseX, 0, width, 0, 255), (int)map(mouseY, 0, height, 0, 255), 0, 255, 0);
}

void keyPressed() {
  if (key == '1') {
    turnOff();
    setMsg(0, 255, 0, 0, 0);
  }

  if (key == '2') {
    turnOff();
    setMsg(11, 255, 0, 0, 0);
  }

  if (key == '3') {
    turnOff();
  }

  if (key == '4') {
    //turnOff();
    turnOn(255, 0, 0, 255);
  }

  if (key == '5') {
    //turnOff();
    turnOn(0, 255, 0, 255);
  }

  if (key == '6') {
    //turnOff();
    turnOn(0, 0, 255, 255);
  }

  if (key == '7') {
    //turnOff();
    turnOn(0, 255, 255, 255);
  }

  if (key == '8') {
    setMsg(5, 0, 0, 255, 0);
  }
  sendMsg();
}



void turnOff() {
  for (int i = 0; i < maxLED; i++) {
    setMsg(i, 0, 0, 0, 0);
  }
}

void turnOn(int r, int g, int b, int a ) {
  for (int i = 0; i < maxLED; i++) {
    setMsg(i, r, g, b, 0);
  }
}

/*
void setMsg(int index, int r, int g, int b, int a, int garmentId) {
 int [] msgInt  = {index, r, g, b, a, garmentId};
 byte[] msg = generate_msg(msgInt);
 myPort.write(msg);
 }
 */

void setMsg(int index, int r, int g, int b, int garmentId) {  
  LEDArray[0] = garmentId;
  LEDArray[index * 3 + 1] = r;
  LEDArray[index * 3 + 2] = g;
  LEDArray[index * 3 + 3] = b;
}

void sendMsg() {
  byte[] msg = generate_msg_1(LEDArray); 
  myPort.write(msg);

  byte[] msg2 = generate_msg_2(LEDArray); 
  myPort.write(msg2);
  println(msg);
  println(msg2);

  byte[] result = new byte[40];
  for (int i =0; i < 20; i++) {
    result[i] = msg[i];
  }
  for (int i =0; i < 20; i++) {
    result[i+20] = msg2[i];
  }
  myPort.write(result);
}

boolean mouseOverRect() { // Test if mouse is over square
  return ((mouseX >= 50) && (mouseX <= 150) && (mouseY >= 50) && (mouseY <= 150));
}
