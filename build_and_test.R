#!/usr/bin/env Rscript

# Build and test the plotR package

# Install required packages if not already installed
if (!require("devtools")) install.packages("devtools")
if (!require("htmlwidgets")) install.packages("htmlwidgets")
if (!require("jsonlite")) install.packages("jsonlite")
if (!require("magrittr")) install.packages("magrittr")

# Build and install the package
devtools::document()
devtools::install()

# Load the package
library(plotR)

# Test basic functionality
cat("Testing basic scatter plot...\n")
p1 <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist"))
    )
  ),
  data = cars
)
print(p1)

cat("\nPackage built and basic test completed!\n")
cat("You can now use the package with: library(plotR)\n")
cat("See inst/examples/basic_example.R for more examples.\n")