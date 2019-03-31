/*
 setup network comunication
 */

// import UDP library
import hypermedia.net.*;


UDP udp;  // define the UDP object
int port = 32000;

//msg data
boolean sendMsg = false;
byte [] msgData;

float timerLED = 0;
float resetLEDTime = 1000;
boolean restLED = false;

void UDPSetup() {
  udp = new UDP( this, port );
  //udp.log( true );     // <-- printout the connection activity
  udp.listen( true );
}

/*
  in information from the DSP
 
 0 -> Mary
 0 -> Mary
 0 -> Mary
 0 -> Mary
 
 */
void receive( byte[] data, String ip, int port ) {  // <-- extended handler

  msgData = data;
  String message = new String( subset(data, 0, msgData.length) );
  String[] msgList = split(message, ' ');

  //get the values
  if (msgList.length >= 4 * 5) {
    //amp (DB float) (onset int), pitch (float), note string

    for (int i = 0; i < 5; i++) {
      int garmentIndex = i*4;
      int ampIndex     = i*4 + 0;
      int onsetIndex   = i*4 + 1;
      int pitchIndex   = i*4 + 2;
      int noteIndex    = i*4 + 3;

      //get the data
      float amp = Float.valueOf(msgList[ampIndex]);
      int onset = int(Float.valueOf(msgList[onsetIndex]));
      float pitch = Float.valueOf(msgList[pitchIndex]);
      String note = msgList[noteIndex];

      //update garments
      manager.garments.get(garmentIndex).amp = amp;
      manager.garments.get(garmentIndex).onset = onset;
      manager.garments.get(garmentIndex).pitch = pitch;
      color pitchColor = mapPitch(pitch);
      manager.garments.get(garmentIndex).pitchColor = pitchColor;

      //String note
      // String statusM = "mary 0 amp: "+amp+" onset: "+onset+" pitch: "+pitch;
      //println(statusM);

      if (pitch != 0) {
        int maxLEDs = manager.garments.get(garmentIndex).getMaxLEDs() - 1;
        sendMsgAll(gPort, i, int(red(pitchColor)), int(green(pitchColor)), int(blue(pitchColor)), 100, maxLEDs);
      }

      if (pitch == 0) {
         manager.garments.get(garmentIndex).incTime();
      }
    }
    
  }

  // print the result
  //println( "receive: \""+data+"\" from "+ip+" on port "+port+" "+message);
}
