#!/usr/bin/env Rscript

# Test the final fix with local D3 dependency

cat("Loading plotR with fixed dependencies...\n")
source("/Users/malshe/Dropbox/Work/JS/plot/plotR/standalone_plotR.R")

library(htmlwidgets)

cat("Creating test plot...\n")
p <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist", fill = "steelblue", r = 6))
    ),
    grid = TRUE,
    width = 600,
    height = 400,
    marginLeft = 60,
    marginBottom = 50
  ),
  data = cars
)

cat("Saving to test_fixed.html...\n")
saveWidget(p, "test_fixed.html", selfcontained = TRUE)

# Also create a more complex example
cat("Creating complex example...\n")
p2 <- plot_chart(
  spec = list(
    marks = list(
      plot_gridY(),
      plot_dot(options = list(
        x = "wt", 
        y = "mpg", 
        fill = "cyl",
        r = 5
      )),
      plot_line(options = list(
        x = "wt",
        y = "mpg",
        stroke = "red",
        strokeWidth = 2
      ))
    ),
    width = 700,
    height = 500,
    marginLeft = 60,
    marginBottom = 50,
    color = list(scheme = "category10")
  ),
  data = mtcars
)

saveWidget(p2, "test_complex.html", selfcontained = TRUE)

cat("\nFiles created:\n")
cat("  - test_fixed.html (simple scatter plot)\n")
cat("  - test_complex.html (multi-mark plot)\n")
cat("\nThese should now work with both D3 and Plot included!\n")