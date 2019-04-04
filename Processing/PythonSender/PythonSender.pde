import processing.serial.*;

Serial myPort;  // Create object from Serial class

// Notes
String C =  "3 0 3 3 409 74 0 0 0 0";
String Db = "61 20 68 75 409 191 20 0 40 0";
String D =  "90 30 100 110 140 90 150 0 120 0";
String Eb = "75 409 8 12 16 8 0 0 4 0";
String E =  "110 40 130 140 170 110 30 90 100 0";
String F =  "185 409 78 87 117 78 19 0 48 0";
String Gb = "210 50 150 170 210 140 40 0 90 0";
String G =  "10 0 10 10 10 70 100 0 0 0";
String Ab = "0 409 9 13 13 9 0 0 4 0";
String A =  "29 409 29 29 39 24 4 0 14 0";
String Bb = "0 0 0 0 0 1 1 1399 0 0";
String B =  "4 1 6 0 409 6 1 0 3 0";

String test0 = "0 61 20 68 75 409 191 20 0 40 0";
String test1 = "0 0 409 0 0 0 0 0 0 0";
String test2 = "2 3 0 3 3 409 74 0 0 0 0";

String off = "0 0 0 0 0 0 0 0 0 0 0";

void sendNoteHylight(int index, String note) {
  String i = Integer.toString(index);
  String msg = i + ' ' + note;

  byte arr[] = msg.getBytes();

  myPort.write(arr);
}

void sendNoteHylight(String note) {

  byte arr[] = note.getBytes();

  myPort.write(arr);
}

void setup()
{

  size(510, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  printArray( Serial.list());
  println(portName);

  myPort = new Serial(this, portName, 9600);
}

void draw() {
}

void keyPressed() {
  if (key == '1') {
    sendNoteHylight(0, C);
    println("send");
  }

  if (key == '2') {
    sendNoteHylight(0, Db);
    println("send");
  }

  if (key == '3') {
    sendNoteHylight(0, Eb);
    println("send");
  }

  if (key == '4') {
    sendNoteHylight(0, E);
    println("send");
  }

  if (key == '5') {
    sendNoteHylight(0, F);
    println("send");
  }

  if (key == '6') {
    sendNoteHylight(0, Gb);
    println("send");
  }

  if (key == '7') {
    sendNoteHylight(0, G);
    println("send");
  }

  if (key == '8') {
    sendNoteHylight(0, Ab);
    println("send");
  }

  if (key == '9') {
    sendNoteHylight(0, A);
    println("send");
  }

  if (key == '0') {
    sendNoteHylight(0, Bb);
    println("send");
  }

  if (key == '-') {
    sendNoteHylight(0, B);
    println("send");
  }

  if (key == 'a') {
    sendNoteHylight(0, off);
    sendNoteHylight(1, off);
    sendNoteHylight(2, off);
    sendNoteHylight(3, off);
    sendNoteHylight(4, off);
    println("send");
  }
}



import java.io.BufferedReader;
import java.io.InputStreamReader;


void runCommand(String command) {
  File workingDir = new File(sketchPath(""));

  String returnedValues;

  try {
    Process p = Runtime.getRuntime().exec(command, null, workingDir);
    int i = p.waitFor();
    if (i == 0) {
      BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
      while ( (returnedValues = stdInput.readLine()) != null) {
        println(returnedValues);
      }
    } else {
      BufferedReader stdErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
      while ( (returnedValues = stdErr.readLine()) != null) {
        println(returnedValues);
      }
    }
  } 
  catch (Exception e) {
    println("Error running command!");
    println(e);
  }
}

void launchCommand(String command) {
  println("Launching new command");
  launch(command);
}
