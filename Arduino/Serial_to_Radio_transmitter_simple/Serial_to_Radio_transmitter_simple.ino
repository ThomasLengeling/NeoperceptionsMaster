#include <SPI.h>

#include <nRF24L01.h>
#include <printf.h>
#include <RF24.h>
#include <RF24_config.h>

const int size_data = 26;
byte val [size_data] ;


RF24 radio(9, 10); // CE, CSN
const byte address[6] = "00001";

#define LED_PIN 2


boolean readSerial = false;

byte msg01[size_data];

void setup() {
  Serial.begin(115200);

  //radio.begin();
  //radio.openWritingPipe(address);
  //radio.setPALevel(RF24_PA_LOW);//RF24_PA_MIN);           // Set PA LOW for this demonstration. We want the radio to be as lossy as possible for this example.
  //radio.setDataRate(RF24_1MBPS);
  //radio.setPayloadSize(size_data);
  //radio.stopListening();

  radio.begin();
  radio.openWritingPipe(address);
  radio.setPALevel(RF24_PA_MIN);
  radio.stopListening();

  pinMode(LED_PIN, OUTPUT);



  //fill with zeros
  for (int i = 0; i < size_data; i++) {
    val[i] = 0;
    msg01[i] = 0;
  }

}

void loop() {
  if (Serial.available()) {
    int readS = Serial.readBytes(val, size_data);


    //copy the information
    for (int i = 0; i < size_data; i++) {
      msg01[i] = val[i];
    }
    readSerial = true;
  }

  //send information if we recvied bytes
  if (readSerial) {
    radio.write(msg01, size_data);
    delay(2);

    while (Serial.available()) {
      Serial.read();
    }
    digitalWrite(LED_PIN, HIGH);
    readSerial = false;
  } else {
    digitalWrite(LED_PIN, LOW);
  }

}
