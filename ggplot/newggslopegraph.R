#devtools::install_github("ibecav/CGPfunctions")

library(CGPfunctions)
library(tidyr)
library(dplyr)

newggslopegraph(newcancer,Year,Survival,Type)
data(newcancer)
head(newcancer)
