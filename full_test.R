#!/usr/bin/env Rscript

# Comprehensive test to identify why plots are blank

cat("=== Full plotR Test Suite ===\n\n")

# Step 1: Load the standalone version
cat("Step 1: Loading plotR (standalone)...\n")
source("/Users/malshe/Dropbox/Work/JS/plot/plotR/standalone_plotR.R")

library(htmlwidgets)

# Step 2: Create various test plots
cat("\nStep 2: Creating test plots...\n")

# Test 1: Minimal plot
cat("  Creating minimal plot...\n")
p1 <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist"))
    )
  ),
  data = cars
)

# Test 2: Plot with explicit dimensions
cat("  Creating plot with dimensions...\n")
p2 <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist", fill = "steelblue", r = 5))
    ),
    width = 600,
    height = 400,
    marginLeft = 50,
    marginBottom = 50
  ),
  data = cars
)

# Test 3: Multiple marks
cat("  Creating multi-mark plot...\n")
p3 <- plot_chart(
  spec = list(
    marks = list(
      plot_gridY(),
      plot_dot(options = list(x = "wt", y = "mpg", fill = "cyl")),
      plot_line(options = list(x = "wt", y = "mpg", stroke = "red"))
    )
  ),
  data = mtcars
)

# Step 3: Save all plots
cat("\nStep 3: Saving plots...\n")

# Save as separate files
saveWidget(p1, "test1_minimal.html", selfcontained = TRUE)
cat("  Saved: test1_minimal.html\n")

saveWidget(p2, "test2_dimensions.html", selfcontained = TRUE)
cat("  Saved: test2_dimensions.html\n")

saveWidget(p3, "test3_multimark.html", selfcontained = TRUE)
cat("  Saved: test3_multimark.html\n")

# Step 4: Create a manual HTML test with inline data
cat("\nStep 4: Creating manual HTML test...\n")

html_manual <- '<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="inst/htmlwidgets/lib/plot/plot.min.js"></script>
    <script src="inst/htmlwidgets/plotR.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/htmlwidgets@1.6.2/www/htmlwidgets.js"></script>
    <style>
        #testplot { width: 600px; height: 400px; border: 1px solid #ccc; }
    </style>
</head>
<body>
    <h1>Manual Widget Test</h1>
    <div id="testplot" class="plotR html-widget" style="width:600px;height:400px;"></div>
    
    <script type="application/json" data-for="testplot">{
        "x": {
            "spec": {
                "marks": [{
                    "type": "dot",
                    "data": "@@data@@",
                    "options": {"x": "speed", "y": "dist"}
                }]
            },
            "data": [
                {"speed": 4, "dist": 2},
                {"speed": 7, "dist": 4},
                {"speed": 8, "dist": 16},
                {"speed": 9, "dist": 10},
                {"speed": 10, "dist": 18}
            ]
        }
    }</script>
    
    <script>
        // Initialize htmlwidgets
        if (window.HTMLWidgets) {
            window.HTMLWidgets.staticRender();
            console.log("HTMLWidgets initialized");
        } else {
            console.error("HTMLWidgets not loaded!");
        }
    </script>
</body>
</html>'

writeLines(html_manual, "test_manual.html")
cat("  Saved: test_manual.html\n")

# Step 5: Create direct JavaScript test
cat("\nStep 5: Creating direct JavaScript test...\n")

html_direct <- '<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Direct Plot Test</title>
    <script src="inst/htmlwidgets/lib/plot/plot.min.js"></script>
</head>
<body>
    <h1>Direct Plot.js Test (No Widget)</h1>
    <div id="plot1"></div>
    <hr>
    <div id="plot2"></div>
    
    <script>
        // Check Plot availability
        if (typeof Plot === "undefined") {
            document.body.innerHTML = "<h1 style=\"color:red\">Plot library not loaded!</h1>";
        } else {
            console.log("Plot loaded:", Plot);
            
            // Cars data subset
            const carsData = [
                {speed: 4, dist: 2},
                {speed: 7, dist: 4},
                {speed: 8, dist: 16},
                {speed: 9, dist: 10},
                {speed: 10, dist: 18},
                {speed: 11, dist: 17},
                {speed: 12, dist: 14},
                {speed: 13, dist: 26},
                {speed: 14, dist: 26},
                {speed: 15, dist: 20}
            ];
            
            // Create plot 1
            const plot1 = Plot.plot({
                marks: [
                    Plot.dot(carsData, {x: "speed", y: "dist", fill: "steelblue", r: 5})
                ],
                grid: true,
                width: 600,
                height: 400,
                marginLeft: 50,
                marginBottom: 40
            });
            document.getElementById("plot1").appendChild(plot1);
            console.log("Plot 1 created");
            
            // Create plot 2 with line
            const plot2 = Plot.plot({
                marks: [
                    Plot.dot(carsData, {x: "speed", y: "dist", fill: "orange", r: 4}),
                    Plot.line(carsData, {x: "speed", y: "dist", stroke: "blue", strokeWidth: 2})
                ],
                grid: true,
                width: 600,
                height: 400,
                marginLeft: 50,
                marginBottom: 40
            });
            document.getElementById("plot2").appendChild(plot2);
            console.log("Plot 2 created");
        }
    </script>
</body>
</html>'

writeLines(html_direct, "test_direct.html")
cat("  Saved: test_direct.html\n")

cat("\n=== Test Complete ===\n")
cat("\nFiles created:\n")
cat("  1. test1_minimal.html - Basic R widget test\n")
cat("  2. test2_dimensions.html - Widget with dimensions\n")
cat("  3. test3_multimark.html - Multiple marks\n")
cat("  4. test_manual.html - Manual widget initialization\n")
cat("  5. test_direct.html - Direct Plot.js (should definitely work)\n")
cat("\nTroubleshooting:\n")
cat("  1. Open test_direct.html first - if this is blank, Plot.js isn't loading\n")
cat("  2. Open other files and check browser console (F12) for errors\n")
cat("  3. Look for 'Plot loaded' and 'plotR renderValue called' messages\n")