#!/usr/bin/env Rscript

# Create plots with properly configured tooltips

cat("Creating plots with properly configured tooltips...\n")

# Function to create a plot HTML file with working tooltips
create_tooltip_plot <- function(data, marks_js, options_js = "{}", filename, title = "Interactive Plot") {
  
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
            font-style: italic;
        }
        
        /* Custom tooltip styles */
        .plot-tooltip {
            position: absolute;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 12px;
            pointer-events: none;
            white-space: pre-line;
            z-index: 1000;
        }
    </style>
</head>
<body>
    <h1>', title, '</h1>
    <div class="info">Hover over data points to see details (tooltips enabled)</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    
    <script>
        function createPlot() {
            if (typeof d3 === "undefined" || typeof Plot === "undefined") {
                setTimeout(createPlot, 100);
                return;
            }
            
            console.log("Creating plot with tooltips...");
            
            // Data from R
            const data = ', data_json, ';
            
            try {
                // Create the plot
                const plotSpec = Object.assign({
                    marks: [', marks_js, ']
                }, ', options_js, ');
                
                console.log("Plot spec:", plotSpec);
                const plot = Plot.plot(plotSpec);
                
                document.getElementById("plot").appendChild(plot);
                console.log("Plot with tooltips created!");
                
            } catch (error) {
                console.error("Error:", error);
                document.getElementById("plot").innerHTML = 
                    "<div style=\\"color: red; padding: 20px;\\"><strong>Error:</strong> " + error.message + "</div>";
            }
        }
        
        createPlot();
    </script>
</body>
</html>')
  
  writeLines(html_content, filename)
  cat(paste("Created:", filename, "\n"))
}

# Example 1: Simple test with basic tooltip
cat("\nExample 1: Simple scatter with basic tooltip\n")
create_tooltip_plot(
  data = cars[1:10, ], # Just first 10 rows for testing
  marks_js = 'Plot.dot(data, {
    x: "speed", 
    y: "dist", 
    fill: "steelblue", 
    r: 8,
    title: (d, i) => `Point ${i + 1}: Speed ${d.speed}, Distance ${d.dist}`
  })',
  options_js = '{
    grid: true,
    width: 600,
    height: 400,
    marginLeft: 60,
    marginBottom: 50,
    x: {label: "Speed (mph)"},
    y: {label: "Distance (ft)"}
  }',
  filename = "tooltip_test.html",
  title = "Tooltip Test - Hover Over Points"
)

# Example 2: Using tip mark (Plot.js specific tooltip mark)
cat("\nExample 2: Using Plot.tip for better tooltips\n")
create_tooltip_plot(
  data = cars[1:15, ],
  marks_js = '
    Plot.dot(data, {
      x: "speed", 
      y: "dist", 
      fill: "orange", 
      r: 6,
      stroke: "white",
      strokeWidth: 1
    }),
    Plot.tip(data, Plot.pointer({
      x: "speed",
      y: "dist", 
      title: (d) => `Speed: ${d.speed} mph\\nStopping Distance: ${d.dist} ft`
    }))
  ',
  options_js = '{
    grid: true,
    width: 600,
    height: 400,
    marginLeft: 60,
    marginBottom: 50,
    x: {label: "Speed (mph)"},
    y: {label: "Distance (ft)"}
  }',
  filename = "tooltip_tip_mark.html",
  title = "Using Plot.tip for Tooltips"
)

# Example 3: Interactive with crosshair
cat("\nExample 3: Plot with crosshair pointer\n")
create_tooltip_plot(
  data = cars,
  marks_js = '
    Plot.dot(data, {
      x: "speed", 
      y: "dist", 
      fill: "red", 
      r: 5
    }),
    Plot.crosshair(data, {x: "speed", y: "dist"}),
    Plot.tip(data, Plot.pointer({
      x: "speed",
      y: "dist",
      title: (d) => `🚗 ${d.speed} mph → ${d.dist} ft stopping distance`
    }))
  ',
  options_js = '{
    grid: true,
    width: 700,
    height: 450,
    marginLeft: 60,
    marginBottom: 50,
    x: {label: "Speed (mph)"},
    y: {label: "Distance (ft)"}
  }',
  filename = "tooltip_crosshair.html",
  title = "Plot with Crosshair and Tooltips"
)

# Example 4: Test different tooltip approaches
cat("\nExample 4: Multiple tooltip methods comparison\n")
create_tooltip_plot(
  data = head(mtcars, 10),
  marks_js = '
    Plot.dot(data, {
      x: "wt", 
      y: "mpg", 
      fill: "cyl",
      r: 8,
      title: d => `${d.cyl} cyl: ${d.mpg} mpg at ${d.wt} klbs`
    }),
    Plot.tip(data, Plot.pointer({
      x: "wt",
      y: "mpg",
      title: d => `Weight: ${d.wt * 1000} lbs\\nMPG: ${d.mpg}\\nCylinders: ${d.cyl}`
    }))
  ',
  options_js = '{
    grid: true,
    width: 600,
    height: 400,
    marginLeft: 60,
    marginBottom: 50,
    color: {scheme: "category10", legend: true},
    x: {label: "Weight (1000 lbs)"},
    y: {label: "Miles per Gallon"}
  }',
  filename = "tooltip_comparison.html",
  title = "Multiple Tooltip Methods"
)

cat("\n✅ Tooltip test plots created!\n")
cat("\nFiles created:\n")
cat("  - tooltip_test.html (basic title tooltips)\n") 
cat("  - tooltip_tip_mark.html (using Plot.tip)\n")
cat("  - tooltip_crosshair.html (with crosshair)\n")
cat("  - tooltip_comparison.html (multiple methods)\n")
cat("\n🎯 These should have working hover tooltips!\n")
cat("📝 Check browser console if tooltips still don\\'t work.\n")