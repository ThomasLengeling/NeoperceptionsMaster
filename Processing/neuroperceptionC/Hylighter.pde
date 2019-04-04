/*  
 Hyligher
 */

class Hylighter {
  //gui
  Accordion accordion;

  //array of lights
  ArrayList<HyperLED> hyperLEDs;

  //multi light
  int numHyl;

  //postion
  float posX;
  float posY;

  Serial port;
  String strPort;
  boolean serialRead = true;

  Hylighter(int numH, float posX, float posY) {
    hyperLEDs = new ArrayList<HyperLED>();
    numHyl = numH;

    this.posX = posX;
    this.posY = posY;

    for (int  i = 0; i < numHyl; i++) {
      HyperLED led = new HyperLED();
      float x = posX + 100*i;
      float y = posY;

      led.setPos(x, y);
      hyperLEDs.add(led);
    }
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

  void sendNoteHylight(int index, String note) {
    String i = Integer.toString(index);
    String msg = i + ' ' + note;

    byte arr[] = msg.getBytes();

    //port.write(arr);
   // println("send: "+index+" "+note);
  }

  //draw
  void draw() {
    for (HyperLED led : hyperLEDs) {
      led.draw();
    }
  }

  //void create GUI
  void createGUI() {
    Group g1 = cp5.addGroup("hylighter")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(350)
      ;


    for (int i = 0; i < numHyl; i++) {     
      cp5.addToggle("activate_h"+i)
        .setPosition(10, 10 + i*50)
        .setSize(25, 25)
        .setValue(1)
        .moveTo(g1)
        ;
    }
    accordion = cp5.addAccordion("acch")
      .setPosition(20, 400)
      .setWidth(250)
      .addItem(g1);

    accordion.open(0);
  }
}
/*
Class that manages the HyperLEDs
 */
class HyperLED {
  int currentColor = 0;
  
  //number of LEDs
  int numWave =10;
  int tam = 35;

  //visual information
  float posX = 0;
  float posY = 0;

  //enable
  boolean enable = true;

  HyperLED() {
    currentColor =0;
  }

  void setPos(float x, float y) {
    this.posX = x;
    this.posY = y;
  }

  void draw() {

    noStroke();
    if (enable) {
      fill(255);
      rect(posX, posY, tam, tam);
    } else {
      fill(color(200));
      rect(posX, posY, tam, tam);
    }
  }
}
