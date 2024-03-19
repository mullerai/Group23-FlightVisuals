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
  
  
  
   int amountOriginAirports = unique.length -1;
   int amountArrivalAirports = unique2.length -1;
   
   println ("" + countCertainValue(flightData, colIndex1, "LAX"));
   
   
   
}

void draw() {
  
}




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

float countCertainValue (Table table, int colIndex, String airportCode)
{
  int result = 0;
  int totalCount = 0;
  
  for (TableRow row : table.rows()) {
    
    String value = row.getString(colIndex);
    //value = value.trim();

     totalCount++;
    
    if (value.equals(airportCode)) {
      
      result++;
    }
  }
  
  
  

  return (float) result / totalCount  * 100;
}
