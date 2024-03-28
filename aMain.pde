import java.util.Date;

PFont stdFont;
final int EVENT_NULL=0;
final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_BUTTON3=3;
final int EVENT_BUTTON4=4;
final int EVENT_BUTTON5=5;
final int EVENT_BUTTON6=6;
final int EVENT_BUTTON7 = 7;
final int EVENT_BUTTON8 = 8;
final int EVENT_BUTTON9 = 9;
final int EVENT_BUTTON10 = 10;
int maxdate = 0;
int[] flightsArray;
String[] dateLabels;
String[] yLabels;
Screen mainScreen;
Screen currentScreen;
Screen mapScreen;
Screen statScreen;
Screen simScreen;
Screen graphScreen;
Screen pieChartScreen;
Screen dotPlotScreen;
Screen linePlotScreen;
Screen flightDataScreen;
Screen heatMapScreen;
FlightManager flightManager;
PImage planePic;
PImage cloudPic;
Map mapScreenMap;
Map simScreenMap;
int simulatedMinutes = 0;
boolean simulationStarted = false, drawingLinePlot = false;
int lastTime = 0;
ArrayList<Flight> queryFlights = new ArrayList<Flight>();
Date currentDate = new Date();
PFont smallerstdFont;
Table flightData;

void setup() {
  stdFont=loadFont("Chalkboard-30.vlw");
  smallerstdFont = loadFont("ComicSansMS-20.vlw");
  fullScreen(P2D);
  textFont(stdFont);
  planePic = loadImage("planePic.png");
  planePic.resize(300, 300);
  cloudPic = loadImage("cloud.png");
  cloudPic.resize(200, 200);
  mapScreenMap = new Map(loadImage("USA_GOOD3.png"), 450, 200);
  simScreenMap = new Map(loadImage("USA_GOOD3.png"), 450, 200);

  Button mapButton, statButton, simButton, backToMainButton, backToStatButton, queryButton, pieChartButton, dotPlotButton, linePlotButton, tableButton, heatmapButton, queryButton2;
  TextBox statText;

  mainScreen = new Screen(color(139, 175, 176));
  mapScreen = new Screen(color(230, 238, 238));
  mapScreen.addTitle("Map", color(0), width/2 - 150, 100);

  statScreen = new Screen(color(169, 196, 196));
  statScreen.addTitle("Statistics", color(0), width/2 - 150, 100);

  simScreen = new Screen(color(109, 154, 155));
  // simScreen.addTitle("Sim", color(0), width/2 - 150, 100);
  simScreen.addTitle(MapTools.convertMinutesToTime(simulatedMinutes), color(0), width/2-150, 100);
  simScreen.addTextBox(new TextBox(width -200, 200, 150, 50, "MM/DD/YYYY", "Enter Date"));

  mapButton = new Button((width)/9, (4*height)/6, 300, 200, "Map", color(139, 175, 176), stdFont, EVENT_BUTTON1);
  mainScreen.addButton(mapButton);
  mainScreen.addTitle("Menu", color(0), width/2 - 150, 100);

  statButton = new Button((4*width)/9, (4*height)/6, 300, 200, "Statistics", color(139, 175, 176), stdFont, EVENT_BUTTON2);
  mainScreen.addButton(statButton);

  simButton = new Button((7*width)/9, (4*height)/6, 300, 200, "Simulation", color(139, 175, 176), stdFont, EVENT_BUTTON3);
  mainScreen.addButton(simButton);


  statText = new TextBox (width / 2, (2 * height) / 3, 100, 50, "Enter text Here", "Name" );
  statScreen.addTextBox(statText);


  backToMainButton = new Button(100, 100, 100, 75, "Back", 100, stdFont, EVENT_BUTTON4);
  queryButton = new Button(100, 600, 100, 75, "Query", 100, stdFont, EVENT_BUTTON6);
  mapScreen.addButton(backToMainButton);
  mapScreen.addButton(queryButton);
  String [] airlines = {"AA", "AS", "B6", "DL", "F9", "G4", "HA", "NK", "UA", "WN", "*"};
  mapScreen.addDropdown(airlines, width -400, 200, "Select Airline");
  mapScreen.addTextBox(new TextBox(width -200, 200, 150, 50, "MM/DD/YYYY", "Enter Start Date"));
  mapScreen.addTextBox(new TextBox(width -200, 400, 150, 50, "MM/DD/YYYY", "Enter End Date"));
  mapScreen.addTextBox(new TextBox(width - 200, 800, 150, 50, "*", "Origin Airport Code/*"));
  mapScreen.addTextBox(new TextBox(width - 200, 1000, 150, 50, "*", "Dest Airport Code/**"));
  // mapScreen.addTextBox(new TextBox(width - 400, 600, 150, 50, "*","Destination State/*"));
  mapScreen.addTextBox(new TextBox(width - 400, 800, 150, 50, "*", "Origin State/*"));
  mapScreen.addTextBox(new TextBox(width - 400, 1000, 150, 50, "*", "Dest State/*"));

  statScreen.addButton(backToMainButton);
  simScreen.addButton(backToMainButton);

  backToMainButton = new Button(100, 100, 100, 75, "Back", 100, stdFont, EVENT_BUTTON4);
  pieChartButton = new Button(100, 200, 150, 50, "Pie Chart", 100, smallerstdFont, EVENT_BUTTON7);
  dotPlotButton = new Button(100, 300, 150, 50, "Dot Plot", 100, smallerstdFont, EVENT_BUTTON8);
  linePlotButton = new Button(100, 400, 150, 50, "Line Plot", 100, smallerstdFont, EVENT_BUTTON9);
  tableButton = new Button(100, 500, 150, 50, "Flight Table", 100, smallerstdFont, EVENT_BUTTON9);
  heatmapButton = new Button(100, 600, 150, 50, "Heatmap", 100, smallerstdFont, EVENT_BUTTON9);
  
  
  mapScreen.addButton(backToMainButton);
  statScreen.addButton(backToMainButton);
  statScreen.addButton(pieChartButton);
  statScreen.addButton(dotPlotButton);
  statScreen.addButton(linePlotButton);
  statScreen.addButton(tableButton);
  statScreen.addButton(heatmapButton);
  
  simScreen.addButton(backToMainButton);

  graphScreen = new Screen(color(169, 196, 196));
  graphScreen.addTitle("Graphs", color(0), width/2-150, 100);
  backToStatButton = new Button(100, 100, 100, 75, "Back", color(169, 196, 196), stdFont, EVENT_BUTTON2);
  graphScreen.addButton(backToStatButton);

  //toGraphScreen = new Button(200, 200, 100, 75, "Graphs", color(169, 196, 196), stdFont, EVENT_BUTTON5);
  //statScreen.addButton(toGraphScreen);
  
  pieChartScreen = new Screen(color(169, 196, 196));
  pieChartScreen.addTitle("Graphs", color(0), width/2-150, 100);
  pieChartScreen.addButton(backToStatButton);
  
  dotPlotScreen = new Screen(color(169, 196, 196));
  dotPlotScreen.addTitle("Graphs", color(0), width/2-150, 100);
  dotPlotScreen.addButton(backToStatButton);
  
  linePlotScreen = new Screen(color(169, 196, 78));
  linePlotScreen.addTitle("Graphs", color(0), width/2-150, 100);
  linePlotScreen.addButton(backToStatButton);
  queryButton2 = new Button(width -200, 500, 150, 50, "Query", color(169, 196, 196), stdFont, EVENT_BUTTON10);
  linePlotScreen.addButton(queryButton2);
  linePlotScreen.addTextBox(new TextBox(width -200, 100, 150, 50, "", "Enter End Date:"));

  currentScreen = mainScreen;
  
  String filePath = "flights_full.csv"; 
  flightData = loadTable(filePath, "csv");
  
  flightManager = new FlightManager("flights2k(1).csv");
  flightManager.loadFlights();
  // ArrayList<Flight> a = flightManager.filterFlights("01/01/2022", "01/03/2022","*","*","*","*","*",-1,MapTools.Setting.EITHER,MapTools.Setting.EITHER,-1);
}

