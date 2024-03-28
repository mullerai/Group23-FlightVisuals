import processing.data.Table;
import processing.data.TableRow;
import java.util.ArrayList;
import java.util.Collections;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;

class Graphs 
{

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
  
  
  void dotPlotOrigin(ArrayList<Flight> f , String[] yLabels, String filePath)
{
Table fData;
  String value;
  float temp1;
  fData = loadTable(filePath, "csv");
  Float [] array = new Float [getUniqueValues(fData, 3).length];
  String [] array1 = new String [getUniqueValues(fData, 3).length];
  array1 = getUniqueValues(fData, 3);

for (int i = 0; i < array1.length ; i++) {
  temp1 = 0;
  String temp = array1[i];
  
for (Flight flight : f)
{
  value = flight.originIATA;
  
  if (temp == value)
  {
  temp1++;
  }
  
}
array[i] = temp1/100;
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
array[i] = temp1/100;
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
}








}
