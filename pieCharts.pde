// pie chart class created by kellan
class pieChart{
  Table table;
  IntList diversions;
  IntList cancellations;
  FloatList diversionAngles;
  IntList totalFlights;
  FloatList diversionPercentages;
  FloatList cancellationPercentages;
  PFont keyFont;
  PFont keyFontTitle;
  PFont keyFont2;
  PFont keyFontTitle2;
  
  
  float diameter;
  FloatList data;
  StringList airlines;
  PFont font;
  PFont title;
  String TITLE;
  boolean[] buttons;
  FloatList adjustedAngles;
  int lastClickTime;
  int lastClickTime2;
  int clickCooldown;
  String next;
  //data coming is handled in the constructor with the call to getData method
  pieChart(Table inputData){
    this.diameter =(height/3)*2;
    font = loadFont("3ds-Light-48.vlw");
    this.title = loadFont("BodoniMT-Bold-84.vlw");
    this.TITLE ="Cancellations";   
    
    
    
  airlines = new StringList();
  diversions = new IntList();
  cancellations = new IntList();
  data = new FloatList();
  totalFlights = new IntList();
  diversionPercentages = new FloatList();
  cancellationPercentages = new FloatList();
  getData(inputData);
  buttons = new boolean[data.size()];
    adjustedAngles = data;
    lastClickTime = 0;
    lastClickTime2 = 0;
    clickCooldown = 500; // 0.5 seconds in milliseconds
  }
  // pie chart and key is drawn here
  void draw() {
    float lastAngle = 0;
    int keyWidth = 15;
    int keyHeight = 10;
    int x = (width/2)+((int)diameter/2)+75;
    int y = 360/3;
    int increment = 20;
    int titlePos = 30;
    if (height>500){
      keyWidth *= 3;
      keyHeight *= 3;
      y *= 3;
      increment *= 3;
      titlePos *= 3;
    }
    fill(0);
    textFont(title);
    textAlign(CENTER, CENTER);
    text(TITLE, (width/2), titlePos);
    for (int i = 0; i < data.size(); i++) {
      textAlign(LEFT, TOP);
      float red = map(i, 0, data.size(), 0, 255);
      float green = map(i, 0, data.size()/2, 0, 255);
      float blue = map(i, 0, data.size()/4, 0, 255);
      fill(red,green,blue);
      
      if(!buttons[i]){
        arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(adjustedAngles.get(i)));
        lastAngle += radians(adjustedAngles.get(i));
      }
      
      //key
      rect(x,y,keyWidth,keyHeight);
      String airline = codeToName(airlines.get(i));
      textFont(font);
      fill(0);
      text(airline,x+keyWidth+10, y);
      y+=increment;
    }
  }
  
  //void keyPressed(){
  //   buttonPressed(buttons);
  //}
  
  //calls function to handle that way the pie chart is changed
  void mousePressed(){
    buttonPressed(buttons);
  }
  // function to return the name associated with the airline code
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
  // handle the buttonpressed within the pie chart class
  void buttonPressed(boolean b[]){
    int keyWidth = 15;
    int keyHeight = 10;
    int x = (width/2)+((int)diameter/2)+75;
    int y = 360/3;
    int increment = 20;
    if (height>500){
      keyWidth *= 3;
      keyHeight *= 3;
      //x *= 3;
      y *= 3;
      increment *= 3;
    }
    for (int i=0; i<b.length; i++){
      if (mouseX>x && mouseX<=x+keyWidth && mouseY>=y && mouseY<=y+keyHeight &&  millis() - lastClickTime >= clickCooldown){
        if (b[i] == true){
          b[i] = false;
          println("button " + (i+1) + " pressed");
        }
        else{
          b[i] = true;
          println("button " + (i+1) + " pressed");
        }
        lastClickTime = millis();
        adjustedAngles = angleAdjustment(data, b);
      }
      y+=increment;
    }
    
  }
  // this adjusts the angles of the pie chart accoring to which buttons have been pressed
  FloatList angleAdjustment(FloatList input, boolean[] b){
    FloatList output;
    float missingAngle = 0;
    
    for (int i=0; i<b.length; i++){
      if( b[i] == true)
        missingAngle += input.get(i);
    }
    
    if (missingAngle>0){ 
      output = new FloatList();
      for (int x=0; x<b.length; x++){
        if(b[x] == false){
          output.append(input.get(x)*(360.0/(360.0-missingAngle)));
          println(codeToName(airlines.get(x))+": "+input.get(x)*(360.0/(360.0-missingAngle)));
        }
        else{
          output.append(0.0);
          println(codeToName(airlines.get(x))+": 0.0");
        }
          
      }
    } else{
      output = input;
    }
    //adjustedAngles = angleAdjustment(data, b);
    return output;
  }
  // this method formats the data in way that it usable for the pie chart
  void getData(Table table){
    table.removeRow(0);
    for (TableRow row : table.rows()) {
      String carrier = row.getString(1);
      int diverted = row.getInt(16);
      int cancelled = row.getInt(15);
      if (!airlines.hasValue(carrier)){
        airlines.append(carrier);
        diversions.append(0);
        cancellations.append(0);
        totalFlights.append(0);
      }
      
      for(int i=0; i<airlines.size(); i++){
        if (airlines.get(i).equals(carrier)){
          if (diverted == 1){
            diversions.add(i, 1);
            //println(carriers.get(i) + " was diverted");
          }
          else if (cancelled == 1){
            cancellations.add(i,1);
            //println(carriers.get(i) + " was cancelled");
          }
         totalFlights.add(i,1);   
        }
      }
    }
  //float totalDPercentage = 0;
  float totalCPercentage =0;
  for(int i=0; i<airlines.size(); i++){
    //float percent = ((float)diversions.get(i)/(float)totalFlights.get(i))*100.0;
    //diversionPercentages.append(percent);
    //totalDPercentage += percent;
    float percent = ((float)cancellations.get(i)/(float)totalFlights.get(i))*100.0;
    cancellationPercentages.append(percent);
    totalCPercentage += percent;
  }
  
  
  
  for(int i=0; i<airlines.size(); i++){
    //diversionAngles.append(((float)diversions.get(i)/(float)totalDiversions) * 360.0);
    //diversionAngles.append((diversionPercentages.get(i)/totalDPercentage)*360.0);
    //cancellationAngles.append(((float)cancellations.get(i)/(float)totalCancellations) * 360.0);
    data.append((cancellationPercentages.get(i)/totalCPercentage)*360.0);
  }
  }
}
