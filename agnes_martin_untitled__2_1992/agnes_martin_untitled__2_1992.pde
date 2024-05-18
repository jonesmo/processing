int singleSpan;
int colorIndex = 0;
color blueColor, yellowColor, redColor, whiteColor, localColor;
color[] pattern = new color[6];

void setup() {
  size(783, 783);
  
  singleSpan = height / 27;
  strokeWeight(0);
  stroke(255);
  
  whiteColor = color(255);
  blueColor = color(200, 245, 255);
  redColor = color(255, 200, 200);
  yellowColor = color(255, 255, 200);
  
  for (int j = 0; j < 3; j++) {
    pattern[j] = blueColor;
  };
  pattern[3] = redColor;
  pattern[4] = yellowColor;
  pattern[5] = whiteColor;
  
  noLoop();
}

void draw() {
  for (int vertPos = 0; vertPos < height; vertPos += singleSpan) {
        if (colorIndex < 6) {
          localColor = pattern[colorIndex];
          fill(localColor);
          rect(0, vertPos, width, vertPos + singleSpan);
          colorIndex++;
        }
        else {
          colorIndex = 0;
          localColor = pattern[colorIndex];
          fill(localColor);
          rect(0, vertPos, width, vertPos + singleSpan);
          colorIndex++;
        }
  }
}
