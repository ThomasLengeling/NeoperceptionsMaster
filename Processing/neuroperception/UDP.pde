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
  if (msgList.length > 3) {
    //amp (DB float) (onset int), pitch (float), note string
    float amp = Float.valueOf(msgList[0]);
    int onset = int(Float.valueOf(msgList[1]));
    float pitch = Float.valueOf(msgList[2]);
    
    String note = msgList[3];
    //String note
    // String statusM = "mary 0 amp: "+amp+" onset: "+onset+" pitch: "+pitch;
    //println(statusM);
    //update Garmet
    manager.garments.get(0).amp = amp;
    manager.garments.get(0).onset = onset;
    manager.garments.get(0).pitch = pitch;
    manager.garments.get(0).mapPitch();
  }


  // print the result
  println( "receive: \""+data+"\" from "+ip+" on port "+port+" "+message);
}
