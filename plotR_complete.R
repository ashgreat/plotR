#!/usr/bin/env Rscript

# Complete plotR system with working interactivity

cat("Loading complete plotR system with interactive tooltips...\n")

# Main function to create interactive plots
plotR <- function(data, mark_type = "dot", x = NULL, y = NULL, 
                  fill = NULL, size = NULL, stroke = NULL,
                  width = 600, height = 400, 
                  title = "Interactive Plot",
                  tooltip_template = NULL,
                  save_as = NULL) {
  
  # Validate inputs
  if (is.null(x) || is.null(y)) {
    stop("Both x and y variables must be specified")
  }
  
  # Convert data to JSON
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  # Build mark options
  mark_options <- list()
  mark_options$x <- x
  mark_options$y <- y
  
  if (!is.null(fill)) mark_options$fill <- fill
  if (!is.null(size)) mark_options$r <- size
  if (!is.null(stroke)) mark_options$stroke <- stroke
  
  # Default tooltip template
  if (is.null(tooltip_template)) {
    tooltip_parts <- c(paste0(x, ": ${d.", x, "}"))
    tooltip_parts <- c(tooltip_parts, paste0(y, ": ${d.", y, "}"))
    if (!is.null(fill)) tooltip_parts <- c(tooltip_parts, paste0(fill, ": ${d.", fill, "}"))
    tooltip_template <- paste(tooltip_parts, collapse = "\\n")
  }
  
  # Build mark JavaScript code
  mark_js_options <- sapply(names(mark_options), function(name) {
    paste0(name, ': "', mark_options[[name]], '"')
  })
  mark_js <- paste0('Plot.', mark_type, '(data, {', paste(mark_js_options, collapse = ', '), '})')
  
  # Build tooltip JavaScript
  tooltip_js <- paste0('Plot.tip(data, Plot.pointer({
    x: "', x, '",
    y: "', y, '",
    title: d => `', tooltip_template, '`
  }))')
  
  # Combine marks
  all_marks <- paste(mark_js, tooltip_js, sep = ',\n    ')
  
  # Build plot options
  plot_options <- list(
    grid = TRUE,
    width = width,
    height = height,
    marginLeft = 60,
    marginBottom = 50
  )
  
  # Add axis labels
  plot_options$x <- list(label = x)
  plot_options$y <- list(label = y)
  
  # Add color scheme if fill is used
  if (!is.null(fill)) {
    plot_options$color <- list(scheme = "category10", legend = TRUE)
  }
  
  options_json <- jsonlite::toJSON(plot_options, auto_unbox = TRUE)
  
  # Create HTML
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
        }
        h1 { color: #333; margin-bottom: 10px; }
        .subtitle { color: #666; font-size: 14px; margin-bottom: 20px; font-style: italic; }
    </style>
</head>
<body>
    <h1>', title, '</h1>
    <div class="subtitle">Interactive plot created with plotR • Hover for details</div>
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
                        ', all_marks, '
                    ],
                    ', gsub('^\\{|\\}$', '', options_json), '
                });
                
                document.getElementById("plot").appendChild(plot);
                console.log("plotR: Interactive plot created successfully!");
                
            } catch (error) {
                console.error("plotR Error:", error);
                document.getElementById("plot").innerHTML = 
                    "<div style=\\"color: red; padding: 20px;\\">Error: " + error.message + "</div>";
            }
        }
        
        createPlot();
    </script>
</body>
</html>')
  
  # Save or return
  if (!is.null(save_as)) {
    writeLines(html_content, save_as)
    cat(paste("Interactive plot saved to:", save_as, "\n"))
    return(invisible(save_as))
  } else {
    # Return HTML content for viewing
    temp_file <- tempfile(fileext = ".html")
    writeLines(html_content, temp_file)
    if (interactive()) {
      browseURL(temp_file)
    }
    return(invisible(temp_file))
  }
}

# Convenience functions for different plot types
plotR_scatter <- function(data, x, y, fill = NULL, size = NULL, ...) {
  plotR(data = data, mark_type = "dot", x = x, y = y, fill = fill, size = size, ...)
}

plotR_line <- function(data, x, y, stroke = "steelblue", ...) {
  plotR(data = data, mark_type = "line", x = x, y = y, stroke = stroke, ...)
}

plotR_bar <- function(data, x, y, fill = "orange", ...) {
  plotR(data = data, mark_type = "barY", x = x, y = y, fill = fill, ...)
}

# Export functions to global environment
assign("plotR", plotR, envir = .GlobalEnv)
assign("plotR_scatter", plotR_scatter, envir = .GlobalEnv)
assign("plotR_line", plotR_line, envir = .GlobalEnv)
assign("plotR_bar", plotR_bar, envir = .GlobalEnv)

cat("✅ plotR functions loaded!\n\n")
cat("Usage examples:\n")
cat("  # Basic scatter plot with tooltips\n")
cat('  plotR_scatter(cars, x = "speed", y = "dist", save_as = "my_plot.html")\n\n')
cat("  # Colored scatter plot\n")
cat('  plotR_scatter(mtcars, x = "wt", y = "mpg", fill = "cyl", save_as = "cars.html")\n\n')
cat("  # Custom tooltip\n")
cat('  plotR(cars, "dot", "speed", "dist", \n')
cat('        tooltip_template = "🚗 Speed: ${d.speed} mph, Distance: ${d.dist} ft",\n')
cat('        save_as = "custom.html")\n\n')
cat("Functions available: plotR, plotR_scatter, plotR_line, plotR_bar\n")