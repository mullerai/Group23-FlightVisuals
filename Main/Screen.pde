ArrayList<Button> buttonList;
color colour;
int event;
PFont stdFont;
final int EVENT_NULL;

class Screen{
  Screen(color colour){
  fullScreen();
  buttonList = new ArrayList();
 }

 void addButton(Button button){
   buttonList.add(button);
}
 
 int getEvent(int mX, int mY){
   for(int i = 0; i < buttonList.size(); i++){
     Button button = (Button) buttonList.get(i);
     if(mX > button.x && mX < button.x + button.width
     && mY > button.y && mY < button.y + button.height){
       return event;
     }
   }
   return EVENT_NULL;
 }
 
 void draw(){
   background(colour);
   for(int i = 0; i < buttonList.size(); i++){
     Button button = (Button) buttonLise.get(i);
     button.draw();
   }
  rect(10, 40, 50, 50);
 }
}
