


# devtools::install_github("msberends/cleaner")
library(cleaner)
ls(package:cleaner)

gender_age <- c("male 0-50", "male 50+", "female 0-50", "female 50+")
gender_age
clean_factor(gender_age, levels = c("M", "F"))
clean_factor(gender_age, levels = c("Male", "Female"))
clean_factor(gender_age, levels = c("0-50", "50+"), ordered = TRUE)
#You can also name your levels to let them match your values. 
#They support regular expressions too:

clean_factor(gender_age, levels = c("female" = "Group A",
                                    "male 50+" = "Group B",
                                    ".*" = "Other"))
clean_numeric(c("$ 12,345.67","€ 12.345,67","12,345.67","12345,67"))
clean_numeric("qwerty123456")
clean_numeric("Positive (0.143)")


clean_character("qwerty123456")
clean_character("Positive (0.143)")
clean_character(x = c("Model: Pro A1          ",
                      "Model specified: Pro A1",
                      "       Pro A1          "), remove = "^.*:")


freq(unclean$gender)
freq(clean_factor(unclean$gender,levels = c("^m" = "Male", "^f" = "Female")))


# Create a vector with 500,000 items
n <- 500000
values <- paste0(sample(c("yes", "no"), n, replace = TRUE),
                 as.integer(runif(n, 0, 10000)))
clean_logical(values[1:3])
clean_character(values[1:3])
clean_numeric(values[1:3])

clean_character("0123test 0123[a-b] ")
clean_character("0123test 0123[a-b] ", remove = "[a-b]")
clean_character("0123test0123", remove = "[a-b")
