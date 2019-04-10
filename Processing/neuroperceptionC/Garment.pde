
/*
Garmet 
 */
class Garment {

  ArrayList<RGBLED> mLEDs;

  int maxLEDs;

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
  float ampSensity =1.0;
  float ampMap;

  color pitchColor = color(0, 150, 200);

  int id;

  //local timer per garment
  int timerLED;
  int timerMax = int(60 * 0.5); //frame per second
  boolean enableLED = false;


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
      led.id = i;

      mLEDs.add(led);
    }
  }

  void setId(int gId) {
    id = gId;
  }

  //set Garmet Name
  void setName(String str) {
    garmetName = str;
  }

  int getMaxLEDs() {
    return mLEDs.size();
  }
  
  void updateAmp(float a){
    amp =a;
    ampMap = constrain(map(amp, -60, 90, 0, 255)*ampSensity, 0, 255);
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

      led.tam = 20 + amp;
      // sendMsgAll(led.id, 0, 0, 0, id);
      //sendSerialMsg(gPort, led.id, 0, 0, 0, id);
    }

    //update timer to turn of the LED
    if (updateTimer()) {
      resetTimer();
    }
  }

  //send serial port values
  void sendValues() {
    if (enable) {
      //send Values to serial port.
    }
  }


  //increment time
  void incTime() {
    timerLED++;
    enableLED = true;
    println("inc garment "+id);
  }

  void resetTimer() {
    enableLED = false;
    timerLED = 0;
    println("reset garment "+id);
  }

  boolean updateTimer() {
    if (abs(millis() - timerLED) >= timerMax) {
      if (enableLED) {
        return true;
      }
    }
    return false;
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

  //unique id
  int id;

  RGBLED() {
    posX = 0;
    posY = 0;
    tam = 20;
    colorLED = color(0, 150, 200);
    id =0;
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
