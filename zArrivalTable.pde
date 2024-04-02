import processing.data.Table;
import processing.data.TableRow;


class ArrivalTable{
  
  Table flightData;
  
  void readInFlights(){
    flightData = loadTable("flights2k(1).csv");
    flightData.sort(0);
  }
  
  void displayTable(int i, float originalxpos, float originalypos){
    background(0);
    textAlign(CENTER, TOP);
    float xpos = originalxpos;
    float ypos = originalypos;
    
    fill(255);
    text("Date", xpos, ypos);
    xpos += 200;
    text("Airline", xpos, ypos);
    xpos += 200;
    text("Origin", xpos, ypos);
    xpos += 200;
    text("Destination", xpos, ypos);
    xpos += 200;
    text("Estimated Arrival", xpos, ypos);
    xpos += 200;
    text("Actual Arrival", xpos, ypos);
    
    ypos += 20;
    
  
    
    for(int x = i; x < i + 20 && x < flightData.getRowCount() - 1; x++){
      TableRow row = flightData.getRow(x);
      
      if(isLate(row) == true){
        fill(255, 0, 0);
    } else {
      fill(255);
    }
    
    if(didNotArrive(row) == true){
      fill(100, 100, 200);
    }
      
      text(row.getString(0), originalxpos, ypos);
      text(row.getString(1), originalxpos+200, ypos);
      text(row.getString(3), originalxpos+400, ypos);
      text(row.getString(7), originalxpos+600, ypos);
      text(row.getString(13), originalxpos+800, ypos);
      text(row.getString(14), originalxpos+1000, ypos);
      
      ypos += 50;
    }
  }
  
  boolean isLate(TableRow row){
      int schArrivalTime = row.getInt(13);
      int actArrivalTime = row.getInt(14);
      if(actArrivalTime > schArrivalTime){
        return true;
    }
    else return false;
  }
  
  boolean didNotArrive(TableRow row){
    int arrivalTime = row.getInt(14);
    if(arrivalTime == 0){
      return true;
    }
    else return false;
  }
  
  void keyPressed(int i, float xpos, float ypos){
    if(key == CODED){
      if(keyCode == DOWN && i + 20 < arrivalTable.flightData.getRowCount()){
        background(0);
        i = i + 20;
        arrivalTable.displayTable(i, xpos, ypos);
      }
      if(keyCode == UP && i > 1){
        ypos = 50;
        i = i - 20;
        background(0);
        arrivalTable.displayTable(i, xpos, ypos);
      }
      if(keyCode == SHIFT){
        arrivalTable.flightData.sortReverse(0);
      }
    }
  }
  
}
