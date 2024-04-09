// class done by Conor Tiernan, along with anything in relation to dotplots and the screen
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
String text;
  
  
  
  
  // initialises the dotplot object
  DotPlot(ArrayList<Flight> f, String filePath, String text)
  {
  this.f = f;
  this.filePath = filePath;
  this.text = text;
  }
  // counts the unique values in a column of a table and returns an array of them
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


//returns the % of  times a certain value appears in a column of a table 
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
  
  // draws a dotplot for the origin airports
  void dotPlotOrigin()
{
Table fData;
  String value;
  float temp1;
  String temp;
  int temp3 = 0;
  int temp2 = 0;
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

  //displays y labels
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
        temp2 = i;
    }
}

float minValue = Float.MAX_VALUE;
for (int i = 0; i < array.length; i++) {
        if (array[i] < minValue) {
            minValue = array[i];
            temp3 = i;
        }
    }




line(startX, endY, endX, endY);
// displays dots
 for (int i = 0; i < array.length; i++) {
    float x = startX  + i * spacing; 
    float y = map(array[i], 0, maxValue, endY, startY); 
    ellipse(x, y, 8, 8); 
  }
  
  text("% of total flights", startX, (startY + endY /2) + 20);
  text("Different Origin Airports", startX + endX /2, startY + 50);
  fill(0,255,0);
  
  text("Busiest Aiport: " + array1[temp2], width - 50, 50);
  
  fill(255,0,0);
  
  text("Quietest Airport:" + array1[temp3], width - 50, 70);
  
  
}

// draws a dotplot for the destination airports
void dotPlotDestination()
{
Table fData;
  String value;
  float temp1;
  String temp;
  int temp3 = 0;
  int temp2 = 0;
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
  Float [] array = new Float [getUniqueValues(fData, 7).length];
  String [] array1 = new String [getUniqueValues(fData, 7).length];
  array1 = getUniqueValues(fData, 7);
  int a = fData.getRowCount();

for (int i = 0; i < array1.length ; i++) {
  temp = array1[i];
  
for (Flight flight : f)
{
  value = flight.destinationIATA;
  
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

  // displays Y labels
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
        temp2 = i;
    }
}

float minValue = Float.MAX_VALUE;
for (int i = 0; i < array.length; i++) {
        if (array[i] < minValue) {
            minValue = array[i];
            temp3 = i;
        }
    }






line(startX, endY, endX, endY);
// displays dots
 for (int i = 0; i < array.length; i++) {
    float x = startX  + i * spacing; 
    float y = map(array[i], 0, maxValue, endY, startY); 
    ellipse(x, y, 8, 8); 
  }


  
  text("% of total flights", startX, (startY + endY /2) + 20);
  text("different destination airports", startX + endX /2, startY);
  
   fill(0,255,0);
  
  text("Busiest Aiport: " + array1[temp2], width - 50, 50);
  
  fill(255,0,0);
  
  text("Quietest Airport:" + array1[temp3], width - 50, 70);
  
  
  
}




}
