library(datasets) # Load datasets
library(ggplot2) # Using ggplot2 for kernel density plots and non-parametric smoothers
# Load iris dataset
data(iris)

# iris variable contains iris data
iris<-datasets::iris

# view the data
View(iris)

# head() / tail()
head(iris,4)
tail(iris,4)

# structure of iris data
str(iris)

# summary of iris data
summary(iris)

# summary of Sepal.Length variable from iris dataset
summary(iris$Sepal.Length) #Sepal.Width/Petal.Length/Petal.Width

# Finding missing values in the iris dataset
sum(is.na(iris))

# skimr() - expands on summary() by providing larger set of statistics
# install.packages("skimr")
library(skimr)

skim(iris) # Perform skim to display summary statistics

# Group data by Species then perform skim
iris %>%
  dplyr::group_by(Species) %>%
  skim()

###########################################################################################
#                                                                                         #
# Data Visualization                                                                      #
#                                                                                         #
# Exploring Relationships between multiple variables                                      #
#                                                                                         #
# The 'ggpairs()' function is a part of the 'GGally' package, used to create a matrix of  #
# scatterplots and other pairwise plots for multiple variables in a dataset.              #
#                                                                                         #
###########################################################################################

# install.packages("GGally")
library(GGally)
ggpairs(iris, ggplot2::aes(colour = Species, alpha = 0.5))



