ArrayList<Button> buttonList;
ArrayList<TextBox> textBoxList;
ArrayList<DotPlot> dotPlotList;
ArrivalTable arrivalTable;
int plane_xpos, plane_ypos;
int cloud_xpos, cloud_ypos;
FlightManager fm;

class Screen{
  PImage backgroundImage;
  color backgroundColour;
  ArrayList<Button> mainButtonList;
  ArrayList<Button> mapScreenButtonList;
  ArrayList<Button> statScreenButtonList;
  ArrayList<Button> simScreenButtonList;
  ArrayList<Button> graphScreenButtonList;
  ArrayList<Button> linePlotScreenButtonList;
  ArrayList <Button> heatMapScreenButtonList;
  ArrayList <Button> dotPlotScreenButtonList;
   ArrayList <Button> flightDataScreenButtonList;
  ArrayList<TextBox> mainTextBoxList;
  ArrayList<TextBox> mapScreenTextBoxList;
  ArrayList<TextBox> statScreenTextBoxList;
  ArrayList<TextBox> simScreenTextBoxList;
  ArrayList<TextBox> graphScreenTextBoxList;
  ArrayList <TextBox> heatMapScreenTextBoxList;
  ArrayList<TextBox> linePlotTextBoxList;
  ArrayList<DotPlot> dotPlotScreenList;
  ArrayList<DotPlot> dotPlotMainList;
  ArrayList<TextBox> dotPlotScreenTextBoxList;
  
  Border newBorder;
  Title newTitle;
  dropdown dropdownMenu;
  
  
  Screen(color backgroundColour){
  this.backgroundColour = backgroundColour;
  mainButtonList = new ArrayList<Button>();
  mapScreenButtonList = new ArrayList<Button>();
  statScreenButtonList = new ArrayList<Button>();
  simScreenButtonList = new ArrayList<Button>();
  graphScreenButtonList = new ArrayList<Button>();
  heatMapScreenButtonList = new ArrayList<Button>();
  linePlotScreenButtonList = new ArrayList<Button>();
  dotPlotScreenButtonList = new ArrayList<Button>();
  mainTextBoxList = new ArrayList<TextBox>();
  mapScreenTextBoxList = new ArrayList<TextBox>();
  statScreenTextBoxList = new ArrayList<TextBox>();
  simScreenTextBoxList = new ArrayList<TextBox>();
  graphScreenTextBoxList = new ArrayList<TextBox>();
  linePlotTextBoxList = new ArrayList<TextBox>();
  heatMapScreenTextBoxList = new ArrayList<TextBox>();
  dotPlotScreenTextBoxList = new ArrayList<TextBox>();
  dotPlotScreenList = new ArrayList<DotPlot>();
  dotPlotMainList = new ArrayList<DotPlot>();
  flightDataScreenButtonList = new ArrayList<Button>();
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
   } else if (this == linePlotScreen) {
      linePlotScreenButtonList.add(button);
    }
    else if (this == dotPlotScreen) {
    dotPlotScreenButtonList.add(button);
    }
    else if (this == heatMapScreen)
    { heatMapScreenButtonList.add(button);
    } else if(this == flightDataScreen){
      flightDataScreenButtonList.add(button);
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
   else if (currentScreen == heatMapScreen)
   {
     buttonList = heatMapScreenButtonList;
   }
   else if (currentScreen == dotPlotScreen)
   {
   buttonList = dotPlotScreenButtonList;
   }else if(currentScreen == flightDataScreen){
     buttonList = flightDataScreenButtonList;
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
 void addBorder(int x, int y, int w, int h)
 {
   newBorder = new Border(x, y, w, h);
 }
 
 void addDropdown(String [] options , int x, int y, String label)
 {
   dropdownMenu = new dropdown(options, x, y, label);
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
     dotPlotList = dotPlotMainList;
   } else if(currentScreen == mapScreen){
     buttonList = mapScreenButtonList;
     textBoxList = mapScreenTextBoxList;
     dotPlotList = dotPlotMainList;
   } else if(currentScreen == statScreen){
     buttonList = statScreenButtonList;
     textBoxList = statScreenTextBoxList;
     dotPlotList = dotPlotMainList;
   } else if(currentScreen == simScreen){
     buttonList = simScreenButtonList;
     textBoxList = simScreenTextBoxList;
     dotPlotList = dotPlotMainList;
   } else if(currentScreen == graphScreen){
     buttonList = graphScreenButtonList;
     textBoxList = graphScreenTextBoxList;
     dotPlotList = dotPlotMainList;
   } else if (currentScreen == linePlotScreen) {
      buttonList = linePlotScreenButtonList;
      textBoxList = linePlotTextBoxList; 
    }
   else if(currentScreen == dotPlotScreen)
   {
     buttonList = dotPlotScreenButtonList;
     textBoxList = dotPlotScreenTextBoxList;
     dotPlotList = dotPlotScreenList;
   }
   else if(currentScreen == heatMapScreen)
   {
     buttonList = heatMapScreenButtonList;
     textBoxList = heatMapScreenTextBoxList;
     fill(139, 175, 176);
     stroke(3);
     rect(0,0, width -500, height);
   }   else if(currentScreen == flightDataScreen){
     buttonList = flightDataScreenButtonList;
   }
   
   if (newTitle != null)
   {
     newTitle.draw();
   }
   for(Button button : buttonList){
     button.draw();
   }
   
   if (newBorder != null)
   {
     newBorder.draw();
   }
   
   for(DotPlot dotPlot : dotPlotList)
   {
   dotPlot.dotPlotOrigin();
   }
   
   if(currentScreen == flightDataScreen){
     arrivalTable = new ArrivalTable();
     arrivalTable.readInFlights();
     arrivalTable.displayTable(1, 100, 50);
     arrivalTable.keyPressed(1, 100, 50);
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
 
 void addTextBox(TextBox textBox){
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
   } else if (this == linePlotScreen) {
      linePlotTextBoxList.add(textBox);
    }
    else if (this == heatMapScreen) {
      heatMapScreenTextBoxList.add(textBox);
    }
    else if (this == dotPlotScreen){
    
    }
 }
 void addDotPlot(DotPlot dp)
 {
 if (this == dotPlotScreen)
 {
 dotPlotScreenList.add(dp);
 }
 }
}
