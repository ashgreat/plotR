#!/usr/bin/env Rscript

# Create interactive plots with tooltips and hover effects

cat("Creating interactive plots with tooltips and hover effects...\n")

# Function to create a plot HTML file with interactivity
create_interactive_plot <- function(data, marks_js, options_js = "{}", filename, title = "Interactive Plot") {
  
  # Convert data to JSON
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  # Create the HTML content
  html_content <- paste0('
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>', title, '</title>
    <script src="https://unpkg.com/d3@7.9.0/dist/d3.min.js"></script>
    <script src="https://unpkg.com/@observablehq/plot@0.6/dist/plot.umd.min.js"></script>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            margin: 20px;
            background-color: #fafafa;
        }
        .plot-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: inline-block;
            position: relative;
        }
        h1 { 
            color: #333; 
            margin-bottom: 20px; 
            font-size: 24px;
        }
        .info {
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <h1>', title, '</h1>
    <div class="info">Hover over data points to see details</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    
    <script>
        // Wait for libraries to load
        function createPlot() {
            if (typeof d3 === "undefined" || typeof Plot === "undefined") {
                setTimeout(createPlot, 100);
                return;
            }
            
            console.log("Creating interactive plot...");
            
            // Data from R
            const data = ', data_json, ';
            
            try {
                // Create the plot with interactivity
                const plotSpec = Object.assign({
                    marks: [', marks_js, ']
                }, ', options_js, ');
                
                const plot = Plot.plot(plotSpec);
                
                // Add to page
                document.getElementById("plot").appendChild(plot);
                console.log("Interactive plot created successfully!");
                
            } catch (error) {
                console.error("Error creating plot:", error);
                document.getElementById("plot").innerHTML = 
                    "<div style=\\"color: red; padding: 20px;\\"><strong>Error:</strong> " + error.message + "</div>";
            }
        }
        
        createPlot();
    </script>
</body>
</html>')
  
  # Write to file
  writeLines(html_content, filename)
  cat(paste("Created:", filename, "\n"))
}

# Example 1: Scatter plot with detailed tooltips
cat("\nExample 1: Interactive scatter plot with tooltips\n")
create_interactive_plot(
  data = cars,
  marks_js = 'Plot.dot(data, {
    x: "speed", 
    y: "dist", 
    fill: "steelblue", 
    r: 6,
    stroke: "white",
    strokeWidth: 1,
    title: d => `Speed: ${d.speed} mph\\nDistance: ${d.dist} ft`
  })',
  options_js = '{
    grid: true,
    width: 600,
    height: 400,
    marginLeft: 60,
    marginBottom: 50,
    x: {label: "Speed (mph)"},
    y: {label: "Stopping Distance (ft)"}
  }',
  filename = "interactive_scatter.html",
  title = "Cars: Speed vs Stopping Distance"
)

# Example 2: Multi-mark plot with different tooltips
cat("\nExample 2: Line + scatter with rich tooltips\n")  
create_interactive_plot(
  data = cars,
  marks_js = '
    Plot.line(data, {
      x: "speed", 
      y: "dist", 
      stroke: "red", 
      strokeWidth: 2,
      strokeOpacity: 0.7
    }),
    Plot.dot(data, {
      x: "speed", 
      y: "dist", 
      fill: "blue", 
      r: 5,
      stroke: "white",
      strokeWidth: 1,
      title: d => `🚗 Speed: ${d.speed} mph\\n🛑 Distance: ${d.dist} ft\\n📊 Ratio: ${(d.dist/d.speed).toFixed(1)}`
    })
  ',
  options_js = '{
    grid: true,
    width: 700,
    height: 450,
    marginLeft: 60,
    marginBottom: 50,
    x: {label: "Speed (mph)"},
    y: {label: "Stopping Distance (ft)"}
  }',
  filename = "interactive_line_scatter.html",
  title = "Cars: Speed vs Distance with Trend"
)

# Example 3: Bar chart with tooltips
cat("\nExample 3: Interactive bar chart\n")
cyl_summary <- aggregate(cbind(mpg = mpg, count = rep(1, nrow(mtcars))) ~ cyl, 
                        data = mtcars, 
                        FUN = function(x) c(mean = mean(x), sum = sum(x)))
