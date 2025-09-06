#!/usr/bin/env Rscript

# Fix gallery examples with proper Observable Plot implementations
cat("🔧 Fixing gallery examples with professional Observable Plot techniques...\n\n")

# Load professional plotR system
source("plotR_professional.R")

# Create fixed examples directory
if (!dir.exists("gallery_fixed")) {
  dir.create("gallery_fixed")
}

# 1. Fix Enhanced Scatter Plot - Remove rownames reference
cat("📊 Fixing enhanced scatter plot...\n")
plotR_scatter(
  data = mtcars,
  x = "wt",
  y = "mpg", 
  fill = "cyl",
  size = "hp",
  title = "Enhanced Scatter: Multi-dimensional Car Analysis",
  tooltip_template = "🚗 Car\\n⚖️ Weight: ${d.wt * 1000} lbs\\n⛽ MPG: ${d.mpg}\\n🔧 Cylinders: ${d.cyl}\\n💪 Horsepower: ${d.hp}",
  save_as = "gallery_fixed/enhanced_scatter.html"
)

# 2. Create True Waffle Chart using rect mark
cat("📊 Creating proper waffle chart...\n")

# Create waffle data - each row represents one square
create_waffle_data <- function(categories, values, total_squares = 100) {
  waffle_data <- data.frame()
  squares_per_value <- round(values * total_squares / sum(values))
  
  current_square <- 1
  for (i in 1:length(categories)) {
    n_squares <- squares_per_value[i]
    for (j in 1:n_squares) {
      row_num <- ceiling(current_square / 10)  # 10 squares per row
      col_num <- ((current_square - 1) %% 10) + 1
      
      waffle_data <- rbind(waffle_data, data.frame(
        category = categories[i],
        value = values[i],
        x = col_num,
        y = row_num,
        square_id = current_square
      ))
      current_square <- current_square + 1
    }
  }
  return(waffle_data)
}

browser_categories <- c("Chrome", "Safari", "Edge", "Firefox", "Other")
browser_values <- c(65, 18, 9, 5, 3)
waffle_data <- create_waffle_data(browser_categories, browser_values)

# Create waffle HTML manually with proper rect marks
waffle_html <- paste0('
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Browser Market Share 2023 - Waffle Chart</title>
    <script src="https://unpkg.com/d3@7.9.0/dist/d3.min.js"></script>
    <script src="https://unpkg.com/@observablehq/plot@0.6/dist/plot.umd.min.js"></script>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            margin: 20px;
            background-color: #fafafa;
            line-height: 1.6;
        }
        .plot-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            display: inline-block;
            margin: 20px 0;
        }
        h1 { 
            color: #2c3e50; 
            margin-bottom: 10px; 
            font-size: 28px;
            font-weight: 600;
        }
        .subtitle { 
            color: #7f8c8d; 
            font-size: 16px; 
            margin-bottom: 25px; 
        }
    </style>
</head>
<body>
    <h1>Browser Market Share 2023 - Waffle Chart</h1>
    <div class="subtitle">Each square represents 1% of market share • Hover for details</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    
    <script>
        const data = ', jsonlite::toJSON(waffle_data, dataframe = "rows"), ';
        
        const plot = Plot.plot({
            marks: [
                Plot.rect(data, {
                    x: "x",
                    y: "y", 
                    fill: "category",
                    stroke: "white",
                    strokeWidth: 2,
                    rx: 2,
                    title: d => `${d.category}: ${d.value}% market share`
                })
            ],
            width: 500,
            height: 400,
            x: {
                axis: null,
                domain: [0.5, 10.5]
            },
            y: {
                axis: null,
                domain: [0.5, 10.5],
                reverse: true
            },
            color: {
                scheme: "category10",
                legend: true
            },
            marginTop: 20,
            marginRight: 120,
            marginBottom: 20,
            marginLeft: 20
        });
        
        document.getElementById("plot").appendChild(plot);
    </script>
</body>
</html>')

writeLines(waffle_html, "gallery_fixed/browser_waffle.html")

# 3. Fix Population Pyramid with proper implementation
cat("📊 Creating proper population pyramid...\n")
age_demographics <- data.frame(
  age_group = rep(c("0-14", "15-29", "30-44", "45-59", "60-74", "75+"), 2),
  gender = rep(c("Male", "Female"), each = 6),
  population = c(
    -12.5, -18.2, -19.8, -17.3, -12.1, -8.1,  # Male (negative for left side)
    11.8, 17.5, 19.2, 17.8, 13.4, 9.3         # Female (positive for right side)
  ),
  abs_population = c(
    12.5, 18.2, 19.8, 17.3, 12.1, 8.1,        # Absolute values for tooltips
    11.8, 17.5, 19.2, 17.8, 13.4, 9.3
  )
)

