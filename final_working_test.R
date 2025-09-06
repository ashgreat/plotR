#!/usr/bin/env Rscript

# Final working test for plotR

cat("Loading plotR standalone version...\n")
source("/Users/malshe/Dropbox/Work/JS/plot/plotR/standalone_plotR.R")

library(htmlwidgets)

cat("Creating a simple test plot...\n")
p <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist", fill = "steelblue", r = 5))
    ),
    grid = TRUE,
    width = 600,
    height = 400,
    marginLeft = 50,
    marginBottom = 40
  ),
  data = cars
)

cat("Saving plot to final_test.html...\n")
saveWidget(p, "final_test.html", selfcontained = TRUE)

cat("Plot saved! The HTML should now work with both D3 and Plot libraries.\n")
cat("Open final_test.html in your browser.\n")
cat("Also try test_with_d3.html to verify the libraries work directly.\n")