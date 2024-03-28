class Flight { // All code in this class by Aidan Muller
  String date, originIATA, originState, carrier, destinationIATA, destinationState;
  int departureTime, arrivalTime, distanceTravelled;
  float[][] pixelPositionsSim = new float[2][2];
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
   //println(departureTime, arrivalTime);
   cancelled = cd;
   diverted = dd;
   distanceTravelled = dis;
  }
  float[] getPixelPositionFromHour(int hour) {
    float[] returnPosition = new float[2];
    int startHourMinutes, endHourMinutes;
    float fraction;
    startHourMinutes = ((departureTime-departureTime%100)/100) * 60 + departureTime%100;
    endHourMinutes = ((arrivalTime-arrivalTime%100)/100) * 60 + arrivalTime%100;
    if (endHourMinutes<startHourMinutes) endHourMinutes += 24*60;
    fraction = (float)(((float)(hour-startHourMinutes))/((float)(endHourMinutes-startHourMinutes)));
    //returnPosition[0] = (float)((float)(pixelPositionsSim[0][0]+pixelPositionsSim[1][0]))*fraction;
    //returnPosition[1] = (float)((float)(pixelPositionsSim[0][1]+pixelPositionsSim[1][1]))*fraction;
    
    returnPosition[0] = ((float)pixelPositionsSim[0][0])+((float)(pixelPositionsSim[1][0]-pixelPositionsSim[0][0]))*fraction;
    returnPosition[1] = ((float)pixelPositionsSim[0][1])+((float)(pixelPositionsSim[1][1]-pixelPositionsSim[0][1]))*fraction;

    
    if (startHourMinutes>hour || hour>endHourMinutes) {
       returnPosition[0] = -1;
       returnPosition[1] = -1;
    }
    if (returnPosition[0] != Double.POSITIVE_INFINITY && cancelled == false && diverted == false && returnPosition[0] != -1) {
      //println(pixelPositionsSim[0][0], pixelPositionsSim[1][0], pixelPositionsSim[0][0]+((float)(pixelPositionsSim[1][0]-pixelPositionsSim[0][0]))*fraction, ((float)pixelPositionsSim[0][0])+((float)(pixelPositionsSim[1][0]-pixelPositionsSim[0][0]))*fraction);
      // println(((float)pixelPositionsSim[0][0])+((float)(pixelPositionsSim[1][0]-pixelPositionsSim[0][0]))*fraction, ((float)pixelPositionsSim[0][1])+((float)(pixelPositionsSim[1][1]-pixelPositionsSim[0][1]))*fraction);  
  }
    return returnPosition;
  }
}
