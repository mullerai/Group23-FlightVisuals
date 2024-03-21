ArrayList<Button> buttonList;
ArrayList<TextBox> textBoxList;
int plane_xpos, plane_ypos;
int cloud_xpos, cloud_ypos;

class Screen{
  color backgroundColour;
  ArrayList<Button> mainButtonList;
  ArrayList<Button> mapScreenButtonList;
  ArrayList<Button> statScreenButtonList;
  ArrayList<Button> simScreenButtonList;
  ArrayList<Button> graphScreenButtonList;
  ArrayList<TextBox> mainTextBoxList;
  ArrayList<TextBox> mapScreenTextBoxList;
  ArrayList<TextBox> statScreenTextBoxList;
  ArrayList<TextBox> simScreenTextBoxList;
  ArrayList<TextBox> graphScreenTextBoxList;
  Title newTitle;
  dropdown dropdownMenu;
  
  Screen(color backgroundColour){
  this.backgroundColour = backgroundColour;
  mainButtonList = new ArrayList<Button>();
  mapScreenButtonList = new ArrayList<Button>();
  statScreenButtonList = new ArrayList<Button>();
  simScreenButtonList = new ArrayList<Button>();
  graphScreenButtonList = new ArrayList<Button>();
  mainTextBoxList = new ArrayList<TextBox>();
  mapScreenTextBoxList = new ArrayList<TextBox>();
  statScreenTextBoxList = new ArrayList<TextBox>();
  simScreenTextBoxList = new ArrayList<TextBox>();
  graphScreenTextBoxList = new ArrayList<TextBox>();
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
   } else if(this == graphScreen){
     graphScreenButtonList.add(button);
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
   } else if(currentScreen == graphScreen){
     buttonList = graphScreenButtonList;
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
 void addDropdown(String [] options , int x, int y)
 {
   dropdownMenu = new dropdown(options, x, y);
 }
 
 void placeImage(){
   if(currentScreen == mainScreen){
     plane_xpos = width;
     plane_ypos = 0;
     cloud_xpos = width/2;
     cloud_ypos = 400;
   }
 }
 
 void draw(){
   background(backgroundColour);
   if(currentScreen == mainScreen){
     buttonList = mainButtonList;
     textBoxList = mainTextBoxList;
   } else if(currentScreen == mapScreen){
     buttonList = mapScreenButtonList;
     textBoxList = mapScreenTextBoxList;
   } else if(currentScreen == statScreen){
     buttonList = statScreenButtonList;
     textBoxList = statScreenTextBoxList;
   } else if(currentScreen == simScreen){
     buttonList = simScreenButtonList;
     textBoxList = simScreenTextBoxList;
   } else if(currentScreen == graphScreen){
     buttonList = graphScreenButtonList;
     textBoxList = graphScreenTextBoxList;
   }
   if (newTitle != null)
   {
     newTitle.draw();
   }
   for(Button button : buttonList){
     button.draw();
   }
   for (TextBox textBox : textBoxList){
   textBox.draw();
   }
   if(planePic != null && currentScreen == mainScreen){
     plane_xpos -=5;
     plane_ypos +=2;
     if(plane_xpos < (0-planePic.width)) {
       plane_xpos = (width+planePic.width);
       plane_ypos = 0;
     } if(plane_ypos >= 300){
       plane_ypos = 300;
     }
     image(planePic, plane_xpos, plane_ypos);
   }
   if(cloudPic != null && currentScreen == mainScreen){
     cloud_xpos += 2;
     if(cloud_xpos > (width+cloudPic.width)){
       cloud_xpos = 0;
     }
     image(cloudPic, cloud_xpos, 400);
     image(cloudPic, cloud_xpos - (cloudPic.width + 100), 400);
     image(cloudPic, cloud_xpos + 10, 200);
     image(cloudPic, cloud_xpos + 10, 200);
     image(cloudPic, cloud_xpos + 10, 200);
   }
   
   if (dropdownMenu != null)
   {
     dropdownMenu.draw();
   }
 }
 
 void addTextBox (TextBox textBox)
 {
 if(this == mainScreen){
      mainTextBoxList.add(textBox);
   } else if(this == mapScreen){
     mapScreenTextBoxList.add(textBox);
   } else if(this == statScreen){
     statScreenTextBoxList.add(textBox);
   } else if(this == simScreen){
     simScreenTextBoxList.add(textBox);
   } else if(this == graphScreen){
     graphScreenTextBoxList.add(textBox);
   }
 }
 
}
