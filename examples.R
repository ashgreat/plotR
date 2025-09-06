# Comprehensive examples for plotR package

library(plotR)
library(htmlwidgets)

# Example 1: Simple scatter plot
cat("Creating Example 1: Simple scatter plot\n")
p1 <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist"))
    )
  ),
  data = cars
)
saveWidget(p1, "example1_scatter.html", selfcontained = TRUE)

# Example 2: Line chart with styling
cat("Creating Example 2: Line chart\n")
p2 <- plot_chart(
  spec = list(
    marks = list(
      plot_line(options = list(x = "speed", y = "dist", stroke = "steelblue", strokeWidth = 2))
    ),
    grid = TRUE
  ),
  data = cars
)
saveWidget(p2, "example2_line.html", selfcontained = TRUE)

# Example 3: Bar chart
cat("Creating Example 3: Bar chart\n")
# Aggregate data for bar chart
cyl_data <- aggregate(mpg ~ cyl, data = mtcars, mean)
p3 <- plot_chart(
  spec = list(
    marks = list(
      plot_barY(options = list(x = "cyl", y = "mpg", fill = "orange"))
    ),
    marginBottom = 40
  ),
  data = cyl_data
)
saveWidget(p3, "example3_bar.html", selfcontained = TRUE)

# Example 4: Combined plot with multiple marks
cat("Creating Example 4: Combined plot\n")
p4 <- plot_chart(
  spec = list(
    marks = list(
      plot_gridY(),
      plot_gridX(),
      plot_dot(options = list(x = "speed", y = "dist", fill = "blue", r = 4)),
      plot_line(options = list(x = "speed", y = "dist", stroke = "red", strokeWidth = 1.5))
    ),
    marginLeft = 50,
    marginBottom = 40
  ),
  data = cars,
  width = 600,
  height = 400
)
saveWidget(p4, "example4_combined.html", selfcontained = TRUE)

# Example 5: Grouped scatter plot with color
cat("Creating Example 5: Grouped scatter plot\n")
p5 <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(
        x = "wt", 
        y = "mpg", 
        fill = "cyl",
        r = 5
      ))
    ),
    color = list(
      type = "ordinal",
      scheme = "tableau10"
    ),
    marginLeft = 50,
    marginBottom = 40,
    grid = TRUE
  ),
  data = mtcars,
  width = 700,
  height = 500
)
saveWidget(p5, "example5_grouped.html", selfcontained = TRUE)

# Example 6: Area chart
cat("Creating Example 6: Area chart\n")
# Create time series data
dates <- seq(as.Date("2024-01-01"), as.Date("2024-12-31"), by = "day")
values <- cumsum(rnorm(length(dates), mean = 0.1, sd = 1))
ts_data <- data.frame(
  date = dates,
  value = values
)

p6 <- plot_chart(
  spec = list(
    marks = list(
      plot_area(options = list(
        x = "date", 
        y = "value",
        fill = "steelblue",
        fillOpacity = 0.3
      )),
      plot_line(options = list(
        x = "date",
        y = "value", 
        stroke = "steelblue",
        strokeWidth = 2
      ))
    ),
    marginLeft = 60,
    marginBottom = 40
  ),
  data = ts_data,
  width = 800,
  height = 400
)
saveWidget(p6, "example6_area.html", selfcontained = TRUE)

cat("\nAll examples created successfully!\n")
cat("HTML files saved:\n")
cat("  - example1_scatter.html\n")
cat("  - example2_line.html\n")
cat("  - example3_bar.html\n")
cat("  - example4_combined.html\n")
cat("  - example5_grouped.html\n")
cat("  - example6_area.html\n")
cat("\nOpen these files in a web browser to view the visualizations.\n")