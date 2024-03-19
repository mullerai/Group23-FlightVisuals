class stats_cm {
  Table flightData;
  Table resultsTable;

  void setup() {

    //String filePath = "C:\\Users\\Dback\\Downloads\\flights2k(1).csv"; // adjust file path to wherever it is in your files
    String filePath = "flights2k(1).csv"; // adjust file path to wherever it is in your files


    flightData = loadTable(filePath, "csv");

    //println("flights cancelled: " + countCancelled());
    //println("flights diverted: " + countDiverted());
    //println("percenatage cancelled: " + cancelledPercentage() + "%");
    //println("percenatage diverted: "+ divertedPercentage() + "%");
    //println("average distance: " + averageDistance() + " miles");
    //println("average departure delay: " + averageDepartureDelayTime() + " minutes");
    //println("average arrival delay: " + averageArrivalDelayTime() + " minutes");

    resultsTable = new Table();
    for (int i = 0; i < 7; i++) {
      TableRow newRow = resultsTable.addRow();
      switch (i) {
      case 0:
        newRow.setString("Metric", "Cancelled Flights" + "\t");
        newRow.setString("Value", str(countCancelled()));
        break;
      case 1:
        newRow.setString("Metric", "Diverted Flights" + "\t");
        newRow.setString("Value", str(countDiverted()));
        break;
      case 2:
        newRow.setString("Metric", "Cancelled Percentage" + "\t");
        newRow.setString("Value", str(cancelledPercentage()) + "%");
        break;
      case 3:
        newRow.setString("Metric", "Diverted Percentage" + "\t");
        newRow.setString("Value", str(divertedPercentage()) + "%");
        break;
      case 4:
        newRow.setString("Metric", "Average Distance" + "\t");
        newRow.setString("Value", str(averageDistance()));
        break;
      case 5:
        newRow.setString("Metric", "Average Departure Delay" + "\t");
        newRow.setString("Value", str(averageDepartureDelayTime()) + " minutes");
        break;
      case 6:
        newRow.setString("Metric", "Average Arrival Delay" + "\t");
        newRow.setString("Value", str(averageArrivalDelayTime()) + " minutes");
        break;
      default:
        break;
      }
    }
    printTable(resultsTable);
  }
  
  void printTable(Table table) {
    for (TableRow row : table.rows()) {
      for (int col = 0; col < table.getColumnCount(); col++) {
        print(row.getString(col) + "\t");
      }
      println();
    }
  }
  
  int countCancelled() {
    int cancelled = 0;
    String filePath = "flights2k(1).csv"; // adjust file path to wherever it is in your files
    flightData = loadTable(filePath, "csv");
    for (TableRow row : flightData.rows()) {
      row.getString(15);
      if (row.getString(15).equals("1"))
      {
        cancelled++;
      }
    }
    return cancelled;
  }

  int countDiverted() {
    int diverted = 0;
    String filePath = "flights2k(1).csv";
    flightData = loadTable(filePath, "csv");
    for (TableRow row : flightData.rows()) {
      row.getString(16);
      if (row.getString(16).equals("1"))
      {
        diverted++;
      }
    }
    return diverted;
  }

  float cancelledPercentage() {
    int cancelled = 0;
    int totalFlights = flightData.getRowCount();
    if (totalFlights == 0) {
      return 0;
    }

    for (TableRow row : flightData.rows()) {
      String cancellationValue = row.getString(15);
      if (cancellationValue != null && cancellationValue.equals("1")) {
        cancelled++;
      }
    }

    float percentageCancelled = (float)cancelled / totalFlights * 100; 
    return percentageCancelled;
  }

  float divertedPercentage() {
    int diverted = 0;
    int totalFlights = flightData.getRowCount();
    if (totalFlights == 0) {
      return 0;
    }

    for (TableRow row : flightData.rows()) {
      String divertedValue = row.getString(16);
      if (divertedValue != null && divertedValue.equals("1")) {
        diverted++;
      }
    }

    float percentageDiverted = (float)diverted / totalFlights * 100;
    return percentageDiverted;
  }

  float averageDistance() {
    int totalDistance = 0;
    int totalFlights = flightData.getRowCount();
    if (totalFlights == 0) {
      return 0;
    }
    for (int i = 1; i < flightData.getRowCount(); i++) {
      TableRow row = flightData.getRow(i);
      String dist = row.getString(17);
      int distance = Integer.parseInt(dist);
      totalDistance += distance;
    }
    return float(totalDistance)/ (totalFlights-1);
  }

  float averageDepartureDelayTime() {
    int totalDelay = 0;
    int validFlights = 0;
    flightData.removeRow(0);

    for (TableRow row : flightData.rows()) {
      String scheduledDepTimeString = row.getString(11);
      String actualDepTimeString = row.getString(12);

      // Check if both scheduled and actual departure times are present and non-empty
      if (scheduledDepTimeString != null && actualDepTimeString != null &&
        !scheduledDepTimeString.isEmpty() && !actualDepTimeString.isEmpty()) {

        int scheduledDepTime = Integer.parseInt(scheduledDepTimeString);
        int actualDepTime = Integer.parseInt(actualDepTimeString);

        int scheduledMinutes = (scheduledDepTime / 100) * 60 + (scheduledDepTime % 100);
        int actualMinutes = (actualDepTime / 100) * 60 + (actualDepTime % 100);

        int delay = scheduledMinutes - actualMinutes;

        totalDelay += delay;

        validFlights++;
      }
    }

    if (validFlights > 0) {
      float averageDelay = (float) totalDelay / validFlights;
      return Float.parseFloat(String.format("%.2f", averageDelay));
    } else {
      return 0;
    }
  }

  float averageArrivalDelayTime() {
    int totalDelay = 0;
    int validFlights = 0;
    flightData.removeRow(0);

    for (TableRow row : flightData.rows()) {
      String scheduledArrTimeString = row.getString(13);
      String actualArrTimeString = row.getString(14);

      // Check if both scheduled and actual departure times are present and non-empty
      if (scheduledArrTimeString != null && actualArrTimeString != null &&
        !scheduledArrTimeString.isEmpty() && !actualArrTimeString.isEmpty()) {

        int scheduledArrTime = Integer.parseInt(scheduledArrTimeString);
        int actualArrTime = Integer.parseInt(actualArrTimeString);

        int scheduledMinutes = (scheduledArrTime / 100) * 60 + (scheduledArrTime % 100);
        int actualMinutes = (actualArrTime / 100) * 60 + (actualArrTime % 100);

        int delay = scheduledMinutes - actualMinutes;

        totalDelay += delay;

        validFlights++;
      }
    }
    if (validFlights > 0) {
      float averageDelay = (float) totalDelay / validFlights;
      return Float.parseFloat(String.format("%.2f", averageDelay));
    } else {
      return 0;
    }
  }
}
