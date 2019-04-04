/*
  Mapping from pitch and midi to color
 */

int [] midiAflat = {32, 44, 56, 68, 92, 104, 116};
int [] midiANatural = { 21, 33, 45, 57, 69, 81, 93, 105, 117};

int [] midiBflat = {22, 34, 46, 58, 70, 82, 94, 106, 118};
int [] midiBNatural = { 23, 35, 47, 59, 71, 83, 95, 107, 119};

int [] midiCNatural = {24, 36, 48, 60, 72, 84, 96, 108, 120};
int [] midiCSharp = { 25, 37, 49, 61, 73, 85, 97, 109, 121};

int [] midiDNatural = {26, 38, 50, 62, 74, 86, 98, 110, 122};

int [] midiEflat = { 27, 39, 51, 63, 75, 87, 99, 111, 123};
int [] midiENatural = { 28, 40, 52, 64, 88, 100, 112, 124};

int [] midiFNatural = {29, 41, 53, 65, 89, 101, 113, 125};
int [] midiFSharp = {  30, 42, 54, 66, 90, 102, 114, 126};

int [] midiGNatural = {31, 43, 55, 67, 91, 103, 115, 127};

color [] noteColors ={#F74B27, #FF829B, #FE7B0D, #FEB76C, #FFD500, #FFFDAF, #84FFB6, #0132FC, #A8E3FF, #E1A0FF, #E0D7FF, #3CBA2D };
String [] noteNames = {"A Flat", "A Natural", "B Flat", "B natural", "C natural", "C Sharp", "D Natural", "E Flat", "E natural", "F Shap", "G natural"}; 


String Ab = "0 409 9 13 13 9 0 0 4 0";
String A =  "29 409 29 29 39 24 4 0 14 0";

String Bb = "0 0 0 0 0 1 1 1399 0 0";
String B =  "4 1 6 0 409 6 1 0 3 0";

String C =  "3 0 3 3 409 74 0 0 0 0";

String Db = "61 20 68 75 409 191 20 0 40 0";
String D =  "90 30 100 110 140 90 150 0 120 0";

String Eb = "75 409 8 12 16 8 0 0 4 0";
String E =  "110 40 130 140 170 110 30 90 100 0";

String F =  "185 409 78 87 117 78 19 0 48 0";

String Gb = "210 50 150 170 210 140 40 0 90 0";
String G =  "10 0 10 10 10 70 100 0 0 0";

ArrayList<String> cmdHylighter; 
int currIndexHylighter = -1;

String off = "0 0 0 0 0 0 0 0 0 0 0";

ArrayList<int []> notesMidMap;

void setupMidiMap() {
  notesMidMap = new ArrayList<int []>();
  notesMidMap.add(midiAflat);
  notesMidMap.add(midiANatural);

  notesMidMap.add(midiBflat);
  notesMidMap.add(midiBNatural);

  notesMidMap.add(midiCNatural);
  notesMidMap.add(midiCSharp);

  notesMidMap.add(midiDNatural);

  notesMidMap.add(midiEflat);
  notesMidMap.add(midiENatural);

  notesMidMap.add(midiFNatural);
  notesMidMap.add(midiFSharp);

  notesMidMap.add(midiGNatural);

  cmdHylighter = new ArrayList<String>();
  cmdHylighter.add(Ab);
  cmdHylighter.add(A);
  cmdHylighter.add(Bb);
  cmdHylighter.add(B);
  cmdHylighter.add(C);
  cmdHylighter.add(Db);
  cmdHylighter.add(D);
  cmdHylighter.add(Eb);
  cmdHylighter.add(E);
  cmdHylighter.add(F);
  cmdHylighter.add(Gb); 
  cmdHylighter.add(G);
}

color mapPitch(float pitch) {
  color pitchColor = color(10, 10, 10, 255);
  int midiPitch = floor(pitch);
  currIndexHylighter = -1;
  //// println(midiPitch);


  for (int j =0; j < notesMidMap.size(); j++) {
    int [] mNote =  notesMidMap.get(j);
    for (int i = 0; i < mNote.length; i++) {
      if (midiPitch == mNote[i]) {
        pitchColor = noteColors[j];
        //println("note: "+noteNames[j]+ " "+j);
        currIndexHylighter = j;
        return pitchColor;
      } else {
        //pitchColor =color(0, 0, 0, 255);
        //currIndexHylighter = -1;
      }
    }
  }
  
  pitchColor = color(pitchColor, 100);
  return pitchColor;
}
