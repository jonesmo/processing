/**
 This program demonstrates the various configuration options available
 for the knob control (GKnob).
 
 The only thing not set is the range limits. By default the knob returns
 values in the range 0.0 to 1.0 inclusive. Use setLimits() to set your 
 own range.
 
 Modify the knob to suit your own needs then click on the button to copy 
 the code to create a simple sketch demonstrating this knob to the clipboard.
 To see this the knob in action, open Processing and paste the code into 
 an empty sketch.
 
 for Processing V3+
 (c) 2018 Peter Lager
 
 */

import g4p_controls.*;

GKnob kb;
int bgcol = 128;

public void setup() {
  size(500, 360);
  surface.setTitle("Knob Configuration Demo");
  G4P.setCursor(CROSS);
  // Create the knob using default settings
  kb = new GKnob(this, 60, 60, 180, 180, 0.8f);
  // Now make the configuration controls
  makeKnobConfigControls();
}

public void draw() {
  background(bgcol);
  fill(227, 230, 255);
  noStroke();
  rect(width - 190, 0, 200, height);
  rect(0, height - 84, width - 190, 84);
}

public void handleKnobEvents(GValueControl knob, GEvent event) { 
  // Has the demo knob turned?
  if (kb == knob)
    lblValue.setText("" + knob.getValueS());
  // These 2 knobs are part to configure the demo
  else if (knbStart == knob || knbEnd == knob)
    this.kb.setTurnRange(knbStart.getValueF(), knbEnd.getValueF());
}


public void handleButtonEvents(GButton button, GEvent event) { 
  if (button.tagNo >= 1000) {
    kb.setLocalColorScheme(button.tagNo - 1000);
    lblValue.setLocalColorScheme(button.tagNo - 1000);
  } else if (btnMakeCode == button)
    placeCodeOnClipboard();
}

public void handleSliderEvents(GValueControl slider, GEvent event) { 
  if (slider == sdrSense)
    kb.setSensitivity(slider.getValueF());
  else if (slider == sdrSense)
    kb.setSensitivity(slider.getValueF());    
  else if (slider == sdrEasing)
    kb.setEasing(slider.getValueF());    
  else if (slider == sdrNbrTicks)
    kb.setNbrTicks(slider.getValueI());    
  else if (slider == sdrBack)
    bgcol = slider.getValueI();  
  else if (slider == sdrGripRatio)
    kb.setGripAmount(slider.getValueF());
}

public void handleToggleControlEvents(GToggleControl option, GEvent event) {
  if (option == optAngular)
    kb.setTurnMode(G4P.CTRL_ANGULAR);
  else if (option == optXdrag)
    kb.setTurnMode(G4P.CTRL_HORIZONTAL);
  else if (option == optYdrag)
    kb.setTurnMode(G4P.CTRL_VERTICAL);
  else if (option == cbxOverArc)
    kb.setOverArcOnly(option.isSelected());
  else if (option == cbxOverAll)
    kb.setIncludeOverBezel(option.isSelected());
  else if (option == cbxOpaque)
    kb.setOpaque(option.isSelected());
  else if (option == cbxShowArcOnly)
    kb.setShowArcOnly(option.isSelected());
  else if (option == cbxShowTicks)
    kb.setShowTicks(option.isSelected());
  else if (option == cbxShowTrack)
    kb.setShowTrack(option.isSelected());
  else if (option == cbxSticky)
    kb.setStickToTicks(option.isSelected());
}


private void placeCodeOnClipboard() {
  StringBuilder s = new StringBuilder();
  s.append("// Generated by the GKnob example program\n\n");
  s.append("import g4p_controls.*;\n\n");
  s.append("GKnob kb; \n\n");
  s.append("void setup() { \n");
  s.append("  size(300, 300); \n");
  s.append("  kb = new GKnob(this, 60, 60, 180, 180, " + sdrGripRatio.getValueF() + "); \n");
  s.append("  // Some of the following statements are not actually\n");
  s.append("  // required because they are setting the default value. \n");
  s.append("  kb.setTurnRange("+knbStart.getValueF()+", " + knbEnd.getValueF() + "); \n");
  s.append("  kb.setLocalColorScheme(" + kb.getLocalColorScheme() + "); \n");
  s.append("  kb.setOpaque(" + kb.isOpaque() + "); \n");
  s.append("  kb.setValue(" + kb.getValueF() + "); \n");
  s.append("  kb.setNbrTicks(" + kb.getNbrTicks() + "); \n");
  s.append("  kb.setShowTicks(" + kb.isShowTicks() + "); \n");
  s.append("  kb.setShowTrack(" + kb.isShowTrack() + "); \n");
  s.append("  kb.setShowArcOnly(" + kb.isShowArcOnly() +"); \n");
  s.append("  kb.setStickToTicks(" + kb.isStickToTicks() + "); \n");
  s.append("  kb.setTurnMode(" + kb.getTurnMode() + "); \n");
  s.append("  kb.setIncludeOverBezel(" + kb.isIncludeOverBezel() + "); \n");
  s.append("  kb.setOverArcOnly(" + kb.isOverArcOnly() + "); \n");
  s.append("  kb.setSensitivity(" + kb.getSensitivity() + "); \n");
  s.append("  kb.setEasing(" + kb.getEasing() + "); \n");
  s.append("}   \n\n");
  s.append("void draw(){ \n");
  s.append("  background(" + bgcol + "); \n");
  s.append("} \n");
  if (GClip.copy(s.toString()))
    println("Paste code into empty Processing sketch");
  else
    System.err.println("UNABLE TO ACCESS CLIPBOARD");
}
