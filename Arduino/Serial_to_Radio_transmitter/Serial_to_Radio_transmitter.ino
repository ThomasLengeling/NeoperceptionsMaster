#include <SPI.h>

#include <nRF24L01.h>
#include <printf.h>
#include <RF24.h>
#include <RF24_config.h>

byte val[6] = {0, 0, 0, 0, 0, 0};
boolean readSerial = false;

RF24 radio(7, 8); // CE, CSN
const byte address[6] = "00001";
void setup() {
  Serial.begin(74880);

  radio.begin();
  radio.openWritingPipe(address);
  radio.setPALevel(RF24_PA_MIN);
  radio.stopListening();

  pinMode(3, OUTPUT);
}
void loop() {
  if (Serial.available()) {
    int readS = Serial.readBytes(val, 6);

    while (Serial.available()) {
      Serial.read();
    }
    readSerial = true;
  }

  if (readSerial) {
    radio.write(val, 6);
    readSerial = false;
  }

 
}
