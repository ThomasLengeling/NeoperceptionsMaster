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



const int size_data = 38;
byte raw[size_data];// = {0, 0, 0, 0, 0, 0, 0};
byte val[size_data];// = {0, 0, 0, 0, 0, 0, 0};
int ID = 0;

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

  for(int i = 0; i < size_data; i++){
    val[i] = 5;
    raw[i] = 5;
  }
}

int findIndex(byte *x, byte y) {
  for ( int i = 0; i < size_data; i ++ ) {
    if (x[i] == y) {
      return i;
    }
  }
  return 0;
}

void sort_data(byte *x, byte *r) {
  int index = findIndex(x, byte('<'));
  for ( int i = 0; i < size_data; i ++ ) {
    int n_i = i;
    int n_j = i + index;
    if (n_j > (size_data - 1)) {
      n_j = n_j - size_data;
    }
    r[n_i] = x[n_j];
  }
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
    for(int i = 0; i < size_data; i++) {
      
    Serial.print(int(val[i]));
    Serial.print(",");
    }
    Serial.println();
  }

  if (int(val[1]) == ID) {
    //strip.setBrightness(int(val[5]));

    for (int i = 0; i < 12; i++) {
    if (debug) {
    Serial.print(i);
    Serial.print(",");
    Serial.print(int(val[3*i  + 2]));
    Serial.print(",");
    Serial.print(int(val[3*i  + 3]));
    Serial.print(",");
    Serial.print(int(val[3*i  + 4]));
    Serial.println();
    }
    strip.setPixelColor(i, int(val[3*i + 2]), int(val[3*i + 3]), int(val[3*i + 4]));
  
    }
    //strip.setPixelColor(int(val[1]), int(val[2]), int(val[3]), int(val[4]));

  }

    strip.show();
}
