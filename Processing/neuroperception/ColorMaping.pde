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
}

color mapPitch(float pitch) {
  color pitchColor = color(0, 0, 0, 255);
  int midiPitch = floor(pitch);
 //// println(midiPitch);


  for (int j =0; j < notesMidMap.size(); j++) {
    int [] mNote =  notesMidMap.get(j);
    for (int i = 0; i < mNote.length; i++) {
      if (midiPitch == mNote[i]) {
        pitchColor = noteColors[j];
       // println("note: "+noteNames[j]);
        return pitchColor;
      }
    }
  }


  return pitchColor;
}
