int radius, diameter;

void setup() {
  size(1000, 1000);
  background(255);
  strokeWeight(0.5);
  stroke(0);
  fill(255, 255, 255, 0);
  
  diameter = width / 3;
  radius = diameter / 2;
}

void draw() {
  line(0, height / 2, width, height/2);
  
  circle(width / 2, height / 2, diameter);
  
  circle(width / 2 - radius, height / 2, diameter);
}
