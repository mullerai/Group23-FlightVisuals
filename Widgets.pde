class Button
{
  
  int EVENT_NULL = 0;
  int x, y, width, height;
  int GAP_HEIGHT;
  int GAP_WIDTH;
  String label; int event;
  color buttonColor, labelColor = color(0);
  PFont buttonFont;
  color originalColour;
  
  
  Button(int x,int y, int width, int height, String label,
  color buttonColor, PFont buttonFont, int event)
  {
  this.x=x; this.y=y; this.width = width; this.height= height;
  GAP_HEIGHT = height/3;
  GAP_WIDTH = width/10;
  this.label=label; this.event=event;
  this.buttonColor=buttonColor; this.buttonFont=buttonFont;
  this.buttonColor= buttonColor;
  this.originalColour = buttonColor;
  }
  
  void draw()
  {
    stroke(0);
    strokeWeight(3);
    fill(buttonColor);
    rect(x,y,width,height,5);
    fill(labelColor);
    textFont(buttonFont);
    text(label, x+GAP_WIDTH, y+height-GAP_HEIGHT);
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
      this.buttonColor = color(169,196,196);
    }
    else
    {
      this.buttonColor = originalColour;

    }
   }
  
   }
   
