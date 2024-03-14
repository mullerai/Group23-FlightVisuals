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
  void drawFlight() {
    // Code to draw a flight on map will go here
  }
};
