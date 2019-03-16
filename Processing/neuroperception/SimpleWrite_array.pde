/**
 * Simple Write Array. 
 * 
 * Check if the mouse is over a rectangle and writes an array of ints to the serial port. 
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int[] val = {0, 0, 0, 0, 0}; //new int[5];

void setup() 
{
  size(200, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

byte[] generate_msg(int[] v){
  byte[] result = new byte[5];
  for (int i = 0; i < 5; i ++) {
    result[i] = byte(v[i]);
  }
  return result;
}

void draw() {
  background(255);
  if (mouseOverRect() == true) {  // If mouse is over square,
    fill(204);                    // change color and
    int mask = 0x000000FF;
    val[2] = 0 & mask;
  } 
  else {                        // If mouse is not over square,
    fill(0);                      // change color and
    val[2] = 0;  
  }
  rect(50, 50, 100, 100);         // Draw a square
  
  byte[] msg = generate_msg(val);
  println(msg);
  myPort.write(msg);

}

boolean mouseOverRect() { // Test if mouse is over square
  return ((mouseX >= 50) && (mouseX <= 150) && (mouseY >= 50) && (mouseY <= 150));
}
