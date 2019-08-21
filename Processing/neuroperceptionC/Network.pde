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
color currentColor = color(0, 0, 0);
int indexLED = 0;

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

  println("mid: "+msgList[msgList.length - 1]);

  //get the values
  if (msgList.length >= 4 * 5) {
    //amp (DB float) (onset int), pitch (float), note string

    for (int i = 0; i < 5; i++) {
      int garmentIndex = i;
      int ampIndex     = i*4 + 0;
      int onsetIndex   = i*4 + 1;
      int pitchIndex   = i*4 + 2;
      int noteIndex    = i*4 + 3;

      //get the data

      float amp =0;
      try {
        amp = Float.valueOf(msgList[ampIndex]);
      }
      catch(Exception e) {
        
      }
      float ampSen = 1.5;
      int onset = int(Float.valueOf(msgList[onsetIndex]));
      float pitch = Float.valueOf(msgList[pitchIndex]);
      String note = msgList[noteIndex];

      //update garments
      manager.garments.get(garmentIndex).amp = amp;
      manager.garments.get(garmentIndex).onset = onset;
      manager.garments.get(garmentIndex).pitch = pitch;
      color pitchColor = mapPitch(pitch);

      currentColor = pitchColor;
      manager.garments.get(garmentIndex).pitchColor = pitchColor;
    
      //amp
      manager.garments.get(garmentIndex).updateAmp(amp);
      float ampMap =  manager.garments.get(garmentIndex).ampMap;
      
      //String note
      // String statusM = "mary 0 amp: "+amp+" onset: "+onset+" pitch: "+pitch;

      if (  manager.garments.get(garmentIndex).enable) {
        //println(note);
        
        println(ampMap);

        // setLEDValues(maxLEDs, int(red(pitchColor)), int(green(pitchColor)), int(blue(pitchColor)), garmentIndex);
        //turnOn(int(red(pitchColor)*ampMap), int(green(pitchColor)*ampMap), int(blue(pitchColor)*ampMap), 12, garmentIndex);
        turnOn(int(red(pitchColor)), int(green(pitchColor)), int(blue(pitchColor)), int(ampMap), garmentIndex);
        sendMsg(gPort);

        //hylighters.sendNoteHylight(garmentIndex, cmdHylighter.get(currIndexHylighter));
        indexLED += 1;
        if (indexLED >= 12) {
          indexLED = 0;
        }
        //turnOn(int(red(pitchColor)), int(green(pitchColor)), int(blue(pitchColor)), maxLEDs, garmentIndex);
      } else {
        //sendMsgAll(12, 0, 0, 0, garmentIndex);
        //sendMsg(gPort);

        manager.garments.get(garmentIndex).incTime();
      }
    }
  }

  // print the result
 // println( "receive: \""+data+"\" from "+ip+" on port "+port+" "+message);
}