void mousePressed() {
  int event = currentScreen.getEvent();
  mapScreen.dropdownMenu.checkMouseOver(mouseX, mouseY);

  for (TextBox textBox : textBoxList)
  {
    if (textBox.contains(mouseX, mouseY)) {
      textBox.setSelected(true);
    } else {
      textBox.setSelected(false);
    }
  }

  switch(event) {
  case EVENT_BUTTON1:
    currentScreen = mapScreen;
    break;

  case EVENT_BUTTON2:
    currentScreen = statScreen;
    break;

  case EVENT_BUTTON3:
    currentDate = new Date();
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
    queryFlights = flightManager.filterFlights(mapScreen.mapScreenTextBoxList.get(0).text, mapScreen.mapScreenTextBoxList.get(1).text, airline,
      mapScreen.mapScreenTextBoxList.get(2).text, mapScreen.mapScreenTextBoxList.get(4).text, mapScreen.mapScreenTextBoxList.get(3).text, mapScreen.mapScreenTextBoxList.get(5).text, -1, MapTools.Setting.EITHER, MapTools.Setting.EITHER, -1);
    mapScreenMap.getPixelPositions(queryFlights);
    break;
    
    case EVENT_BUTTON7:
    currentScreen = pieChartScreen;
    break;
    
    case EVENT_BUTTON8:
     currentScreen = dotPlotScreen;
    break;
    
    case EVENT_BUTTON9:
     currentScreen = linePlotScreen;
    break;
    
    case EVENT_BUTTON10:
     String maxDate = linePlotScreen.linePlotTextBoxList.get(0).getText();
     drawingLinePlot=false;
      maxdate = 31;
      maxdate = Integer.parseInt(maxDate);
      flightsArray = getFlightsPerDate(flightData, maxdate); //no. of flights until max date in Jan
  
     dateLabels = getDateLabels(maxdate);              //x labels
     yLabels = generateYLabels(flightsArray);          //y labels
     LineGraph(flightsArray, yLabels, dateLabels, "Flights", "January 2022");
     drawingLinePlot=true;
     
     
    break;
  
    
    
  }
}
void draw() {
  background(0);
  currentScreen.draw();
  if (currentScreen == mapScreen) {
    mapScreenMap.draw();
    // mapScreenMap.drawFlight(queryFlights.get(0));
    mapScreenMap.drawPixelPositions();
  }
  if (currentScreen == simScreen) {
    if (simulationStarted) {
      Date tempDate = new Date();
      if (tempDate.getTime()-currentDate.getTime() > 1000) {
        currentDate = new Date();
        simulatedMinutes += 1;
        simScreen.newTitle.message = MapTools.convertMinutesToTime(simulatedMinutes);
      }
    }
    simScreenMap.draw();
  }
  if (currentScreen == linePlotScreen) {
    linePlotScreen.draw();
    if (drawingLinePlot==true) LineGraph(flightsArray, yLabels, dateLabels, "Flights", "January 2022");
}
}

void keyPressed() {
  for (TextBox textBox : textBoxList)
  {
    if (textBox.isSelected() && key != ENTER) {
      if (key == BACKSPACE && textBox.getText().length() > 0) {
        textBox.setText(textBox.getText().substring(0, textBox.getText().length() - 1));
      } else if (key != CODED && key != BACKSPACE) {
        textBox.setText(textBox.getText() + key);
      }
    }
    if (key == ENTER)
    {
      System.out.print(textBox.getText());
    }
  }
}
