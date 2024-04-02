// #################################
// # THIS CLASS IS BY AIDAN MULLER #
// #          @mullerai            #
// #################################

static class MapTools {
  final static float MAP_RATIO_LNG = 6.7/23.0; // "Stretch" map image size to properly calculate longitude as coordinate
  final static float MAP_RATIO_LAT = 3.75/11.0; // "Stretch" map image size to properly calculate latitude as coordinate
  final static float MAP_RATIO_LNG2 = 9/24.0; // "Stretch" map image size to properly calculate longitude as coordinate
  final static float MAP_RATIO_LAT2 = 5/12.0; // "Stretch" map image size to properly calculate latitude as coordinate
  static float longitudeToPixels(float lng, float w) {  // function to calculate longitude as x-coordinate, takes the longitude and image-width as argument
    //float newLng = lng + 180 - 15; // Get longitude between 0 and 360, and sub 15 because image is missing one longitudal line to west
    float newLng = lng + 180; // Get longitude between 0 and 360, and sub 15 because image is missing one longitudal line to west
    return (newLng/360.0)*(w/MAP_RATIO_LNG2); // Calculate pixel using equirectangular principles
  }
  static float latitudeToPixels(float lat, float h) { // Function to calculate latitude as y-coordinate, takes the latitude and image-height as argument
    //float newLat = (-lat)+90-15;  // Get lat between 0 and 180, and sub 15 because image is missing one latitudal line to north
    float newLat = (-lat)+90;  // Get lat between 0 and 180, and sub 5 because image is missing one latitudal line to north
    // println(h/MAP_RATIO_LAT2);
    return (newLat/180.0)*(h/MAP_RATIO_LAT2); // Calculate pixel using equirectangular principles
  }
  static String convertMinutesToTime(int mins) {
    mins = mins%1440;
    int hours = mins/60;
    mins = mins-(hours*60);
    String minsString, hoursString;
    if (mins < 10) minsString = String.format("0%d", mins);
    else minsString = String.format("%d", mins);
    if (hours < 10) hoursString = String.format("0%d", hours);
    else hoursString = String.format("%d", hours);
    return String.format("%s:%s", hoursString, minsString);
  }
  enum Setting {    // This enum functions as a tri-state boolean
    SET,            // SET - true
    UNSET,          // UNSET - false
    EITHER          // EITHER - either true or false (useful in flightManager as wildcard)
  }
}

// 40.730610, -73.935242
// .27372
// 32.897480, and the longitude is -97.040443
