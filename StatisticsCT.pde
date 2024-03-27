import processing.data.Table;
import processing.data.TableRow;
import java.util.ArrayList;
import java.util.Collections;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;

Table flightData;



//void setup() {
//  fullScreen();
//  size(400, 400);

//  // Load the table
  //String filePath = "../flights2k(1).csv"; // adjust file path to wherever it is in your files
  //flightData = loadTable(filePath, "csv");

//  // Example usage
//  int colIndex1 = 3;
//  int colIndex2 = 7;

//  //printTable(flightData);
//  String[] unique = getUniqueValues(flightData, colIndex1);
//  String[] unique2 = getUniqueValues(flightData, colIndex2);

//  int amountOriginAirports = unique.length - 1;
//  int amountArrivalAirports = unique2.length - 1;

//  //println("percentage of occurrences of 'LAX': " + countCertainValue(flightData, colIndex1, "LAX") + "%");
////printTable(flightData);
  
//  println(countCertainValue(flightData, 0, " 1/5/2022 12:00:00AM"));

//float[] array = percentageOfUniqueValuesArray( flightData , 3);
//   println(array);
  
  
//float [] array = new float [getUniqueValues(flightData, 3).length];
//  array = percentageOfUniqueValuesArray(flightData, 3);
//  String[] yLabels = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"};
//  dotPlot(array, yLabels);  
  
//}

//void draw (){

//}


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

//public static void swapRows(Table table, int row1, int row2) {
//  TableRow temp = table.getRow(row1);
//  table.setRow(row1, table.getRow(row2));
//  table.setRow(row2, temp);
//}





////void printTable(Table table) {
////  for (TableRow row : table.rows()) {
////    println(row.getString(0)); // Print only the first column for demonstration
////  }
////}


//float []  percentageOfUniqueValuesArray(Table table, int colIndex)
//{
//String[] unique = getUniqueValues(table, colIndex);
//float [] result = new float[unique.length - 1];
//float temp;
//String temp1;

//for (int i = 0; i < result.length ; i++)
//{
//  if (i + 1 < unique.length && unique[i + 1] != null){
//  temp1 = unique[i + 1];   
//  temp = countCertainValue(table, colIndex, temp1); 
//  result[i] = temp;}
//  else
//  {
//  break;
//  }
  
  
//}
//return result;

//}

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
  value = flight.originIAIA;
  
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
  value = flight.destinationIAIA;
  
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
