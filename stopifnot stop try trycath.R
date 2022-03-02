# https://cran.r-project.org/web/packages/tryCatchLog/vignettes/tryCatchLog-intro.html

#Denial Of Service (DoS)
#Denial of service (DoS) attacks are employed in order to temporarily shut down a server or service by overwhelming it with traffic.
# https://www.rplumber.io/articles/security.html

function(pts=10) {
  if (pts > 1000 & pts > 0){
    stop("pts must be between 1 and 1,000")
  }
  
  plot(1:pts)
}

stop("something is wrong")


stopifnot(1 == 2)
warning("bad weather today, don't forget your umbrella")
message("good morning")

test <- function() {
  log("not a number")
  print("R does stop due to an error and never executes this line")
}


# Use try to ignore errors
# With the try function you can handle errors to continue the execution (by ignoring the error):
  
try(log("not a number"), silent = TRUE)
print("errors can't stop me")

# Use tryCatch to handle errors
# With tryCatch you can handle errors as you want:


{ # required to execute the code as one block to summarize the output in this Rmd
  f <- function() {
    warning("deprecated function called")
    print("Hello world")
  }
  f()
  print("Done")
}