#install.packages("usethis")
library(usethis)
edit_rstudio_snippets()

# Recoding variables
# create 2 age categories
mydata <- ifelse(mydata > 70, c("older"), c("younger"))
# another example: create 3 age categories
attach(mydata)
mydata[age > 75] <- "Elder"
mydata[age > 45 & age <= 75] <- "Middle Aged"
mydata[age <= 45] <- "Young"
detach(mydata)


https://sites.google.com/site/pessoad/ensino