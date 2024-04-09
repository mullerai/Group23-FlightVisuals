//Class by Anastasia O'Donnell 

class Airport
{
  int numberOfFlights = 0;
  String IATA;
  
  Airport(String iata)
  {
    IATA = iata;
  }
/**
 * This function increments the value of the variable 'numberOfFlights' by 1.
 * 
 * @param None
 * @return None
 */
  void increment()
  {
    numberOfFlights = numberOfFlights + 1;
    
  }
  //Code for testing purposes
  void printStuff()
  {
    System.out.println(IATA +" "+ numberOfFlights);
  }
}
