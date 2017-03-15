#########################################################################
### QUESTION 1
install.packages(c("AppliedPredictiveModeling", "caret"))
install.packages("dplyr")
install.packages("ElemStatLearn", "pgmm", "rpart")
install.packages("rattle", "rpart.plot")

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(dplyr)

unique(segmentationOriginal$Case)

train <- dplyr::filter(segmentationOriginal, Case == "Train")
test <- dplyr::filter(segmentationOriginal, Case == "Test")

set.seed(125)

fitModel <- train(Class ~ ., method = "rpart", data = train)

suppressMessages(library(rattle))
library(rpart.plot)
fancyRpartPlot(fitModel$finalModel)

#########################################################################
### QUESTION 3

library(pgmm)
data(olive)
olive = olive[,-1]

oliveModel <- train(Area ~ ., data = olive, method = "rpart")
newdata = as.data.frame(t(colMeans(olive)))

predict(oliveModel, newdata = newdata)
unique(olive$Area)

#########################################################################
### QUESTION 4

library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

colnames(SAheart)

set.seed(13234)
heartfit <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
                  method = "glm", family = "binomial", data = trainSA)

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

(missClass(testSA$chd, predict(heartfit, newdata = testSA)))
(missClass(trainSA$chd, predict(heartfit, newdata = trainSA)))


#########################################################################
### QUESTION 5

library(ElemStatLearn)
library(randomForest)
data(vowel.train)
data(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

set.seed(33833)

vowelfit <- randomForest(y ~ ., data = vowel.train)
order(varImp(vowelfit), decreasing = T)
