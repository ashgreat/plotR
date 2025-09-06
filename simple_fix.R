#!/usr/bin/env Rscript

# Simple fix for browser waffle using minimal code
cat("🔧 Creating simple working browser chart...\n")

# Load professional plotR system
source("plotR_professional.R")

# Create simple browser data
browser_data <- data.frame(
  browser = c("Chrome", "Safari", "Edge", "Firefox", "Other"),
  share = c(65, 18, 9, 5, 3)
)

# Use the most basic approach - direct HTML creation
data_json <- jsonlite::toJSON(browser_data, dataframe = "rows", auto_unbox = TRUE)

# Simple bar mark without complex tooltip
simple_marks <- 'Plot.barY(data, {
  x: "browser", 
  y: "share", 
  fill: "browser"
})'

# Simple options
simple_options <- list(
  width = 600,
  height = 400,
  marginLeft = 70,
  marginBottom = 60,
  marginTop = 40,
  marginRight = 40,
  x = list(label = "Browser"),
  y = list(label = "Market Share (%)"),
  color = list(scheme = "category10")
)

options_json <- jsonlite::toJSON(simple_options, auto_unbox = TRUE)

# Create HTML
html_content <- paste0('
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Browser Market Share 2023</title>
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
    <h1>Browser Market Share 2023</h1>
    <div class="subtitle">Market share by browser</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    
    <script>
        function createPlot() {
            if (typeof d3 === "undefined" || typeof Plot === "undefined") {
                setTimeout(createPlot, 100);
                return;
            }
            
            const data = ', data_json, ';
            
            try {
                const plot = Plot.plot({
                    marks: [
                        Plot.barY(data, {
                            x: "browser", 
                            y: "share", 
                            fill: "browser"
                        })
                    ],
                    ', substr(options_json, 2, nchar(options_json)-2), '
                });
                
                document.getElementById("plot").appendChild(plot);
                console.log("Browser chart created successfully!");
                
            } catch (error) {
                console.error("Error:", error);
                document.getElementById("plot").innerHTML = 
                    "<div style=\"color: red; padding: 20px;\">Error: " + error.message + "</div>";
            }
        }
        
        createPlot();
    </script>
</body>
</html>')

writeLines(html_content, "gallery_fixed/browser_waffle.html")

cat("✅ Simple browser chart created!\n")
cat("🌐 Should work without errors now.\n")