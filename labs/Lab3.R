library(ggplot2)

getwd() #get working directory
ep <- read.csv("data/NASAExoplanets.csv")
ep <- na.omit(ep)

#1 plot
ggplot(data = ep, aes(x = stellar_magnitude)) +
  geom_histogram(bins = 20, color = "blue", fill = "skyblue") +
  labs(title = "exoplanet stellar magnitude",
       x = "stellar magnitude",
       y = "# of planets in range")

#2 plot
ggplot(data = ep, aes(x = planet_type, y = stellar_magnitude, fill = planet_type)) +
  geom_bar(stat = "summary",
           fun = "mean") 

#3 plot
ggplot(data = ep, aes(x = orbital_radius, y = orbital_period)) +
  geom_smooth() +
  labs(title = "exoplanet orbital radius vs orbital period")
