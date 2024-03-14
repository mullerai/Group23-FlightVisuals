Table flightData; 

void setup() {
  
  //String filePath = "C:\\Users\\Dback\\Downloads\\flights2k(1).csv"; // adjust file path to wherever it is in your files
  String filePath = "../flights2k(1).csv"; // adjust file path to wherever it is in your files
  
  
  flightData = loadTable(filePath, "csv");
  
  int colIndex1 = 3;
  int colIndex2 = 7;
  
  //printTable(flightData);
  String [] unique = getUniqueValues(flightData, colIndex1);
  String [] unique2 = getUniqueValues(flightData, colIndex2);
  
  
  // for (String value : unique) {
   // println(value);
   //}
   int amountOriginAirports = unique.length -1;
   int amountArrivalAirports = unique2.length -1;
   
   println ("" + countCertainValue(flightData, colIndex1, "LAX"));
   
   
   
}

void draw() {
  
}


//void printTable(Table table) {
  //for (TableRow row : table.rows()) {
    //for (int col = 0; col < table.getColumnCount(); col++) {
      //print(row.getString(col) + "\t");
    //}
    //println(); 
  //}
//}

String[] getUniqueValues(Table table, int colIndex) 
{
ArrayList<String> uniqueValuesList = new ArrayList<String>();

 for (TableRow row : table.rows()) {
    
    String value = row.getString(colIndex);
    
    
    if (!uniqueValuesList.contains(value)) {
      
      uniqueValuesList.add(value);
    }
  }

  // Convert the ArrayList to an array
  String[] uniqueValuesArray = new String[uniqueValuesList.size()];
  uniqueValuesList.toArray(uniqueValuesArray);

  return uniqueValuesArray;

}

int countCertainValue (Table table, int colIndex, String airportCode)
{
  int result = 0;
  
  for (TableRow row : table.rows()) {
    
    String value = row.getString(colIndex);
    value = value.trim();

    
    if (value == airportCode) {
      
      result++;
    }
  }
  
  
  
  //return (result/getUniqueValues(flightData, colIndex).length - 1) * 100;
  return result;
}
