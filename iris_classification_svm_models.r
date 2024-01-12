# Import libraries
library(datasets) # Contains the Iris dataset
library(caret) # caret Package is used for Machine Learning Algorithms (caret-Classification and Regression Training)
library(caTools) # This package is used for splitting the data set
library(e1071) # svm() function

#Load the iris data set
data(iris)

#Finding sum of missing values in iris dataset
sum(is.na(iris))

# set.seed() function helps in creating the same random numbers each time a random function is called.
set.seed(100)

# Splitting the iris data set into training data and testing data
sample <- sample.split(iris$Species, SplitRatio = 0.8) #Training data = 80%, testing data = 20% of the iris data
View(sample)
train_data <- subset(iris,sample == TRUE)
test_data <- subset(iris,sample == FALSE)
View(train_data)
View(test_data)

# plots of training data
plot(train_data)
featurePlot(x = train_data[,1:4], y = train_data$Species, plot = "box")

# plots of testing data
plot(test_data)
featurePlot(x = test_data[,1:4], y = test_data$Species, plot = "box")

##############################################################################

# svm Linear Model

# Create a trainControl object for 10-fold cross-validation
trainParams <- trainControl(method="cv", number = 10)

# Define the hyperparameter grid
hyperparameter_grid <- expand.grid(C = 2^seq(-6,4))

# Building CV (cross validation) Model for svmLinear
model.cv.linear <- train(Species~., 
                  data = train_data, 
                  method = "svmLinear", 
                  na.action=na.omit, 
                  preProcess = c("scale","center"),
                  trControl = trainParams,
                  tuneGrid = hyperparameter_grid)
print(summary(model.cv.linear))
print(model.cv.linear$bestTune$C)

# svm model for kernel = linear
svm.model.linear <- svm(Species~., data=train_data, kernel="linear", cost=model.cv.linear$bestTune$C)
print(svm.model.linear)

# Linear model performance on training data
svm.model.linear.prediction.train <- predict(svm.model.linear,train_data)
confusionMatrix(table(Prediction=svm.model.linear.prediction.train, Actual = train_data$Species))
##                                      Output:
##Confusion Matrix and Statistics
##
##              Actual
## Prediction   setosa versicolor virginica
## setosa         40          0         0
## versicolor      0         40         1
## virginica       0          0        39
## 
## Accuracy : 0.9917          
          

# Linear model performance on testing data
svm.model.linear.prediction.test <- predict(svm.model.linear,test_data)
confusionMatrix(table(Prediction=svm.model.linear.prediction.test, Actual = test_data$Species))
##                                    Output:
## Confusion Matrix and Statistics
##
##              Actual
## Prediction   setosa versicolor virginica
## setosa         10          0         0
## versicolor      0          9         0
## virginica       0          1        10
## 
## Accuracy : 0.9667 
################################################################################################

# SVM Polynomial Model

#Hyperparameter grid for polynomial svm
hyperparameter_grid <- expand.grid(C = 2^seq(-6,4), scale = c(1, 0.1), degree = 1)

# Building CV (cross validation) Model for svmPoly
model.cv.poly <- train(Species~., 
                  data = train_data, 
                  method = "svmPoly", 
                  na.action=na.omit, 
                  preProcess = c("scale","center"),
                  trControl = trainParams,
                  tuneGrid = hyperparameter_grid)
print(model.cv.poly)
print(model.cv.poly$bestTune$C)

# svm model for kernel = polynomial
svm.model.poly <- svm(Species~., data=train_data, kernel="polynomial", cost=model.cv.poly$bestTune$C)
print(svm.model.poly)

# Polynomial svm model performance on training data
svm.model.poly.prediction.train <- predict(svm.model.poly,train_data)
confusionMatrix(table(Prediction=svm.model.poly.prediction.train, Actual = train_data$Species))
## Confusion Matrix and Statistics
## 
## Actual
## Prediction   setosa versicolor virginica
## setosa         40          0         0
## versicolor      0         40         7
## virginica       0          0        33
## 
## Overall Statistics
## 
## Accuracy : 0.9417    


# Polynomial svm model performance on testing data
svm.model.poly.prediction.test <- predict(svm.model.poly,test_data)
confusionMatrix(table(Prediction=svm.model.poly.prediction.test, Actual = test_data$Species))
##                                Output:
## Confusion Matrix and Statistics
## 
## Actual
## Prediction   setosa versicolor virginica
## setosa         10          0         0
## versicolor      0         10         4
## virginica       0          0         6
## 
## Accuracy : 0.8667   
###############################################################################################

# SVM Radial Model

# Hyperparameter grid for svm radial
hyperparameter_grid <- expand.grid(C = 2^seq(-6,4), sigma = c(0.01,0.1,1,2,3))

# Building CV (cross validation) Model for svmRadial
model.cv.radial <- train(Species~., 
                       data = train_data, 
                       method = "svmRadial", 
                       na.action=na.omit, 
                       preProcess = c("scale","center"),
                       trControl = trainParams,
                       tuneGrid = hyperparameter_grid)
print(model.cv.radial)
print(model.cv.radial$bestTune$C)

# svm model for kernel = radial
svm.model.radial <- svm(Species~., data=train_data, kernel="radial", cost=model.cv.radial$bestTune$C)
print(svm.model.radial)

# Radial svm model performance on training data
svm.model.radial.prediction.train <- predict(svm.model.radial,train_data)
confusionMatrix(table(Prediction=svm.model.radial.prediction.train, Actual = train_data$Species))
##                               Output:
## Confusion Matrix and Statistics
## 
## Actual
## Prediction   setosa versicolor virginica
## setosa         40          0         0
## versicolor      0         40         1
## virginica       0          0        39
## 
## Accuracy : 0.9917          


# Radial svm model performance on testing data
svm.model.radial.prediction.test <- predict(svm.model.radial,test_data)
confusionMatrix(table(Prediction=svm.model.radial.prediction.test, Actual = test_data$Species))
##                                Output:
## Confusion Matrix and Statistics
## 
## Actual
## Prediction   setosa versicolor virginica
## setosa         10          0         0
## versicolor      0          8         2
## virginica       0          2         8
## 
## Accuracy : 0.8667 



#############################################################################################
# Analyzing Results:

# Linear Model:
# training data - Accuracy - 99.17%
# testing data - Accuracy - 96.67%
# Good Performance on training and testing data, indicating generalization

# Polynomial Model:
# training data - Accuracy - 94.17%
# testing data - Accuracy - 86.67%
# Slight drop in performance on the testing set compared to the training set

# Radial Model:
# training data - Accuracy - 99.17%
# testing data - Accuracy - 86.67%
# Slight drop in performance on the testing set compared to the training set

# The Polynomial and Radial models show a slight decrease in accuracy on the testing set 
# compared to the training set, indicating some level of overfitting or suboptimal generalization.
# Therefore, Linear svm model is the best model among the three models.

####################################################################################################


# Feature Importance
importance <- varImp(model.cv.linear)
plot(importance)
plot(importance, col = "pink")
