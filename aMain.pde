PFont stdFont;
final int EVENT_NULL=0;
final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_BUTTON3=3;
final int EVENT_BUTTON4=4;
final int EVENT_BUTTON5=5;
final int EVENT_BUTTON6=6;
Screen mainScreen;
Screen currentScreen;
Screen mapScreen;
Screen statScreen;
Screen simScreen;
Screen graphScreen;
FlightManager flightManager;
PImage planePic;
PImage cloudPic;
Map mapScreenMap;
ArrayList<Flight> queryFlights = new ArrayList<Flight>();

void setup(){
  stdFont=loadFont("Chalkboard-30.vlw");
  fullScreen(P2D);
  textFont(stdFont);
  planePic = loadImage("planePic.png");
  planePic.resize(300, 300);
  cloudPic = loadImage("cloud.png");
  cloudPic.resize(200, 200);
  mapScreenMap = new Map(loadImage("usaLargeNoLines.png"), 450, 200);
  
  Button mapButton, statButton, simButton, backToMainButton, backToStatButton, queryButton;
  TextBox statText;
  
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
  
 
 statText = new TextBox (width / 2, (2 * height) / 3, 100, 50, "example");
 statScreen.addTextBox(statText);  
  

  backToMainButton = new Button(100, 100, 100, 75, "Back", 100, stdFont, EVENT_BUTTON4);
  queryButton = new Button(100, 600, 100, 75, "Query", 100, stdFont, EVENT_BUTTON6);
  mapScreen.addButton(backToMainButton);
  mapScreen.addButton(queryButton);
  String [] airlines = {"AA", "AS", "B6","DL", "F9", "G4", "HA", "NK", "UA", "WN", "*"};
  mapScreen.addDropdown(airlines, width -400, 200, "Select Airline");
  statScreen.addButton(backToMainButton);
  simScreen.addButton(backToMainButton);
  
  backToMainButton = new Button(100, 100, 100, 75, "Back", 100, stdFont, EVENT_BUTTON4);
  mapScreen.addButton(backToMainButton);
  statScreen.addButton(backToMainButton);
  simScreen.addButton(backToMainButton);
  
  graphScreen = new Screen(color(169, 196, 196));
  graphScreen.addTitle("Graphs", color(0), width/2-150, 100);
  backToStatButton = new Button(100, 100, 100, 75, "Back", color(169, 196, 196), stdFont, EVENT_BUTTON2);
  graphScreen.addButton(backToStatButton);
  
  //toGraphScreen = new Button(200, 200, 100, 75, "Graphs", color(169, 196, 196), stdFont, EVENT_BUTTON5);
  //statScreen.addButton(toGraphScreen);

  currentScreen = mainScreen;
  
  flightManager = new FlightManager("flights2k(1).csv");
  flightManager.loadFlights();
  // ArrayList<Flight> a = flightManager.filterFlights("01/01/2022", "01/03/2022","*","*","*","*","*",-1,MapTools.Setting.EITHER,MapTools.Setting.EITHER,-1);
}

void mousePressed(){
  int event = currentScreen.getEvent();
  mapScreen.dropdownMenu.checkMouseOver(mouseX, mouseY);
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
    
    case EVENT_BUTTON5:
    currentScreen = graphScreen;
    break;
    
    case EVENT_BUTTON6:
    String airline = mapScreen.dropdownMenu.input;
    queryFlights = flightManager.filterFlights("*", "*", airline,"*","*","*","*",-1,MapTools.Setting.EITHER,MapTools.Setting.EITHER,-1);
    mapScreenMap.getPixelPositions(queryFlights);
    break;
  }
}
void draw(){
  background(0);
  currentScreen.draw();

  if (currentScreen == mapScreen) {
    mapScreenMap.draw();
    // mapScreenMap.drawFlight(queryFlights.get(0));
    mapScreenMap.drawPixelPositions();
  }

}
