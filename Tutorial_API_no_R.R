# install.packages(c("httr", "jsonlite"))
# https://www.dataquest.io/blog/r-api-tutorial/

library(httr)
library(jsonlite)

res = GET("http://api.open-notify.org/astros.json")
res
# The number 200 is what we want to see; it corresponds to a successful request,

rawToChar(res$content)

data <- fromJSON(rawToChar(res$content))
names(data)

data$people

# APIs and Query Parameters
# Let's use this API to find out when the ISS will be passing over the Brooklyn Bridge (which is at roughly latitude 40.7, longitude: -74):
res = GET("http://api.open-notify.org/iss-pass.json",
    query = list(lat = 40.7, lon = -74))

# Checking the URL that gets used in the API request yields
# http://api.open-notify.org/iss-pass.json?lat=40.7&lon=-74


res = GET("http://api.open-notify.org/iss-pass.json",
          query = list(lat = 40.7, lon = -74))
data = fromJSON(rawToChar(res$content))
data$response


#You've Got the Basics of APIs in R!
#In this tutorial, we learned what an API is, and how they can be useful to data analysts and data scientists.
#Using our R programming skills and the httr and jsonlite libraries, we took data from an API and converted it into a familiar format for analysis. 