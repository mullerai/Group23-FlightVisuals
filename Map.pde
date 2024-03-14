class Map {
  PImage mapTexture;    // Map image texture
  int x, y;             // Map x and y position
  int w, h;
  Map(PImage texture, int xPos, int yPos) {
    mapTexture = texture;
    x = xPos;
    y = yPos;
    w = texture.width;
    h = texture.height;
  }
};
