# testFunc <- (x^2 + y - 11)^2 + (x + y^2 - 7)^2

CalculateFunction <- function(x,y,Function, optFor){
  Value <- eval(parse(text=Function))
  if (optFor == 0) {
    Value = -Value # invert
  }
  return(Value)
}

obtain_optimal <- function(x_min, x_max, y_min, y_max, imax, cmax, amin, temp, coolingParam, optFor, userFunction) { # function that takes all user inputs

  # defining dataframe
  # x: x value
  # y: y value
  # z: output of the function
  df <- data.frame(epoch = 0, x = 0, y = 0, z = 0)
  
  # number of epochs
  epn <- 0
  
    while (epn <= cmax) {
    a <- 0
    i <- 0
    
    # random initial x and y values
    x <- runif(1, min=x_min, max=x_max)
    y <- runif(1, min=y_min, max=y_max)
    
    while(i <= imax && a <= amin) {
      
      # random neighbouring values
      xn <- runif(1, min=max(x_min, x-0.5), max=min(x_max, x+0.5))
      yn <- runif(1, min=max(y_min, y-0.5), max=min(y_max, y+0.5))
      

      fxy <- CalculateFunction(x, y, userFunction, optFor)
      fnxy <- CalculateFunction(xn, yn, userFunction, optFor)
      
      # calculate energy change
      ec <- fxy - fnxy
      
      # generate random number r between 0 and 1
      r <-  runif(1, min=0, max=1)
      
      if (r<min(1, exp((-ec)/temp))) {
        x <- xn
        y <- yn
        # increment a and i
        a <- a+1
      }
      i <- i+1
    }
    # update temp
    temp <- coolingParam*temp
      
    # increment epoch
    if (a <= 0){
      epn <- epn+1
    }
    # populate dataframe
    df[epn, 1] <- epn
    df[epn, 2] <- x
    df[epn, 3] <- y
    df[epn, 4] <- CalculateFunction(x, y, userFunction, optFor)
    
  }
return(df)
}

# func <- "(x^2 + y - 11)^2 + (x + y^2 - 7)^2"

# result <- obtain_optimal(-2,2,-2,2,3,3,5,50,0.95,0,func)
# result$epoch

# plot(result$epoch, result$z)

