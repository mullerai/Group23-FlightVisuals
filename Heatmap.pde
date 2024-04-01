ArrayList <Airport> ListOfAirports;

class Heatmap {  // Code in this class written by Aiden Muller
                  // Modified code from the Map Class
  PImage mapTexture;    // Map image texture
  int x, y;             // Map x and y position
  private int w, h;             // Map image width & height
  float[][] pixelPositions = {};
  Flight flight;
  ArrayList <String> iatas;
  ArrayList<Airport> ListOfAirports;
  Heatmap(PImage texture, int xPos, int yPos) {
    mapTexture = texture;
    x = xPos;
    y = yPos;
    w = texture.width;
    h = texture.height;
  }
  void draw() {
    image(mapTexture, x, y);
    
    fill(color(255,0,0));
    rect(x, y + h + 20, 20, 20);
    fill(0);
    text("Very Busy",x + 30, y + h+30);
    
    fill(color(255, 204, 0));
    rect(x, y + h + 50, 20, 20);
    fill(0);
    text("Busy",x + 30, y + h+60);
    
    fill(color(0,255,0));
    rect(x, y + h + 80, 20, 20);
    fill(0);
    text("Not Busy",x + 30, y + h+90);
    
  }
  
  
  void setPosition(int xPos, int yPos) {
    x = xPos;
    y = yPos;
  }
  float[] getCoordinatesFromIATA(String inpIATA) {
    String filePath = "usa-airports.csv"; // adjust file path to wherever it is in your files
    float[] returnValue = new float[2];
    returnValue[0] = -1;
    returnValue[1] = -1;
    Table flightData = loadTable(filePath, "csv");
    for (TableRow row : flightData.rows()) {
      String iata = row.getString(0);
      if (iata.equals(inpIATA)) {
        returnValue[0] = float(row.getString(5));
        returnValue[1] = float(row.getString(6));
      }
    }
    return returnValue;
  }

 void drawAirports(ArrayList <Airport> airports) {
    color colour;
  for (int i = 0; i < airports.size(); i++) {
    if (airports.get(i).numberOfFlights >= 20)
    {
      colour = color(255,0,0);
    }
    else if (airports.get(i).numberOfFlights >= 5 && airports.get(i).numberOfFlights < 20)
    {
      colour = color(255,165,0);
    } 
    else if (airports.get(i).numberOfFlights >= 2 && airports.get(i).numberOfFlights < 5)
    {
      colour = color(255, 204, 0);
    }
    else
    {
      colour = color(0,255,0);
    }
      drawAirport(airports.get(i).IATA, colour);
  }
}

ArrayList <Airport> chooseColour(ArrayList <Flight> flights)
{
  iatas = new ArrayList<String>();
  ListOfAirports = new ArrayList<Airport>();
  for (int i = 0; i <flights.size(); i ++)
  {
    Flight flight = flights.get(i);
    if (!(iatas.contains(flight.originIATA)))
    {
      iatas.add(flight.originIATA);
      ListOfAirports.add(new Airport(flight.originIATA));
    }
  }

  for (int i =0; i < ListOfAirports.size(); i ++)
  {
    
    for (int j = 0; j < flights.size(); j ++)
    {
      if (flights.get(j).originIATA.equals(ListOfAirports.get(i).IATA))
      {
        ListOfAirports.get(i).increment();
      }
    }
   ListOfAirports.get(i).printStuff();
  }
  return ListOfAirports;
}


// count the number of flights leaving from a certain airport
// draw that airport in a colour relating to that
  void drawAirport(String IATA, color colour) {
    float[] pixelPos = getCoordinatesFromIATA(IATA);
    pixelPos[0] = y+MapTools.latitudeToPixels(pixelPos[0], h);
    pixelPos[1] = x+MapTools.longitudeToPixels(pixelPos[1], w);
    noStroke();
    fill(colour, 128);
    circle(pixelPos[1], pixelPos[0], 15);
  }
}
