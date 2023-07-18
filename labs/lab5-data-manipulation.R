getwd() #get working directory
ep <- read.csv("data/NASAExoplanets.csv")
ep <- na.omit(ep)
View(ep)
ep <- filter(ep, discovery_year >= 2010)
ep_orbit <- select(ep, name, planet_type, orbital_radius, orbital_period, eccentricity)
View(ep_orbit)
ep_rorbit <- mutate(ep_orbit,
                    orbit_sec = orbital_period*3.156*10^7,
                    orbit_year = orbit_sec/31557600)
View(ep_rorbit)
summarize(ep_rorbit,
          mean_pd = mean(orbital_period, na.rm = TRUE),
          count = n(),
          .by = planet_type)
ep_rorbit <- arrange(ep_rorbit, planet_type)
ggplot(data = ep_rorbit, aes(x = planet_type, y = eccentricity, fill = planet_type)) +
  geom_bar(stat = "summary",
           fun = "mean")


