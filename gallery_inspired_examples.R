#!/usr/bin/env Rscript

# Gallery-inspired examples using plotR functions
# Based on Observable Plot Gallery: https://observablehq.com/@observablehq/plot-gallery

cat("🎨 Creating Observable Plot Gallery inspired examples...\n\n")

# Load professional plotR system
source("plotR_professional.R")

# Create examples directory if it doesn't exist
if (!dir.exists("gallery_examples")) {
  dir.create("gallery_examples")
}

# 1. Enhanced Scatter Plot (inspired by Scatterplot gallery)
cat("📊 Creating enhanced scatter plot...\n")
plotR_scatter(
  data = mtcars,
  x = "wt",
  y = "mpg", 
  fill = "cyl",
  size = "hp",
  title = "Gallery Inspired: Multi-dimensional Car Analysis",
  tooltip_template = "🚗 ${rownames(d)}\\n⚖️ Weight: ${d.wt * 1000} lbs\\n⛽ MPG: ${d.mpg}\\n🔧 Cylinders: ${d.cyl}\\n💪 Horsepower: ${d.hp}",
  save_as = "gallery_examples/enhanced_scatter.html"
)

# 2. Proportional Symbol Plot (inspired by Symbol scatterplot)
cat("📊 Creating proportional symbol plot...\n")
# Create population data similar to gallery examples
cities <- data.frame(
  city = c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix", 
           "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"),
  population = c(8400000, 3900000, 2700000, 2300000, 1600000, 
                1600000, 1500000, 1400000, 1300000, 1000000),
  longitude = c(-74.0, -118.2, -87.6, -95.4, -112.1, -75.2, -98.5, -117.2, -96.8, -121.9),
  latitude = c(40.7, 34.1, 41.9, 29.8, 33.4, 39.9, 29.4, 32.7, 32.8, 37.3)
)

plotR_bubble_map(
  data = cities,
  x = "longitude",
  y = "latitude", 
  size = "population",
  title = "Gallery Inspired: US Cities Population Map",
  save_as = "gallery_examples/population_bubbles.html"
)

# 3. Multi-line Chart (inspired by Line chart gallery)
cat("📊 Creating multi-line chart...\n")
# Create time series data
years <- 2015:2023
tech_stocks <- data.frame(
  year = rep(years, 3),
  company = rep(c("Apple", "Google", "Microsoft"), each = length(years)),
  stock_price = c(
    c(105, 115, 157, 177, 293, 132, 150, 182, 193), # Apple
    c(520, 742, 1032, 1186, 1734, 1477, 2734, 2893, 2960), # Google  
    c(40, 56, 84, 107, 157, 157, 331, 284, 348)  # Microsoft
  )
)

# Create separate line charts for each company (simulating multi-line)
for (comp in unique(tech_stocks$company)) {
  comp_data <- tech_stocks[tech_stocks$company == comp, ]
  plotR_line(
    data = comp_data,
    x = "year",
    y = "stock_price",
    title = paste("Gallery Inspired:", comp, "Stock Price"),
    save_as = paste0("gallery_examples/", tolower(comp), "_stock.html")
  )
}

# 4. Grouped Bar Chart (inspired by Bar chart gallery)
cat("📊 Creating grouped bar chart simulation...\n")
# Create revenue data by quarter
revenue_data <- data.frame(
  quarter = c("Q1", "Q2", "Q3", "Q4"),
  sales_2022 = c(120, 135, 148, 162),
  sales_2023 = c(135, 152, 168, 185)
)

# Create separate bar charts for each year (simulating grouped bars)
revenue_2022 <- data.frame(quarter = revenue_data$quarter, sales = revenue_data$sales_2022)
revenue_2023 <- data.frame(quarter = revenue_data$quarter, sales = revenue_data$sales_2023)

plotR_bar(
  data = revenue_2022,
  x = "quarter", 
  y = "sales",
  title = "Gallery Inspired: 2022 Quarterly Revenue",
  save_as = "gallery_examples/revenue_2022.html"
)

plotR_bar(
  data = revenue_2023,
  x = "quarter",
  y = "sales", 
  title = "Gallery Inspired: 2023 Quarterly Revenue",
  save_as = "gallery_examples/revenue_2023.html"
)

# 5. Advanced Isotype Chart (inspired by Isotype visualization)
cat("📊 Creating advanced isotype chart...\n")
transportation <- data.frame(
  mode = c("Car", "Bus", "Train", "Bike", "Walk"),
  users = c(850, 320, 180, 95, 45),
  icon = c("🚗", "🚌", "🚂", "🚲", "🚶")
)

