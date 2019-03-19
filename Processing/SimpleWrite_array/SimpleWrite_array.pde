/**
 * Simple Write Array.
 *
 * Check if the mouse is over a rectangle and writes an array of ints to the serial port.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int mask = 0x000000FF;

int maxLED = 8;

void setup()
{

  size(510, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, "COM4", 74880);
}

byte[] generate_msg(int[] v) {
  byte[] result = new byte[7];
  result[0] = byte('<');
  for (int i = 0; i < 6; i ++) {
    result[i+1] = byte(v[i] & mask);
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
}

void keyPressed() {
  if (key == '1') {
    turnOff();
    setMsg(0, 255, 0, 0, 255, 0);
  }

  if (key == '2') {
    turnOff();
    setMsg(1, 255, 0, 0, 255, 0);
  }

  if (key == '3') {
    turnOff();
    setMsg(2, 255, 0, 0, 255, 0);
  }

  if (key == '4') {
    turnOff();
    setMsg(3, 255, 0, 0, 255, 0);
  }
}



void turnOff() {
  for (int i = 0; i < maxLED; i++) {
    setMsg(i, 0, 0, 0, 0, 0);
  }
}

void turnOn(int r, int g, int b, int a ){
    for (int i = 0; i < maxLED; i++) {
    setMsg(i, r, g, b, 255, 0);
  }
}

void setMsg(int index, int r, int g, int b, int a, int garmentId) {
  int [] msgInt  = {index, r, g, b, a, garmentId};
  byte[] msg = generate_msg(msgInt);
  myPort.write(msg);
}

boolean mouseOverRect() { // Test if mouse is over square
  return ((mouseX >= 50) && (mouseX <= 150) && (mouseY >= 50) && (mouseY <= 150));
}
