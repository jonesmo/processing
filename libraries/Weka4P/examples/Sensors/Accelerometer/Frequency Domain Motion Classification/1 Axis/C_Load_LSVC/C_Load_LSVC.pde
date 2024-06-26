//*********************************************
//  C_Load_LSVC : Load a Linear Support Vector Classifier model
//
//  Author:     Rong-Hao Liang <r.liang@tue.nl>
//  Edited by:  Wesley Hartogs <dev@wesleyhartogs.nl>
//
//  Version: 1.0.0 (22 06 2021)
//
//  Manual:
//  Drag the .model and .arff file into this sketch window or
//  copy the .model and .arff file to the data folder of this sketch.
//  Sketch -> Show Sketch Folder (ctrl/cmd + K)
//
//  You can generate your own model by using the TrainModel_LSVC_Mouse example  
//
//  The program will read a LSVC trained model and the .arff
//  and visualizes the model and shows you the prediction.
//
//*********************************************

import papaya.*;
import processing.serial.*;
Serial port; 

import Weka4P.*;
Weka4P wp;

int sensorNum = 1;                                                        //number of sensors in use
int streamSize = 500;                                                     //number of data to show
int[] rawData = new int[sensorNum];
float[][] sensorHist = new float[sensorNum][streamSize];                  //history data to show
float[][] diffArray = new float[sensorNum][streamSize];                   //diff calculation: substract
float[] modeArray = new float[streamSize];                                //To show activated or not
float[] thldArray = new float[streamSize];                                //diff calculation: substract


//segmentation parameters
float energyMax = 0;
float energyThld = 50;                                                    //use energy for activation
float[] energyHist = new float[streamSize];                               //history data to show

//FFT parameters
float sampleRate = 500;
int numBins = 65;
int bufferSize = (numBins-1)*2;

//Band pass filter
final int LOW_THLD = 2; 
final int HIGH_THLD = 64;                                                //high threshold of band-pass frequencies
int numBands = HIGH_THLD-LOW_THLD+1;
ezFFT[] fft = new ezFFT[sensorNum];                                      // fft per sensor
float[][] FFTHist = new float[numBands][streamSize];                     //history data to show

//visualization parameters
float fftScale = 5;

//window
int windowSize = 20;                                                     //The size of data window
float[][] windowArray = new float[numBands][windowSize];                 //data window collection
boolean b_sampling = false;                                              //flag to keep data collection non-preemptive
int sampleCnt = 0;                                                       //counter of samples
float[] X = new float[numBands];                                         //Form a feature vector X;

//Statistical Features
float[] windowM = new float[numBands];                                   //mean
float[] windowSD = new float[numBands];                                  //standard deviation

//Save
Table csvData;
boolean b_saveCSV = false;
String dataSetName = "A0VibTrain"; 
String[] attrNames;
boolean[] attrIsNominal;
int labelIndex = 0;

boolean bShowInfo = true;

String lastPredY = "";

void setDataType() {
  attrNames =  new String[numBands+1];
  attrIsNominal = new boolean[numBands+1];
  for (int j = 0; j < numBands; j++) {
    attrNames[j] = "f_"+j;
    attrIsNominal[j] = false;
  }
  attrNames[numBands] = "label";
  attrIsNominal[numBands] = true;
}


void setup() {
  size(500, 500, P2D);
  wp = new Weka4P(this);
  initSerial();
  for (int i = 0; i < sensorNum; i++) {                                //ezFFT(number of samples, sampleRate)
    fft[i] = new ezFFT(bufferSize, sampleRate);
  }
  for (int i = 0; i < streamSize; i++) {                               //Initialize all modes as null
    modeArray[i] = -1;
  }
  wp.loadTrainARFF("A0VibTrain.arff");                                 //load a ARFF dataset
  wp.loadModel("LinearSVC.model");                                     //load a pretrained model.
}

void draw() {
  background(255);
  energyMax = 0;                                                       //reset the measurement of energySum
  
  fft[0].updateFFT(sensorHist[0]);
  for (int j = 0; j < numBands; j++) {
    float x = fft[0].getSpectrum()[j+LOW_THLD];                        //get the energy of channel j
    if (x>energyMax) energyMax = x;                                    //check energyMax: the max energy of all channels
    appendArrayTail(FFTHist[j], x);                                    //update fft history

    
    if (b_sampling == true) {
      windowArray[j][sampleCnt-1] = x;                                  //windowed statistics
    }
  }
  

  if (energyMax>energyThld) {
    if (b_sampling == false) {                                          //if not sampling
      b_sampling = true;                                                //do sampling
      sampleCnt = 0;                                                    //reset the counter
      for (int j = 0; j < numBands; j++) {
        X[j] = 0;                                                       //reset the feature vector
        for (int k = 0; k < windowSize; k++) {
          (windowArray[j])[k] = 0;                                      //reset the window
        }
      }
    }
  }

  if (b_sampling == true) {
    ++sampleCnt;
    
    if (sampleCnt == windowSize) {
      for (int j = 0; j < numBands; j++) {
        windowM[j] = Descriptive.mean(windowArray[j]);                  //mean
        windowSD[j] = Descriptive.std(windowArray[j], true);            //standard deviation
        X[j] = max(windowArray[j]);
      }
      lastPredY = wp.getPrediction(X);
      double yID = wp.getPredictionIndex(X);
      for(int n = 0 ; n < windowSize ; n++){
        appendArrayTail(modeArray, (float)yID);
      }
      b_sampling = false;
    }
  } else {
    appendArrayTail(modeArray, -1);                                     //the class is null without mouse pressed.
  }

  appendArrayTail(energyHist, energyMax);                               //update energyMax history
  appendArrayTail(thldArray, energyThld);
  fft[0].drawSpectrogram(fftScale, 1024, true);

  barGraph(modeArray, 0, height, 0, height-100, 500., 50);

  lineGraph(energyHist, 0, height, 0, height-150, 500., 50, 0, color(0, 255, 0));
  lineGraph(thldArray, 0, height, 0, height-150, 500., 50, 0, color(128, 0, 255));

  for (int j = 0; j < numBands; j++) {
    float x = 60 + 80*(j%2);
    float y = height-180-(j)*fftScale;
    showInfo("X["+j+"] = "+nf(X[j], 0, 0), x, y, (int)fftScale*2);
  }
  String Y = lastPredY;
  showInfo("Prediction: "+Y, 320+20, 20,16);
  showInfo("Threshold: "+energyThld+" ([A]:+/[Z]:-)", 20, height-118, 18);
  drawFFTInfo(20, height-100, 18);
}




