int strokeColor = 0;
int boxWidth = 120;
int boxHeight = 80;
int marginLR = 120;
int marginTB = 100;
int cols = 4;
int rows = 6;

int gridWidth = cols * boxWidth;
int gridHeight = rows * boxHeight;

int canvasWidth, canvasHeight;

void setup() {
  size(800, 800);
  
  canvasWidth = gridWidth + 2 * marginLR;
  canvasHeight = gridHeight + 2 * marginTB;
  windowResize(canvasWidth, canvasHeight);
  
  strokeWeight(1);
  background(255);
  
  noLoop();
}

void draw() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int x = i * boxWidth + marginLR;
      int y = j * boxHeight + marginTB;
      
      rect(x, y, boxWidth, boxHeight);
    }
  }
}
