library(dplyr)
data(starwars, package = "dplyr")

# print the first few rows
head(starwars)

library(inspectdf)

# explore the categorical features 
x <- inspect_cat(starwars)
x

x %>% show_plot()

# return tibble showing columns types
x <- inspect_types(starwars)
x
x %>% show_plot()

#-------------------------------------------------------
data(storms, package = "dplyr")
inspect_cor(storms)

inspect_cor(storms) %>% show_plot()

inspect_num(storms, breaks = 10) %>%
  show_plot()
