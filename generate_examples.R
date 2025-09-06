#!/usr/bin/env Rscript

# Generate all chart examples for documentation

cat("🎨 Generating comprehensive chart examples...\n\n")

# Load the professional plotR system
source("/Users/malshe/Dropbox/Work/JS/plot/plotR/plotR_professional.R")

# Create examples directory
dir.create("examples", showWarnings = FALSE)

cat("📊 Creating basic charts...\n")

# 1. Scatter Plot
cat("  • Scatter plot...")
plotR_scatter(
  data = mtcars,
  x = "wt", 
  y = "mpg",
  fill = "cyl",
  size = "hp",
  title = "Motor Cars: Weight vs Fuel Efficiency",
  tooltip_template = "🚗 Weight: ${d.wt * 1000} lbs\\n⛽ MPG: ${d.mpg}\\n🔧 ${d.cyl} cylinders\\n🐎 ${d.hp} horsepower",
  save_as = "examples/scatter_plot.html"
)

# 2. Bar Chart  
cat(" ✅\\n  • Bar chart...")
cyl_summary <- aggregate(cbind(mpg = mpg, count = rep(1, nrow(mtcars))) ~ cyl, 
                        data = mtcars, 
                        FUN = function(x) c(mean = mean(x), sum = sum(x)))
bar_data <- data.frame(
  cylinders = cyl_summary$cyl,
  avg_mpg = round(cyl_summary$mpg[,1], 1),
  count = cyl_summary$count[,2]
)

plotR_bar(
  data = bar_data,
  x = "cylinders",
  y = "avg_mpg", 
  title = "Average MPG by Cylinder Count",
  tooltip_template = "${d.cylinders} Cylinders\\nAverage MPG: ${d.avg_mpg}\\nNumber of cars: ${d.count}",
  save_as = "examples/bar_chart.html"
)

# 3. Line Chart
cat(" ✅\\n  • Line chart...")
# Generate realistic sales data
set.seed(123)
years <- 2010:2023
base_sales <- 100
growth_rate <- 0.08
noise <- rnorm(length(years), 0, 10)
sales <- round(base_sales * (1 + growth_rate)^(0:(length(years)-1)) + noise)

time_data <- data.frame(
  year = years,
  sales = sales
)

plotR_line(
  data = time_data,
  x = "year",
  y = "sales", 
  title = "Sales Growth Over Time",
  tooltip_template = "Year ${d.year}\\nSales: $${d.sales}K",
  save_as = "examples/line_chart.html"
)

cat(" ✅\\n\\n📊 Creating advanced charts...\n")

# 4. Pie Chart
cat("  • Pie chart...")
pie_data <- data.frame(
  category = c("Product A", "Product B", "Product C", "Product D"),
  value = c(35, 28, 22, 15)
)

plotR_pie(
  data = pie_data,
  labels = "category",
  values = "value",
  title = "Market Share Distribution", 
  save_as = "examples/pie_chart.html"
)

# 5. Donut Chart
cat(" ✅\\n  • Donut chart...")
traffic_data <- data.frame(
  segment = c("Desktop", "Mobile", "Tablet", "Other"),
  percentage = c(45, 35, 15, 5)
)

plotR_donut(
  data = traffic_data,
  labels = "segment", 
  values = "percentage",
  title = "Website Traffic Sources",
  save_as = "examples/donut_chart.html"
)

# 6. Stacked Dots (Population pyramid style)
cat(" ✅\\n  • Stacked dots...")
set.seed(42)
age_groups <- seq(20, 80, 5)
pop_data <- data.frame(
  age = rep(age_groups, 2),
  gender = rep(c("Male", "Female"), each = length(age_groups)),
  count = c(
    # Male population (slightly declining with age)
    round(rnorm(length(age_groups), mean = 1000 - age_groups*5, sd = 100)),
    # Female population (similar but slightly higher)
    round(rnorm(length(age_groups), mean = 1050 - age_groups*5, sd = 90))
  )
)
pop_data$count <- pmax(pop_data$count, 50)  # Ensure positive values

plotR_stacked_dots(
  data = pop_data,
  x = "age",
  y = "count", 
  fill = "gender",
  title = "Population Distribution by Age and Gender",
  save_as = "examples/stacked_dots.html"
)

