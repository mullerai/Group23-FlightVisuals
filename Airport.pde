class Airport
{
  int numberOfFlights = 0;
  String IATA;
  
  Airport(String iata)
  {
    IATA = iata;
  }
  void increment()
  {
    numberOfFlights = numberOfFlights + 1;
    
  }
  void printStuff()
  {
    System.out.println(IATA +" "+ numberOfFlights);
  }
  
  

}
