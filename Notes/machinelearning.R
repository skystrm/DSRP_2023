##unsupervised learning ####
##PCA
head(iris)

##remove any non-numeric variables
iris_num <- select(iris, -Species)
iris_num

##do PCA
pcas <- prcomp(iris_num, scale. = T)
summary(pcas)
pcas$rotation

variancePercentages <- as.data.frame(pcas$rotation^2)
arrange(variancePercentages, desc(PC1))

##get x vals of PCAs and make it a data frame
pca_vals <- as.data.frame(pcas$x)
pca_vals$Species <- iris$Species

library(ggplot2)
ggplot(pca_vals, aes(PC1, PC2, color = Species)) +
  geom_point()+
  theme_minimal()


###uperviesed ML models

##load req pack
library(dplyr)

##Step one Collect data
head(iris)

##S2 clean and process data
##get rid of nas
#only use na.omit when you have specific variables for the model
noNAs <- na.omit(starwars)

noNAs <- filter(starwars, !is.na(mass))

#replaces with means
repwithMeans <- mutate(starwars,
                       mass = ifelse(is.na(mass),
                                     mean(mass),
                                     mass))

#encoding categories as factors or int
#if cat var is a char, make it a factor
intSpecies <- mutate(starwars,
                     species = as.integer(as.factor(species)))

#If cat vaiable is already a factor, make it an int
irisAllNumeric <- mutate(iris, 
                         Species = as.integer(Species))

##S3 visualize data
#make a PCA
# calculate correlations
library(reshape2)
library(ggplot2)

cor(irisAllNumeric)

irisCors <- cor(irisAllNumeric) |>
  melt() |>
  as.data.frame()

ggplot(irisCors, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white", 
                       midpoint = 0)

#high corr.?
ggplot(irisAllNumeric, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point() +
  theme_minimal()

#low corr.?
ggplot(irisAllNumeric, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point() +
  theme_minimal()

#S4 perform feature selectiom
#choose what var you wan to classify or predict
#choose which var you want to use as feature in your model
#for iris data..
#classify on species(Classification) and predict on sepal.length(regression)

##S5 separate data into testing and training sets
#Choose 70-85% of data to train on
library(rsample)

#set a seed for reproducibility
set.seed(71723)
##Put 75% of data into training set
reg_split <- initial_split(irisAllNumeric, prop = .75)
#use split to form testing and training sets
reg_train <- training(reg_split)
reg_test <- testing(reg_split)

##Class dataset splits(use iris instead of irisall numeric)
class_split <- initial_split(iris, prop = .75)

class_train <- training(class_split)
class_test <- testing(class_split)

#S6-7: choose a ml model and train it
library(parsnip)

#linear reg
lm_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ Petal.Length + Petal.Width + Species + Sepal.Width,
      data = reg_train)

##Sepal.Length = 2.3 + Petal.Length*0.7967 + Petal.Width*-0.4067  + 
#Species*-0.3312 + Sepal.Width*0.5501 

lm_fit$fit
summary(lm_fit$fit)


##Logistic reg
#for logistic reg
#1. filter data 2 only 2 groups in cat var of interest
#2.make cat vaiable a factor
#3. Make your training and testing results


#for our purposrd we are going to filter test and training data(dont do this)
binary_test_data <- filter(class_test, Species %in% c("setosa", "versicolor"))
binary_train_data <- filter(class_train, Species %in% c("setosa", "versicolor"))

#build the model
log_fit <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification") |>
  fit(Species ~ Petal.Width + Petal.Length + ., data = binary_train_data)

log_fit$fit
summary(log_fit$fit)


##Boosted Desicion tree
boost_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ ., data = reg_train)

boost_fit$fit$evaluation_log

#classification
#use "classification" as the mode and use Species as the predictor(ind.)
#use class_train for the data

boost_class_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("classification") |>
  fit(Species~ ., data = class_train)

boost_class_fit$fit$evaluation_log

##Random Forest
#reg
forest_reg_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ ., data = reg_train)

forest_reg_fit$fit

#class
forest_class_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("classification") |>
  fit(Species ~ ., data = class_train)

forest_class_fit$fit

##Step8 eval model performance on test set
#calc errors for regression
library(yardstick)
#lm_fit, boost_reg_fit, forest_reg_fit
reg_results <- reg_test

reg_results$lm_pred <- predict(lm_fit, reg_test)$.pred
reg_results$boost_pred <- predict(boost_fit, reg_test)$.pred
reg_results$forest_pred <- predict(forest_reg_fit, reg_test)$.pred

yardstick::mae(reg_results, Sepal.Length, lm_pred)
yardstick::mae(reg_results, Sepal.Length, boost_pred)
yardstick::mae(reg_results, Sepal.Length, forest_pred)

yardstick::rmse(reg_results, Sepal.Length, lm_pred)
yardstick::rmse(reg_results, Sepal.Length, boost_pred)
yardstick::rmse(reg_results, Sepal.Length, forest_pred)

#calc acc for class models
install.packages("Metrics")
library(Metrics)
class_results <- class_test

class_results$lm_pred <- predict(log_fit, class_test)$.pred_class
class_results$boost_pred <- predict(boost_class_fit, class_test)$.pred_class
class_results$forest_pred <- predict(forest_class_fit, class_test)$.pred_class

#f1(class_results$Species, class_results$log_pred)
#f1(class_results$Species, class_results$boost_pred)
#f1(class_results$Species, class_results$forest_pred)

class_results$Species == "setosa"
class_results$log_pred == "setosa"

f1(class_results$Species == "virginica", class_results$log_pred == "virginica")


