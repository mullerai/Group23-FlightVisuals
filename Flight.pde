class Flight {
  String date, originIATA, originState, carrier, destinationIATA, destinationState;
  int departureTime, arrivalTime, distanceTravelled;
  boolean cancelled, diverted;
  Flight(String d, String c, String oIATA, String oState, String dIATA, String dState, int dT, int aT, boolean cd, boolean dd, int dis) {
   date = d;
   carrier = c;
   originIATA = oIATA;
   originState = oState;
   destinationIATA = dIATA;
   destinationState = dState;
   departureTime = dT;
   arrivalTime = aT;
   cancelled = cd;
   diverted = dd;
   distanceTravelled = dis;
  }
}
