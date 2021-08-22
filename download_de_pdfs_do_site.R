https://tidytuesday.netlify.app/posts/2021-08-18-star-trek-voice-commands/
  


library("pdftools")
library("glue")
library("tidyverse")

month <- c("January", "February", "March", "April", "May", "June", "July",
           "August", "September", "October", "November", "December")

year <- c("2013", "2014", "2015", "2016", "2017")

# Creates a String of the URL Addresses
urls <- 
  tidyr::expand_grid(month, year) %>%
  glue_data("http://www.understandingwar.org/sites/default/files/AfghanistanOrbat_{month}{year}.pdf")


# Creates Names for the PDF Files 
pdf_names <- 
  tidyr::expand_grid(month, year) %>%
  glue_data("orbat-report-{month}-{year}.pdf")

safe_download <- safely(~ download.file(.x , .y, mode = "wb"))
walk2(urls, pdf_names, safe_download)

#purrr::safely() is one option here. 
#If you wrap download.file() in safely(), it will skip over the errors and continue iterating over each of the urls. 
#In this case, you don't care about what is returned, so safely() just skips the files that aren't found. 
#If you are storing the results of a call wr… 
#https://community.rstudio.com/t/download-multiple-files-using-download-file-function-while-skipping-broken-links-with-walk2/51222

#---------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------

#"https://inteligencia.insightnet.com.br/pdfs/93.pdf
dir.create("insight_inteligencia")

library(glue)
numeros<- 1:93
origem<-glue("https://inteligencia.insightnet.com.br/pdfs/{numeros}.pdf")
destino <-paste0(glue(getwd(),"/insight_inteligencia/{numeros}.pdf"))

#for(i in seq_along(origem)){
#  download.file(origem[i], destino[i], mode="wb")
#}

#purrr::safely() is one option here. 
#If you wrap download.file() in safely(), it will skip over the errors and continue iterating over each of the urls. 
#In this case, you don't care about what is returned, so safely() just skips the files that aren't found. 

library(purrr)
safe_download <- safely(~ download.file(.x, .y, mode = "wb"))
walk2(origem, destino, safe_download)



