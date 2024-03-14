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
    for (TableRow row : flightTable.rows()) {
      flights.add(new Flight(
        row.getString(0),
        row.getString(1),
        row.getString(3),
        row.getString(5),
        row.getString(7),
        row.getString(9),
        Integer.parseInt(row.getString(12)),
        Integer.parseInt(row.getString(14)),
        row.getString(15).equals("1"),
        row.getString(16).equals("1"),
        Integer.parseInt(row.getString(17))
       ));
    }
  }
};
