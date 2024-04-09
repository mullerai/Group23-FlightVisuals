// Class ArrivalTable done by Mairead O'Dwyer
// This class is used to read in a table of data and display that table on screen
// this table focuses on the arrival of the flights
import processing.data.Table;    // importing library to work with tables and tablerows
import processing.data.TableRow;


class ArrivalTable {

  Table flightData;

  float xpos;
  float ypos;


  ArrivalTable(float xpos, float ypos) { // constructor to position the table
    this.ypos = ypos;
    this.xpos = xpos;
  }

  void readInFlights() { // load in data
    flightData = loadTable("flights2k(1).csv");
    if (ButtonPressed == true) { // when ButtonPressed is true in aMain file, flight data is ordered by latest flight and reversed if false;
      flightData.sortReverse(0);
    } else {
      flightData.sort(0);
    }
  }

  void displayTable(int i, float originalxpos) {  // function to display the table on screen
    float xpos = originalxpos;
    float ypos = 40;
    textAlign(CENTER, TOP);
    textSize(20);

    // creates headers for the different columns and positions them
    fill(255);
    text("Date", xpos, ypos);
    text("Airline", xpos + 200, ypos);
    text("Origin", xpos + 400, ypos);
    text("Destination", xpos + 600, ypos);
    text("Estimated Arrival", xpos + 800, ypos);
    text("Actual Arrival", xpos + 1000, ypos);

    ypos = ypos + 20;


    // iterates through each row of the data
    for (int x = i; x < i + 18 && x < flightData.getRowCount() - 1; x++) {
      TableRow row = flightData.getRow(x);

      fill(255);

      if (isLate(row) == true) {     // calls function to see if the flight arrived late
        fill(255, 0, 0);           // if it arrived late, the text is changed to red
      }

      if (didNotArrive(row) == true) {    // calls function to see if the flight did not arrive i.e. cancelled or diverted
        fill(100, 100, 200);            // if it did not arrive, the text is changed to blue;
      }

      if (arrivedEarly(row) == true) {    // calls function to see if the flight arrived early
        fill(0, 200, 0);                // if it arrived early, the text is changed to green;
      }

      text(row.getString(0), originalxpos, ypos);           // finds the text in the row and coloumn, and prints it out on the table
      text(row.getString(1), originalxpos+200, ypos);
      text(row.getString(3), originalxpos+400, ypos);
      text(row.getString(7), originalxpos+600, ypos);
      text(row.getString(13), originalxpos+800, ypos);
      text(row.getString(14), originalxpos+1000, ypos);

      ypos += 50;
    }
  }

  boolean isLate(TableRow row) {             // function to see if the flight arrived late
    int schArrivalTime = row.getInt(13);  // gets an integer value from the scheduled arrival column of the data
    int actArrivalTime = row.getInt(14);  // gets an integer value from the actual arrival coloumn of the data
    if (actArrivalTime > schArrivalTime) {  // compares the scheduled arrival time with the actual arrival time
      return true;                        // if the actual arrival time is greater than scheduled arrival time
    }                                       // the function returns a true value;
    else return false;                      // else it returns a false value;
  }

  boolean didNotArrive(TableRow row) {       // function to see if the flight did not arrive i.e was cancelled or diverted
    int arrivalTime = row.getInt(14);       // gets an integer value from the arrival coloumn of the data
    if (arrivalTime == 0) {                   // if the value is equal to 0, the flight did not arrive and the function returns a true value;
      return true;
    } else return false;                      // else it returns a false value
  }

  boolean arrivedEarly(TableRow row) {       // function to see if the flight arrived earlier then scheduled
    int arrivalTime = row.getInt(14);       // gets an integer value from the actual arrival time coloumn of the data
    int scharrivalTime = row.getInt(13);    // gets an integer value from the scheuled arrival time coloumn of the data
    if (arrivalTime < scharrivalTime && arrivalTime > 0) {  // compares the actual arrival time from the scheduled arrival time and checks to see if the arrival time is greater than 0
      return true;                                        // if the actual arrival time is less then scheduled arrival time AND the actual arrival time is greate than 0
    } else {                                              // it returns a true value;
      return false;                                       // else it returns a false value;
    }
  }
}
