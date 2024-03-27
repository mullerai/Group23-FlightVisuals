class Map {  // All code in this class by Aidan Muller
  PImage mapTexture;    // Map image texture
  int x, y;             // Map x and y position
  private int w, h;             // Map image width & height
  float[][] pixelPositions = {};
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
    color(255);
    line(pixelPos[1], pixelPos[0], pixelPos2[1], pixelPos2[0]);
    color(0);
    // Code to draw a flight on map will go here
  }
  void getPixelPositions(ArrayList<Flight> f) {
    pixelPositions = new float[f.size()][4];
    for (int i = 0; i < f.size(); i++) {
      float[] pixelPos = getCoordinatesFromIATA(f.get(i).originIATA);
      float[] pixelPos2 = getCoordinatesFromIATA(f.get(i).destinationIATA);
      pixelPos[0] = y+MapTools.latitudeToPixels(pixelPos[0], h);
      pixelPos[1] = x+MapTools.longitudeToPixels(pixelPos[1], w);
      pixelPos2[0] = y+MapTools.latitudeToPixels(pixelPos2[0], h);
      pixelPos2[1] = x+MapTools.longitudeToPixels(pixelPos2[1], w);
      if (pixelPos2[1]-x > 800) println(f.get(i).destinationIATA);
      // line(pixelPos[1], pixelPos[0], pixelPos2[1], pixelPos2[0]);
      pixelPositions[i][0] = pixelPos[1];
      pixelPositions[i][1] = pixelPos[0];
      pixelPositions[i][2] = pixelPos2[1];
      pixelPositions[i][3] = pixelPos2[0];
    }
  }
  void drawPixelPositions() {
    stroke(255, 255, 255);
    for (int i = 0; i < pixelPositions.length; i++) {
      line(pixelPositions[i][0], pixelPositions[i][1], pixelPositions[i][2], pixelPositions[i][3]);
    }
    stroke(0, 0, 0);
  }
  void drawFlights(ArrayList<Flight> f) {
    for (int i = 0; i < f.size(); i++) {
      drawFlight(f.get(i));
    }
  }
};
