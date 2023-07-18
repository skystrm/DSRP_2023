##compare the mass of male and female starwars char
##null hypo: avg mass of male and fem char is the same
##alt hypo: avg mass of M and F is diff
swHumans <- starwars |> filter(species == "Human", mass > 0)
males <- swHumans |> filter(sex == "male")
females <- swHumans |> filter(sex == "female")

t.test(males$mass, females$mass, paired = F)
#p val is 0.06
#insignificant, failed to reject null hypo


##Anova
iris
anova_results <- aov(data = iris, Sepal.Length ~ Species)

#Are any group diff from each other
summary(anova_results)

##Which ones?
TukeyHSD(anova_results)


##is there a sig. diff in petal length or width by species
anova_petall_results <- aov(data=iris, Petal.Length ~ Species)
summary(anova_petall_results)
TukeyHSD(anova_petall_results)


##Starwars
head(starwars)
unique(starwars$species)

##which 5 species are the most common
t3species <- starwars |>
  summarize(.by = species,
            count = sum(!is.na(species))) |>
  slice_max(count, n=3)

t3species

starwars_t3species <-starwars |>
  filter(species %in% t3species$species)

starwars_t3species

##Is there a sig. diff in mass of each species
a <- aov(data = starwars_t3species, height ~ species)
summary(a)
TukeyHSD(a)

##Chi-squared
t <- table(starwars$spe)

t <- table(mpg$year, mpg$drv)
chisq_result <- chisq.test(t)
chisq_result
chisq_result$p.value
chisq_result$residuals

#install.packages("corrplot")
library(corrplot)

corrplot(chisq_result$residuals)


##chi-sqaured full analysis
heroes <- read.csv("Data/heroes_information.csv")
head(heroes)

##clean data
heroes_clean <- heroes |>
  filter(Alignment != "-",
         Gender != "-")

##plot the counts of alignment and gender
ggplot(heroes_clean, aes(x= Gender, y = Alignment)) +
  geom_count() +
  theme_minimal()

##make contingency tabl
t <- table(heroes_clean$Alignment, heroes_clean$Gender)
t

##chi squared test
chi <- chisq.test(t)
chi$p.value
chi$residuals

corrplot(chi$residuals, is.cor = F)



