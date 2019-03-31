//Serial Garment
Serial gPort;
String gStrPort = "";
boolean gSerialRead = true;

void setupGarmentSerial(String str) {
  gStrPort = str;
  try {
    gPort = new Serial(this, gStrPort, 74880);
    println("set up port "+gStrPort);
  }
  catch(Exception e) {
    gSerialRead = false;
    println("Error Serial:"+gStrPort);
  }
}

/*
void turnOff() {
 for (int i = 0; i < maxLED; i++) {
 setMsg(i, 0, 0, 0, 0, 0);
 }
 }
 
 void turnOn(int r, int g, int b, int a ) {
 for (int i = 0; i < maxLED; i++) {
 setMsg(i, r, g, b, 255, 0);
 }
 }
 */

//send color to the leds
void sendMsg(Serial gPort, int index, int r, int g, int b, int a, int garmentId) {
  int [] msgInt  = {index, r, g, b, a, garmentId};
  byte[] msg = generateMsg(msgInt);
  gPort.write(msg);
}

void sendMsgAll(Serial gPort, int index, int r, int g, int b, int a, int maxLEDs) {
  for (int i = 0; i < maxLEDs; i++) {
    sendMsg(gPort, index, r, g, b, a, i);
  }
}

byte[] generateMsg(int[] v) {
  int mask = 0x000000FF;
  byte[] result = new byte[7];
  result[0] = byte('<');
  for (int i = 0; i < 6; i ++) {
    result[i+1] = byte(v[i] & mask);
  }
  return result;
}
