
/*
Garmet 
 */
class Garment {

  ArrayList<RGBLED> mLEDs;

  //initial position
  float posX;
  float posY;

  String garmetName = "";
  
  
  //eanble single Garmet
  boolean enable = true;
  
  //DSP information onset, pitch, note, amplitud
  float pitch;
  int onset;
  float amp;

  Garment(int numLEDs, float posX, float posY) {
    mLEDs = new ArrayList<RGBLED>();

    this.posX = posX;
    this.posY = posY;

    for (int i = 0; i < numLEDs; i++) {
      RGBLED led = new RGBLED();
      float x = posX;
      float y = posY + 60*i;
      //set postion
      //set color
      led.setPos(x, y);

      mLEDs.add(led);
    }
  }

  //set Garmet Name
  void setName(String str) {
    garmetName = str;
  }
 

  //draw garment
  void draw() {
    for (RGBLED led : mLEDs) {
      fill(255);
      text(garmetName, posX - 20, posY - 35);
      led.draw(enable);
      
      //audio reactive visualization
      led.tam = 20 + amp*25; 
    }
  }
  
  //send serial port values
  void sendValues() {
    if (enable) {
      //send Values to serial port.
      
    }
  }
}

//Single LED that controlls the Garmet
class RGBLED {

  //property color
  color colorLED;

  //disply mode
  float posX;
  float posY;
  
  float tam;

  RGBLED() {
    posX = 0;
    posY = 0;
    tam = 20;
  }

  void setPos(float x, float y) {
    this.posX = x;
    this.posY = y;
  }

  //draw color
  void draw(boolean enable) {
    noStroke();
    if (enable) {
      fill(0, 150, 190);
    } else {
      tam = 20;
      fill(0, 50, 100);
    }
    ellipse(posX, posY, tam, tam);
  }
}
