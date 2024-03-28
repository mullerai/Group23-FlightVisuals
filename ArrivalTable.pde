import processing.data.Table;
import processing.data.TableRow;
import java.util.ArrayList;
import java.util.Collections;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;
import controlP5.*;
ControlP5 cp5;

Table flightData1;

class ArrivalTable{
  Table flightData2;
  String fileName1;
  
  void readInFlights(){
    flightData2 = loadTable("flights2k.csv");
  }
  
  void sortTableByDate(){
    flightData2.sort(0);
  }
  
  boolean isLate(){
    for(int i = 1; i < flightData2.getRowCount(); i++){
      float schArrTime = flightData2.getFloat(i, 13);
      float actArrTime = flightData2.getFloat(i, 14);
      if(schArrTime < actArrTime){
        fill(12, 421, 42);
        return false;
      }
    }
    return true;
  }
  
  void keyPressed(){
    if(key == CODED){
      if(keyCode == DOWN){
        translate(0, +mouseY);
      }
    }
  }
  
  void displayTable(){
    textAlign(CENTER, TOP);
    
    float xpos = 50;
    float ypos = 10;
    
    text("Date", xpos, ypos);
    xpos += 100;
    text("Airline", xpos, ypos);
    xpos += 100;
    text("Origin", xpos, ypos);
    xpos += 100;
    text("Destination", xpos, ypos);
    xpos += 100;
    text("Estimated Arrival", xpos, ypos);
    xpos += 100;
    text("Actual Arrival", xpos, ypos);
    
    ypos += 20;
    
    for(int i = 1; i < flightData2.getRowCount(); i++){
      TableRow row = flightData2.getRow(i);
      
      text(row.getString(0), 50, ypos);
      text(row.getString(1), 150, ypos);
      text(row.getString(3), 250, ypos);
      text(row.getString(7), 350, ypos);
      text(row.getString(13), 450, ypos);
      text(row.getString(14), 550, ypos);
      
      ypos += 20;
    }
  }
  
  void mouseMoved(){
    if(mouseY >= height){
      
    }
  }
}
