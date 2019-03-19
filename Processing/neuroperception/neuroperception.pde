import controlP5.*;
import processing.serial.*;

ControlP5 cp5;

//garmet
GarmentManager manager;

//hyligher
Hylighter      hylighters;

void setup() {
  size(1280, 800);
  smooth(16);

  //udp
  UDPSetup();

  //gui
  cp5 = new ControlP5(this);

  printArray(Serial.list());

  //manager
  float gStartX = 350; 
  float gStartY = 80;
  String portNameG= "";
  manager = new GarmentManager(6, gStartX, gStartY);
  manager.createGUI();
  manager.setupSerial(this, portNameG);

  //create Hylighter
  float hStartX = 350; 
  float hStartY = 650;
  String portNameH= "";
  hylighters = new Hylighter(5, hStartX, hStartY);
  hylighters.createGUI();
  hylighters.setupSerial(this, portNameH);
}

void draw() {
  background(50);


  manager.draw();
  hylighters.draw();

  controlActivations();
}

void controlActivations() {

  int i =0;
  for (Garment gm : manager.garments) {
    int activate = int(cp5.getController("activate_"+tags[i]).getValue());
    gm.enable = boolean(activate);
    i++;
  }

  i =0;
  for (HyperLED led : hylighters.hyperLEDs) {
    int activate = int(cp5.getController("activate_h"+i).getValue());
    led.enable = boolean(activate);
    i++;
  }
}
