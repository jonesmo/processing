int strokeColor = 0;
int vertSpacing = 5;
int horSpacing = 22;
int marginLR = 50;
int marginTBHor = 110;
int marginTBVer = int(0.5 * marginTBHor);
int numVertLines = 25;

int lineStartL, lineEndR, lineStartT, lineEndB;
int vertPosition, horPosition;
int widthOfVertLines, startOfVertLines;

void setup() {
  size(800, 900);
  
  lineStartL = marginLR;
  lineEndR = width - marginLR;
  lineStartT = marginTBHor;
  lineEndB = height - marginTBHor;
  
  widthOfVertLines = numVertLines * horSpacing;
  startOfVertLines = int((width - widthOfVertLines) / 2) + 8;
  
  strokeWeight(1);
  background(255);
  
  noLoop();
}

void draw() {
  for (vertPosition = lineStartT; vertPosition < lineEndB; vertPosition += vertSpacing) {
    lineStartL = lineStartL + int(random(-2, 2));
    lineEndR = lineEndR + int(random(-2, 2));
    line(lineStartL, vertPosition, lineEndR, vertPosition);
  }
  
  for (horPosition = startOfVertLines; horPosition < (width - startOfVertLines); horPosition += horSpacing) {
    lineStartT = marginTBVer + int(random(-3, 3));
    lineEndB = height - marginTBVer + int(random(-3, 3));
    line(horPosition, lineStartT, horPosition, lineEndB);
  }
}
