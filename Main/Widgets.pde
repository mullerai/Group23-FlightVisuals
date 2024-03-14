class Button
{
  int GAP = 15;
  int EVENT_NULL = 0;
  int x, y, width, height;
  String label; int event;
  color buttonColor, labelColor;
  PFont buttonFont;
  
  
  Button(int x,int y, int width, int height, String label,
  color buttonColor, PFont buttonFont, int event)
  {
  this.x=x; this.y=y; this.width = width; this.height= height;
  this.label=label; this.event=event;
  this.buttonColor=buttonColor; this.buttonFont=buttonFont;
  buttonColor= color(0);
  }
  
  void draw()
  {
    stroke(0);
    fill(buttonColor);
    rect(x,y,width,height,5);
    fill(labelColor);
    textFont(buttonFont);
    text(label, x+GAP, y+height-GAP);
    changeColour(mouseX, mouseY);
    
  }
  
  int getEvent(int mX, int mY)
  {
    if(mX>x && mX < x+width && mY >y && mY <y+height)
    {
      return event;
    }
      return EVENT_NULL;
   }
   
   void changeColour(int mX, int mY)
   {
     if(mX>x && mX < x+width && mY >y && mY <y+height)
    {
      this.buttonColor = color(50, 105, 168);
      stroke(100);
      strokeWeight(2);
    }
    else
    {
      this.buttonColor = color(100);
      stroke(0);
    }
   }
  
   }
   
