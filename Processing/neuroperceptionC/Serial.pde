//Serial Garment
Serial gPort;

String gStrPort = "";
boolean gSerialRead = true;

int maxGarments = 5;

int mask = 0x000000FF;
int[] LEDArray = new int[26]; // id, rgb * 12  

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
void turnOff(int gIndex) {
  setLEDValues(0, 0, 0, 0, 1, gIndex);
}

void turnOffAll() {
  for (int i = 0; i < maxGarments; i++) {
    setLEDValues(0, 0, 0, 0, 1, i);
  }
}

//turn on with one color

void turnOn(int r, int g, int b, int a, int gIndex) {
  setLEDValues(r, g, b, a, 1, gIndex);
}

void turnOnAll(int r, int g, int b, int a) {
  for (int i = 0; i < maxGarments; i++) {
    setLEDValues(r, g, b, a, 1, i);
  }
}

//send a msg to all
void sendMsgAll(int r, int g, int b, int a) {
  for (int i = 0; i < maxGarments; i++) {
    setLEDValues(r, g, b, a, 1, i);
  }
}

//send indiviual msg
void sendSerialMsg(int r, int g, int b, int a, int on, int indexG) {
  setLEDValues(r, g, b, a, on, indexG);
  //sendMsg(gPort);
}

//set the LED values
void setLEDValues(int r, int g, int b, int a, int on, int garmentId) {
  int gIndex = garmentId*5;
  LEDArray[gIndex] = on;
  LEDArray[gIndex + 1] = r;
  LEDArray[gIndex + 2] = g;
  LEDArray[gIndex + 3] = b;
  LEDArray[gIndex + 4] = a;
}


/*
Send the actual msg
 */
void sendMsg(Serial gport) {
  byte[] msg = generate_msg_1(LEDArray); 
  try {
    gport.write(msg);
    println("sent msg to g");
  }
  catch(Exception e) {
    println("sending port error");
  }
}


byte[] generate_msg_1(int[] v) {
  byte[] result = new byte[26];
  result[0] = byte('<');
  for (int i = 0; i < 25; i ++) {
    result[i+1] = byte(v[i] & mask);
  }
  return result;
}
