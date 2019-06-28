##================================================================================================
##                                                                                              
##    Nome: Programmatically generate REGEX Patterns in R without knowing Regex                                           
##                                                    
##    site: https://www.r-bloggers.com/programmatically-generate-regex-patterns-in-r-without-knowing-regex/                                                                                                                                                 ##
##    Objetivo:
##    prof. Steven Dutt-Ross                          
##    UNIRIO           
##================================================================================================
 

#devtools::install_github("VerbalExpressions/RVerbalExpressions")
strings = c('123Abdul233','233Raja434','223Ethan Hunt444')

library(RVerbalExpressions)
#Extract Strings
expr =  rx_alpha() 
stringr::str_extract_all(strings,expr) 

#Extract Numbers
expr =  rx_digit() 
stringr::str_extract_all(strings,expr)  

#Another Constructor to extract the name as a word
#Here, we can use the function rx_word() to match it as word (rather than letters).
expr =  rx_alpha()  %>%  rx_word() %>% rx_alpha() 
stringr::str_extract_all(strings,expr)

expr

#----------------------------------------------------------------------------------------


library(stringr)
#Extract characters that come after a specific character
#In this example, the goal is to extract alpha numeric characters that come after a @, including the @.

string <- "nowy commit, nowa przygoda @OSKI @data2 @pankote testujemy kod @oski2"

x <- rx() %>% 
  rx_find(value = "@") %>% 
  rx_alnum() %>% 
  rx_one_or_more()

x
str_extract_all(string, x)

#1. First, construct the verbal expression with rx
#2. Then, find the @ tag
#3. Then, match any alphanumeric characters (once)
#4. Then, match one or more alphanumeric characters (modifying the behavior in step 3)

#----------------------------------------------------------------------------------------
#Extract things between specific characters
#In this example, the goal is to extract everything between the word PRODUCT and OKAY.

string <- "PRODUCT colgate good but not goodOKAY"

x <- rx() %>% 
  rx_seek_prefix("PRODUCT") %>% 
  rx_anything() %>% 
  rx_seek_suffix("OKAY")

x

str_extract(string, x)
#----------------------------------------------------------------------------------------
#Extract things that contain two specific words
#In this example, the goal is to extract file names with the words “abc” and “clean” in them.

string <- c("abc_clean.csv", "abc_other_clean.csv", "abc_other_raw.csv", "abc_raw.csv",
            "abc_something_clean.csv", "abc_something_raw.csv", "def_clean.csv",
            "def_other_clean.csv", "def_other_raw.csv", "def_raw.csv", "def_something_clean.csv",
            "def_something_raw.csv")

x <- rx() %>% 
  rx_find("abc") %>% 
  rx_anything() %>% 
  rx_find("clean")

x

str_extract(string, x)
#----------------------------------------------------------------------------------------

#Match things that don’t start with specific characters
#In this example, the goal is to not match anything that starts with an “MS” and then remove the last two characters. Given the minimal reproducible example below, we could do this with a single pattern (second example) or by a pattern + a combination of stringr functions. Generally, I lean towards the latter.

string <- c('MSTRG.7176.1', 'MSTRG.7176.2', 'AT2G26340.2', 'AT2G26355.1')

x <- rx() %>% 
  rx_start_of_line() %>% 
  rx_not("MS") %>% 
  rx_anything()

str_extract(string, x) %>% 
  str_sub(1, str_count(x) - 2)

# or
x <- rx() %>% 
  rx_start_of_line() %>% 
  rx_not("MS") %>% 
  rx_anything_but(".")

x

str_extract(string, x)


#----------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------
