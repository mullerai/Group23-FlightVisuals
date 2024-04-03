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
    this.titleFont = loadFont("ComicSansMS-Bold-70.vlw");
  }
  
  void draw()
  {
    textFont(titleFont);
    fill(0);
    textAlign(CENTER, CENTER);
    text(message, x, y);
  }

}

class Border
{
  int x;
  int y;
  int w;
  int h;
  Border(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void draw()
  {
    fill (color(109, 154, 155));
    rect(x - 20, y -20, w, h);
  }





}
