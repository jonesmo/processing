/**
 An image toggle button has two or more possible states. As 
 you click on the button it loops through the states.
 
 This program demonstrates how to create image toggle buttons.
 
 If G4P is unable to create the button using the information
 i.e. images then it will create the default two state switch
 button.
 
 for Processing V3+
 (c) 2018 Peter Lager
 
 */

import g4p_controls.*;

GImageToggleButton btnToggle0, btnToggle1, btnToggle2, btnToggle3; 
GLabel label1, label2, label3, label4, label5; 

public void setup() {
  size(480, 220, JAVA2D);
  surface.setTitle("Image Toggle Buttons Demo");
  G4P.setGlobalColorScheme(GCScheme.ORANGE_SCHEME);
  G4P.setCursor(ARROW);

  // ##########################################################################
  // Create default 2 state switch button
  btnToggle0 = new GImageToggleButton(this, 10, 10);
  btnToggle0.tag = "Library default button ";
  
  // ##########################################################################
  // Create 16 state switch button
  btnToggle1 = new GImageToggleButton(this, 190, 70, "smile_4x4.png", 4, 4);
  btnToggle1.tag = "User 16 state button ";
  
  // ##########################################################################
  // Create 16 state switch button with mouse over image
  btnToggle2 = new GImageToggleButton(this, 340, 70, "smile_4x4.png", "smile_4x4_grey.png", 4, 4);
  btnToggle2.tag = "User 16 state button with over image ";
  
  // ##########################################################################
  // Create 2 state light-bulb button.
  btnToggle3 = new GImageToggleButton(this, 10, 90, "bulb.png", 2, 1);
  btnToggle3.tag = "Light bulb 2 state button ";
  
  // Create description labels
  createLabels();
}

public void draw() {
  background(250, 225, 200);
}

// Event handler for image toggle buttons
public void handleToggleButtonEvents(GImageToggleButton button, GEvent event) { 
  println(button + "   State: " + button.getState());
}

// Create the labels syaing what-is-what
public void createLabels() {
  label1 = new GLabel(this, 60, 10, 110, 50);
  label1.setText("Library default 2 state button");
  label1.setTextBold();
  label1.setOpaque(true);
  label2 = new GLabel(this, 190, 10, 270, 20);
  label2.setText("Smiley 16 state button");
  label2.setTextBold();
  label2.setOpaque(true);
  label3 = new GLabel(this, 190, 30, 120, 40);
  label3.setText("Off image only");
  label3.setTextBold();
  label3.setOpaque(true);
  label4 = new GLabel(this, 340, 30, 120, 40);
  label4.setText("With mouse over image");
  label4.setTextBold();
  label4.setOpaque(true);
  label5 = new GLabel(this, 60, 170, 100, 40);
  label5.setText("User defined 2 state button");
  label5.setTextBold();
  label5.setOpaque(true);
}