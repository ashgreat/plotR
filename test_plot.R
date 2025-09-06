#!/usr/bin/env Rscript

# Test the plotR package with HTML output

# Load required libraries
library(plotR)
library(htmlwidgets)

# Create a simple scatter plot
p1 <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist"))
    ),
    grid = TRUE,
    marginLeft = 50,
    marginBottom = 50
  ),
  data = cars,
  width = 600,
  height = 400
)

# Save to HTML file
htmlwidgets::saveWidget(p1, "test_plot.html", selfcontained = TRUE)
cat("Plot saved to test_plot.html\n")
cat("Open this file in a web browser to see the visualization.\n")

# Create a more complex example
p2 <- plot_chart(
  spec = list(
    marks = list(
      plot_gridY(),
      plot_gridX(),
      plot_dot(options = list(
        x = "wt", 
        y = "mpg", 
        fill = "cyl",
        r = 5
      )),
      plot_axisX(options = list(label = "Weight")),
      plot_axisY(options = list(label = "Miles per Gallon"))
    ),
    color = list(
      type = "ordinal",
      scheme = "category10"
    ),
    marginLeft = 60,
    marginBottom = 50,
    marginTop = 20,
    marginRight = 20
  ),
  data = mtcars,
  width = 700,
  height = 500
)

# Save second example
htmlwidgets::saveWidget(p2, "test_plot_mtcars.html", selfcontained = TRUE)
cat("Second plot saved to test_plot_mtcars.html\n")

# Test in RStudio viewer if available
if (interactive()) {
  print(p1)
  Sys.sleep(2)
  print(p2)
}