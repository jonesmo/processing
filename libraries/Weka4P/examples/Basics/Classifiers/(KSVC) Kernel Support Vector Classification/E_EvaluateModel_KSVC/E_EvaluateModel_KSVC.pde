//*********************************************
//  E_EvaluateModel_KSVC : Evaluates a model from training and test data.
//
//  Author:     Rong-Hao Liang <r.liang@tue.nl>
//  Edited by:  Wesley Hartogs <dev@wesleyhartogs.nl>
//
//  Version: 1.0.0 (17 03 2021)
//
//  Manual:
//  Drag both test and train .arrf files into this sketch window or
//  copy the .arff files to the data folder of this sketch.\
//  Also import the .model file
//  Sketch -> Show Sketch Folder (ctrl/cmd + K)
//
//  You can generate your own dataset and test dataset by using the CollectData_Mouse example  
//  You can generate your own model by using the TrainModel_KSVC example
//
//  The program will evaluate the model and reports its findings in the console.
//
//*********************************************

import Weka4P.*;                                       // Import the Weka4Processing library
Weka4P wp;                                             // Global Weka4P variable

void setup() {
  size(500, 500);
  wp = new Weka4P(this);                               // Initialize Weka4P object

  wp.loadTrainARFF("mouseTrain.arff");                 // Load a ARFF dataset
  wp.loadTestARFF("mouseTest.arff");                   // Load a ARFF dataset
  wp.loadModel("RBFSVC.model");                        // Load a pretrained model.
  wp.setModelDrawing(2);                               // Set the model visualization (for 2D features) with unit = 2
  wp.evaluateTestSet(false, true);                     // 5-fold cross validation
}
void draw() {
  wp.drawModel(0, 0);                                  // Draw the model visualization (for 2D features)
  wp.drawDataPoints(wp.test);                          // Draw the datapoints
  float[] X = {mouseX, mouseY};                        // Store the mouse coordinates in a array
  String Y = wp.getPrediction(X);                      // Predict the value
  wp.drawPrediction(X, Y);                             // Draw the prediction
}
