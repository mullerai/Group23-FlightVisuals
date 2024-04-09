//code written by Conor McCarthy

int countOccurrences(Table table, int column, String value) { //counts occurences of a particular column
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

String[] getDateLabels(int min, int max) {  //gets date label from start to end date
  int minDay = min;
  int maxDay = max;

  String[] dateLabels = new String[maxDay - minDay + 1];
  int index = 0;

  for (int i = minDay; i <= maxDay; i++) {
    dateLabels[index] = Integer.toString(i);
    index++;
  }

  return dateLabels;
}

int[] getFlightsPerDate(Table flightData, int min, int max) {  //gets amount of flights for corresponding dates
  flightData.removeRow(0);
  int minDay = min;
  int maxDay = max;

  int[] flightsPerDate = new int[maxDay - minDay + 1];

  for (TableRow row : flightData.rows()) {
    String[] dateParts = split(row.getString(0), '/');
    int day = int(dateParts[1]);
    String cancelled = row.getString(15);
    if (day >= minDay && day <= maxDay && (cancelled == null || !cancelled.equals("1.00"))) {
      flightsPerDate[day - minDay]++;
      
    }
  }

  return flightsPerDate;
}

String[] generateYLabels(int[] flightsPerDate) { //generates y labels creating 10 ticks starting at highest value
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


void LineGraph(int[] arrayofPoints, String[] yLabels, String[] xLabels, String yLabel,  String xLabel) { //draws Line Graph
  float startX = width * 0.2;
  float endX = width * 0.85;
  float startY = height * 0.2;
  float endY = height * 0.85;
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
