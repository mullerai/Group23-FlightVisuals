PFont stdFont;
final int EVENT_NULL=0;
final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_BUTTON3=3;
final int EVENT_BUTTON4=4;
final int EVENT_BUTTON5=5;
Screen mainScreen;
Screen currentScreen;
Screen mapScreen;
Screen statScreen;
Screen infoScreen;

void setup(){
  stdFont=loadFont("Chalkboard-30.vlw");
  fullScreen();
  textFont(stdFont);
  
  Button mapButton, statButton, extraButton, backButton, backStatButton, 
  backInfoButton;
  
  mainScreen = new Screen(color(139,175,176));
  mapScreen = new Screen(color(230, 238, 238));
  statScreen = new Screen(color(169, 196, 196));
  infoScreen = new Screen(color(109,154,155));
  
  mapButton = new Button(100, 600, 400, 200, "Map", 100,stdFont, EVENT_BUTTON1);
  mainScreen.addButton(mapButton);
  
  statButton = new Button(550, 600, 400, 200, "Statistics", 100, stdFont, EVENT_BUTTON2);
  mainScreen.addButton(statButton);
  
  extraButton = new Button(1000, 600, 400, 200, "Extra Info", 100, stdFont, EVENT_BUTTON3);
  mainScreen.addButton(extraButton);
  
  backButton = new Button(100, 100, 100, 75, "Back", 100, stdFont, EVENT_BUTTON4);
  mapScreen.addButton(backButton);
  statScreen.addButton(backButton);
  infoScreen.addButton(backButton);
  currentScreen = mainScreen;
}

void mousePressed(){
  int event = currentScreen.getEvent();
  switch(event){
    case EVENT_BUTTON1:
    currentScreen = mapScreen;
    break;
    
    case EVENT_BUTTON2:
    currentScreen = statScreen;
    break;
    
    case EVENT_BUTTON3:
    currentScreen = infoScreen;
    break;
    
    case EVENT_BUTTON4:
    currentScreen = mainScreen;
    break;
  }
}
void draw(){
  background(0);
  currentScreen.draw();
  currentScreen.title();
  currentScreen.placeImage();
}
