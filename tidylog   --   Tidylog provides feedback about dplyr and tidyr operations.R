
#devtools::install_github("elbersb/tidylog")
library(dplyr)
data("mtcars")
a <- filter(mtcars, mpg > 20)
#> filter: removed 18 rows (56%), 14 rows remaining
b <- filter(mtcars, mpg > 100)
#> filter: removed all rows (100%)
c <- filter(mtcars, mpg > 0)
#> filter: no rows removed
d <- filter_at(mtcars, vars(starts_with("d")), any_vars((. %% 2) == 0))
#> filter_at: removed 19 rows (59%), 13 rows remaining
e <- distinct(mtcars)
#> distinct: no rows removed
f <- distinct_at(mtcars, vars(vs:carb))
#> distinct_at: removed 18 rows (56%), 14 rows remaining
g <- top_n(mtcars, 2, am)
#> top_n: removed 19 rows (59%), 13 rows remaining
i <- sample_frac(mtcars, 0.5)
#> sample_frac: removed 16 rows (50%), 16 rows remaining


library(tidylog)