# 7. Bubble Map (US Cities)
cat(" ✅\\n  • Bubble map...")
cities_data <- data.frame(
  city = c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix", 
           "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"),
  lat = c(40.7128, 34.0522, 41.8781, 29.7604, 33.4484, 
          39.9526, 29.4241, 32.7157, 32.7767, 37.3382),
  lon = c(-74.0060, -118.2437, -87.6298, -95.3698, -112.0740,
          -75.1652, -98.4936, -117.1611, -96.7970, -121.8863),
  population = c(8336817, 3979576, 2693976, 2320268, 1680992,
                1584064, 1547253, 1423851, 1343573, 1021795)
)

plotR_bubble_map(
  data = cities_data,
  x = "lon",
  y = "lat", 
  size = "population",
  title = "US Cities by Population",
  save_as = "examples/bubble_map.html"
)

# 8. Stacked Waffle (Employee Satisfaction)
cat(" ✅\\n  • Stacked waffle...")
survey_data <- data.frame(
  department = rep(c("Sales", "Engineering", "Marketing", "Support"), each = 3),
  category = rep(c("Satisfied", "Neutral", "Dissatisfied"), 4),
  count = c(
    # Sales: 45, 30, 25
    45, 30, 25,
    # Engineering: 60, 20, 20  
    60, 20, 20,
    # Marketing: 40, 35, 25
    40, 35, 25,
    # Support: 55, 25, 20
    55, 25, 20
  )
)

plotR_stacked_waffle(
  data = survey_data,
  x = "department",
  fill = "category", 
  y = "count",
  title = "Employee Satisfaction by Department",
  save_as = "examples/stacked_waffle.html"
)

# 9. Isotype Chart (Livestock)
cat(" ✅\\n  • Isotype chart...")
livestock_data <- data.frame(
  animal = c("Cattle", "Sheep", "Pigs", "Chickens"),
  count_millions = c(94.4, 5.2, 71.3, 518.3),
  emoji = c("🐄", "🐑", "🐖", "🐓")
)

plotR_isotype(
  data = livestock_data,
  category = "animal",
  count = "count_millions",
  icon = "emoji",
  title = "US Livestock Population (millions of animals)",
  save_as = "examples/isotype_chart.html"
)

# 10. Grid Choropleth (State population change)
cat(" ✅\\n  • Grid choropleth...")
# State grid coordinates (approximate US map layout)
state_positions <- data.frame(
  state = c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", 
            "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", 
            "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"),
  x = c(1, 7, 6, 4, 2, 5, 10, 9, 10, 9, 8, 1, 6, 3, 6, 7, 5, 7, 6, 10, 9, 10, 7, 6, 6, 7, 4, 8, 5, 5, 10, 9, 
        4, 3, 9, 8, 5, 2, 9, 10, 8, 5, 7, 5, 4, 9, 10, 2, 7, 8, 4),
  y = c(8, 5, 4, 3, 2, 3, 6, 6, 6, 7, 6, 8, 4, 2, 4, 4, 3, 4, 6, 6, 6, 7, 3, 2, 4, 5, 2, 5, 2, 3, 7, 6, 
        3, 2, 6, 4, 3, 1, 5, 6, 6, 2, 4, 4, 2, 5, 7, 1, 3, 5, 2)
)

# Add simulated population change data
set.seed(456)
state_positions$pop_change <- round(rnorm(nrow(state_positions), mean = 0.5, sd = 2.0), 1)

plotR_grid_choropleth(
  data = state_positions,
  x = "x", 
  y = "y",
  fill = "pop_change",
  label = "state", 
  title = "State Population Change (2010-2020, %)",
  save_as = "examples/grid_choropleth.html"
)

cat(" ✅\\n\\n🎉 All examples generated successfully!\\n\\n")

cat("📂 Generated files:\\n")
examples <- list.files("examples", pattern = "\\.html$", full.names = FALSE)
for (ex in examples) {
  cat(paste("   •", ex, "\\n"))
}

cat("\\n📸 To create screenshots:\\n")
cat("   1. Open each HTML file in your browser\\n")
cat("   2. Take a screenshot of each visualization\\n")
cat("   3. Save screenshots as PNG files in the screenshots/ folder\\n")
cat("   4. Name them: scatter_plot.png, bar_chart.png, etc.\\n")

cat("\\n✨ All charts include interactive tooltips - hover to see details!\\n")