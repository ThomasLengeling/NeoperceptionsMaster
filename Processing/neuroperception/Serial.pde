//Serial Garment
Serial gPort;

String gStrPort = "";
boolean gSerialRead = true;

int mask = 0x000000FF;
int[] LEDArray = new int[37]; // id, rgb * 12  

/*
Setup port for garments
*/
void setupGarmentSerial(String str) {
  gStrPort = str;
  try {
    gPort = new Serial(this, gStrPort, 115200);
    println("set up port "+gStrPort);
  }
  catch(Exception e) {
    gSerialRead = false;
    println("Error Serial:"+gStrPort);
  }
}

//turn off all leds
void turnOff(Serial gPort, int maxLEDs, int gIndex) {
  for (int i = 0; i < maxLEDs; i++) {
    setLEDValues(i, 0, 0, 0, gIndex);
  }
  sendMsg(gPort);
}

//turn on with one color
void turnOn(Serial gPort, int r, int g, int b, int maxLEDs, int gIndex) {
  for (int i = 0; i < maxLEDs; i++) {
    setLEDValues(i, r, g, b, gIndex);
  }
  sendMsg(gPort);
}

//send a msg to all
void sendMsgAll(Serial gPort, int maxLEDs, int r, int g, int b, int indexG) {
  for (int i = 0; i < maxLEDs; i++) {
    setLEDValues(i, r, g, b, indexG);
  }
  sendMsg(gPort);
}

//send indiviual msg
void sendSerialMsg(Serial gPort, int index, int r, int g, int b, int indexG) {
  setLEDValues(index, r, g, b, indexG);
  sendMsg(gPort);
}

//set the LED values
void setLEDValues(int index, int r, int g, int b, int garmentId) {  
  LEDArray[0] = garmentId;
  LEDArray[index * 3 + 1] = r;
  LEDArray[index * 3 + 2] = g;
  LEDArray[index * 3 + 3] = b;
}

/*
Send the actual msg
*/
void sendMsg(Serial gport) {
  byte[] msg = generate_msg_1(LEDArray); 
  byte[] msg2 = generate_msg_2(LEDArray);

  try {
    gport.write(msg);
    gport.write(msg2);
    println("sent Msg");
  }
  catch(Exception e) {
    println("sending port error");
  }

  //println(msg);
  //println(msg2);
}

//generate the msg array
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
