#!/usr/bin/env Rscript

# Create working plots with correct Plot.js mark syntax

cat("Creating working plots with proper Plot.js syntax...\n")

# Function to create a plot HTML file with correct Plot.js syntax
create_plot_html <- function(data, marks_js, options_js = "{}", filename) {
  
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
            console.log("Available Plot functions:", Object.keys(Plot).filter(k => typeof Plot[k] === "function").slice(0, 10));
            
            // Data from R
            const data = ', data_json, ';
            console.log("Data points:", data.length);
            console.log("Sample data:", data.slice(0, 3));
            
            try {
                // Create the plot with actual Plot marks
                const plotSpec = Object.assign({
                    marks: [', marks_js, ']
                }, ', options_js, ');
                
                console.log("Plot specification:", plotSpec);
                
                const plot = Plot.plot(plotSpec);
                
                // Add to page
                document.getElementById("plot").appendChild(plot);
                console.log("Plot created successfully!");
                
            } catch (error) {
                console.error("Error creating plot:", error);
                document.getElementById("plot").innerHTML = 
                    "<div style=\\"color: red; padding: 20px;\\"><strong>Error:</strong> " + error.message + "<br><br>Check browser console for details.</div>";
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
  marks_js = 'Plot.dot(data, {x: "speed", y: "dist", fill: "steelblue", r: 5})',
  options_js = '{
    grid: true,
    width: 600,
    height: 400,
    marginLeft: 60,
    marginBottom: 50,
    x: {label: "Speed (mph)"},
    y: {label: "Distance (ft)"}
  }',
  filename = "working_example1.html"
)

# Example 2: Multiple marks (scatter + line)
cat("\nExample 2: Scatter + Line plot\n")  
create_plot_html(
  data = cars,
  marks_js = '
    Plot.line(data, {x: "speed", y: "dist", stroke: "red", strokeWidth: 2}),
    Plot.dot(data, {x: "speed", y: "dist", fill: "blue", r: 4, stroke: "white", strokeWidth: 1})
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
  filename = "working_example2.html"
)

# Example 3: Bar chart (aggregated data)
cat("\nExample 3: Bar chart\n")
# Create aggregated data for bar chart
cyl_summary <- aggregate(mpg ~ cyl, data = mtcars, FUN = mean)
names(cyl_summary) <- c("cylinders", "avg_mpg")

create_plot_html(
  data = cyl_summary,
  marks_js = 'Plot.barY(data, {x: "cylinders", y: "avg_mpg", fill: "orange"})',
  options_js = '{
    grid: true,
    width: 500,
    height: 400,
    marginLeft: 60,
    marginBottom: 50,
    x: {label: "Number of Cylinders"},
    y: {label: "Average MPG"}
  }',
  filename = "working_example3.html"
)

# Example 4: Grouped scatter plot
cat("\nExample 4: Grouped scatter (mtcars)\n")
create_plot_html(
  data = mtcars,
  marks_js = 'Plot.dot(data, {x: "wt", y: "mpg", fill: "cyl", r: 6})',
  options_js = '{
    grid: true,
    width: 700,
    height: 500,
    marginLeft: 60,
    marginBottom: 50,
    color: {scheme: "category10"},
    x: {label: "Weight (1000 lbs)"},
    y: {label: "Miles per Gallon"}
  }',
  filename = "working_example4.html"
)

cat("\n✅ All working plots created!\n")
cat("\nFiles created:\n")
cat("  - working_example1.html (simple scatter)\n") 
cat("  - working_example2.html (scatter + line)\n")
cat("  - working_example3.html (bar chart)\n")
cat("  - working_example4.html (grouped scatter)\n")
cat("\nThese use correct Plot.js syntax and should work!\n")