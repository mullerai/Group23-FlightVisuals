static class MapTools {
  final static float MAP_RATIO_LNG = 7.0/23.0; // "Stretch" map image size to properly calculate longitude as coordinate
  final static float MAP_RATIO_LAT = 4.0/11.0; // "Stretch" map image size to properly calculate latitude as coordinate
  static float longitudeToPixels(float lng, float w) {  // function to calculate longitude as x-coordinate, takes the longitude and image-width as argument
    float newLng = lng + 180 - 15; // Get longitude between 0 and 360, and sub 15 because image is missing one longitudal line to west
    return (newLng/360.0)*(w/MAP_RATIO_LNG); // Calculate pixel using equirectangular principles
  }
  static float latitudeToPixels(float lat, float h) { // Function to calculate latitude as y-coordinate, takes the latitude and image-height as argument
    float newLat = (-lat)+90-15;  // Get lat between 0 and 180, and sub 15 because image is missing one latitudal line to north
    return (newLat/180.0)*(h/MAP_RATIO_LAT); // Calculate pixel using equirectangular principles
  }
  enum Setting {    // This enum functions as a tri-state boolean
    SET,            // SET - true
    UNSET,          // UNSET - false
    EITHER          // EITHER - either true or false (useful in flightManager as wildcard)
  }
  static float[] getCoordinatesFromIATA(String inpIATA) {
    String filePath = "data/usa-airports.csv"; // adjust file path to wherever it is in your files
    float[] returnValue = new float[2];
    returnValue[0] = -1;
    returnValue[1] = -1;
    flightData = loadTable(filePath, "csv");
    for (TableRow row : table.rows()) {
      String iata = row.getString(0);
      if (iata.equals(inpIATA)) {
        returnValue[0] = float.parseFloat(row.getString(5));
        returnValue[1] = float.parseFloat(row.getString(6));
      }
    }
    return returnValue;
  }
}
