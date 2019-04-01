//tags
String [] tags = {"Mary_voice", "Violin_0", "Viola", "Chelo", "Violin_1", "Piano"};


class GarmentManager {
  Accordion accordion;
  ArrayList<Garment> garments;

  //pos
  float initPosX = 0;
  float initPosY = 0;

  //number of garmets
  int numGarmets = 0;

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
      gm.setId(i);
      garments.add(gm);
    }
  }


  //void create GUI
  void createGUI() {
    Group g1 = cp5.addGroup("garmet")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(350)
      ;


    for (int i = 0; i < numGarmets; i++) {     
      cp5.addToggle("activate_"+tags[i])
        .setPosition(10, 10 + i*50)
        .setSize(25, 25)
        .setValue(1)
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
