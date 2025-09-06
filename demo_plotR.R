#!/usr/bin/env Rscript

# Demo of the complete plotR system

cat("Loading plotR system...\n")
source("/Users/malshe/Dropbox/Work/JS/plot/plotR/plotR_complete.R")

cat("\nCreating demo plots...\n")

# Demo 1: Simple scatter plot
cat("\nDemo 1: Basic scatter plot\n")
plotR_scatter(
  data = cars, 
  x = "speed", 
  y = "dist",
  title = "Cars: Speed vs Stopping Distance",
  save_as = "demo1_scatter.html"
)

# Demo 2: Colored scatter plot with custom tooltips
cat("\nDemo 2: Colored scatter with custom tooltips\n")
plotR_scatter(
  data = mtcars,
  x = "wt",
  y = "mpg", 
  fill = "cyl",
  title = "Motor Cars: Weight vs Fuel Efficiency",
  tooltip_template = "🚗 Weight: ${d.wt * 1000} lbs\\n⛽ MPG: ${d.mpg}\\n🔧 ${d.cyl} cylinders\\n🐎 ${d.hp} horsepower",
  save_as = "demo2_colored.html"
)

# Demo 3: Bar chart
cat("\nDemo 3: Bar chart with aggregated data\n")
cyl_summary <- aggregate(mpg ~ cyl, data = mtcars, FUN = mean)
names(cyl_summary) <- c("cylinders", "avg_mpg")
plotR_bar(
  data = cyl_summary,
  x = "cylinders",
  y = "avg_mpg",
  title = "Average MPG by Cylinder Count", 
  tooltip_template = "${d.cylinders} Cylinders\\nAverage: ${d.avg_mpg.toFixed(1)} MPG",
  save_as = "demo3_bars.html"
)

# Demo 4: Advanced scatter with size encoding
cat("\nDemo 4: Advanced scatter with size and color\n")
plotR(
  data = mtcars,
  mark_type = "dot",
  x = "wt",
  y = "mpg",
  fill = "cyl", 
  size = "hp",
  title = "Multi-dimensional Motor Car Analysis",
  tooltip_template = "Weight: ${d.wt} × 1000 lbs\\nMPG: ${d.mpg}\\nCylinders: ${d.cyl}\\nHorsepower: ${d.hp}",
  width = 750,
  height = 550,
  save_as = "demo4_advanced.html"
)

# Demo 5: Line plot
cat("\nDemo 5: Line plot\n")
# Create time series data
dates <- seq(as.Date("2024-01-01"), as.Date("2024-12-31"), by = "month")
values <- cumsum(rnorm(length(dates), mean = 2, sd = 5))
ts_data <- data.frame(
  month = as.numeric(dates - as.Date("2024-01-01")) + 1,
  value = values,
  date_label = format(dates, "%b %Y")
)

plotR_line(
  data = ts_data,
  x = "month", 
  y = "value",
  title = "Time Series Example",
  tooltip_template = "${d.date_label}\\nValue: ${d.value.toFixed(1)}",
  save_as = "demo5_line.html"
)

cat("\n🎉 All demo plots created!\n")
cat("\nInteractive HTML files with tooltips:\n")
cat("  - demo1_scatter.html (basic scatter)\n")
cat("  - demo2_colored.html (colored scatter with rich tooltips)\n")
cat("  - demo3_bars.html (bar chart)\n")
cat("  - demo4_advanced.html (multi-dimensional bubble chart)\n")
cat("  - demo5_line.html (time series line plot)\n")
cat("\n✨ All plots have interactive tooltips that work!\n")
cat("🎯 Hover over any data point to see details.\n")