plotR_isotype(
  data = transportation,
  category = "mode",
  count = "users", 
  icon = "icon",
  title = "Gallery Inspired: Transportation Mode Usage (per 1000 people)",
  save_as = "gallery_examples/transportation_isotype.html"
)

# 6. Complex Waffle Chart (inspired by Stacked representations)
cat("📊 Creating complex waffle chart...\n") 
browser_usage <- data.frame(
  browser = c("Chrome", "Safari", "Edge", "Firefox", "Other"),
  market_share = c(65, 18, 9, 5, 3),
  category = rep("Browsers", 5)
)

plotR_stacked_waffle(
  data = browser_usage,
  x = "category",
  fill = "browser",
  y = "market_share", 
  title = "Gallery Inspired: Browser Market Share 2023",
  save_as = "gallery_examples/browser_waffle.html"
)

# 7. Geographic Grid Visualization (inspired by Maps gallery)
cat("📊 Creating geographic grid...\n")
# Create a simple state grid 
us_states_grid <- data.frame(
  state = c("WA", "OR", "CA", "NV", "ID", "UT", "AZ", "MT", "WY", "CO", "NM", "ND", "SD", "NE", "KS", "OK", "TX"),
  x = c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4),
  y = c(1, 2, 3, 2, 1, 2, 3, 1, 2, 3, 4, 1, 2, 3, 4, 5, 6),
  population = c(7.7, 4.2, 39.5, 3.1, 1.8, 3.3, 7.3, 1.1, 0.6, 5.8, 2.1, 0.8, 0.9, 1.9, 2.9, 4.0, 29.1),
  label = c("Washington", "Oregon", "California", "Nevada", "Idaho", "Utah", "Arizona", 
           "Montana", "Wyoming", "Colorado", "New Mexico", "North Dakota", "South Dakota", 
           "Nebraska", "Kansas", "Oklahoma", "Texas")
)

plotR_grid_choropleth(
  data = us_states_grid,
  x = "x",
  y = "y", 
  fill = "population",
  label = "state",
  title = "Gallery Inspired: Western US Population Density",
  save_as = "gallery_examples/us_population_grid.html"
)

# 8. Enhanced Pie Chart with Custom Colors (inspired by Pie charts)
cat("📊 Creating enhanced pie chart...\n")
energy_sources <- data.frame(
  source = c("Natural Gas", "Coal", "Nuclear", "Renewable", "Petroleum"),
  percentage = c(32, 24, 19, 17, 8),
  color = c("#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4", "#FFEAA7")
)

plotR_pie(
  data = energy_sources,
  labels = "source", 
  values = "percentage",
  title = "Gallery Inspired: US Energy Production by Source 2023",
  save_as = "gallery_examples/energy_pie.html"
)

# 9. Population Pyramid Style (using stacked dots)
cat("📊 Creating population pyramid style...\n")
age_demographics <- data.frame(
  age_group = rep(c("0-14", "15-29", "30-44", "45-59", "60-74", "75+"), 2),
  gender = rep(c("Male", "Female"), each = 6),
  population = c(
    # Male
    12.5, 18.2, 19.8, 17.3, 12.1, 8.1,
    # Female  
    11.8, 17.5, 19.2, 17.8, 13.4, 9.3
  )
)

plotR_stacked_dots(
  data = age_demographics,
  x = "age_group",
  y = "population", 
  fill = "gender",
  title = "Gallery Inspired: Population Demographics by Age and Gender",
  save_as = "gallery_examples/population_pyramid.html"
)

# 10. Custom Donut Chart (inspired by advanced pie charts)
cat("📊 Creating custom donut chart...\n")
market_segments <- data.frame(
  segment = c("Enterprise", "Small Business", "Consumer", "Education", "Government"),
  revenue = c(45.2, 28.7, 15.8, 6.3, 4.0)
)

plotR_donut(
  data = market_segments,
  labels = "segment",
  values = "revenue", 
  title = "Gallery Inspired: Revenue by Market Segment (Billions $)",
  save_as = "gallery_examples/market_donut.html"
)

cat("\n✅ Gallery-inspired examples complete!\n\n")

cat("📂 Generated files in gallery_examples/ folder:\n")
files <- list.files("gallery_examples", pattern = "\\.html$")
for (file in files) {
  cat("   •", file, "\n")
}

cat("\n🎨 These examples demonstrate plotR's ability to recreate many\n")
cat("   Observable Plot gallery visualizations with interactive tooltips!\n\n")

cat("🌐 Open any HTML file in your browser to see the interactive plots.\n")