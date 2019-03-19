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
  String message = new String( subset(data, 0, msgData.length-1) );
  String[] msgList = split(message, ' ');




  //get the values
  float amp = Float.valueOf(msgList[0]);
 // int onset = Integer.valueOf(msgList[1]);
  //float pitch = Float.valueOf(msgList[2]);
 // String statusM = "mary 0 amp: "+amp+" onset: "+onset+" pitch: "+pitch;
  //println(statusM);
  //update Garmet
  manager.garments.get(0).amp = amp;
 // manager.garments.get(0).onset = onset;
 // manager.garments.get(0).pitch = pitch;


  // print the result
  println( "receive: \""+data+"\" from "+ip+" on port "+port+" "+message);
}
