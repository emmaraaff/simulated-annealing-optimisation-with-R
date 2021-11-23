# A Simulated Annealing Optimisation Engine in R
This project provides code for a simple optimisation engine using the simulated annealing algorithm. A user dashboard was created using R Shiny to take in user inputs to be used in the simulated annealing code, and to output the optimal values for x, y and z (with z being the optimal function value) for a given user inputted function.

A good test function is Himmelbau's function, which is described here: https://en.wikipedia.org/wiki/Himmelblau%27s_function

It should be noted that this is a very basic implementation, and I am not sure if the simulated annealing algorithm works perfectly since I don't have a lot of knowledge about it. I'm uploading this code because I really struggled to find resources on implementing simulated annealing using R, so I am hoping this can help someone even if it's just a starting point.

## To run:
I recommend running in RStudio.
1. Run the simulated annealing algorithm code first (SA.R)
2. Then run app.R to run the R Shiny dashboard

**NB for those unfamiliar with R Shiny:** your code MUST be saved in a file named app.R, otherwise R won't know it's a Shiny app/dashboard and it won't run correctly. RStudio has some very helpful resources on R Shiny that helped me get started with the basic interface, for anyone interested: https://shiny.rstudio.com/. It's all free and open-source.
