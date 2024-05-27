int radius;

void setup() {
  size(1000, 1000);
  background(255);
  strokeWeight(0.5);
  stroke(0);
  fill(255, 255, 255, 0);
  
  radius = width / 2;
}

void draw() {
  line(0, height / 2, width, height/2);
  
  circle(width / 2, height / 2, radius);
  
  circle(width / 4, height / 2, radius + 300);
  circle(3 * width / 4, height / 2, radius + 300);
  
  line(width / 2, 0, width / 2, height);
  
  circle(width / 4, height / 2, radius);
  circle(3 * width / 4, height / 2, radius);
  circle(width / 2, height / 2 - width / 4, radius);
  circle(width / 2, height / 2 + width / 4, radius);
  
  line(0, 0, width, height);
  line(width, 0, 0, height);
  
  line(width / 4, height / 4, 3 * width / 4, height / 4);
  line(width / 4, height / 4, width / 4, 3 * height / 4);
  line(width / 4, 3 * height / 4, 3 * width / 4, 3 * height / 4);
  line(3 * width / 4, 3 * height / 4, 3 * width / 4, height / 4);
}
