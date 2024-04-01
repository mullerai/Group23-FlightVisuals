
//void setup() {
//  String filePath = "flights_full.csv"; // adjust file path to wherever it is in your files
//  flightData = loadTable(filePath, "csv");
   
//  fullScreen();
//  background(255);
  
// //  int maxdate = 31;
  
//   dateInput = new TextBox(width - 200, 200, 150, 50, "", "Enter Max Date");
  

                                             
//  //int[] flightsArray = getFlightsPerDate(flightData, maxdate); //no. of flights until max date in Jan
  
//  //String[] dateLabels = getDateLabels(maxdate);              //x labels
//  //String[] yLabels = generateYLabels(flightsArray);          //y labels
  
// // LineGraph(flightsArray, yLabels, dateLabels, "Flights", "January 2022");
//}

//void draw() {
  
//  dateInput.draw();
  
//}
//void mousePressed() {
//  if (dateInput.contains(mouseX, mouseY)) {
//    dateInput.setSelected(true); // Select TextBox
//  } else {
//    dateInput.setSelected(false); // Deselect TextBox
//  }
//}

//void keyPressed() {
  
//  if (dateInput.isSelected()) {
    
//    if (keyCode == BACKSPACE) {
//      if (dateInput.getText().length() > 0) {
//        dateInput.setText(dateInput.getText().substring(0, dateInput.getText().length() - 1));
//      }
//    } 
//    else if (keyCode == ENTER) {
//      background(255);
//      String maxDate = dateInput.getText();
//      int maxdate = 31;
//      maxdate = Integer.parseInt(maxDate);
//      int[] flightsArray = getFlightsPerDate(flightData, maxdate); //no. of flights until max date in Jan
  
//      String[] dateLabels = getDateLabels(maxdate);              //x labels
//      String[] yLabels = generateYLabels(flightsArray);          //y labels
//      LineGraph(flightsArray, yLabels, dateLabels, "Flights", "January 2022");
//    }
//    else {
     
//      dateInput.setText(dateInput.getText() + key);
//    }
//  }
//}



void printTable(Table table) {  
  for (TableRow row : table.rows()) {
    for (int col = 0; col < table.getColumnCount(); col++) {
      print(row.getString(col) + "\t");
    }
    println();
  }
}

int countOccurrences(Table table, int column, String value) {
  int count = 0;
  for (TableRow row : table.rows()) {
    if (row.getString(column).equals(value)) {
      count++;
    }
  }
  return count;
}

float cancelledPercentage() {
  int cancelled = 0;
  int totalFlights = flightData.getRowCount();
  if (totalFlights == 0) {
    return 0;
  }

  for (TableRow row : flightData.rows()) {
    String cancellationValue = row.getString(15);
    if (cancellationValue != null && cancellationValue.equals("1.00")) {
      cancelled++;
    }
  }

  float percentageCancelled = (float)cancelled / totalFlights * 100; // Calculate percentage
  return Float.parseFloat(String.format("%.2f", percentageCancelled));
}

float divertedPercentage() {
  int diverted = 0;
  int totalFlights = flightData.getRowCount();
  if (totalFlights == 0) {
    return 0;
  }

  for (TableRow row : flightData.rows()) {
    String divertedValue = row.getString(16);
    if (divertedValue != null && divertedValue.equals("1.00")) {
      diverted++;
    }
  }

  float percentageDiverted = (float)diverted / totalFlights * 100; 
  return Float.parseFloat(String.format("%.2f", percentageDiverted));
}

float averageDistance() {
  float totalDistance = 0;
  int totalFlights = flightData.getRowCount();
  if (totalFlights == 0) {
    return 0;
  }
  for (int i = 1; i < flightData.getRowCount(); i++) {
    TableRow row = flightData.getRow(i);
    String dist = row.getString(17);
    float distance = Float.parseFloat(dist);
    totalDistance += distance;
    
    }
  float averageDistance = totalDistance/ (totalFlights-1);
  return Float.parseFloat(String.format("%.2f", averageDistance));
}

String[] getDateLabels(int max) {  //change 
  int maxDay = max;

  String[] dateLabels = new String[maxDay];

  for (int i = 0; i < maxDay; i++) {
    dateLabels[i] = Integer.toString(i + 1);
  }

  return dateLabels;
}

int[] getFlightsPerDate(Table flightData, int max) {  //change
  flightData.removeRow(0);
  int maxDay = max;

  int[] flightsPerDate = new int[maxDay];

  for (TableRow row : flightData.rows()) {
    String[] dateParts = split(row.getString(0), '/');
    int day = int(dateParts[1]);
    String cancelled = row.getString(15);
    if (day > 0 && day <= maxDay && (cancelled == null || !cancelled.equals("1.00"))) {
      flightsPerDate[day - 1]++;
    }
  }

  return flightsPerDate;
}

String[] generateYLabels(int[] flightsPerDate) {
  int maxFlights = max(flightsPerDate);
  int numTicks = 11;
  int tickInterval = maxFlights / (numTicks - 1);

  String[] yLabels = new String[numTicks];

  for (int i = 0; i < numTicks; i++) {
    int labelValue = i * tickInterval;
    yLabels[i] = str(labelValue);
  }

  yLabels[0] = "0";
  yLabels[numTicks - 1] = str(maxFlights);

  return yLabels;
}


void LineGraph(int[] arrayofPoints, String[] yLabels, String[] xLabels, String yLabel,  String xLabel) {
  float startX = width * 0.15;
  float endX = width * 0.9;
  float startY = height * 0.15;
  float endY = height * 0.9;
  float spacing = (endX - startX) / (arrayofPoints.length - 1);

  line(startX, startY, startX, endY);

  for (int i = 0; i < yLabels.length; i++) {
    float y = map(i * 10, 0, 100, endY, startY); 
    float labelY = map(i * 10, 0, 100, endY, startY); 
    textAlign(RIGHT, CENTER);
    fill(0);
    text(yLabels[i], startX - 5, labelY);
    line(startX - 5, y, startX, y); 
  }

  for (int i = 0; i < xLabels.length; i++) {
    float x = map(i, 0, xLabels.length - 1, startX, endX);
    
    textAlign(CENTER, CENTER);
    fill(0);
    text(xLabels[i], x, endY + 20);
    line(x, endY, x, endY + 5);
  }

  line(startX, endY, endX, endY);
  
  for (int i = 0; i < arrayofPoints.length; i++) {
    float x = startX + i * spacing; 
    float y = map(arrayofPoints[i], 0, max(arrayofPoints), endY, startY); 
    if(i>0){
      float prevX = startX + (i - 1) * spacing;
      float prevY = map(arrayofPoints[i - 1], 0, max(arrayofPoints), endY, startY);
      line(prevX, prevY, x, y);
    }
    ellipse(x, y, 2, 2); 
  }
  
  fill(0);
  textSize(height/40);
  text(yLabel, startX - 100, startY + endY /2);
  text(xLabel, startX + endX/2, endY + 50);
}