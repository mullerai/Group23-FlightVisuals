//void setup() {
//  String filePath = "flights2k(1).csv"; // adjust file path to wherever it is in your files
//  flightData = loadTable(filePath, "csv");

//  fullScreen();
//  background(255);
  
//  int[] flightsArray = getFlightsPerDate(flightData);
  
//  String[] dateLabels = getDateLabels(flightData);
//  String[] yLabels = generateYLabels(flightsArray);
//  for (int i = 0; i < yLabels.length; i++) {
//    println("Date " + (i + 1) + ": " + yLabels[i]);
//  }
  
//  println("Flights per date:");
//  for (int i = 0; i < flightsArray.length; i++) {
//    println("Date " + (i + 1) + ": " + flightsArray[i]);
//  }
  
//  LineGraph(flightsArray, yLabels, dateLabels, "Flights", "January 2022");
//}

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
String[] getDateLabels(Table flightData) {
  int maxDay = 0;
  for (TableRow row : flightData.rows()) {
    String[] dateParts = split(row.getString(0), '/');
    int day = int(dateParts[1]);
    if (day > maxDay) {
      maxDay = day;
    }
  }

  // Initialize the array to store date labels
  String[] dateLabels = new String[maxDay];

  // Populate the array with day numbers
  for (int i = 0; i < maxDay; i++) {
    dateLabels[i] = Integer.toString(i + 1);
  }

  return dateLabels;
}

int[] getFlightsPerDate(Table flightData) {
  flightData.removeRow(0);
  int maxDay = 0;
  for (TableRow row : flightData.rows()) {
    String[] dateParts = split(row.getString(0), '/');
    int day = int(dateParts[1]);
    if (day > maxDay) {
      maxDay = day;
    }
  }

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


void LineGraph(int[] array, String[] yLabels, String[] xLabels, String yLabel, String xLabel) {
  float startX = width * 0.1;
  float endX = width * 0.9;
  float startY = height * 0.1;
  float endY = height * 0.9;
  float spacing = (endX - startX) / (array.length - 1);

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
  
  for (int i = 0; i < array.length; i++) {
    float x = startX + i * spacing; 
    float y = map(array[i], 0, max(array), endY, startY); 
    if(i>0){
      float prevX = startX + (i - 1) * spacing;
      float prevY = map(array[i - 1], 0, max(array), endY, startY);
      line(prevX, prevY, x, y);
    }
    ellipse(x, y, 1, 1); 
  }
  
  fill(0);
  textSize(25);
  text(yLabel, startX - 50, startY + endY /2);
  text(xLabel, startX + endX/2, endY + 50);
}
