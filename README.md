# plotR: Interactive Data Visualization with Observable Plot

[![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)](https://www.r-project.org/)
[![Observable Plot](https://img.shields.io/badge/Observable_Plot-3B82F6?style=for-the-badge&logo=observable&logoColor=white)](https://observablehq.com/plot/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An R interface to [Observable Plot](https://observablehq.com/plot/), a powerful JavaScript library for exploratory data visualization. Create expressive, interactive charts with a concise and consistent grammar of graphics.

## Features

✨ **Rich Chart Types**: Support for scatter plots, bar charts, line charts, pie charts, bubble maps, waffle charts, and more  
🎯 **Interactive Tooltips**: Built-in hover tooltips with customizable templates  
🎨 **Beautiful Styling**: Leverages Observable Plot's sophisticated visual design  
📊 **Grammar of Graphics**: Consistent API following the principles of layered graphics  
🔧 **R Integration**: Seamless workflow with R data frames and familiar R syntax  
📱 **Responsive**: Charts automatically adapt to different screen sizes  

## Installation

```r
# Install development version from GitHub
devtools::install_github("ashgreat/plotR")

# Load the package
library(plotR)
```

## Quick Start

```r
library(plotR)

# Simple scatter plot with interactive tooltips
plotR_scatter(
  data = mtcars,
  x = "wt",
  y = "mpg", 
  fill = "cyl",
  title = "Fuel Efficiency vs Weight",
  save_as = "scatter_plot.html"
)
```

## Chart Gallery

### Basic Charts

#### Scatter Plot
![Scatter Plot](screenshots/scatter_plot.png)

```r
plotR_scatter(
  data = mtcars,
  x = "wt", 
  y = "mpg",
  fill = "cyl",
  size = "hp",
  title = "Motor Cars: Weight vs Fuel Efficiency",
  tooltip_template = "🚗 Weight: ${d.wt * 1000} lbs\\n⛽ MPG: ${d.mpg}\\n🐎 HP: ${d.hp}",
  save_as = "scatter_advanced.html"
)
```

#### Bar Chart  
![Bar Chart](screenshots/bar_chart.png)

```r
# Aggregate data
cyl_summary <- aggregate(mpg ~ cyl, data = mtcars, FUN = mean)
names(cyl_summary) <- c("cylinders", "avg_mpg")

plotR_bar(
  data = cyl_summary,
  x = "cylinders",
  y = "avg_mpg", 
  title = "Average MPG by Cylinder Count",
  tooltip_template = "${d.cylinders} Cylinders: ${d.avg_mpg.toFixed(1)} MPG",
  save_as = "bar_chart.html"
)
```

#### Line Chart
![Line Chart](screenshots/line_chart.png)

```r
# Time series data
time_data <- data.frame(
  year = 2010:2023,
  sales = c(100, 120, 140, 130, 160, 180, 170, 200, 220, 210, 240, 260, 280, 300)
)

plotR_line(
  data = time_data,
  x = "year",
  y = "sales", 
  title = "Sales Growth Over Time",
  tooltip_template = "Year ${d.year}: $${d.sales}K sales",
  save_as = "line_chart.html"
)
```

### Advanced Charts

#### Pie Chart
![Pie Chart](screenshots/pie_chart.png)

```r
plotR_pie(
  data = data.frame(
    category = c("Product A", "Product B", "Product C", "Product D"),
    value = c(30, 25, 20, 25)
  ),
  labels = "category",
  values = "value",
  title = "Market Share Distribution", 
  save_as = "pie_chart.html"
)
```

#### Donut Chart
![Donut Chart](screenshots/donut_chart.png)

```r
plotR_donut(
  data = data.frame(
    segment = c("Desktop", "Mobile", "Tablet", "Other"),
    percentage = c(45, 35, 15, 5)
  ),
  labels = "segment", 
  values = "percentage",
  title = "Traffic Sources",
  save_as = "donut_chart.html"
)
```

#### Stacked Dots
![Stacked Dots](screenshots/stacked_dots.png)

```r
# Population data by age and gender
pop_data <- data.frame(
  age = rep(20:80, 2),
  gender = rep(c("Male", "Female"), each = 61),
  count = c(rnorm(61, 1000, 200), rnorm(61, 1050, 180))
)

plotR_stacked_dots(
  data = pop_data,
  x = "age",
  y = "count", 
  fill = "gender",
  title = "Population Distribution by Age and Gender",
  save_as = "stacked_dots.html"
)
```

#### Bubble Map
![Bubble Map](screenshots/bubble_map.png)

```r
# US cities data
cities_data <- data.frame(
  city = c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix"),
  lat = c(40.7128, 34.0522, 41.8781, 29.7604, 33.4484),
  lon = c(-74.0060, -118.2437, -87.6298, -95.3698, -112.0740),
  population = c(8336817, 3979576, 2693976, 2320268, 1680992)
)

plotR_bubble_map(
  data = cities_data,
  x = "lon",
  y = "lat", 
  size = "population",
  title = "US Cities by Population",
  save_as = "bubble_map.html"
)
```

#### Stacked Waffle
![Stacked Waffle](screenshots/stacked_waffle.png)

```r
# Survey responses
survey_data <- data.frame(
  category = rep(c("Satisfied", "Neutral", "Dissatisfied"), 4),
  department = rep(c("Sales", "Engineering", "Marketing", "Support"), each = 3),
  count = c(45, 30, 25, 60, 20, 20, 40, 35, 25, 55, 25, 20)
)

plotR_stacked_waffle(
  data = survey_data,
  x = "department",
  fill = "category", 
  y = "count",
  title = "Employee Satisfaction by Department",
  save_as = "stacked_waffle.html"
)
```

#### Isotype Chart  
![Isotype Chart](screenshots/isotype_chart.png)

```r
# Livestock data
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
  title = "US Livestock Population (in millions)",
  save_as = "isotype_chart.html"
)
```

#### Grid Choropleth
![Grid Choropleth](screenshots/grid_choropleth.png)

```r
# State grid data
state_grid <- data.frame(
  state = state.abb,
  x = c(6, 6, 5, 6, 4, 4, 6, 6, 6, 6, 2, 3, 4, 4, 4, 4, 5, 5, 6, 6, 
        6, 4, 4, 3, 5, 3, 4, 1, 6, 5, 4, 5, 6, 4, 3, 4, 7, 6, 6, 5,
        6, 4, 4, 4, 1, 5, 2, 2, 4, 5),
  y = c(2, 6, 2, 4, 6, 3, 3, 1, 0, 6, 6, 3, 6, 5, 4, 3, 4, 6, 5, 2,
        1, 7, 6, 4, 1, 6, 7, 6, 4, 3, 2, 6, 7, 1, 5, 0, 2, 0, 4, 5,
        3, 5, 2, 4, 7, 2, 5, 7, 1, 0),
  value = rnorm(50, 0, 0.1)  # Population change
)

plotR_grid_choropleth(
  data = state_grid,
  x = "x", 
  y = "y",
  fill = "value",
  label = "state", 
  title = "State Population Change (%)",
  save_as = "grid_choropleth.html"
)
```

## API Reference

### Core Functions

- `plotR(data, mark_type, x, y, ...)` - Main plotting function
- `plotR_scatter(data, x, y, fill, size, ...)` - Scatter plots  
- `plotR_line(data, x, y, ...)` - Line charts
- `plotR_bar(data, x, y, ...)` - Bar charts
- `plotR_pie(data, labels, values, ...)` - Pie charts
- `plotR_donut(data, labels, values, ...)` - Donut charts

### Advanced Functions

- `plotR_stacked_dots(data, x, y, fill, ...)` - Stacked dot plots
- `plotR_bubble_map(data, x, y, size, ...)` - Bubble maps  
- `plotR_stacked_waffle(data, x, fill, y, ...)` - Waffle charts
- `plotR_isotype(data, category, count, icon, ...)` - Isotype charts
- `plotR_grid_choropleth(data, x, y, fill, label, ...)` - Grid choropleths

### Common Parameters

- `data` - Data frame containing the data to plot
- `x`, `y` - Column names for x and y aesthetics  
- `fill` - Column name for fill color aesthetic
- `size` - Column name for size aesthetic
- `title` - Plot title
- `tooltip_template` - Custom tooltip template with `${d.column}` syntax
- `width`, `height` - Plot dimensions in pixels
- `save_as` - Output HTML filename

## Tooltip Customization

plotR supports rich, interactive tooltips using template strings:

```r
tooltip_template = "🚗 ${d.car_name}\\n⚖️ Weight: ${d.wt * 1000} lbs\\n⛽ MPG: ${d.mpg}\\n🐎 ${d.hp} HP"
```

- Use `${d.column_name}` to reference data columns
- Use `\\n` for line breaks  
- Include emojis and formatting for visual appeal
- JavaScript expressions like `${d.wt * 1000}` are supported

## Integration with R Ecosystem

plotR works seamlessly with popular R packages:

```r
library(dplyr)
library(plotR)

mtcars %>%
  mutate(efficiency = ifelse(mpg > 20, "High", "Low")) %>%
  plotR_scatter(
    x = "wt", 
    y = "mpg", 
    fill = "efficiency",
    title = "Fuel Efficiency Analysis"
  )
```

## Output Formats

All plotR functions generate standalone HTML files that can be:

- 📱 Viewed in any web browser
- 📤 Shared via email or web hosting
- 📋 Embedded in R Markdown documents  
- 🖥️ Displayed in RStudio Viewer
- 📊 Integrated into Shiny applications

## Examples and Tutorials

For comprehensive examples and tutorials, see:

- `vignette("getting-started")` - Basic usage and concepts
- `vignette("advanced-charts")` - Complex visualizations  
- `vignette("customization")` - Styling and theming
- `vignette("interactivity")` - Tooltips and interactions

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## License

MIT © [Ashish Kumar](https://github.com/ashgreat)
