Table flightData; 

void setup() {
  
  String filePath = "C:\\Users\\Dback\\Downloads\\flights2k(1).csv"; // adjust file path to wherever it is in your files
  
  flightData = loadTable(filePath, "csv");
  
  printTable(flightData);
}

void draw() {
  
}


void printTable(Table table) {
  for (TableRow row : table.rows()) {
    for (int col = 0; col < table.getColumnCount(); col++) {
      print(row.getString(col) + "\t");
    }
    println(); 
  }
}
