/** This class by Anastasia O'Donnell
**/

// Button Widget
/**
 * This class represents a button with specified characteristics such as position, size, label, color, and event.
 * It provides methods for drawing the button, retrieving the button event, and changing the button color based on mouse position.
 */
 
class Button 
{

  int EVENT_NULL = 0;
  int x, y, width, height;
  int GAP_HEIGHT;
  int GAP_WIDTH;
  String label;
  int event;
  color buttonColor, labelColor = color(0);
  PFont buttonFont;
  color originalColour;


  Button(int x, int y, int width, int height, String label,
    color buttonColor, PFont buttonFont, int event)
  {
    this.x=x;
    this.y=y;
    this.width = width;
    this.height= height;
    GAP_HEIGHT = height/2;
    GAP_WIDTH = width/2;
    this.label=label;
    this.event=event;
    this.buttonColor=buttonColor;
    this.buttonFont=buttonFont;
    this.buttonColor= buttonColor;
    this.originalColour = buttonColor;
  }
  // draws the button
  void draw()
  {
    stroke(0);
    strokeWeight(3);
    fill(buttonColor);
    rect(x, y, this.width, this.height, 5);
    fill(labelColor);
    textFont(buttonFont);
    textAlign(CENTER, CENTER);
    text(label, x+GAP_WIDTH, y+height-GAP_HEIGHT);
    changeColour(mouseX, mouseY);
  }
  // returns the button event
  int getEvent(int mX, int mY)
  {
    if (mX>x && mX < x+width && mY >y && mY <y+height)
    {
      return event;
    }
    return EVENT_NULL;
  }
  //Changes the colour of the button depending on mouse position
  void changeColour(int mX, int mY)
  {
    if (mX>x && mX < x+width && mY >y && mY <y+height)
    {
      this.buttonColor = color(169, 196, 196);
    } else
    {
      this.buttonColor = originalColour;
    }
  }
}
//Dropdown Widget
/**
 * This class represents a dropdown menu with a list of options.
 * It provides methods for drawing the dropdown menu, selecting options, and retrieving the current selection.
 */
class dropdown
{
  boolean dropdownActive = false;
  int dropdownWidth = 150;
  int dropdownHeight = 30;
  int optionHeight = 25;
  String [] options;
  int x;
  int y;
  String input;
  String label;

  dropdown(String[] options, int x, int y, String label)
  {
    this.options = options;
    this.input = options[0];
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw()
  {
    fill(200);
    rect(x, y, dropdownWidth, dropdownHeight);
    fill(0);
    textSize(16);
    textAlign(CENTER, CENTER);
    text((input == null)?"Select Airline":input, x + 75, y + 15);
    textSize(16);
    text(label, x + 45, y -15);

    if (dropdownActive) {
      for (int i = 0; i < options.length; i++) { //Iterate through each option
        fill(155);
        if (mouseX > x &&
          mouseX < x + dropdownWidth && mouseY > y + (i+1) * optionHeight &&
          mouseY < y + (i+1)*optionHeight + optionHeight)
        {
          fill(255);
        }
        rect(x, y + (i+1) * optionHeight, dropdownWidth, optionHeight);
        fill(0);
        text(options[i], x + 75, y + (i+1) * optionHeight + optionHeight/2);
      }
    }
  }
  
  //Checks if the mouse is over the dropdown 
  //Sets the variable dropdownActive accordiningly
  void checkMouseOver(float mouseX, float mouseY)
  {
    if (dropdownActive) {
      for (int i = 0; i < options.length; i++) {
        if (mouseX > x &&
          mouseX < x + dropdownWidth && mouseY > y + (i+1) * optionHeight &&
          mouseY < y + (i+1)*optionHeight + optionHeight)
        {
          input = options[i];
          dropdownActive = false;
        }
      }
    }
    if (mouseX > x &&
      mouseX < x+dropdownWidth && mouseY > y &&
      mouseY <= (y+dropdownHeight))
    {
      dropdownActive = !dropdownActive;
    }
  }
  //Returns a string of the current option chosen
  String getInput()
  {
    return input;
  }
}
//Checkbox Widget
/**
 * This class represents a checkbox with specified characteristics such as position and size.
 * It provides methods for drawing the checkbox, checking if the mouse is over the checkbox, and toggling its state.
 */
class Checkbox {
  float x, y; // Position of the checkbox
  float size; // Size of the checkbox
  boolean checked; // State of the checkbox

  Checkbox(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    checked = false;
  }


  boolean isMouseOver() {
    return mouseX > x && mouseX < x + size && mouseY > y && mouseY < y + size;
  }

  void draw() {
    stroke(0);
    fill(255);
    rect(x, y, size, size);

    if (checked) {
      line(x, y, x + size, y + size);
      line(x + size, y, x, y + size);
    }
  }

  void toggle() {
    checked = !checked;
  }
}

//TextBox Widget
// 
/**
 * This class represents a text box with specified characteristics such as position, size, text, and label.
 * It provides methods for drawing the text box, checking if the mouse is on top of the text box,
 * setting and retrieving the selection state, setting and retrieving the text content.
 */
class TextBox {
  float x, y, w, h;
  String text;
  boolean selected;
  String label;

  TextBox(float x, float y, float w, float h, String text, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.selected = false;
    this.label = label;
  }

  void draw() {
    stroke(0);
    if (selected) {
      fill(200);
    } else {
      fill(255);
    }

    rect(x, y, w, h);
    fill(0);
    textSize(15);
    textAlign(LEFT, CENTER);
    text(text, x + 5, y + h/2);
    textSize(20);
    text(label,x, y-15);
  }

//Returns the if the mouse is on top of the TextBox
  boolean contains(float px, float py) {
    return px > x && px < x + w && py > y && py < y + h;
  }
// Sets whether or not the TextBox is selected
  void setSelected(boolean selected) {
    this.selected = selected;
  }
//Returns if the TextBox is selected
  boolean isSelected() {
    return selected;
  }
//Sets the text variable
  void setText(String text) {
    this.text = text;
  }
//Returns the entered text
  String getText() {
    return text;
  }
}
