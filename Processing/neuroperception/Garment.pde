
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

  color pitchColor = color(0, 150, 200);

  int id;


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


  //draw garment
  void draw() {
    for (RGBLED led : mLEDs) {
      fill(255);
      text(garmetName, posX - 20, posY - 35);
      led.draw(enable);

      //audio reactive visualization
      //led.tam = 20 + amp*25;
      led.colorLED = pitchColor;
      led.tam = 20 + map(amp, -60, 10, 0, 1)*25;


      //update timer to turn of the LED
      if (led.updateTimer()) {
        led.resetTimer();
        sendMsg(gPort, id, 0, 0, 0, 0, led.id);
      }
    }
  }

  //send serial port values
  void sendValues() {
    if (enable) {
      //send Values to serial port.
    }
  }

  void incTime() {
    for (RGBLED led : mLEDs) {
      led.incTime();
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

  //local timer per LED
  int timerLED;
  int timerMax = int(60 * 0.6); //frame per second
  boolean enableLED = false;

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
      if (enableLED) {
        fill(colorLED);
      }else{
        fill(colorLED, 150);
      }
    } else {
      tam = 20;
      fill(0, 50, 100);
    }
    ellipse(posX, posY, tam, tam);
  }

  //increment time
  void incTime() {
    timerLED++;
    enableLED = true;
  }

  void resetTimer() {
    enableLED = false;
    timerLED = 0;
    println("reset LEDs "+id);
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
