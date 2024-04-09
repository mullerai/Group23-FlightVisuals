ArrayList <Airport> ListOfAirports;
/** Code from Map class modified by Anastasia O'Donnell
**/
class Heatmap { 
  PImage mapTexture;    
  int x, y;            
  private int w, h;             
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
  
  
/**
 * This method draws a map along with a key indicating the level of busyness.
 * The map is drawn using a specified image.
 * Four rectangles are drawn representing different levels of busyness, along with corresponding text labels.
 * 
 */
  void draw() {
    image(mapTexture, x, y); //Draw map
    
    fill(color(255,0,0));         // Draw Key 
    rect(x, y + h + 20, 20, 20);
    fill(0);
    text(" Very Busy",x + 70, y + h+30);
    
    fill(color(255,165,0));
    rect(x, y + h + 50, 20, 20);
    fill(0);
    text(" Busy ",x + 50, y + h+60);
    
    fill(color(255, 204, 0));
    rect(x, y + h + 80, 20, 20);
    fill(0);
    text(" Moderately Busy",x + 90, y + h+90);
    
    fill(color(0,255,0));
    rect(x, y + h + 110, 20, 20);
    fill(0);
    text(" Not Busy",x + 70, y + h+120);
    
    
    
    
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
  
  /**
 * This method draws airports on a graphical display based on the number of flights associated with each airport.
 * The color of the airport marker is determined by the number of flights as follows:
 * - If the number of flights is 20 or more, the color is set to red.
 * - If the number of flights is between 5 and 19 (inclusive), the color is set to orange.
 * - If the number of flights is between 2 and 4 (inclusive), the color is set to yellow.
 * - If the number of flights is less than 2, the color is set to green.
 * 
 * @param airports An ArrayList of Airport objects representing the airports to be drawn.
 */

 void drawAirports(ArrayList <Airport> airports) {
    color colour;
  for (int i = 0; i < airports.size(); i++) {
    if (airports.get(i).numberOfFlights >= 20)
    {
      colour = color(255,0,0); // color = red
    }
    else if (airports.get(i).numberOfFlights >= 5 && airports.get(i).numberOfFlights < 20)
    {
      colour = color(255,165,0); // color = orange
    } 
    else if (airports.get(i).numberOfFlights >= 2 && airports.get(i).numberOfFlights < 5)
    {
      colour = color(255, 204, 0); //color = yellow
    }
    else
    {
      colour = color(0,255,0); // color = green
    }
      drawAirport(airports.get(i).IATA, colour);
  }
}

/**
 * This method takes a list of flights and a boolean indicating whether to consider destination or origin airports.
 * It creates a list of unique airports based on the given criteria and counts the number of flights associated with each airport.
 * 
 * @param flights The list of flights to be considered.
 * @param destination A boolean indicating whether to consider destination (true) or origin (false) airports.
 * @return An ArrayList of Airport objects containing unique airports with their respective flight counts.
 */
ArrayList <Airport> chooseColour(ArrayList <Flight> flights, boolean destination)
{
  iatas = new ArrayList<String>();
  ListOfAirports = new ArrayList<Airport>();
  for (int i = 0; i <flights.size(); i ++)
  {
    Flight flight = flights.get(i);
    
   String dest = (destination == true)? flight.destinationIATA : flight.originIATA;
    if (!(iatas.contains(dest)))
    {
      iatas.add(dest);
      ListOfAirports.add(new Airport(dest));
    }
  }

  for (int i =0; i < ListOfAirports.size(); i ++)
  {
    
    for (int j = 0; j < flights.size(); j ++)
    {
      String dest = (destination == true)? flights.get(j).destinationIATA : flights.get(j).originIATA;
      if (dest.equals(ListOfAirports.get(i).IATA))
      {
        ListOfAirports.get(i).increment();
      }
    }
  }
  return ListOfAirports;
}

  void drawAirport(String IATA, color colour) {
    float[] pixelPos = getCoordinatesFromIATA(IATA);
    pixelPos[0] = y+MapTools.latitudeToPixels(pixelPos[0], h);
    pixelPos[1] = x+MapTools.longitudeToPixels(pixelPos[1], w);
    noStroke();
    fill(colour, 128);
    circle(pixelPos[1], pixelPos[0], 15);
  }
}
