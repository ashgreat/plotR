# Debug test for plotR

# Load the standalone version
source("/Users/malshe/Dropbox/Work/JS/plot/plotR/standalone_plotR.R")

library(htmlwidgets)

# Create a simple test plot
cat("\nCreating test plot...\n")
p <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist"))
    ),
    grid = TRUE
  ),
  data = cars,
  width = 600,
  height = 400
)

# Save with self-contained = FALSE to see file structure
cat("Saving test_debug.html (not self-contained)...\n")
saveWidget(p, "test_debug.html", selfcontained = FALSE)

# Also save self-contained version
cat("Saving test_selfcontained.html (self-contained)...\n")
saveWidget(p, "test_selfcontained.html", selfcontained = TRUE)

# Create a minimal test to check if Plot library works
cat("\nCreating minimal HTML test...\n")

html_content <- '<!DOCTYPE html>
<html>
<head>
    <title>Plot Test</title>
    <script src="https://cdn.jsdelivr.net/npm/@observablehq/plot@0.6/dist/plot.umd.min.js"></script>
</head>
<body>
    <h1>Plot Library Test</h1>
    <div id="myplot"></div>
    
    <script>
        // Test data
        const data = [
            {x: 1, y: 2},
            {x: 2, y: 3},
            {x: 3, y: 5},
            {x: 4, y: 4},
            {x: 5, y: 7}
        ];
        
        // Create plot
        const plot = Plot.plot({
            marks: [
                Plot.dot(data, {x: "x", y: "y", fill: "steelblue", r: 5}),
                Plot.line(data, {x: "x", y: "y", stroke: "red"})
            ],
            grid: true,
            width: 600,
            height: 400
        });
        
        // Add to page
        document.getElementById("myplot").appendChild(plot);
        console.log("Plot created successfully!");
    </script>
</body>
</html>'

writeLines(html_content, "test_cdn.html")
cat("Created test_cdn.html - this uses CDN version of Plot\n")

# Let's also check what the widget actually contains
cat("\nWidget structure:\n")
str(p, max.level = 2)

cat("\nFiles created:\n")
cat("  - test_debug.html (and test_debug_files/ folder)\n")
cat("  - test_selfcontained.html\n")  
cat("  - test_cdn.html (uses CDN, should definitely work)\n")
cat("\nOpen test_cdn.html first to verify Plot library works.\n")
cat("Then check browser console (F12) for errors in the other files.\n")