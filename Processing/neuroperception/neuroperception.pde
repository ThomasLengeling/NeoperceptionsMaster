

import controlP5.*;
import processing.serial.*;

ControlP5 cp5;

//garmet
GarmentManager manager;

//hyligher
Hylighter      hylighters;

/*

*/
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
  String portNameG= "/dev/ttyUSB0";//"COM25";
  manager = new GarmentManager(6, gStartX, gStartY);
  manager.createGUI();
  setupGarmentSerial(portNameG);

  //create Hylighter
  float hStartX = 350; 
  float hStartY = 650;
  String portNameH= "/dev/ttyUSB4";
  hylighters = new Hylighter(5, hStartX, hStartY);
  hylighters.createGUI();
  hylighters.setupSerial(this, portNameH);

  setupMidiMap();
}

/*

*/
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

void keyPressed() {
  if (key == '3') {
    turnOff(gPort, 12, 0);
  }

  if (key == '4') {
    turnOn(gPort, 0, 255, 0, 12, 0);
  }
}
