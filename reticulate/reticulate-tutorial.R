library(reticulate)
library(palmerpenguins)
library(dplyr)
library(ggplot2)
library(extrafont)

# https://nik.netlify.app/post/reticulate-tutorial/
# https://gist.github.com/nikdata/ce4c72550f184e6bc20d6c98475e5a5d

df_pgs <- palmerpenguins::penguins

dplyr::glimpse(df_pgs)

# number missing
df_pgs %>%
  purrr::map_df(function(x) sum(is.na(x))) %>%
  tidyr::pivot_longer(names_to = 'variable', cols = everything())

# number of unique values
df_pgs %>%
  purrr::map_df(function(x) n_distinct(x)) %>%
  tidyr::pivot_longer(names_to = 'variable', cols = everything())

# get count by group
df_pgs %>%
  group_by(species) %>%
  count()

# species count by island
df_pgs %>%
  group_by(island, species) %>%
  count()

# plotting
df_pgs %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species)) +
  scale_x_continuous(limits = c(30,60)) +
  scale_y_continuous(limits = c(12,22), breaks = seq(12,22,2)) +
  labs(x = "Bill Length (mm)", 
       y = "Bill Depth (mm)", 
       color = "Species",
       title = "Bill Depth vs Length",
       caption = "Source: {palmerpenguins} package") +
  theme(plot.title = element_text(family = "Bahnschrift", color = 'grey100'),
        plot.caption = element_text(family = "Bahnschrift", color = 'grey60'),
        axis.title = element_text(family = 'Bahnschrift', color = 'grey100'),
        axis.text.x = element_text(family = "Bahnschrift", color = 'grey70'),
        axis.text.y = element_text(family = "Bahnschrift", color = 'grey70'),
        plot.background = element_rect(fill = 'grey10'),
        panel.background = element_blank(),
        panel.grid.major = element_line(color = 'grey30', size = 0.2),
        panel.grid.minor = element_line(color = 'grey30', size = 0.2),
        legend.background =  element_rect(fill = 'grey20'),
        legend.key = element_blank(),
        legend.title = element_text(family = 'Bahnschrift', color = 'grey80'),
        legend.text = element_text(family = "Bahnschrift", color = 'grey90'),
        legend.position = c(0.9, 0.2)
  )

df_pgs %>%
  ggplot(aes(x = sex, y = body_mass_g)) +
  geom_boxplot(aes(fill = species), color = 'steelblue') +
  labs(x = "Sex", 
       y = "Body Mass (grams)", 
       title = "Body Mass of Species by Sex", 
       caption = 'Source: {palmerpenguins} package') +
  theme(plot.title = element_text(family = "Bahnschrift", color = 'grey100'),
        plot.caption = element_text(family = "Bahnschrift", color = 'grey60'),
        axis.title = element_text(family = 'Bahnschrift', color = 'grey100'),
        axis.text.x = element_text(family = "Bahnschrift", color = 'grey70'),
        axis.text.y = element_text(family = "Bahnschrift", color = 'grey70'),
        plot.background = element_rect(fill = 'grey10'),
        panel.background = element_blank(),
        panel.grid.major = element_line(color = 'grey30', size = 0.2),
        panel.grid.minor = element_line(color = 'grey30', size = 0.2),
        legend.background =  element_rect(fill = 'grey20'),
        legend.key = element_blank(),
        legend.title = element_text(family = 'Bahnschrift', color = 'grey80'),
        legend.text = element_text(family = "Bahnschrift", color = 'grey90'),
        legend.position = c(0.90, 0.9)
  )

# values are already encoded as factors
# want to use recipes and SKLEARN for modeling

# split into training/test
set.seed(1337)
pg_split <- rsample::initial_split(df_pgs, prop = 0.75)
pg_train <- rsample::training(pg_split)
pg_test <- rsample::testing(pg_split)

