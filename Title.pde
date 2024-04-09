/** This class by Anastasia O'Donnell
**/

//This class sets a standard title with a standard font
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
//Creates a border that can be drawn around an object
class Border
{
  int x;
  int y;
  int w;
  int h;
  //Constructor
  Border(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  // Draws a border around object with a padding of 20px
  void draw()
  {
    fill (color(109, 154, 155));
    rect(x - 20, y -20, w, h);
  }





}
