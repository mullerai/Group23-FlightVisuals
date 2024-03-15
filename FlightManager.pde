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
  ArrayList<Flight> filterFlights(String d, String c, String oIATA, String oState, String dIATA, String dState, int t, MapTools.Setting cd, MapTools.Setting dd, int dis) {
    // Uses MapTools.Setting in file MapTools
    ArrayList<Flight> returnFlights = new ArrayList<Flight>();
    for (Flight flight : flights) {
      if ((!flight.date.equals(d) && !d.equals("*")) ||
        (!flight.carrier.equals(c) && !c.equals("*")) ||
        (!flight.originIATA.equals(oIATA) && !oIATA.equals("*")) ||
        (!flight.originState.equals(oState) && !oState.equals("*")) ||
        (!flight.destinationIATA.equals(dIATA) && !dIATA.equals("*")) ||
        (!flight.destinationState.equals(dState) && !dState.equals("*")) ||
        (!(t==-1) && (t >= flight.departureTime && t<= flight.arrivalTime)) ||    // This line needs to have some additional logic to account for clock roll-over
        (!flight.cancelled==(cd==MapTools.Setting.SET) && !(cd==MapTools.Setting.EITHER)) ||
        (!flight.cancelled==(dd==MapTools.Setting.SET) && !(dd==MapTools.Setting.EITHER)) ||
        (!(dis==-1) && (dis == flight.distanceTravelled))
        ) continue;
      returnFlights.add(flight);
    }
    return returnFlights;
  }
};
