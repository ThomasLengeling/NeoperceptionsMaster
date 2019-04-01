#include <SPI.h>

#include <nRF24L01.h>
#include <printf.h>
#include <RF24.h>
#include <RF24_config.h>

const int val_size = 38;
byte val [val_size] ;

boolean readSerial = false;

RF24 radio(9, 10); // CE, CSN
const byte address[6] = "00001";

#define LED_PIN 2

void setup() {
  Serial.begin(115200);

  radio.begin();
  radio.openWritingPipe(address);
  radio.setPALevel(RF24_PA_MIN);
  radio.stopListening();

  pinMode(LED_PIN, OUTPUT);

  //fill with zeros
  for(int i = 0; i < val_size; i++){
    val[i] = 0;
  }
}
void loop() {
  if (Serial.available()) {
    int readS = Serial.readBytes(val, val_size);
    readSerial = true;
  }

  if (readSerial) {
    radio.write(val, val_size);
    readSerial = false;

    while (Serial.available()) {
      Serial.read();
    }

    digitalWrite(LED_PIN, HIGH);
  } else {
    digitalWrite(LED_PIN, LOW);
  }

}
