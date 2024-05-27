/* Example for comparing images to get the difference.
 * Author: Nick 'Milchreis' Müller
 */

import milchreis.imageprocessing.*;

PImage image1, image2;

void setup() {
  size(550, 550);
  // Load image
  image1 = loadImage(dataPath("example.jpg"));
  image2 = loadImage(dataPath("example2.jpg"));

  textAlign(CENTER, CENTER);
  textSize(32);
}

void draw() {

  if (mousePressed == true) {
    // Show both original images on mouse pressed
    image(image1, 0, 0);
    image(image2.get(image2.width/2, 0, image2.width/2, image2.height), width/2, 0);
  } else {
    // Calculate a picture with different pixels
    // white is a big difference
    // black is less/no difference
    PImage differenceImage = Comparison.calculateDifferenceImage(image1, image2);
    image(differenceImage, 0, 0);

    float difference = Comparison.howDifferent(image1, image2);
    float differenceInPercent = difference * 100;

    text(differenceInPercent + "%", width/2, height - 40);
  }
}
