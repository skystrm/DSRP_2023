getwd() #get working directory
ep <- read.csv("data/NASAExoplanets.csv")
ep <- na.omit(ep)

ep_num <- select(ep, -name, -planet_type, -mass_wrt, -radius_wrt, -detection_method)
pcas <- prcomp(ep_num, scale. = T)
summary(pcas)
pcas$rotation^2
pca_vals <- as.data.frame(pcas$x)
pca_vals$planet_type <- ep$planet_type
pca_vals$mass_wrt <- ep$mass_wrt
pca_vals$radius_wrte <- ep$radius_wrt
pca_vals$detection_method <- ep$pdetection_method

library(ggplot2)
ggplot(pca_vals, aes(PC1, PC2, color = planet_type)) +
  geom_point()+
  theme_minimal()

epAllNumeric <- mutate(ep_num, 
                         pn = as.integer(as.factor(ep$planet_type)))

epCors <- cor(epAllNumeric) |>
  melt() |>
  as.data.frame()

ggplot(epCors, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white", 
                       midpoint = 0)

#linear reg
set.seed(71723)
reg_split <- initial_split(epAllNumeric, prop = .75)
reg_train <- training(reg_split)
reg_test <- testing(reg_split)

eplm_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(stellar_magnitude ~ eccentricity + distance + .,
      data = reg_train)

eplm_fit$fit
summary(eplm_fit$fit)
reg_results <- reg_test
reg_results$lm_pred <- predict(eplm_fit, reg_test)$.pred
yardstick::mae(reg_results, stellar_magnitude, lm_pred)
yardstick::rmse(reg_results, stellar_magnitude, lm_pred)

#boosted decision tree
set.seed(71723)
epbdt_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(stellar_magnitude ~ eccentricity + distance + .,
      data = reg_train)
epbdt_fit$fit
summary(eplm_fit$fit)
reg_results <- reg_test
reg_results$boost_pred <- predict(epbdt_fit, reg_test)$.pred
yardstick::mae(reg_results, stellar_magnitude, boost_pred)
yardstick::rmse(reg_results, stellar_magnitude, boost_pred)
