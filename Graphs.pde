import processing.data.Table;
import processing.data.TableRow;
import java.util.ArrayList;
import java.util.Collections;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;
Screen s;


class DotPlot 
{
ArrayList<Flight> f;
String filePath;
  
  
  
  
  
  DotPlot(ArrayList<Flight> f, String filePath)
  {
  this.f = f;
  this.filePath = filePath;
  }
  
  String[] getUniqueValues(Table table, int colIndex) {
  ArrayList<String> uniqueValuesList = new ArrayList<String>();
 table.removeRow(0);
  for (TableRow row : table.rows()) {
    String value = row.getString(colIndex);

    if (!uniqueValuesList.contains(value)) {
      uniqueValuesList.add(value);
    }
  }

  String[] uniqueValuesArray = new String[uniqueValuesList.size()];
  uniqueValuesList.toArray(uniqueValuesArray);

  return uniqueValuesArray;
}

float countCertainValue(Table table, int colIndex, String airportCode) {
  int result = 0;
  int totalCount = 0;

  for (TableRow row : table.rows()) {
    String value = row.getString(colIndex);
    totalCount++;

    if (value.equals(airportCode)) {
      result++;
    }
  }

  return (float) result / totalCount * 100;
}
  
  
  void dotPlotOrigin()
{
Table fData;
  String value;
  float temp1;
  String temp;
  String[] yLabels = new String[6];
  yLabels[0] = "0";
  yLabels[1] = "1";
  yLabels[2] = "2";
  yLabels[3] = "3";
  yLabels[4] = "4";
  yLabels[5] = "5";
  temp1 = 0;
  //fData = loadTable(filePath, "csv");
  fData = loadTable("../flights2k(1).csv");
  Float [] array = new Float [getUniqueValues(fData, 3).length];
  String [] array1 = new String [getUniqueValues(fData, 3).length];
  array1 = getUniqueValues(fData, 3);
  int a = fData.getRowCount();

for (int i = 0; i < array1.length ; i++) {
  temp = array1[i];
  
for (Flight flight : f)
{
  value = flight.originIATA;
  
  if (temp.trim().equals(value.trim()))
  {
  temp1++;
  }
  
}


array[i] = (temp1 / a) * 100;
temp1 = 0;
}

  float startX = width * 0.2;
float endX = width * 0.9;
float startY = height * 0.15;
float endY = height * 0.9;
float spacing = (endX - startX) / (array.length - 1);

line(startX, startY, startX, endY);

  
  for (int i = 0; i < yLabels.length; i++) {
    float y = map(i * 10 , 0, 40, endY, startY); 
    float labelY = map(i * 10 , 0, 40, endY, startY); 
    textAlign(RIGHT, CENTER);
    text(yLabels[i], startX - 5, labelY);
    line(startX - 5, y, startX, y); 
  }


float maxValue = Float.MIN_VALUE;
for (int i = 0; i < array.length; i++) {
    if (array[i] > maxValue) {
        maxValue = array[i];
    }
}

//for (int i = 0; i < array.length ; i++)
//{
//println("\n " + array[i]);
//}




line(startX, endY, endX, endY);

 for (int i = 0; i < array.length; i++) {
    float x = startX  + i * spacing; 
    float y = map(array[i], 0, maxValue, endY, startY); 
    ellipse(x, y, 8, 8); 
  }
  
  text("% of total flights", startX, startY + endY /2);
  text("different origin airports", startX + endX /2, startY + 50);
}


void dotPlotDestination(ArrayList<Flight> f , String[] yLabels, String filePath)
{
Table fData;
  String value;
  float temp1;
  fData = loadTable(filePath, "csv");
  Float [] array = new Float [getUniqueValues(fData, 7).length];
  String [] array1 = new String [getUniqueValues(fData, 7).length];
  array1 = getUniqueValues(fData, 7);

for (int i = 0; i < array1.length ; i++) { // runs through the array and counts how many times a certain airport code appears and returns as a percentage into the array.
  temp1 = 0;
  String temp = array1[i];
  
for (Flight flight : f)
{
  value = flight.destinationIATA;
  
  if (temp == value)
  {
  temp1++;
  }
  
}
array[i] = (temp1/array.length) * 100;
}

  float startX = width * 0.1;
float endX = width * 0.9;
float startY = height * 0.1;
float endY = height * 0.9;
float spacing = (endX - startX) / (array.length - 1);

line(startX, startY, startX, endY);

  
  for (int i = 0; i < yLabels.length; i++) {
    float y = map(i * 10, 0, 40, endY, startY); 
    float labelY = map(i * 10, 0, 40, endY, startY); 
    textAlign(RIGHT, CENTER);
    text(yLabels[i], startX - 5, labelY);
    line(startX - 5, y, startX, y); 
  }


float maxValue = Float.MIN_VALUE;
for (int i = 0; i < array.length; i++) {
    if (array[i] > maxValue) {
        maxValue = array[i];
    }
}


line(startX, endY, endX, endY);

 for (int i = 0; i < array.length; i++) {
    float x = startX + i * spacing; 
    float y = map(array[i], 0, maxValue, endY, startY); 
    ellipse(x, y, 8, 8); 
  }
  
  text("% of total flights", startX, startY + endY /2);
  text("different destination airports", startX + endX /2, startY);
}




}




class pieChart{
  float diameter;
  FloatList data;
  StringList airlines;
  PFont font;
  PFont title;
  String TITLE;
  boolean[] buttons;
  FloatList adjustedAngles;
  int lastClickTime;
  int clickCooldown;
  pieChart(float diameter, FloatList data, StringList airlines, PFont font, PFont title, String TITLE){ //data is just a list of angles
    this.diameter = diameter;
    this.data = data;
    this.airlines = airlines;
    this.font = font;
    this.title = title;
    this.TITLE = TITLE;   
    buttons = new boolean[data.size()];
    adjustedAngles = data;
    lastClickTime = 0;
    clickCooldown = 500; // 2 seconds in milliseconds
    
    for (int i=0; i<data.size();i++){
      println(codeToName(airlines.get(i))+": "+ data.get(i));
    }
  }
  void draw() {
    float lastAngle = 0;
    int keyWidth = 15;
    int keyHeight = 10;
    int x = 10;
    int y = 360/4;
    int increment = 20;
    int titlePos = 30;
    if (height>500){
      keyWidth *= 3;
      keyHeight *= 3;
      x *= 3;
      y *= 3;
      increment *= 3;
      titlePos *= 3;
    }
    textFont(title);
    text(TITLE, titlePos, titlePos);
    for (int i = 0; i < data.size(); i++) {
      //float gray = map(i, 0, data.size(), 0, 255);
      //fill(gray);
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
      text(airline,x+keyWidth+10, y+keyHeight);
      y+=increment;
    }
    //buttonPressed(buttons);
    //adjustedAngles = angleAdjustment(data, buttons);
  }
  
  void keyPressed(){
     buttonPressed(buttons);
  }
  
  void mousePressed(){
    buttonPressed(buttons);
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
  void buttonPressed(boolean b[]){
    int keyWidth = 15;
    int keyHeight = 10;
    int x = 10;
    int y = 360/4;
    int increment = 20;
    if (height>500){
      keyWidth *= 3;
      keyHeight *= 3;
      x *= 3;
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
}
