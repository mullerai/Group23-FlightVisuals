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
//  size(400, 400);

//  // Load the table
//  String filePath = "../flights2k(1).csv"; // adjust file path to wherever it is in your files
//  flightData = loadTable(filePath, "csv");

//  // Example usage
//  int colIndex1 = 3;
//  int colIndex2 = 7;

//  //printTable(flightData);
//  String[] unique = getUniqueValues(flightData, colIndex1);
//  String[] unique2 = getUniqueValues(flightData, colIndex2);

//  int amountOriginAirports = unique.length - 1;
//  int amountArrivalAirports = unique2.length - 1;

//  //println("percentage of occurrences of 'LAX': " + countCertainValue(flightData, colIndex1, "LAX") + "%");
////sortByDate(flightData);
////printTable(flightData);
  
//  println(countCertainValue(flightData, 0, " 1/5/2022 12:00:00AM"));

  
  
  
//}

String[] getUniqueValues(Table table, int colIndex) {
  ArrayList<String> uniqueValuesList = new ArrayList<String>();

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

public static void swapRows(Table table, int row1, int row2) {
  TableRow temp = table.getRow(row1);
  table.setRow(row1, table.getRow(row2));
  table.setRow(row2, temp);
}

void sortByDate(Table table) {
  
  int colIndex = 0;
  int rowCount = table.getRowCount();
  boolean swapped;
  
  do {
  swapped = false;
  for (int i = 1; i < rowCount -1 ; i++)
  {
  TableRow currentRow = table.getRow(i);
      TableRow nextRow = table.getRow(i + 1);
      
      String currentDateStr = currentRow.getString(0); 
      String nextDateStr = nextRow.getString(0);
      
      // Parsing dates
      String[] currentDateParts = split(currentDateStr, '/');
      String[] nextDateParts = split(nextDateStr, '/');
      
      
      int currentMonth = int(currentDateParts[0]);
      int currentDay = int(currentDateParts[1]);
      int currentYear = int(currentDateParts[2]);
      
      int nextMonth = int(nextDateParts[0]);
      int nextDay = int(nextDateParts[1]);
      int nextYear = int(nextDateParts[2]);
      
      
      if (currentYear > nextYear || (currentYear == nextYear && currentMonth > nextMonth) ||
          (currentYear == nextYear && currentMonth == nextMonth && currentDay > nextDay)) {
       
        swapRows(table, i, i + 1);
        swapped = true;
      }
    }
  
  }while(swapped);
  
  
 
  
  
  
  
}



void printTable(Table table) {
  for (TableRow row : table.rows()) {
    println(row.getString(0)); // Print only the first column for demonstration
  }
}
