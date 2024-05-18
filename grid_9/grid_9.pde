int videoScale = 40;
int cols, rows;
color[][] colors;
color[][] colorsOriginal;
int strokeColor = 255;
int frameCounter = 0;
int stasisTime = 1000;

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
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int interval = int(random(20, max(20 + frameCounter, 500)));
      
      int x = i * videoScale;
      int y = j * videoScale;
      
      if (frameCounter%(interval)==0) {
        
        if (frameCounter != 0) {
          if (frameCounter < stasisTime) {
            color swap1 = color(colors[randX1][randY1]);
            color swap2 = color(colors[randX2][randY2]);
            
            colors[randX1][randY1] = swap2;
            colors[randX2][randY2] = swap1;
          } else {
            if (frameCounter%(interval*1.5)==0) {
              color swap1 = color(colors[randX1][randY1]);
              color swap2 = color(colors[randX2][randY2]);
              
              float swap1red = red(swap1);
              float swap1green = green(swap1);
              float swap1blue = blue(swap1);
              float swap1luminosity = max(0.299 * swap1red + 0.587 * swap1green + 0.114 * swap1blue, 50);
              
              float swap2red = red(swap2);
              float swap2green = green(swap2);
              float swap2blue = blue(swap2);
              
              colors[randX1][randY1] = color(swap1luminosity);
              colors[randX2][randY2] = color(swap2red, swap2green, swap2blue);
              
              if (strokeColor > 0 && frameCounter%(interval*2.5)==0) {
                strokeColor--;
              }
            }

          }
        }
        
        color c = colors[i][j];
        
        fill(c);
        stroke(strokeColor);
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

void keyPressed() {
  if (key==' ') {
    loop();
  }
}

void keyReleased() {
  if (key==' ') {
    noLoop();
  }
}
