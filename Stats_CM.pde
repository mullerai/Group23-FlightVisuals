class stats_cm {

  int countCancelled() {
  int cancelled = 0;
  String filePath = "flights2k(1).csv"; // adjust file path to wherever it is in your files
  Table flightData = loadTable(filePath, "csv");
  for (TableRow row : flightData.rows()) {
    row.getString(15);
    if(row.getString(15).equals("1"))
    {
    cancelled++;
    }
  }
  return cancelled;
}
}
