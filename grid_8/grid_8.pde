int videoScale = 40;
int cols, rows;
color[][] colors;
color[][] colorsOriginal;
int frameCounter = 0;

void setup() {
  size(800, 800);
  
  cols = width/videoScale;
  rows = height/videoScale;
  print(cols, "columns\n");
  print(rows, "rows\n");
  
  strokeWeight(2);
  
  colors = new color[rows][cols];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int red = (255 / cols) * i;
      int green = (255 / rows) * j;
      
      color c = color(red, green, 127);
      colors[i][j] = c;
    }
  }
  colorsOriginal = colors;
  
  noLoop();
}

void draw() {
  // select two random cells
  int randX1 = int(random(0, rows));
  int randY1 = int(random(0, cols));
  int randX2 = int(random(0, rows));
  int randY2 = int(random(0, cols));
  print(randX1, ", ", randY1, "\n");
  print(randX2, ", ", randY2, "\n");
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int interval = int(random(20, rows + 20));
      
      int x = i * videoScale;
      int y = j * videoScale;
      
      if (frameCounter%(interval)==0) {
        
        color cx1 = color(colors[randX1][randY1]);
        color cx2 = color(colors[randX2][randY2]);
        
        colors[randX1][randY1] = cx2;
        colors[randX2][randY2] = cx1;
        
        color c = colors[i][j];
        
        fill(c);
        stroke(255);
        
        rect(x, y, videoScale, videoScale);
    }
      
      }
  }
  
  frameCounter++;
}

void mousePressed() {
  loop();
}

void mouseReleased() {
  noLoop();
}
