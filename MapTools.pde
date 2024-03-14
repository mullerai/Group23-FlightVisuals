static class MapTools {
  final static float MAP_RATIO_LNG = 7.0/23.0;
  final static float MAP_RATIO_LAT = 4.0/11.0;
  static float longitudeToPixels(float lng, float w) {
    float newLng = lng + 180 - 15;
    return (newLng/360.0)*(w/MAP_RATIO_LNG);
  }
  static float latitudeToPixels(float lat, float h) {
    float newLat = (-lat)+90-15;
    return (newLat/180.0)*(h/MAP_RATIO_LAT);
  }
}
