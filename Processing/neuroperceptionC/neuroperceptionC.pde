

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
  String portNameG= "COM3";
  manager = new GarmentManager(6, gStartX, gStartY);
  manager.createGUI();
  setupGarmentSerial(portNameG);
  //create Hylighter
  float hStartX = 350; 
  float hStartY = 650;
  String portNameH =  Serial.list()[0];
  hylighters = new Hylighter(5, hStartX, hStartY);
  hylighters.createGUI();
  //hylighters.setupSerial(this, portNameH);

  setupMidiMap();
}

/*

 */
void draw() {
  background(50);

  manager.draw();
  hylighters.draw();

  if (currIndexHylighter == -1) {
    //hylighters.sendNoteHylight(0, off);
  } else {
    if (currIndexHylighter <cmdHylighter.size() ) {
      hylighters.sendNoteHylight(0, cmdHylighter.get(currIndexHylighter));
    }
  }

 // sendMsg(gPort);
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

  i =0;
  for (Garment gm : manager.garments) {
    float amp = cp5.getController("amp_"+tags[i]).getValue();
    gm.ampSensity = amp;
    i++;
  }

  //sensitivity amps




  // sendMsgAll(gPort, maxLEDs, int(red(pitchColor)), int(green(pitchColor)), int(blue(pitchColor)), garmentIndex);
}

void keyPressed() {
  if (key == '3') {
    turnOffAll();
    sendMsg(gPort);
    delay(2);
  }

  if (key == '4') {
    turnOnAll((int)random(255), (int)random(255), (int)random(255), 200);
    sendMsg(gPort);
    delay(2);
  }


  if (key == '5') {
    for (int i = 0; i < 5; i++) {
      hylighters.sendNoteHylight(i, off);
    }
  }

  if (key == '6') {
    for (int i = 0; i < 5; i++) {
      hylighters.sendNoteHylight(i, cmdHylighter.get(0));
    }
  }

  if (key == '7') {
    for (int i = 0; i < 5; i++) {
      hylighters.sendNoteHylight(i, cmdHylighter.get(1));
    }
  }

  if (key == '8') {
    for (int i = 0; i < 5; i++) {
      hylighters.sendNoteHylight(i, cmdHylighter.get(2));
    }
  }

  if (key == '9') {
    for (int i = 0; i < 5; i++) {
      hylighters.sendNoteHylight(i, cmdHylighter.get(3));
    }
  }

  if (key == '0') {
    for (int i = 0; i < 5; i++) {
      hylighters.sendNoteHylight(i, cmdHylighter.get(4));
    }
  }

  if (key == '-') {
    for (int i = 0; i < 5; i++) {
      hylighters.sendNoteHylight(i, cmdHylighter.get(5));
    }
  }
}