cyl_data <- data.frame(
  cylinders = cyl_summary$cyl,
  avg_mpg = cyl_summary$mpg[,1],
  count = cyl_summary$count[,2]
)

create_interactive_plot(
  data = cyl_data,
  marks_js = 'Plot.barY(data, {
    x: "cylinders", 
    y: "avg_mpg", 
    fill: "orange",
    stroke: "#ff6b35",
    strokeWidth: 1,
    title: d => `${d.cylinders} Cylinders\\nAvg MPG: ${d.avg_mpg.toFixed(1)}\\nCars: ${d.count}`
  })',
  options_js = '{
    grid: true,
    width: 500,
    height: 400,
    marginLeft: 60,
    marginBottom: 50,
    x: {label: "Number of Cylinders"},
    y: {label: "Average Miles per Gallon"}
  }',
  filename = "interactive_bars.html",
  title = "Average MPG by Cylinder Count"
)

# Example 4: Colorful scatter with detailed tooltips
cat("\nExample 4: Grouped scatter with rich tooltips\n")
# Add car names to mtcars
mtcars_with_names <- mtcars
mtcars_with_names$car <- rownames(mtcars)

create_interactive_plot(
  data = mtcars_with_names,
  marks_js = 'Plot.dot(data, {
    x: "wt", 
    y: "mpg", 
    fill: "cyl", 
    r: 8,
    stroke: "white",
    strokeWidth: 1.5,
    title: d => `🚗 ${d.car}\\n⚖️ Weight: ${d.wt} × 1000 lbs\\n⛽ MPG: ${d.mpg}\\n🔧 Cylinders: ${d.cyl}\\n🐎 HP: ${d.hp}`
  })',
  options_js = '{
    grid: true,
    width: 750,
    height: 550,
    marginLeft: 60,
    marginBottom: 50,
    color: {
      scheme: "category10",
      legend: true
    },
    x: {label: "Weight (1000 lbs)"},
    y: {label: "Miles per Gallon"}
  }',
  filename = "interactive_mtcars.html",
  title = "Motor Cars: Weight vs Fuel Efficiency"
)

# Example 5: Advanced interactivity with multiple dimensions
cat("\nExample 5: Bubble chart with size and color encoding\n")
create_interactive_plot(
  data = mtcars_with_names,
  marks_js = 'Plot.dot(data, {
    x: "wt", 
    y: "mpg", 
    fill: "cyl",
    r: "hp",  // Size by horsepower
    stroke: "white",
    strokeWidth: 1,
    fillOpacity: 0.7,
    title: d => `🚗 ${d.car}\\n⚖️ Weight: ${d.wt} × 1000 lbs\\n⛽ MPG: ${d.mpg}\\n🔧 Cylinders: ${d.cyl}\\n🐎 Horsepower: ${d.hp}\\n⚙️ Transmission: ${d.am ? "Manual" : "Automatic"}`
  })',
  options_js = '{
    grid: true,
    width: 800,
    height: 600,
    marginLeft: 70,
    marginBottom: 50,
    color: {
      scheme: "viridis",
      legend: true
    },
    r: {
      range: [3, 20]  // Size range for bubbles
    },
    x: {label: "Weight (1000 lbs)"},
    y: {label: "Miles per Gallon"}
  }',
  filename = "interactive_bubbles.html",
  title = "Motor Cars: Multi-dimensional Analysis"
)

cat("\n✅ All interactive plots created!\n")
cat("\nFiles created with hover tooltips:\n")
cat("  - interactive_scatter.html (basic tooltips)\n") 
cat("  - interactive_line_scatter.html (rich tooltips with calculations)\n")
cat("  - interactive_bars.html (bar chart with counts)\n")
cat("  - interactive_mtcars.html (car details with emojis)\n")
cat("  - interactive_bubbles.html (bubble chart with multiple dimensions)\n")
cat("\n🎯 Hover over any data point to see detailed information!\n")
cat("🎨 The plots include colors, sizes, and rich formatting.\n")