# define recipe
base_recipe <- recipes::recipe(species ~ ., data = pg_train) %>%
  recipes::step_mutate(tmp_species = species) %>%
  recipes::step_meanimpute(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g, id = 'impute_missing_continuous') %>%
  recipes::step_factor2string(sex) %>%
  recipes::step_mutate(sex = ifelse(is.na(sex),'unknown',sex)) %>%
  recipes::step_string2factor(sex, levels = c('male','female','unknown')) %>%
  recipes::step_dummy(sex, one_hot = TRUE, levels = c('male','female','unknown'), preserve = TRUE) %>%
  recipes::step_integer(species, strict = TRUE, id = 'label encode response variable') %>%
  recipes::step_dummy(island, id = 'sparse encoding of islad variable', one_hot = TRUE, levels = c('Biscoe','Dream','Torgersen'), preserve = TRUE) %>%
  recipes::prep(training = pg_train)

base_recipe
summary(base_recipe)

# juice the recipe

cln_train <- recipes::juice(base_recipe)
cln_test <- recipes::bake(base_recipe, pg_test)

# imbalnce?
cln_train %>%
  group_by(tmp_species, species) %>%
  count()

cln_train %>%
  group_by(island, tmp_species, species) %>%
  count()

glimpse(cln_train)
glimpse(cln_test)

# import sklearn & smote
pysmote_over <- reticulate::import('imblearn.over_sampling')
pysmote_under <- reticulate::import('imblearn.under_sampling')
pysmote_pipe <- reticulate::import('imblearn.pipeline')

sklearn_modelselection <- reticulate::import('sklearn.model_selection')
sklearn_ensemble <- reticulate::import('sklearn.ensemble')
sklearn_metrics <- reticulate::import('sklearn.metrics')

# rebalance the dataset
cln_train %>%
  group_by(species, tmp_species) %>%
  count()

over <- pysmote_over$SMOTE(sampling_strategy = reticulate::dict('Chinstrap' = 100L, 'Gentoo' = 100L))
under <- pysmote_under$RandomUnderSampler(sampling_strategy = reticulate::dict('Adelie' = 100L))

steps <- list(c('o', over), c('u', under))
pipeline <- pysmote_pipe$Pipeline(steps = steps)

df_rebal <- pipeline$fit_resample(X = cln_train %>% select(-tmp_species, -island, -sex), y = cln_train %>% select(tmp_species))

nb_pred <- as_tibble(df_rebal[[1]])
nb_resp <- as_tibble(df_rebal[[2]])

cln_bal <- bind_cols(nb_resp, nb_pred)

cln_bal %>%
  group_by(tmp_species, species) %>%
  count()

# define the hypertuning parameter grid

param_grid <- reticulate::dict('bootstrap' = list(TRUE),
                               'max_depth' = seq(1L,4L,1L),
                               'max_features' = seq(2L,6L,1L),
                               'min_samples_split' = seq(2L,5L,1L),
                               'n_estimators' = c(250L, 500L))

rf_mdl <- sklearn_ensemble$RandomForestClassifier()

grid_search <- sklearn_modelselection$GridSearchCV(estimator = rf_mdl,
                                                   param_grid = param_grid,
                                                   cv = 5L,
                                                   n_jobs = -1L,
                                                   verbose = 2L,
                                                   scoring = 'accuracy',
                                                   refit = TRUE)

grid_search$fit(X = cln_bal %>% select(-tmp_species, -species), y = cln_bal$species)


grid_search$best_params_

best_grid = grid_search$best_estimator_

# make train/test predictions

ypred_train <- best_grid$predict(cln_train %>% select(-island, -tmp_species, -sex, -species))
ypred_test <- best_grid$predict(cln_test %>% select(-island, -tmp_species, -sex, -species))

# sklearn metrics

sklearn_metrics$accuracy_score(y_true = cln_train$species, y_pred = ypred_train)
sklearn_metrics$f1_score(cln_train$species, ypred_train, average = 'weighted')

sklearn_metrics$accuracy_score(y_true = cln_test$species, y_pred = ypred_test)
sklearn_metrics$f1_score(cln_test$species, ypred_test, average = 'weighted')
