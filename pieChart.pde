class pieChart{
  float diameter;
  FloatList data;
  StringList airlines;
  PFont font;
  PFont title;
  String TITLE;
  pieChart(float diameter, FloatList data, StringList airlines, PFont font, PFont title, String TITLE){
    this.diameter = diameter;
    this.data = data;
    this.airlines = airlines;
    this.font = font;
    this.title = title;
    this.TITLE = TITLE;    
  }
  void draw() {
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
}
