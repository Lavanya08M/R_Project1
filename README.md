# Iris Species Prediction using Support Vector Machine (SVM) in R

This repository contains a machine learning model built in R to predict the species of Iris flowers using Support Vector Machine (SVM). The dataset used for training and testing is the well-known Iris dataset.

## Overview

Support Vector Machine (SVM) is a supervised machine learning algorithm used for both classification and regression. SVM is particularly efficient in high-dimensional spaces and is well- suited for scenarios where
the data has clear margins of separation. In this project, SVM is employed to create a model capable of predicting the species of Iris flowers based on their sepal and petal characteristics.

## Dataset

The Iris dataset consists of measurements of sepal length, sepal width, petal length, and petal width for three different species of Iris flowers: setosa, versicolor, and virginica. The dataset is widely used for 
machine learning and statistical analysis.

## Files

- exploratory_data_iris.r: R script loads the Iris dataset, explores its structure and summary statistics, and creates a matrix of scatterplots to visualize relationships between variables, with points colored by 
                          species for differentiation.
- iris_classification_svm_models.r: R script provides a step-by-step walkthrough of the data preparation, model building, and evaluation processes. It concludes with insights drawn from the results obtained through 
                          different SVM kernels on the Iris dataset.

## Dependencies

- Required packages: 'e1071', 'caret', 'caTools', 'ggplot2'
  
  Install the required packages using the following commands: install.packages(c("e1071","caret","caTools","ggplot2"))
  
  

