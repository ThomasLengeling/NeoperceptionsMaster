import hypermedia.net.*;


UDP udp;  // define the UDP object

String ip       = "127.0.0.1";  // the remote IP address
int port        = 32000;  
boolean sendMsg = true;

float ampGrow =0;
int onset = 0;
float pitch = 0;
String message;

void setup() {
  size(200, 200);
  udp = new UDP( this );
}

void draw() {
  //reset
  message = "";

  //add values
  message+=ampGrow;
  message+=" ";
  message+=onset;
  message+=" ";
  message+=pitch;

  ampGrow+= 0.01;
  if (ampGrow >=1.0) {
    ampGrow = 0.0;
    onset = (onset ==1)? 0 : 1;
  }

  if (sendMsg) {
    udp.send( message, ip, port );
  }
}

void keyPressed() {
  if (key == 'a') {

    sendMsg= !sendMsg;
  }
}
