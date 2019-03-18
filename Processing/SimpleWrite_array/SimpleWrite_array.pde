/**
 * Simple Write Array. 
 * 
 * Check if the mouse is over a rectangle and writes an array of ints to the serial port. 
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int mask = 0x000000FF;
int[] val = {0 & mask, 0 & mask, 0 & mask, 0 & mask, 200 & mask}; //new int[5];

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

byte[] generate_msg(int[] v){
  byte[] result = new byte[6];
  result[0] = byte('<');
  for (int i = 0; i < 5; i ++) {
    result[i+1] = byte(v[i]);
  }
  return result;
}

void draw() {
  
  background(255);

  
  if (mouseX <= 255) {
    val[0] = 0 & mask;
    val[1] = mouseX & mask;
    val[2] = 0;
    val[3] = 0;
    send();
    
    val[0] = 1 & mask;
    val[2] = mouseX & mask;
    val[1] = 0;
    val[3] = 0;
    send();
  } else {
    val[0] = 0 & mask;
    val[1] = (2 * 255) - mouseX & mask;
    val[2] = 0;
    val[3] = 0;
    send();
    
    val[0] = 1 & mask;
    val[2] = (2 * 255) - mouseX & mask;
    val[1] = 0;
    val[2] = 0;
    val[3] = 0;
    send();
  }
  


}

void send(){
  byte[] msg = generate_msg(val);
  myPort.write(msg);
}

boolean mouseOverRect() { // Test if mouse is over square
  return ((mouseX >= 50) && (mouseX <= 150) && (mouseY >= 50) && (mouseY <= 150));
}
