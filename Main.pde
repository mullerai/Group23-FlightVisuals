//PFont stdFont;
//final int EVENT_NULL=0;
//final int EVENT_BUTTON1=1;
//final int EVENT_BUTTON2=2;
//final int EVENT_BUTTON3=3;
//final int EVENT_BUTTON4=4;
//final int EVENT_BUTTON5=5;
//Screen mainScreen;
//Screen currentScreen;
//Screen mapScreen;
//Screen statScreen;
//Screen simScreen;

//void setup(){
//  stdFont=loadFont("Chalkboard-30.vlw");
//  fullScreen();
//  textFont(stdFont);
  
//  Button mapButton, statButton, simButton, backButton;
  
//  mainScreen = new Screen(color(139,175,176));
//  mapScreen = new Screen(color(230, 238, 238));
//  mapScreen.addTitle("Map", color(0), width/2 - 150, 100);
  
//  statScreen = new Screen(color(169, 196, 196));
//  statScreen.addTitle("Statistics", color(0), width/2 - 150, 100);
  
//  simScreen = new Screen(color(109,154,155));
//  simScreen.addTitle("Sim", color(0), width/2 - 150, 100);
  
  
//  mapButton = new Button(100, 600, 400, 200, "Map", 100,stdFont, EVENT_BUTTON1);
//  mainScreen.addButton(mapButton);
//  mainScreen.addTitle("Menu", color(0), width/2 - 150, 100);
  
//  statButton = new Button(550, 600, 400, 200, "Statistics", 100, stdFont, EVENT_BUTTON2);
//  mainScreen.addButton(statButton);
  
//  simButton = new Button(1000, 600, 400, 200, "Simulation", 100, stdFont, EVENT_BUTTON3);
//  mainScreen.addButton(simButton);
  
//  backButton = new Button(100, 100, 100, 75, "Back", 100, stdFont, EVENT_BUTTON4);
//  mapScreen.addButton(backButton);
//  statScreen.addButton(backButton);
//  simScreen.addButton(backButton);
//  currentScreen = mainScreen;
//}

//void mousePressed(){
//  int event = currentScreen.getEvent();
//  switch(event){
//    case EVENT_BUTTON1:
//    currentScreen = mapScreen;
//    break;
    
//    case EVENT_BUTTON2:
//    currentScreen = statScreen;
//    break;
    
//    case EVENT_BUTTON3:
//    currentScreen = simScreen;
//    break;
    
//    case EVENT_BUTTON4:
//    currentScreen = mainScreen;
//    break;
//  }
//}
//void draw(){
//  background(0);
//  currentScreen.draw();
//  currentScreen.placeImage();
//}