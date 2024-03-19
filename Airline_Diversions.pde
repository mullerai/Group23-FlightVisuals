Table table;
StringList carriers;
IntList diversions;
IntList cancellations;
FloatList diversionAngles;
FloatList cancellationAngles;
int totalDiversions;
int totalCancellations;
PFont keyFont;
PFont keyFontTitle;
Boolean switcher;
final int SCREENX = 640;
final int SCREENY = 360;


void setup() {
  size(640, 360);
  noStroke();
  switcher = true;
  
  //table = loadTable("flights2k(1).csv", "header");
  table = loadTable("flights_full (2).csv", "header");
  
  carriers = new StringList();
  diversions = new IntList();
  cancellations = new IntList();
  diversionAngles = new FloatList();
  cancellationAngles = new FloatList();
  totalDiversions = 0;
  totalCancellations = 0;
  
  keyFont = loadFont("3ds-Light-16.vlw");
  keyFontTitle = loadFont("BodoniMT-Bold-28.vlw");
  

  println(table.getRowCount() + " total rows in table");

  for (TableRow row : table.rows()) {

    String carrier = row.getString("MKT_CARRIER");
    int diverted = row.getInt("DIVERTED");
    int cancelled = row.getInt("CANCELLED");
    
    if (!carriers.hasValue(carrier)){
      carriers.append(carrier);
      diversions.append(0);
      cancellations.append(0);
    }
    
    for(int i=0; i<carriers.size(); i++){
      if (carriers.get(i).equals(carrier)){
        if (diverted == 1){
          diversions.add(i, 1);
          //println(carriers.get(i) + " was diverted");
        }
        else if (cancelled == 1){
          cancellations.add(i,1);
          //println(carriers.get(i) + " was cancelled");
        }
        //else
          //println(carriers.get(i) + " was normal");
      }
    }
  }
  
  
  for(int i=0; i<carriers.size(); i++){
    println(carriers.get(i)+" had "+ diversions.get(i) +" diversions and " + cancellations.get(i) + " cancelations");
    totalDiversions += diversions.get(i);
    totalCancellations += cancellations.get(i);
  }
  
  for(int i=0; i<carriers.size(); i++){
    diversionAngles.append(((float)diversions.get(i)/(float)totalDiversions) * 360.0);
    cancellationAngles.append(((float)cancellations.get(i)/(float)totalCancellations) * 360.0);
  }
  
  
}

void draw() {
  background(255);
  if (switcher)
    pieChart(300, cancellationAngles, carriers, keyFont, keyFontTitle, "Cancellations");
  else
    pieChart(300, diversionAngles, carriers, keyFont, keyFontTitle, "Diversions");
}

void mousePressed(){
  if(switcher)
    switcher = false;
  else
    switcher = true;
}

void pieChart(float diameter, FloatList data, StringList airlines, PFont font, PFont title, String TITLE) {
  float lastAngle = 0;
  int keyWidth = 15;
  int keyHeight = 10;
  int x = 10;
  int y = SCREENY/5;
  textFont(title);
  text(TITLE, 30, 30);
  for (int i = 0; i < data.size(); i++) {
    //float gray = map(i, 0, data.size(), 0, 255);
    //fill(gray);
    float red = map(i, 0, data.size(), 0, 255);
    float green = map(i, 0, data.size()/2, 0, 255);
    float blue = map(i, 0, data.size()/4, 0, 255);
    fill(red,green,blue);
    
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(data.get(i)));
    lastAngle += radians(data.get(i));
    
    //key
    rect(x,y,keyWidth,keyHeight);
    String airline = codeToName(airlines.get(i));
    textFont(font);
    fill(0);
    text(airline,x+15, y+keyHeight);
    y+=20;
  }
}

String codeToName(String airlineCode){
  switch(airlineCode){
    case "AA":
      return "American Airlines";
    case "AS":
      return "Alaska Airlines";
    case "B6":
      return "Jet Blue";
    case "DL":
      return "Delta";
    case "F9":
      return "Frontier";
    case "G4":
      return "Allegiant";
    case "HA":
      return "Hawaiian Airlines";
    case "NK":
      return "Spirit Airlines";
    case "UA":
      return "United Airlines";
    case "WN":
      return "SouthWest Airlines";
    default:
      return airlineCode;
  }
}
