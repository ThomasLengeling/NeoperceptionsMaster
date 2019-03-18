byte val[5] = {0, 0, 0, 0, 0};

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(2, OUTPUT);
}

void loop() {

  if (Serial.available()) {
    Serial.readBytes(val, 5);
  }

  if (int(val[1]) == 255) {
    digitalWrite(2, HIGH);
  } else {
    digitalWrite(2, LOW);
  }

}
