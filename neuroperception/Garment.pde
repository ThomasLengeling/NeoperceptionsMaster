class GarmentManager {
  Accordion accordion;
  ArrayList<Garment> garments;

  //Serial
  Serial port;
  String strPort;
  boolean serialRead = true;

  //pos
  float initPosX = 0;
  float initPosY = 0;
  
  //number of garmets
  int numGarmets = 0;

  //tags
  String [] tags ={"Mary", "Violin", "Viola", "Chelo", "Violin"};

  GarmentManager(int numG, float initX, float initY) {
    numGarmets = numG;
    garments = new ArrayList<Garment>();

    initPosX = initX;
    initPosY = initY;

    for (int i = 0; i < numG; i++) {
      float x =  initPosX + 100*i;
      float y = initPosY;
      Garment gm = new Garment(8, x, y);
      //update Position
      gm.setName(tags[i]);
      garments.add(gm);
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

  //void create GUI
  void createGUI() {
    Group g1 = cp5.addGroup("garmet")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(150)
      ;


    for (int i = 0; i < numG; i++) {     
      cp5.addBang("activate")
        .setPosition(10, 20)
        .setSize(20, 20)
        .moveTo(g1)
        ;
    }
    accordion = cp5.addAccordion("acc")
      .setPosition(20, 20)
      .setWidth(250)
      .addItem(g1);

    accordion.open(0);
  }

  void draw() {

    for (Garment gm : garments) {
      gm.draw();
    }
  }
}

/*
Garmet 
 */
class Garment {

  ArrayList<RGBLED> mLEDs;

  //initial position
  float posX;
  float posY;

  String garmetName = "";

  Garment(int numLEDs, float posX, float posY) {
    mLEDs = new ArrayList<RGBLED>();

    this.posX = posX;
    this.posY = posY;

    for (int i = 0; i < numLEDs; i++) {
      RGBLED led = new RGBLED();
      float x = posX;
      float y = posY + 50*i;
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
      text(garmetName, posX, posY - 20);
      led.draw();
    }
  }

  void sendValues() {
  }
}

//LED
class RGBLED {

  //property color
  color colorLED;

  //disply mode
  float posX;
  float posY;

  RGBLED() {
    posX = 0;
    posY = 0;
  }

  void setPos(float x, float y) {
    this.posX = x;
    this.posY = y;
  }

  //draw color
  void draw() {
    noStroke();
    fill(0, 150, 190);
    ellipse(posX, posY, 25, 25);
  }
}
