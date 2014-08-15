corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  d1 = complete(directory)
  
  id = d1[d1["nobs"] > threshold, ]$id
  
  print(id)
    corr1 = numeric() 
  
    for (i in id) {
     
     files= read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), 
                              ".csv", sep = ""))
     d2 = files[complete.cases(files), ]
     
     corr1 = c(corr1, cor(d2$sulfate, d2$nitrate))
   }
   return(corr1)
}


