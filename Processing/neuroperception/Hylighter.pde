/*
Hyligher
*/
class Hylighter {
  Accordion accordion;
  ArrayList<HyperLED> hyperLEDs;
  //multi light

  Serial port;
  String strPort;
  boolean serialRead = true;

  Hylighter() {
    hyperLEDs = new ArrayList<HyperLED>();
  }

  //Serial
  void setupSerial(PApplet p, String str) {
    strPort = str;
    try {
      port = new Serial(p, strPort, 9600);
    }
    catch(Exception e) {
      serialRead = false;
      println("Error Serial:"+strPort);
    }
  }

  void draw() {
  }
}


/*
Class that manages the HyperLEDs

*/
class HyperLED {

  //wavelength -> float
  ArrayList<Integer> waves;
  int currentColor = 0;

  //number of LEDs
  int numWave;
  int tam = 50;
  
  //visual information
  float posX = 0;
  float posY = 0;

  HyperLED() {
    waves = new ArrayList<Integer>();
    currentColor =0;

    for (int i = 0; i < numWave; i++) {
      int wav = 0;
      waves.add(wav);
    }
  }
  
  void setPos(float x, float y){
   this.posX = x;
   this.posY = y;
  }

  void draw() {

    noStroke();
    fill(waves.get(currentColor));
    rect(posX, posY, tam, tam);
  }
}
