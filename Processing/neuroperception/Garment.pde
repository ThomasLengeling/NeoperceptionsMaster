
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

  color pitchColor = color(0, 150, 200);


  void mapPitch() {
    int midiPitch = floor(pitch);
    println(midiPitch);

    //A Flat
    if (midiPitch == 32 || midiPitch == 44 || midiPitch == 56 || midiPitch == 68 || midiPitch == 92 || midiPitch == 104 || midiPitch == 116) {
      pitchColor = #F74B27;
    }
    //E Flat
    if (midiPitch == 27 || midiPitch == 39 || midiPitch == 51 || midiPitch == 63 || midiPitch == 75 || midiPitch == 87 || midiPitch == 99) {
      pitchColor = #0132FC;
      println("got it");
    }
    
    //f Flat
    if (midiPitch == 30 || midiPitch == 42 || midiPitch == 54 || midiPitch == 66 || midiPitch == 90 || midiPitch == 102 || midiPitch == 114 ) {
      pitchColor = #E0D7FF;
      println("got it");
    }

    if (midiPitch == 0 ) {
      pitchColor = color(0, 150, 200);
    }
  }

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
      //led.tam = 20 + amp*25;
      led.colorLED = pitchColor;
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
    colorLED = color(0, 150, 200);
  }

  void setPos(float x, float y) {
    this.posX = x;
    this.posY = y;
  }

  //draw color
  void draw(boolean enable) {
    noStroke();
    if (enable) {
      fill(colorLED);
    } else {
      tam = 20;
      fill(0, 50, 100);
    }
    ellipse(posX, posY, tam, tam);
  }
}
