#include <SPI.h>

#include <nRF24L01.h>
#include <printf.h>
#include <RF24.h>
#include <RF24_config.h>

const int size_data = 40;
byte val [size_data] ;


RF24 radio(9, 10); // CE, CSN
const byte address[6] = "00001";

#define LED_PIN 2

int counter    = 0;
int maxCounter = 5;

boolean readSerial = false;
boolean finishTransmission = true;

byte msg01[20];
byte msg02[20];

void setup() {
  Serial.begin(115200);

  radio.begin();
  radio.openWritingPipe(address);
  radio.setPALevel(RF24_PA_LOW);//RF24_PA_MIN);           // Set PA LOW for this demonstration. We want the radio to be as lossy as possible for this example.
  radio.setDataRate(RF24_1MBPS);
  radio.setPayloadSize(size_data);
  radio.stopListening();

  pinMode(LED_PIN, OUTPUT);



  //fill with zeros
  for (int i = 0; i < size_data; i++) {
    val[i] = 0;
  }

  for (int i = 0; i < 20; i++) {
    msg01[i] = 0;
    msg02[i] = 0;
  }

}

void loop() {
  if (Serial.available()) {
    if (finishTransmission) {
      int readS = Serial.readBytes(val, size_data);
      readSerial = true;
      finishTransmission = false;

      //copy the information
      for (int i = 0; i < 20; i++) {
        msg01[i] = val[i];
        msg02[i] = val[i + 20];
      }

    }
  }

  //send information if we recvied bytes
  if (readSerial) {

    if (counter == maxCounter) {
      radio.write(msg01, 20);
      delay(1);
      radio.write(msg01, 20);
      delay(1);
    }

    if (counter == maxCounter * 2) {
      radio.write(msg02, 20);
      delay(1);
      radio.write(msg02, 20);
      delay(1);
      finishTransmission = true;
      readSerial = false;
      counter = 0;
      digitalWrite(LED_PIN, HIGH);
    }

    counter++;

    //clean buffer
    if (finishTransmission) {
      while (Serial.available()) {
        Serial.read();
      }
    }


  } else {
    digitalWrite(LED_PIN, LOW);
  }

}
