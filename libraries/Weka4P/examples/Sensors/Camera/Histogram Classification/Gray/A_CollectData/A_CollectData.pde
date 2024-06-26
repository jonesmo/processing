//*********************************************
//  A_CollectData : Collects grayscale histogram data from camera
//
//  Author: Rong-Hao Liang <r.liang@tue.nl>
//  Edited by: Wesley Hartogs <dev@wesleyhartogs.nl>
//
//  Version: 1.0.0 (23 06 2021)
//
//  This example requires Processing Video and OpenCV for processing libraries.
//  You can download these from the contribution manager.
//
//  Manual:
//
//  Start the program and show a thing that you want to classify before the camera.
//  Hold left mouse button to record data points
//
//  Press the "s" key on your keyboard to save 
//  the data to an ARFF and a CSV file.
//
//  You have to press 's' for save for every new label.
//
//  You can find these files in the data folder
//  in your sketch folder.
//  Sketch -> Show Sketch Folder (ctrl/cmd + K)
// 
//*********************************************

import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import org.opencv.core.Mat;

Capture video;
OpenCV opencv;

PImage img, imgGray, imgR, imgG, imgB, imgH, imgS, imgV;
Histogram grayHist; 
Histogram rHist, gHist, bHist;
Histogram hHist, sHist, vHist;

int div = 2, binNum = 16;


int sensorNum = binNum;                                               //number of sensors in use
int dataNum = 500;                                                    //number of data to show
float[] rawData = new float[sensorNum];
float[][] sensorHist = new float[sensorNum][dataNum];                 //history data to show
float[] modeArray = new float[dataNum];                               //classification to show

//Save
Table csvData;
boolean b_saveCSV = false;
String dataSetName = "GrayHistTrain"; 
String[] attrNames;
boolean[] attrIsNominal;
int labelIndex = 0;

boolean b_sampling = false;                                           //flag to keep data collection non-preemptive
int sampleCnt = 0;                                                    //counter of samples

int w = 160, h = 120, d = 10;
void setDataType() {
  attrNames =  new String[binNum+1];
  attrIsNominal = new boolean[binNum+1];
  for (int j = 0; j < binNum; j++) {
    attrNames[j] = "h_"+j;
    attrIsNominal[j] = false;
  }
  attrNames[binNum] = "label";
  attrIsNominal[binNum] = true;
}

void setup() {
  size(500,500);
  video = new Capture(this, 640/div, 480/div, Capture.list()[0]);
  opencv = new OpenCV(this, 640/div, 480/div);
  video.start();
  setDataType();
  initCSV();
}

void draw() {
  background(255);
  updateChannels();
  Mat matGray = grayHist.getMat();
  for (int i = 0; i < binNum; i++) {
    appendArrayTail(sensorHist[i], (float)matGray.get(i, 0)[0]);
    rawData[i] = (float)matGray.get(i, 0)[0];
  }
  if (mousePressed && (frameCount%6==0)) b_sampling = true;
  else b_sampling = false;

  if (b_sampling == true) {
    float[] X = new float[binNum];                                        //Form a feature vector X;
    appendArrayTail(modeArray, labelIndex);                               //the class is null without mouse pressed.
    TableRow newRow = csvData.addRow();
    for (int i = 0; i < binNum; i++) {
      X[i] = rawData[i];
      newRow.setFloat("h_"+i, X[i]);
    }
    newRow.setString("label", getCharFromInteger(labelIndex));
    println(csvData.getRowCount());
    b_sampling = false;
  } else {
    appendArrayTail(modeArray, -1);                                       //the class is null without mouse pressed.
  }
  
  image(img, 0, 0, w, h);
  drawImage(imgGray, grayHist, 1*(w+d), 0*(h+d), w, h, color(255), "Gray");
  barGraph(modeArray, 0, height, 0, height-50, 500., 50);
  showInfo("Current Label: "+getCharFromInteger(labelIndex), 320+20, 20, 16);
  showInfo("Num of Data: "+csvData.getRowCount(), 320+20, 40, 16);
  showInfo("[X]:del/[C]:clear", 320+20, 60, 16);
  showInfo("[S]:save/[/]:label+", 320+20, 80, 16);
  if (b_saveCSV) {
    saveCSV(dataSetName, csvData);
    saveARFF(dataSetName, csvData);
    b_saveCSV = false;
  }
}

void captureEvent(Capture c) {
  c.read();
}

void updateChannels() {
  opencv.useGray();
  opencv.loadImage(video);
  imgGray = opencv.getSnapshot();
  grayHist = opencv.findHistogram(opencv.getGray(), binNum);

  opencv.useColor();
  opencv.loadImage(video);
  rHist = opencv.findHistogram(opencv.getR(), binNum);
  gHist = opencv.findHistogram(opencv.getG(), binNum);
  bHist = opencv.findHistogram(opencv.getB(), binNum);
  imgR = opencv.getSnapshot(opencv.getR());
  imgG = opencv.getSnapshot(opencv.getG());
  imgB = opencv.getSnapshot(opencv.getB());
  img = opencv.getSnapshot();
  
  opencv.useColor(HSB);
  opencv.loadImage(video);
  hHist = opencv.findHistogram(opencv.getH(), binNum);
  sHist = opencv.findHistogram(opencv.getS(), binNum);  
  vHist = opencv.findHistogram(opencv.getV(), binNum);
  imgH = opencv.getSnapshot(opencv.getH());
  imgS = opencv.getSnapshot(opencv.getS());  
  imgV = opencv.getSnapshot(opencv.getV());
}
void drawChannels() {
  image(img, 0, 0, w, h);
  drawImage(imgGray, grayHist, 1*(w+d), 0*(h+d), w, h, color(255), "Gray");
  drawImage(imgR, rHist, 0*(w+d), 1*(h+d), w, h, color(255, 0, 0), "Red");
  drawImage(imgG, gHist, 1*(w+d), 1*(h+d), w, h, color(0, 255, 0), "Green");
  drawImage(imgB, bHist, 2*(w+d), 1*(h+d), w, h, color(0, 0, 255), "Blue");
  drawImage(imgH, hHist, 0*(w+d), 2*(h+d), w, h, color(255), "Hue");
  drawImage(imgS, sHist, 1*(w+d), 2*(h+d), w, h, color(255), "Saturation");
  drawImage(imgV, vHist, 2*(w+d), 2*(h+d), w, h, color(255), "Brightness");
}

void drawImage(PImage imgR, Histogram rHist, int x, int y, int w, int h, color c, String name) {
  pushMatrix();
  translate(x, y);
  pushStyle();
  stroke(c); 
  noFill();
  pushStyle();
  imageMode(CORNER);
  tint(c);
  image(imgR, 0, 0, w, h);
  popStyle();
  rHist.draw( 0, 0, w, h);
  stroke(c); 
  noFill();  
  rect( 0, 0, w, h);
  fill(255);
  noStroke();
  textSize(18);
  text(name, 4, 22);
  popStyle();
  popMatrix();
}

float[] appendArrayTail (float[] _array, float _val) {
  float[] array = _array;
  float[] tempArray = new float[_array.length-1];
  arrayCopy(array, 1, tempArray, 0, tempArray.length);
  array[tempArray.length] = _val;
  arrayCopy(tempArray, 0, array, 0, tempArray.length);
  return array;
}
