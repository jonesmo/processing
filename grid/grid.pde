int videoScale = 40;
int cols, rows;
int colors;

void setup() {
  size(800, 800);
  
  cols = width/videoScale;
  rows = height/videoScale;
  print(cols, "columns\n");
  print(rows, "rows\n");
  
  strokeWeight(2);
}

void draw() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i * videoScale;
      int y = j * videoScale;
      
      int red = (255 / cols) * i;
      int green = (255 / rows) * j;
      
      fill(red, green, 127);
      stroke(255);
      
      rect(x, y, videoScale, videoScale);
    }
  }
}
