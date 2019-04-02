#include "SoftwareSerial.h"
#include "Adafruit_Pixie.h"
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

RF24 radio(9, 10); // CE, CSN
const byte address[6] = "00001";

bool debug = true;

#define NUMPIXELS 12
#define PIXIEPIN 6
#define LEDPIN 2

SoftwareSerial pixieSerial(-1, PIXIEPIN);

Adafruit_Pixie strip = Adafruit_Pixie(NUMPIXELS, &pixieSerial);



const int size_data = 20;
byte raw[size_data];// = {0, 0, 0, 0, 0, 0, 0};
byte val[size_data];// = {0, 0, 0, 0, 0, 0, 0};
int ID = 0;
float ratio = 0.5;

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

uint8_t getRedFromColor(uint32_t c) {
  return c >> 16;
}

uint8_t getGreenFromColor(uint32_t c) {
  return c >> 8;
}

uint8_t getBlueFromColor(uint32_t c) {
  return c;
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

  if (int(val[1]) == ID) {
    //strip.setBrightness(int(val[5]));
    if (val[0] == byte('<')) {
      for (int i = 0; i < 6; i++) {
        if (debug) {
          Serial.print(i);
          Serial.print(",");
          Serial.print(int(val[3 * i  + 2]));
          Serial.print(",");
          Serial.print(int(val[3 * i  + 3]));
          Serial.print(",");
          Serial.print(int(val[3 * i  + 4]));
          Serial.println();
        }
        uint32_t currentC = strip.getPixelColor(i);
        int red = getRedFromColor(currentC);
        int green = getRedFromColor(currentC);
        int blue = getRedFromColor(currentC);

        strip.setPixelColor(i, int((1 - ratio) * float(val[3 * i + 2]) + ratio * float(red)),
                            int((1 - ratio) * float(val[3 * i + 3]) + ratio * float(green)),
                            int((1 - ratio) * float(val[3 * i + 4]) + ratio * float(blue)));

      }
    }

    if (val[0] == byte('>')) {
      for (int i = 0; i < 6; i++) {
        if (debug) {
          Serial.print(i + 6);
          Serial.print(",");
          Serial.print(int(val[3 * i  + 2]));
          Serial.print(",");
          Serial.print(int(val[3 * i  + 3]));
          Serial.print(",");
          Serial.print(int(val[3 * i  + 4]));
          Serial.println();
        }

        uint32_t currentC = strip.getPixelColor(i + 6);
        int red = getRedFromColor(currentC);
        int green = getRedFromColor(currentC);
        int blue = getRedFromColor(currentC);
        //strip.setPixelColor(i + 6, int(val[3*i + 2]), int(val[3*i + 3]), int(val[3*i + 4]));
        //  strip.setPixelColor(i + 6, int((val[3*i + 2] + red) / 2), int((val[3*i + 3] + green) / 2), int((val[3*i + 4] + blue) / 2));
        strip.setPixelColor(i + 6, int((1 - ratio) * float(val[3 * i + 2]) + ratio * float(red)),
                            int((1 - ratio) * float(val[3 * i + 3]) + ratio * float(green)),
                            int((1 - ratio) * float(val[3 * i + 4]) + ratio * float(blue)));

      }
    }
  }

  strip.show();
}
