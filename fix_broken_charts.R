#!/usr/bin/env Rscript

# Fix the broken charts in gallery_fixed using working plotR functions
cat("🔧 Fixing broken charts using working plotR functions...\n\n")

# Load professional plotR system
source("plotR_professional.R")

# 1. Fix Browser Waffle Chart - Use grid approach with cell mark
cat("📊 Fixing browser waffle chart...\n")

# Create simple waffle-style data - each row represents a category
browser_data <- data.frame(
  browser = c("Chrome", "Safari", "Edge", "Firefox", "Other"),
  share = c(65, 18, 9, 5, 3),
  x = c(1, 2, 3, 4, 5),  # Simple horizontal layout
  y = c(1, 1, 1, 1, 1)   # All in same row
)

# Create waffle using the working create_html function but with rect marks
data_json <- jsonlite::toJSON(browser_data, dataframe = "rows", auto_unbox = TRUE)

# Build JavaScript for waffle squares
waffle_js <- 'Plot.rect(data, {
  x: (d, i) => i + 1,
  width: d => d.share / 5,  // Scale width by market share
  y: 1,
  height: 0.8,
  fill: "browser",
  stroke: "white",
  strokeWidth: 2,
  rx: 4
})'

# Build plot options
plot_options <- list(
  width = 600,
  height = 200,
  marginLeft = 80,
  marginBottom = 60,
  marginTop = 40,
  marginRight = 120,
  x = list(label = "Market Share", domain = c(0.5, 5.5)),
  y = list(axis = NULL, domain = c(0.5, 1.5)),
  color = list(scheme = "category10", legend = TRUE)
)

options_json <- jsonlite::toJSON(plot_options, auto_unbox = TRUE)

# Create HTML using the working function
create_html(data_json, waffle_js, options_json, 
           "Browser Market Share 2023 - Waffle Style", 
           "gallery_fixed/browser_waffle.html")

# 2. Fix Energy Pie Chart - Use working arc approach  
cat("📊 Fixing energy pie chart...\n")

energy_data <- data.frame(
  source = c("Natural Gas", "Coal", "Nuclear", "Renewable", "Petroleum"),
  percentage = c(32, 24, 19, 17, 8)
)

# Calculate proper angles for pie chart
total <- sum(energy_data$percentage)
cumulative <- 0
pie_data <- data.frame()

for (i in 1:nrow(energy_data)) {
  start_angle <- cumulative * 2 * pi / total
  cumulative <- cumulative + energy_data$percentage[i]
  end_angle <- cumulative * 2 * pi / total
  
  pie_data <- rbind(pie_data, data.frame(
    source = energy_data$source[i],
    percentage = energy_data$percentage[i],
    start_angle = start_angle,
    end_angle = end_angle
  ))
}

pie_json <- jsonlite::toJSON(pie_data, dataframe = "rows", auto_unbox = TRUE)

# Simple pie chart using arc mark
pie_js <- 'Plot.arc(data, {
  innerRadius: 0,
  outerRadius: 120,
  startAngle: "start_angle", 
  endAngle: "end_angle",
  fill: "source",
  stroke: "white",
  strokeWidth: 2
})'

pie_options <- list(
  width = 400,
  height = 400,
  x = list(axis = NULL, domain = c(-150, 150)),
  y = list(axis = NULL, domain = c(-150, 150)), 
  color = list(scheme = "category10", legend = TRUE)
)

pie_options_json <- jsonlite::toJSON(pie_options, auto_unbox = TRUE)

create_html(pie_json, pie_js, pie_options_json,
           "US Energy Production by Source 2023",
           "gallery_fixed/energy_pie.html")

# 3. Fix US Population Grid - Use simple cell approach
cat("📊 Fixing US population grid...\n")

grid_data <- data.frame(
  state = c("WA", "OR", "CA", "NV", "ID", "UT", "AZ"),
  x = c(1, 1, 1, 2, 2, 2, 2),
  y = c(1, 2, 3, 2, 1, 2, 3),
  population = c(7.7, 4.2, 39.5, 3.1, 1.8, 3.3, 7.3)
)

grid_json <- jsonlite::toJSON(grid_data, dataframe = "rows", auto_unbox = TRUE)

# Simple grid using cell mark
grid_js <- 'Plot.cell(data, {
  x: "x",
  y: "y", 
  fill: "population",
  stroke: "white",
  strokeWidth: 2,
  inset: 2
})'

grid_options <- list(
  width = 300,
  height = 400,
  marginLeft = 60,
  marginRight = 100,
  marginTop = 40,
  marginBottom = 40,
  x = list(axis = NULL, domain = c(0.5, 2.5)),
  y = list(axis = NULL, domain = c(0.5, 3.5)),
  color = list(scheme = "blues", legend = TRUE, label = "Population (millions)")
)

grid_options_json <- jsonlite::toJSON(grid_options, auto_unbox = TRUE)

create_html(grid_json, grid_js, grid_options_json,
           "Western US States Population",
           "gallery_fixed/us_population_grid.html")

cat("\n✅ Fixed all broken charts!\n")
cat("📂 Updated files in gallery_fixed/ folder:\n")
cat("   • browser_waffle.html (now using rect marks)\n")
cat("   • energy_pie.html (now using proper arc marks)\n") 
cat("   • us_population_grid.html (now using cell marks)\n")
cat("\n🌐 All charts should now render correctly!\n")