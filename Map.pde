class Map {
  PImage mapTexture;    // Map image texture
  int x, y;             // Map x and y position
  private int w, h;             // Map image width & height
  Map(PImage texture, int xPos, int yPos) {
    mapTexture = texture;
    x = xPos;
    y = yPos;
    w = texture.width;
    h = texture.height;
  }
  void draw() {
    image(mapTexture, x, y);
  }
  void setPosition(int xPos, int yPos) {
    x = xPos;
    y = yPos;
  }
  float[] getCoordinatesFromIATA(String inpIATA) {
    String filePath = "data/usa-airports.csv"; // adjust file path to wherever it is in your files
    float[] returnValue = new float[2];
    returnValue[0] = -1;
    returnValue[1] = -1;
    Table flightData = loadTable(filePath, "csv");
    for (TableRow row : flightData.rows()) {
      String iata = row.getString(0);
      if (iata.equals(inpIATA)) {
        returnValue[0] = float(row.getString(5));
        returnValue[1] = float(row.getString(6));
      }
    }
    return returnValue;
  }
  void drawAirport(String IATA) {
    float[] pixelPos = getCoordinatesFromIATA(IATA);
    pixelPos[0] = y+MapTools.latitudeToPixels(pixelPos[0], h);
    pixelPos[1] = x+MapTools.longitudeToPixels(pixelPos[1], w);
    circle(pixelPos[1], pixelPos[0], 10);
  }
  void drawFlight(Flight f) {
    float[] pixelPos = getCoordinatesFromIATA(f.originIATA);
    float[] pixelPos2 = getCoordinatesFromIATA(f.destinationIATA);
    pixelPos[0] = y+MapTools.latitudeToPixels(pixelPos[0], h);
    pixelPos[1] = x+MapTools.longitudeToPixels(pixelPos[1], w);
    pixelPos2[0] = y+MapTools.latitudeToPixels(pixelPos2[0], h);
    pixelPos2[1] = x+MapTools.longitudeToPixels(pixelPos2[1], w);
    line(pixelPos[1], pixelPos[0], pixelPos2[1], pixelPos2[0]);
    // Code to draw a flight on map will go here
  }
  void drawFlights(ArrayList<Flight> f) {
    for (int i = 0; i < f.size(); i++) {
      drawFlight(f.get(i));
    }
  }
};
