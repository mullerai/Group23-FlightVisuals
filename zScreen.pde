ArrayList<Button> buttonList;
int xpos, ypos;

class Screen{
  color backgroundColour;
  ArrayList<Button> mainButtonList;
  ArrayList<Button> mapScreenButtonList;
  ArrayList<Button> statScreenButtonList;
  ArrayList<Button> simScreenButtonList;
  Title newTitle;
  
  Screen(color backgroundColour){
  this.backgroundColour = backgroundColour;
  mainButtonList = new ArrayList<Button>();
  mapScreenButtonList = new ArrayList<Button>();
  statScreenButtonList = new ArrayList<Button>();
  simScreenButtonList = new ArrayList<Button>();
 }

 void addButton(Button button){
   if(this == mainScreen){
     mainButtonList.add(button);
   } else if(this == mapScreen){
     mapScreenButtonList.add(button);
   } else if(this == statScreen){
     statScreenButtonList.add(button);
   } else if(this == simScreen){
     simScreenButtonList.add(button);
   }
}
 
 int getEvent(){
   if(currentScreen == mainScreen){
     buttonList = mainButtonList;
   } else if(currentScreen == mapScreen){
     buttonList = mapScreenButtonList;
   } else if(currentScreen == statScreen){
     buttonList = statScreenButtonList;
   } else if(currentScreen == simScreen){
     buttonList = simScreenButtonList;
   }
   for(Button button : buttonList){
     int event = button.getEvent(mouseX, mouseY);
      if(event != EVENT_NULL){
        return event;
      }
     }
   return EVENT_NULL;
 }
 
 void addTitle(String message, color messageColor, int x, int y)
 {
   
   newTitle = new Title(message, messageColor, x,y);
 
 }
 
 void placeImage(){
   if(currentScreen == mainScreen){
     xpos = width;
     ypos = 400;
   }
 }
 
 void draw(){
   background(backgroundColour);
   if(currentScreen == mainScreen){
     buttonList = mainButtonList;
   } else if(currentScreen == mapScreen){
     buttonList = mapScreenButtonList;
   } else if(currentScreen == statScreen){
     buttonList = statScreenButtonList;
   } else if(currentScreen == simScreen){
     buttonList = simScreenButtonList;
   }
   if (newTitle != null)
   {
     newTitle.draw();
   }
   for(Button button : buttonList){
     button.draw();
   }
   if(planePic != null && currentScreen == mainScreen){
     xpos -=5;
     if(xpos < (0-planePic.width)) {
       xpos = (width+planePic.width);
     }
     image(planePic, xpos, 200);
     image(planePic, xpos - (planePic.width+100), 200);
   }
 }
}
