
# Separate a collapsed column into multiple rows

library(tidyr)
df <- tibble(
  x = 1:3,
  y = c("a", "d,e,f", "g,h"),
  z = c("1", "2,3,4", "5,6")
)
df

separate_rows(df, y, z, convert = TRUE)