
library(modelsummary)
library(kableExtra)
library(gt)

url <- 'https://vincentarelbundock.github.io/Rdatasets/csv/HistData/Guerry.csv'
dat <- read.csv(url)

models <- list(
  "OLS 1"     = lm(Donations ~ Literacy + Clergy, data = dat),
  "Poisson 1" = glm(Donations ~ Literacy + Commerce, family = poisson, data = dat),
  "OLS 2"     = lm(Crime_pers ~ Literacy + Clergy, data = dat),
  "Poisson 2" = glm(Crime_pers ~ Literacy + Commerce, family = poisson, data = dat),
  "OLS 3"     = lm(Crime_prop ~ Literacy + Clergy, data = dat)
)

modelsummary(models)
modelsummary(models, output = "markdown")
modelsummary(models, output = "table.docx")
modelsummary(models, output = "table.tex")
modelsummary(models, output = "gt")
modelsummary(models, output = "kableExtra")
modelsummary(models, output = "flextable")
modelsummary(models, output = "huxtable")

modelsummary(models, fmt = 4)
# 4 digits and trailing zero
modelsummary(models, fmt = "%.4f")
# scientific notation
modelsummary(models, fmt = "%.4e")
# custom function with big mark commas
modelsummary(models, fmt = function(x) format(round(x, 0), big.mark=","))

options(OutDec=",")
# --------------------------------------------------------------
# http://www.danieldsjoberg.com/gtsummary/articles/gallery.html
# install.packages("gtsummary")
# --------------------------------------------------------------
library(gtsummary)
# build logistic regression model
m1 <- glm(response ~ age + stage, trial, family = binomial)
tbl_regression(m1)
tbl_regression(m1, exponentiate = TRUE)