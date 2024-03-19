ArrayList<Button> buttonList;
PImage planePic;

class Screen{
  color backgroundColour;
  ArrayList<Button> mainButtonList;
  ArrayList<Button> mapScreenButtonList;
  ArrayList<Button> statScreenButtonList;
  ArrayList<Button> infoScreenButtonList;
  Screen(color backgroundColour){
  this.backgroundColour = backgroundColour;
  mainButtonList = new ArrayList<Button>();
  mapScreenButtonList = new ArrayList<Button>();
  statScreenButtonList = new ArrayList<Button>();
  infoScreenButtonList = new ArrayList<Button>();
 }

 void addButton(Button button){
   if(this == mainScreen){
     mainButtonList.add(button);
   } else if(this == mapScreen){
     mapScreenButtonList.add(button);
   } else if(this == statScreen){
     statScreenButtonList.add(button);
   } else if(this == infoScreen){
     infoScreenButtonList.add(button);
   }
}
 
 int getEvent(){
   if(currentScreen == mainScreen){
     buttonList = mainButtonList;
   } else if(currentScreen == mapScreen){
     buttonList = mapScreenButtonList;
   } else if(currentScreen == statScreen){
     buttonList = statScreenButtonList;
   } else if(currentScreen == infoScreen){
     buttonList = infoScreenButtonList;
   }
   for(Button button : buttonList){
     int event = button.getEvent(mouseX, mouseY);
      if(event != EVENT_NULL){
        return event;
      }
     }
   return EVENT_NULL;
 }
 
 void title(){
   if(currentScreen == mainScreen){
     text("Flight Finder", 675, 100);
   } else if(currentScreen == mapScreen){
     text("Map", 725, 100);
   } else if(currentScreen == statScreen){
     text("Statistics", 675, 100);
   } else if(currentScreen == infoScreen){
     text("Extra Information", 600, 100);
   }
 }
 void addTitle()
 {
   
 
 }
 
 void placeImage(){
   if(currentScreen == mainScreen){
     planePic = loadImage("planeImage.png");
     image(planePic, 500, 200);
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
   } else if(currentScreen == infoScreen){
     buttonList = infoScreenButtonList;
   }
   for(Button button : buttonList){
     button.draw();
   }
 }
}
