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
Screen simScreen;
Screen graphScreen;
FlightManager flightManager;
PImage planePic;
PImage cloudPic;

void setup(){
  stdFont=loadFont("Chalkboard-30.vlw");
  fullScreen(P2D);
  textFont(stdFont);
  planePic = loadImage("planePic.png");
  planePic.resize(300, 300);
  cloudPic = loadImage("cloud.png");
  cloudPic.resize(200, 200);
  
  Button mapButton, statButton, simButton, backToMainButton, backToStatButton;
  
  mainScreen = new Screen(color(139,175,176));
  mapScreen = new Screen(color(230, 238, 238));
  mapScreen.addTitle("Map", color(0), width/2 - 150, 100);
  
  statScreen = new Screen(color(169, 196, 196));
  statScreen.addTitle("Statistics", color(0), width/2 - 150, 100);
  
  simScreen = new Screen(color(109,154,155));
  simScreen.addTitle("Sim", color(0), width/2 - 150, 100);
  
  
  mapButton = new Button((width)/9, (4*height)/6, 300, 200, "Map", color(139,175,176) ,stdFont, EVENT_BUTTON1);
  mainScreen.addButton(mapButton);
  mainScreen.addTitle("Menu", color(0), width/2 - 150, 100);
  
  statButton = new Button((4*width)/9, (4*height)/6, 300, 200, "Statistics", color(139,175,176), stdFont, EVENT_BUTTON2);
  mainScreen.addButton(statButton);
  
  simButton = new Button((7*width)/9, (4*height)/6, 300, 200, "Simulation", color(139,175,176), stdFont, EVENT_BUTTON3);
  mainScreen.addButton(simButton);
  
  backToMainButton = new Button(100, 100, 100, 75, "Back", 100, stdFont, EVENT_BUTTON4);
  mapScreen.addButton(backToMainButton);
  statScreen.addButton(backToMainButton);
  simScreen.addButton(backToMainButton);
  
  backToStatButton = new Button(100, 100, 100, 75, "Back", color(169, 196, 196), stdFont, EVENT_BUTTON2);
  graphScreen.addButton(backToStatButton);
  
  currentScreen = mainScreen;
  
  flightManager = new FlightManager("flights2k(1).csv");
  flightManager.loadFlights();
  // ArrayList<Flight> a = flightManager.filterFlights("01/01/2022", "01/03/2022","*","*","*","*","*",-1,MapTools.Setting.EITHER,MapTools.Setting.EITHER,-1);
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
    currentScreen = simScreen;
    break;
    
    case EVENT_BUTTON4:
    currentScreen = mainScreen;
    break;
    
    
  }
}
void draw(){
  background(0);
  currentScreen.draw();
  //currentScreen.placeImage();
}
