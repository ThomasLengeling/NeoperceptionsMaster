#include "SoftwareSerial.h"
#include "Adafruit_Pixie.h"
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

RF24 radio(9, 10); // CE, CSN
const byte address[6] = "00001";

bool debug = true;
int ID = 3;

#define NUMPIXELS 4
#define PIXIEPIN 6
#define LEDPIN 2

SoftwareSerial pixieSerial(-1, PIXIEPIN);

Adafruit_Pixie strip = Adafruit_Pixie(NUMPIXELS, &pixieSerial);


const int size_data = 26;
byte raw[size_data];// = {0, 0, 0, 0, 0, 0, 0};
byte val[size_data];// = {0, 0, 0, 0, 0, 0, 0};



void setup() {
  if (debug) {
    Serial.begin(115200);
  }

  pixieSerial.begin(115200);

  radio.begin();
  radio.openReadingPipe(0, address);
  radio.setPALevel(RF24_PA_MIN);
  radio.startListening();
  strip.setBrightness(200);

  pinMode(LEDPIN, OUTPUT);

  for (int i = 0; i < size_data; i++) {
    val[i] = 0;
    raw[i] = 0;
  }

  setColorIndex();

}



void loop() {
  // put your main code here, to run repeatedly:
  if (radio.available()) {
    radio.read(raw, size_data);
    digitalWrite(LEDPIN, HIGH);
  } else {
    digitalWrite(LEDPIN, LOW);
  }


  sort_data(raw, val);


  if (debug) {
    for (int i = 0; i < size_data; i++) {
      Serial.print(int(val[i]));
      Serial.print(",");
    }
    Serial.println();
  }


  if (val[0] == byte('<')) {
    int garmentIndex = ID * 5;
    if (int(val[garmentIndex + 1]) == 1) {

      if (debug) {
        Serial.print(garmentIndex);
        Serial.print(",");
        Serial.print(int(val[garmentIndex + 2]));
        Serial.print(",");
        Serial.print(int(val[garmentIndex  + 3]));
        Serial.print(",");
        Serial.print(int(val[garmentIndex  + 4]));
        Serial.print(",");
        Serial.print(int(val[garmentIndex  + 5]));
        Serial.println();

      }

      int red   = int(val[garmentIndex  + 2]);
      int blue  = int(val[garmentIndex  + 3]);
      int green = int(val[garmentIndex  + 4]);
      int brightness =  int(val[garmentIndex  + 5]);

      strip.setBrightness(brightness);
      for (int i = 0; i < NUMPIXELS; i++) {
        strip.setPixelColor(i, red, green, blue);
      }
      strip.show();
    }
  }

}

int findIndex(byte *x, byte y) {
  for ( int i = 0; i < size_data; i ++ ) {
    if (x[i] == y) {
      return i;
    }
  }
  return -1;
}

void sort_data(byte *x, byte *r) {
  int index = findIndex(x, byte('<'));
  if (index == -1) {
    index = findIndex(x, byte('>'));
  }
  for ( int i = 0; i < size_data; i ++ ) {
    int n_i = i;
    int n_j = i + index;
    if (n_j > (size_data - 1)) {
      n_j = n_j - size_data;
    }
    r[n_i] = x[n_j];
  }
}


void setColorIndex() {
  if (ID == 0) {
    for (int i = 0; i < NUMPIXELS; i++) {
      strip.setPixelColor(i, 255, 0, 0);
    }
    strip.show();
    delay(1000);
  } else if (ID == 1) {
    for (int i = 0; i < NUMPIXELS; i++) {
      strip.setPixelColor(i, 0, 255, 0);
    }
    strip.show();
    delay(1000);
  } else if (ID == 2) {
    for (int i = 0; i < NUMPIXELS; i++) {
      strip.setPixelColor(i, 0, 0, 255);
    }
    strip.show();
    delay(1000);

  } else if (ID == 3) {
    for (int i = 0; i < NUMPIXELS; i++) {
      strip.setPixelColor(i, 255, 255, 0);
    }
    strip.show();
    delay(1000);

  } else if (ID == 4) {
    for (int i = 0; i < NUMPIXELS; i++) {
      strip.setPixelColor(i, 255, 0, 255);
    }
    strip.show();
    delay(1000);

  }

  //turn off
  for (int i = 0; i < NUMPIXELS; i++) {
    strip.setPixelColor(i, 0, 0, 0);
  }
  strip.show();
}
