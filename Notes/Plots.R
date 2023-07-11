#install req. packages
#install.packages("ggplot2")
install.packages(c("usethis", "credentials"))
#install.packages("dplyr")

##load req. packages
library(ggplot2)
library(dplyr)

## mpg dataset
Mpg <- ggplot2::mpg
str(Mpg)
?mpg

ggplot(data = Mpg, aes(x = hwy, y=cty)) +
  geom_point() +
  labs(x = "highway mpg",
       y = "city mpg",
       title = "car city vs highway milage")
##histogram
#we can set the number of bars with 'bins'
ggplot(data = iris, aes(x = Sepal.Length)) +
    geom_histogram(bins = 30) #default is 30

#we can set the size of bars with 'binwidth'
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = 0.25)

head(iris)

##density plots
ggplot(data = iris, aes(x=Sepal.Length, y = after_stat(count)))+
  geom_density()+
  labs(title = "Freq. of Iris Sepal Lengths",
       x = "SEPAL LENGTH",
       y = "numbers")

##box plots
ggplot(data = iris, aes(x = Sepal.Length)) +
  geom_boxplot()

ggplot(data = iris, aes(y = Sepal.Length)) +
  geom_boxplot()

ggplot(data = iris, aes(x = Sepal.Length, y = Species)) +
  geom_boxplot()

##violin and box plots
ggplot(data =iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(color = "lightseagreen", fill = "mediumturquoise") +
  geom_boxplot(width = 0.2, fill = "aquamarine") + #can add plots together and colors
  labs(title = "Dist. of Iris sepal lengths by species",
       x = "Species",
       y = "Sepal Length")

#differenating categories by color
ggplot(data =iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_violin() +
  geom_boxplot(width = 0.2, fill = "aquamarine") + #can add plots together and colors
  labs(title = "Dist. of Iris sepal lengths by species",
       x = "Species",
       y = "Sepal Length")

ggplot(data =iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(aes(fill=Species)) +
  geom_boxplot(width = 0.2, fill = "aquamarine") + #can add plots together and colors
  labs(title = "Dist. of Iris sepal lengths by species",
       x = "Species",
       y = "Sepal Length")

##bar plots
ggplot(data = iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_bar(stat = "summary",
           fun = "mean")

##scatter plots
ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_point()

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_jitter(width = 0.25)

ggsave("Plots/Example_jitterplot2")

##line plots
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()+
  geom_line()

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point() +
  geom_line(stat = "summary", fun = "mean")

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()+
  geom_smooth() #can remove grey section by adding se = F
  theme_minimal()  

##color scales
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point(aes(color = Species))
  scale_color_manual(values = c("yellow", "green", "lightblue"))


##factors
Mpg$year <- as.factor(Mpg$year)

iris$Species <- factor(iris$Species, levels = c("versicolor", "setosa", "virginica"))
  
  
  
  
  
  