import java.time.Instant;

class FlightManager { // All code in this class by Aidan Muller
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
        //println(depH, arrH);
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
  String convertDate(String date) {
    String year = String.format("%c%c%c%c", date.charAt(6), date.charAt(7), date.charAt(8), date.charAt(9));
    String day = String.format("%c%c", date.charAt(3), date.charAt(4));
    String month = String.format("%c%c", date.charAt(0), date.charAt(1));
    String newDate = String.format("%s-%s-%s", year, month, day);
    return newDate;
  }
  boolean isInteger(String s) {
    try {
      Integer.parseInt(s);
      return true;
    }
    catch (Exception e) {
      return false;
    }
  }
  long getTimeStampFromDate(String date) {
    if (!date.equals("*")) {
      try {
        Instant givenDate = Instant.parse(String.format("%sT00:00:00Z", convertDate(date)));
        return givenDate.getEpochSecond();
      }
      catch (Exception e) {
        return 0;
      }
    }
    return 0;
  }
  ArrayList<Flight> filterFlights(String d, String d1, String c, String oIATA, String oState, String dIATA, String dState, int t, MapTools.Setting cd, MapTools.Setting dd, int dis) { // d and d1 are date ranges
    // String wildcard  *
    // MapTools.Setting wildcard is MapTools.Setting.EITHER
    // int wildcard is -1
    // Uses MapTools.Setting in file MapTools
    ArrayList<Flight> returnFlights = new ArrayList<Flight>();
    for (Flight flight : flights) {
      if ((!(getTimeStampFromDate(flight.date)<=getTimeStampFromDate(d1) && getTimeStampFromDate(flight.date)>=getTimeStampFromDate(d)) && (!d.equals("*")||!d1.equals("*"))) ||
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
