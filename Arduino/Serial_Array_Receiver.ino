bool started;
bool ended;
char incomingByte;
byte val[5] = {0, 0, 0, 0, 0};
int serialIn = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {

  if (Serial.available()) {
    Serial.readBytes(val, 5);
  }

  if (val[2] == byte(0)) {
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    digitalWrite(LED_BUILTIN, LOW);
  }

}
