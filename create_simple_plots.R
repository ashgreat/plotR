#!/usr/bin/env Rscript

# Create simple plots using direct HTML generation instead of htmlwidgets

cat("Creating simple plots without htmlwidgets dependency...\n")

# Function to create a plot HTML file directly
create_plot_html <- function(data, spec, filename) {
  
  # Convert data to JSON
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  # Create the HTML content
  html_content <- paste0('
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Plot Created with R</title>
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
        }
        h1 { color: #333; margin-bottom: 20px; }
    </style>
</head>
<body>
    <h1>Interactive Plot Created with R plotR Package</h1>
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
            
            console.log("Libraries loaded, creating plot...");
            
            // Data from R
            const data = ', data_json, ';
            console.log("Data:", data);
            
            try {
                // Create the plot
                const plot = Plot.plot(', jsonlite::toJSON(spec, auto_unbox = TRUE), ');
                
                // Add to page
                document.getElementById("plot").appendChild(plot);
                console.log("Plot created successfully!");
                
            } catch (error) {
                console.error("Error creating plot:", error);
                document.getElementById("plot").innerHTML = 
                    "<p style=\\"color: red;\\">Error creating plot: " + error.message + "</p>";
            }
        }
        
        // Start creation
        createPlot();
    </script>
</body>
</html>')
  
  # Write to file
  writeLines(html_content, filename)
  cat(paste("Created:", filename, "\n"))
}

# Example 1: Simple scatter plot
cat("\nExample 1: Simple scatter plot\n")
create_plot_html(
  data = cars,
  spec = list(
    marks = list(
      list(type = "dot", data = cars, x = "speed", y = "dist", fill = "steelblue", r = 5)
    ),
    grid = TRUE,
    width = 600,
    height = 400,
    marginLeft = 60,
    marginBottom = 50,
    x = list(label = "Speed (mph)"),
    y = list(label = "Distance (ft)")
  ),
  filename = "example1_direct.html"
)

# Example 2: Multiple marks
cat("\nExample 2: Scatter + Line plot\n")  
create_plot_html(
  data = cars,
  spec = list(
    marks = list(
      list(type = "line", data = cars, x = "speed", y = "dist", stroke = "red", strokeWidth = 2),
      list(type = "dot", data = cars, x = "speed", y = "dist", fill = "blue", r = 4)
    ),
    grid = TRUE,
    width = 700,
    height = 450,
    marginLeft = 60,
    marginBottom = 50,
    x = list(label = "Speed (mph)"),
    y = list(label = "Distance (ft)")
  ),
  filename = "example2_direct.html"
)

# Example 3: mtcars with color grouping
cat("\nExample 3: mtcars grouped by cylinders\n")
create_plot_html(
  data = mtcars,
  spec = list(
    marks = list(
      list(type = "dot", data = mtcars, x = "wt", y = "mpg", fill = "cyl", r = 6)
    ),
    grid = TRUE,
    width = 700,
    height = 500,
    marginLeft = 60,
    marginBottom = 50,
    color = list(scheme = "category10"),
    x = list(label = "Weight (1000 lbs)"),
    y = list(label = "Miles per Gallon")
  ),
  filename = "example3_direct.html"
)

cat("\n✅ All plots created successfully!\n")
cat("\nFiles created:\n")
cat("  - example1_direct.html (simple scatter)\n") 
cat("  - example2_direct.html (scatter + line)\n")
cat("  - example3_direct.html (grouped by color)\n")
cat("\nThese use CDN versions of D3 and Plot, so they should work!\n")
cat("Open them in your browser to see the visualizations.\n")