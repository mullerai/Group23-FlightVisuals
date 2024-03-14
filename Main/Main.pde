final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;

Screen mainScreen;
Screen currentScreen;
Screen screen2;
void setup(){
  fullScreen();
  
  mainScreen = new Screen(color(0,0,0));
  screen2 = new Screen(color(255, 0, 0));
  
  currentScreen = mainScreen;
}

void mousePressed(){
  int event;
  event = currentScreen.getEvent(mouseX, mouseY);
  switch(event){ 
    case EVENT_BUTTON1:
    currentScreen = screen2;
    break;
  }
}

void draw(){
  currentScreen.draw();
}