pyramid_html <- paste0('
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Population Demographics - Population Pyramid</title>
    <script src="https://unpkg.com/d3@7.9.0/dist/d3.min.js"></script>
    <script src="https://unpkg.com/@observablehq/plot@0.6/dist/plot.umd.min.js"></script>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            margin: 20px;
            background-color: #fafafa;
            line-height: 1.6;
        }
        .plot-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            display: inline-block;
            margin: 20px 0;
        }
        h1 { color: #2c3e50; margin-bottom: 10px; font-size: 28px; font-weight: 600; }
        .subtitle { color: #7f8c8d; font-size: 16px; margin-bottom: 25px; }
    </style>
</head>
<body>
    <h1>Population Demographics - Population Pyramid</h1>
    <div class="subtitle">Age distribution by gender • Hover for details</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    
    <script>
        const data = ', jsonlite::toJSON(age_demographics, dataframe = "rows"), ';
        
        const plot = Plot.plot({
            marks: [
                Plot.barX(data, {
                    x: "population",
                    y: "age_group",
                    fill: "gender",
                    title: d => `${d.gender} ${d.age_group}: ${d.abs_population}% of population`
                }),
                Plot.ruleX([0], {stroke: "#666", strokeWidth: 1})
            ],
            width: 600,
            height: 400,
            x: {
                label: "Population (%)",
                tickFormat: d => Math.abs(d) + "%"
            },
            y: {
                label: "Age Group",
                domain: ["75+", "60-74", "45-59", "30-44", "15-29", "0-14"]
            },
            color: {
                domain: ["Male", "Female"],
                range: ["#4285f4", "#ea4335"],
                legend: true
            },
            marginLeft: 80,
            marginRight: 120
        });
        
        document.getElementById("plot").appendChild(plot);
    </script>
</body>
</html>')

writeLines(pyramid_html, "gallery_fixed/population_pyramid.html")

# 4. Fix Grid Choropleth
cat("📊 Fixing grid choropleth...\n")
us_states_simple <- data.frame(
  state_code = c("WA", "OR", "CA", "NV", "ID", "UT", "AZ", "MT", "WY", "CO", "NM"),
  x = c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3),
  y = c(1, 2, 3, 2, 1, 2, 3, 1, 2, 3, 4),
  population = c(7.7, 4.2, 39.5, 3.1, 1.8, 3.3, 7.3, 1.1, 0.6, 5.8, 2.1),
  state_name = c("Washington", "Oregon", "California", "Nevada", "Idaho", "Utah", "Arizona", 
                "Montana", "Wyoming", "Colorado", "New Mexico")
)

grid_html <- paste0('
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>US Western States Population Grid</title>
    <script src="https://unpkg.com/d3@7.9.0/dist/d3.min.js"></script>
    <script src="https://unpkg.com/@observablehq/plot@0.6/dist/plot.umd.min.js"></script>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            margin: 20px;
            background-color: #fafafa;
            line-height: 1.6;
        }
        .plot-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            display: inline-block;
            margin: 20px 0;
        }
        h1 { color: #2c3e50; margin-bottom: 10px; font-size: 28px; font-weight: 600; }
        .subtitle { color: #7f8c8d; font-size: 16px; margin-bottom: 25px; }
    </style>
</head>
<body>
    <h1>US Western States Population Grid</h1>
    <div class="subtitle">Population in millions • Hover for state details</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    
    <script>
        const data = ', jsonlite::toJSON(us_states_simple, dataframe = "rows"), ';
        
        const plot = Plot.plot({
            marks: [
                Plot.cell(data, {
                    x: "x",
                    y: "y",
                    fill: "population",
                    stroke: "white",
                    strokeWidth: 2,
                    title: d => `${d.state_name} (${d.state_code})\\nPopulation: ${d.population}M`
                }),
                Plot.text(data, {
                    x: "x",
                    y: "y",
                    text: "state_code",
                    fill: "white",
                    fontSize: 14,
                    fontWeight: "bold"
                })
            ],
            width: 300,
            height: 400,
            x: {
                axis: null,
                domain: [0.5, 3.5]
            },
            y: {
                axis: null,
                domain: [0.5, 4.5],
                reverse: true
            },
            color: {
                scheme: "blues",
                legend: true,
                label: "Population (millions)"
            },
            marginTop: 20,
            marginRight: 100,
            marginBottom: 20,
            marginLeft: 20
        });
        
        document.getElementById("plot").appendChild(plot);
    </script>
</body>
</html>')

writeLines(grid_html, "gallery_fixed/us_population_grid.html")

# 5. Fix Isotype Chart with proper emoji rendering
cat("📊 Creating proper isotype chart...\n")

# Create isotype data with proper scaling
transportation_data <- data.frame(
  mode = c("Car", "Bus", "Train", "Bike", "Walk"),
  users = c(85, 32, 18, 9, 4),  # Scaled down for better visualization
  icon = c("🚗", "🚌", "🚂", "🚲", "🚶")
)

# Create individual icon data
create_isotype_data <- function(categories, counts, icons) {
  isotype_data <- data.frame()
  
  for (i in 1:length(categories)) {
    n_icons <- counts[i]
    for (j in 1:n_icons) {
      x_pos <- ((j - 1) %% 10) + 1  # 10 icons per row
      y_pos <- ceiling(j / 10)
      
      isotype_data <- rbind(isotype_data, data.frame(
        category = categories[i],
        icon = icons[i], 
        x = x_pos,
        y = y_pos + (i - 1) * 4,  # Space between categories
        count = counts[i],
        icon_num = j
      ))
    }
  }
  return(isotype_data)
}

isotype_icon_data <- create_isotype_data(
  transportation_data$mode, 
  transportation_data$users, 
  transportation_data$icon
)

isotype_html <- paste0('
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Transportation Mode Usage - Isotype Chart</title>
    <script src="https://unpkg.com/d3@7.9.0/dist/d3.min.js"></script>
    <script src="https://unpkg.com/@observablehq/plot@0.6/dist/plot.umd.min.js"></script>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            margin: 20px;
            background-color: #fafafa;
            line-height: 1.6;
        }
        .plot-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            display: inline-block;
            margin: 20px 0;
        }
        h1 { color: #2c3e50; margin-bottom: 10px; font-size: 28px; font-weight: 600; }
        .subtitle { color: #7f8c8d; font-size: 16px; margin-bottom: 25px; }
    </style>
</head>
<body>
    <h1>Transportation Mode Usage</h1>
    <div class="subtitle">Each icon = 10,000 daily commuters • Hover for details</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    
    <script>
        const iconData = ', jsonlite::toJSON(isotype_icon_data, dataframe = "rows"), ';
        const categoryData = ', jsonlite::toJSON(transportation_data, dataframe = "rows"), ';
        
        const plot = Plot.plot({
            marks: [
                // Category labels
                Plot.text(categoryData, {
                    x: 0,
                    y: (d, i) => (i * 4) + 1.5,
                    text: "mode",
                    textAnchor: "end",
                    fontSize: 14,
                    fontWeight: "bold",
                    fill: "#333"
                }),
                // Icons
                Plot.text(iconData, {
                    x: "x", 
                    y: "y",
                    text: "icon",
                    fontSize: 20,
                    title: d => `${d.category}: ${d.count * 10}K daily users`
                })
            ],
            width: 600,
            height: 400,
            x: {
                axis: null,
                domain: [-1, 11]
            },
            y: {
                axis: null,
                domain: [0, 20],
                reverse: true
            },
            marginTop: 20,
            marginRight: 20,
            marginBottom: 20,
            marginLeft: 100
        });
        
        document.getElementById("plot").appendChild(plot);
    </script>
</body>
</html>')

writeLines(isotype_html, "gallery_fixed/transportation_isotype.html")

# 6. Create Beautiful Pie Chart with proper fonts and interactivity
cat("📊 Creating beautiful pie chart...\n")

energy_sources <- data.frame(
  source = c("Natural Gas", "Coal", "Nuclear", "Renewable", "Petroleum"),
  percentage = c(32, 24, 19, 17, 8)
)

pie_html <- paste0('
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>US Energy Production by Source 2023</title>
    <script src="https://unpkg.com/d3@7.9.0/dist/d3.min.js"></script>
    <script src="https://unpkg.com/@observablehq/plot@0.6/dist/plot.umd.min.js"></script>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            margin: 20px;
            background-color: #fafafa;
            line-height: 1.6;
        }
        .plot-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            display: inline-block;
            margin: 20px 0;
        }
        h1 { color: #2c3e50; margin-bottom: 10px; font-size: 28px; font-weight: 600; }
        .subtitle { color: #7f8c8d; font-size: 16px; margin-bottom: 25px; }
    </style>
</head>
<body>
    <h1>US Energy Production by Source 2023</h1>
    <div class="subtitle">Percentage of total energy production • Hover for details</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    
    <script>
        const data = ', jsonlite::toJSON(energy_sources, dataframe = "rows"), ';
        
        const plot = Plot.plot({
            marks: [
                Plot.arc(data, {
                    innerRadius: 60,
                    outerRadius: 150,
                    startAngle: 0,
                    endAngle: d => d.percentage / 100 * 2 * Math.PI,
                    fill: "source",
                    stroke: "white",
                    strokeWidth: 2,
                    title: d => `${d.source}: ${d.percentage}%`
                })
            ],
            width: 400,
            height: 400,
            color: {
                scheme: "category10",
                legend: true
            },
            marginTop: 20,
            marginRight: 120,
            marginBottom: 20,
            marginLeft: 20
        });
        
        document.getElementById("plot").appendChild(plot);
    </script>
</body>
</html>')

writeLines(pie_html, "gallery_fixed/energy_pie.html")

cat("\n✅ Fixed gallery examples complete!\n\n")

cat("📂 Fixed files in gallery_fixed/ folder:\n")
files <- list.files("gallery_fixed", pattern = "\\.html$")
for (file in files) {
  cat("   •", file, "\n")
}

cat("\n🎨 These examples now showcase proper Observable Plot techniques!\n")
cat("🌐 Open any HTML file to see the professional visualizations.\n")