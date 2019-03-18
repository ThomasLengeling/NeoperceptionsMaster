#include "SoftwareSerial.h"
#include "Adafruit_Pixie.h"
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

RF24 radio(7, 8); // CE, CSN
const byte address[6] = "00001";


#define NUMPIXELS 2
#define PIXIEPIN 6

SoftwareSerial pixieSerial(-1, PIXIEPIN);

Adafruit_Pixie strip = Adafruit_Pixie(NUMPIXELS, &pixieSerial);

byte raw[6] = {0, 0, 0, 0, 0, 0};
byte val[6] = {0, 0, 0, 0, 0, 0};
int size_data = 6;

void setup() {
  Serial.begin(74880);
  pixieSerial.begin(115200);
  
  radio.begin();
  radio.openReadingPipe(0, address);
  radio.setPALevel(RF24_PA_MIN);
  radio.startListening();

  pinMode(3, OUTPUT);
}

int findIndex(byte *x, byte y) {
  for( int i = 0; i < size_data; i ++ ) {
    if (x[i] == y){
      return i;
    }
  }
  return 0;
}

void sort_data(byte *x, byte *r) {
  int index = findIndex(x, byte('<'));
  for( int i = 0; i < size_data; i ++ ) {
    int n_i = i;
    int n_j = i + index;
    if (n_j > (size_data -1)){
      n_j = n_j - size_data;
    }
    r[n_i] = x[n_j];
  } 
}

void loop() {
  // put your main code here, to run repeatedly:
  if (radio.available()) {
    radio.read(raw, size_data);
    digitalWrite(3, HIGH);
  } else {
    digitalWrite(3, LOW);
  }



  sort_data(raw, val);

  Serial.print(int(val[0]));
  Serial.print(",");
  Serial.print(int(val[1]));
  Serial.print(",");
  Serial.print(int(val[2]));
  Serial.print(",");
  Serial.print(int(val[3]));
  Serial.print(",");
  Serial.print(int(val[4]));
  Serial.print(",");
  Serial.print(int(val[5]));
  Serial.print(",");
  Serial.println();
  
  strip.setBrightness(int(val[5]));
  strip.setPixelColor(int(val[1]), int(val[2]), int(val[3]), int(val[4]));
  strip.show();

}
