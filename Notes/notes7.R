##install req packages
#install.packages("tidyr")
install.packages("janitor")

##load req
library(tidyr)
library(janitor)
library(dplyr)

starwars
clean_names(starwars, case = "small_camel")
new_starwars <- clean_names(starwars, case = "screaming_snake")
clean_names(starwars, case = "upper_lower")

clean_names(new_starwars)

new_starwars <- rename(new_starwars, hair_color = haircolor)

##make a table of name and species of all femal starwars char by age
StarWarsWomen <- select(arrange(filter(starwars, sex == "female"), birth_year), name, species)

StarWarsWomen <- filter(starwars, sex == "female")
StarWarsWomen <- arrange(StarWarsWomen, birth_year)
StarWarsWomen <- select(StarWarsWomen, name, species)


##using pipes
StarWarsWomen <- starwars |> 
  filter(sex == "female") |> 
  arrange(birth_year) |>
  select(name, species)

slice_max(starwars, height, n=2, by = species, with_ties = F)

##Tidy data
table4a

pivot_longer(table4a,
             cols = c(`1999`, `2000`), 
             names_to = "year",
             values_to = "cases")

table4b # shows population data
##How would we pivot table4b to be in "tidy" format
tidy_table4b <- pivot_longer(table4b,
                             cols = c(`1999`, `2000`),
                             names_to = "Year",
                             values_to = "Pop.")

##pivot wider
table2

pivot_wider(table2,
            names_from = type,
            values_from = count)

##seperate
table3

separate(table3,
         rate,
         into = c("cases", "pop."))

##unite
table5

unite(table5,
      "year",
      c("century", "year"),
      sep = "")

tidy_table5 <- unite(table5,
                     "year",
                     c("century", "year"),
                     sep = "") |>
              separate(rate,
                      into = c("cases", "population"),
                      sep = "/")

##bind rows
new_data <- data.frame(country = "USA", year = "1999")

bind_rows(tidy_table5, new_data)
