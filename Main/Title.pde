class Title
{
  String message;
  color messageColor;
  int x;
  int y;
  PFont titleFont;
  
  Title(String message, color messageColor, int x, int y)
  {
    this.message = message;
    this.messageColor = messageColor;
    this.x = x;
    this.y = y;
    this.titleFont = loadFont("Arial-Black-90.vlw");
  }
  
  void draw()
  {
    textFont(titleFont);
    text(message, x, y);
  }

}