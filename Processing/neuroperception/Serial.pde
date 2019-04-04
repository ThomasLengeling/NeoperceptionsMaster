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
void turnOff(int maxLEDs, int gIndex) {
  for (int i = 0; i < maxLEDs; i++) {
    setLEDValues(i, 0, 0, 0, gIndex);
  }

}

//turn on with one color
void turnOn(int r, int g, int b, int maxLEDs, int gIndex) {
  for (int i = 0; i < maxLEDs; i++) {
    setLEDValues(i, r, g, b, gIndex);
  }
}

//send a msg to all
void sendMsgAll(int maxLEDs, int r, int g, int b, int indexG) {
  for (int i = 0; i < maxLEDs; i++) {
    setLEDValues(i, r, g, b, indexG);
  }
}

//send indiviual msg
void sendSerialMsg(int index, int r, int g, int b, int indexG) {
  setLEDValues(index, r, g, b, indexG);
  //sendMsg(gPort);
}

//set the LED values
void setLEDValues(int index, int r, int g, int b, int garmentId) {  
  LEDArray[0] = garmentId;
  //color currentC = color(LEDArray[index * 3 + 1], LEDArray[index * 3 + 2], LEDArray[index * 3 + 3]);
  //color newC = color(r, g, b);
  //color interC = lerpColor(currentC, newC, .5);
  LEDArray[index * 3 + 1] = r;//int(red(interC));
  LEDArray[index * 3 + 2] = g;//int(green(interC));
  LEDArray[index * 3 + 3] = b;//int(blue(interC));
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
