library(reticulate)
conda_list(conda = "auto")
use_condaenv()

#----------------------------------------------------------
os <- import("os")
os$listdir(".")
#----------------------------------------------------------
#reticulate::conda_install(envname = NULL,'pandas')
pd <- reticulate::import('pandas', convert = FALSE)
np <- reticulate::import("numpy", convert = FALSE)
#-----------------------------------------------------------

#-----------------------------------------------------------
#Criando um vetor
#-----------------------------------------------------------
np1 <- np$array(c(1:4))
np1

#-----------------------------------------------------------
#Criando um  DataFrame 
#-----------------------------------------------------------
data("mtcars")
df<-reticulate::r_to_py(mtcars)
pd$df$drop([0, 1]) 
py$df$drop(0,1)

#-----------------------------------------------------------
library(dplyr)
df %>% r_to_py() %>% class()

#-----------------------------------------------------------
#{r}
#-----------------------------------------------------------
# convert R object into python 
#-----------------------------------------------------------
Python_in_Renv<- df %>% r_to_py()

#-----------------------------------------------------------
# check if the converted object lives in the `R` environment. 
#https://stackoverflow.com/questions/1169248/test-if-a-vector-contains-a-given-element
#-----------------------------------------------------------
"Python_in_Renv" %in% ls() 

#-----------------------------------------------------------
# convert python object into R 
#-----------------------------------------------------------
Python_in_Renv %>% py_to_r() %>% class()
#-----------------------------------------------------------


#-----------------------------------------------------------
#-----------------------------------------------------------
main <- import_main()
builtins <- import_builtins()


#-----------------------------------------------------------
# Getting Help
#-----------------------------------------------------------
os <- import("os")
py_help(os$chdir)
py_help(np$average)
py_help(pd$wide_to_long)
