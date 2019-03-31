#include <SPI.h>

#include <nRF24L01.h>
#include <printf.h>
#include <RF24.h>
#include <RF24_config.h>

byte val[7] = {0, 0, 0, 0, 0, 0, 0};
boolean readSerial = false;

RF24 radio(9, 10); // CE, CSN
const byte address[6] = "00001";

#define LED_PIN 2

void setup() {
  Serial.begin(74880);

  radio.begin();
  radio.openWritingPipe(address);
  radio.setPALevel(RF24_PA_MIN);
  radio.stopListening();

  pinMode(LED_PIN, OUTPUT);
}
void loop() {
  if (Serial.available()) {
    int readS = Serial.readBytes(val, 7);

    while (Serial.available()) {
      Serial.read();
    }
    readSerial = true;
  }

  if (readSerial) {
    radio.write(val, 7);
    readSerial = false;
    digitalWrite(LED_PIN, HIGH);
  } else {
    digitalWrite(LED_PIN, LOW);
  }

}
