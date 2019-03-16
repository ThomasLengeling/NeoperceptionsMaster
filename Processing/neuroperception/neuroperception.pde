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

  //gui
  cp5 = new ControlP5(this);

  printArray(Serial.list());

  //manager
  float gStartX = 300; 
  float gStartY = 50;
  String portNameG= "";
  manager = new GarmentManager(5, gStartX, gStartY);
  manager.createGUI();
  manager.setupSerial(this, portNameG);

  //create Hylighter
  String portNameH= "";
  hylighters = new Hylighter();
  hylighters.setupSerial(this, portNameH);
}

void draw() {
  background(50);


  manager.draw();
  hylighters.draw();
}
