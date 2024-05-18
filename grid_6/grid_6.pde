int videoScale = 40;
int cols, rows;
int[] colors;
boolean red = false;
int frameCounter = 0;

void setup() {
  size(800, 800);
  
  cols = width/videoScale;
  rows = height/videoScale;
  print(cols, "columns\n");
  print(rows, "rows\n");
  
  strokeWeight(2);
  
  colors = new int[cols * rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int red = (255 / cols) * i;
      int green = (255 / rows) * j;
      
      color c = color(red, green, 127);
      colors = append(colors, c);
    }
  }
  
  noLoop();
}

void draw() {
  color c;
  
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        
          int x = i * videoScale;
          int y = j * videoScale;
          
          c = colors[int(random(0, colors.length))];
          
          int randX = int(random(20, cols + 20));
          int randY = int(random(20, rows + 20));
          
          if (frameCounter%(randY)==0) {
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
