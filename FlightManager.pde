class FlightManager {
  ArrayList<Flight> flights;
  Table flightTable;
  String fileString;
  FlightManager(String filepath) {
    flights = new ArrayList<Flight>();
    fileString = filepath;
  }
  void loadFlights() {
    flightTable = loadTable(fileString, "csv");
    flightTable.removeRow(0);
    for (TableRow row : flightTable.rows()) {
      int depH = 0;
      int arrH = 0;
      int dis = 0;
      boolean cancelled = row.getString(15).equals("1");
      boolean diverted = row.getString(16).equals("1");
      if (!cancelled && !diverted) {
         depH = Integer.parseInt(row.getString(12));
         arrH = Integer.parseInt(row.getString(14));
         dis = Integer.parseInt(row.getString(17));
      }
      flights.add(new Flight(
        row.getString(0),
        row.getString(1),
        row.getString(3),
        row.getString(5),
        row.getString(7),
        row.getString(9),
        depH,
        arrH,
        cancelled,
        diverted,
        dis
       ));
    }
  }
};
