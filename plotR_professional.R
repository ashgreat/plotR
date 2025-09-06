#!/usr/bin/env Rscript

# Professional plotR system with all chart types

cat("Loading professional plotR system...\n")

# Enhanced plotR function with more chart types
plotR <- function(data, mark_type = "dot", x = NULL, y = NULL, 
                  fill = NULL, size = NULL, stroke = NULL,
                  width = 600, height = 400, 
                  title = "Interactive Plot",
                  tooltip_template = NULL,
                  save_as = NULL, ...) {
  
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
    marginLeft = 70,
    marginBottom = 60,
    marginTop = 40,
    marginRight = 40
  )
  
  # Add axis labels
  plot_options$x <- list(label = x)
  plot_options$y <- list(label = y)
  
  # Add color scheme if fill is used
  if (!is.null(fill)) {
    plot_options$color <- list(scheme = "category10", legend = TRUE)
  }
  
  options_json <- jsonlite::toJSON(plot_options, auto_unbox = TRUE)
  
  create_html(data_json, all_marks, options_json, title, save_as)
}

# Helper function to create HTML
create_html <- function(data_json, marks_js, options_json, title, save_as) {
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
            font-style: italic; 
        }
        .footer {
            margin-top: 30px;
            color: #95a5a6;
            font-size: 12px;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>', title, '</h1>
    <div class="subtitle">Interactive visualization created with plotR</div>
    <div class="plot-container">
        <div id="plot"></div>
    </div>
    <div class="footer">Powered by Observable Plot • Hover for details</div>
    
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
                        ', marks_js, '
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
    cat(paste("📊 Interactive plot saved to:", save_as, "\n"))
    return(invisible(save_as))
  } else {
    temp_file <- tempfile(fileext = ".html")
    writeLines(html_content, temp_file)
    if (interactive()) {
      browseURL(temp_file)
    }
    return(invisible(temp_file))
  }
}

# Basic chart functions
plotR_scatter <- function(data, x, y, fill = NULL, size = NULL, ...) {
  plotR(data = data, mark_type = "dot", x = x, y = y, fill = fill, size = size, ...)
}

plotR_line <- function(data, x, y, stroke = "steelblue", ...) {
  plotR(data = data, mark_type = "line", x = x, y = y, stroke = stroke, ...)
}

plotR_bar <- function(data, x, y, fill = "steelblue", ...) {
  plotR(data = data, mark_type = "barY", x = x, y = y, fill = fill, ...)
}

# Advanced chart functions
plotR_pie <- function(data, labels, values, title = "Pie Chart", save_as = NULL, ...) {
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  marks_js <- paste0('
    Plot.cell(data, Plot.group({fill: "count"}, {
      x: "', labels, '",
      fill: "', values, '"
    }))
  ')
  
  # Simplified approach - create HTML directly
  html_content <- paste0('
<!DOCTYPE html>
<html>
<head>
    <title>', title, '</title>
    <script src="https://unpkg.com/d3@7.9.0/dist/d3.min.js"></script>
    <script src="https://unpkg.com/@observablehq/plot@0.6/dist/plot.umd.min.js"></script>
</head>
<body>
    <h1>', title, '</h1>
    <div id="plot"></div>
    <script>
        const data = ', data_json, ';
        
        // Create pie chart using d3 since Plot doesn\'t have native pie charts
        const width = 600;
        const height = 400;
        const radius = Math.min(width, height) / 2;
        
        const color = d3.scaleOrdinal(d3.schemeCategory10);
        const pie = d3.pie().value(d => d.', values, ');
        const arc = d3.arc().innerRadius(0).outerRadius(radius);
        
        const svg = d3.select("#plot")
          .append("svg")
          .attr("width", width)
          .attr("height", height)
          .append("g")
          .attr("transform", `translate(${width/2},${height/2})`);
        
        const arcs = svg.selectAll("arc")
          .data(pie(data))
          .enter()
          .append("g");
        
        arcs.append("path")
          .attr("d", arc)
          .attr("fill", (d, i) => color(i))
          .append("title")
          .text(d => `${d.data.', labels, '}: ${d.data.', values, '}`);
        
        arcs.append("text")
          .attr("transform", d => `translate(${arc.centroid(d)})`)
          .attr("text-anchor", "middle")
          .text(d => d.data.', labels, ');
    </script>
</body>
</html>')
  
  if (!is.null(save_as)) {
    writeLines(html_content, save_as)
    cat(paste("📊 Pie chart saved to:", save_as, "\n"))
  }
  invisible(save_as)
}

plotR_donut <- function(data, labels, values, title = "Donut Chart", save_as = NULL, ...) {
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  html_content <- paste0('
<!DOCTYPE html>
<html>
<head>
    <title>', title, '</title>
    <script src="https://unpkg.com/d3@7.9.0/dist/d3.min.js"></script>
</head>
<body>
    <h1>', title, '</h1>
    <div id="plot"></div>
    <script>
        const data = ', data_json, ';
        const width = 600;
        const height = 400;
        const radius = Math.min(width, height) / 2;
        
        const color = d3.scaleOrdinal(d3.schemeCategory10);
        const pie = d3.pie().value(d => d.', values, ');
        const arc = d3.arc().innerRadius(radius * 0.4).outerRadius(radius);
        
        const svg = d3.select("#plot")
          .append("svg")
          .attr("width", width)
          .attr("height", height)
          .append("g")
          .attr("transform", `translate(${width/2},${height/2})`);
        
        const arcs = svg.selectAll("arc")
          .data(pie(data))
          .enter()
          .append("g");
        
        arcs.append("path")
          .attr("d", arc)
          .attr("fill", (d, i) => color(i))
          .append("title")
          .text(d => `${d.data.', labels, '}: ${d.data.', values, '}%`);
        
        arcs.append("text")
          .attr("transform", d => `translate(${arc.centroid(d)})`)
          .attr("text-anchor", "middle")
          .text(d => d.data.', labels, ');
    </script>
</body>
</html>')
  
  if (!is.null(save_as)) {
    writeLines(html_content, save_as)
    cat(paste("📊 Donut chart saved to:", save_as, "\n"))
  }
  invisible(save_as)
}

plotR_stacked_dots <- function(data, x, y, fill, title = "Stacked Dots", save_as = NULL, ...) {
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  marks_js <- paste0('
    Plot.dot(data, Plot.stackY2({
      x: "', x, '",
      y: d => d.', fill, ' === "Male" ? d.', y, ' : -d.', y, ',
      fill: "', fill, '",
      r: 3
    })),
    Plot.tip(data, Plot.pointer({
      x: "', x, '",
      title: d => `Age: ${d.', x, '}\\nGender: ${d.', fill, '}\\nCount: ${d.', y, '}`
    }))
  ')
  
  options_json <- jsonlite::toJSON(list(
    grid = TRUE,
    width = 800,
    height = 500,
    marginLeft = 60,
    marginBottom = 50,
    color = list(scheme = "category10", legend = TRUE),
    x = list(label = x),
    y = list(label = "Population")
  ), auto_unbox = TRUE)
  
  create_html(data_json, marks_js, options_json, title, save_as)
}

plotR_bubble_map <- function(data, x, y, size, title = "Bubble Map", save_as = NULL, ...) {
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  marks_js <- paste0('
    Plot.dot(data, {
      x: "', x, '",
      y: "', y, '", 
      r: "', size, '",
      fill: "steelblue",
      fillOpacity: 0.6,
      stroke: "white",
      strokeWidth: 1
    }),
    Plot.tip(data, Plot.pointer({
      x: "', x, '",
      y: "', y, '",
      title: d => `${d.city || "Location"}\\nPopulation: ${d.', size, '.toLocaleString()}`
    }))
  ')
  
  options_json <- jsonlite::toJSON(list(
    width = 700,
    height = 500,
    marginLeft = 60,
    marginBottom = 50,
    r = list(range = c(5, 30)),
    x = list(label = "Longitude"),
    y = list(label = "Latitude")
  ), auto_unbox = TRUE)
  
  create_html(data_json, marks_js, options_json, title, save_as)
}

plotR_stacked_waffle <- function(data, x, fill, y, title = "Stacked Waffle", save_as = NULL, ...) {
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  # Use cell marks to approximate waffle chart
  marks_js <- paste0('
    Plot.cell(data, {
      x: "', x, '",
      fill: "', fill, '",
      y: "', y, '"
    }),
    Plot.tip(data, Plot.pointer({
      x: "', x, '",
      title: d => `${d.', x, '}\\n${d.', fill, '}: ${d.', y, '}`
    }))
  ')
  
  options_json <- jsonlite::toJSON(list(
    width = 600,
    height = 400,
    marginLeft = 80,
    marginBottom = 60,
    color = list(scheme = "category10", legend = TRUE),
    x = list(label = x),
    y = list(label = y)
  ), auto_unbox = TRUE)
  
  create_html(data_json, marks_js, options_json, title, save_as)
}

plotR_isotype <- function(data, category, count, icon, title = "Isotype Chart", save_as = NULL, ...) {
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  html_content <- paste0('
<!DOCTYPE html>
<html>
<head>
    <title>', title, '</title>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        .isotype-row { margin: 20px 0; }
        .isotype-label { font-weight: bold; margin-bottom: 10px; }
        .isotype-icons { font-size: 30px; line-height: 1.2; }
    </style>
</head>
<body>
    <h1>', title, '</h1>
    <div id="plot"></div>
    <script>
        const data = ', data_json, ';
        const container = document.getElementById("plot");
        
        data.forEach(d => {
          const row = document.createElement("div");
          row.className = "isotype-row";
          
          const label = document.createElement("div");
          label.className = "isotype-label";
          label.textContent = d.', category, ';
          row.appendChild(label);
          
          const icons = document.createElement("div");
          icons.className = "isotype-icons";
          const iconCount = Math.round(d.', count, ' / 10); // Scale down for display
          icons.textContent = (d.', icon, ' + " ").repeat(iconCount);
          row.appendChild(icons);
          
          container.appendChild(row);
        });
    </script>
</body>
</html>')
  
  if (!is.null(save_as)) {
    writeLines(html_content, save_as)
    cat(paste("📊 Isotype chart saved to:", save_as, "\n"))
  }
  invisible(save_as)
}

plotR_grid_choropleth <- function(data, x, y, fill, label, title = "Grid Choropleth", save_as = NULL, ...) {
  data_json <- jsonlite::toJSON(data, dataframe = "rows", auto_unbox = TRUE)
  
  marks_js <- paste0('
    Plot.cell(data, {
      x: "', x, '",
      y: "', y, '",
      fill: "', fill, '",
      stroke: "white",
      strokeWidth: 2
    }),
    Plot.text(data, {
      x: "', x, '",
      y: "', y, '",
      text: "', label, '",
      fill: "black",
      fontSize: 12
    }),
    Plot.tip(data, Plot.pointer({
      x: "', x, '",
      y: "', y, '",
      title: d => `${d.', label, '}\\nValue: ${(d.', fill, ' * 100).toFixed(1)}%`
    }))
  ')
  
  options_json <- jsonlite::toJSON(list(
    width = 600,
    height = 400,
    marginLeft = 40,
    marginBottom = 40,
    color = list(scheme = "RdYlBu", type = "diverging", legend = TRUE),
    x = list(axis = NULL),
    y = list(axis = NULL, reverse = TRUE)
  ), auto_unbox = TRUE)
  
  create_html(data_json, marks_js, options_json, title, save_as)
}

# Export all functions to global environment
assign("plotR", plotR, envir = .GlobalEnv)
assign("plotR_scatter", plotR_scatter, envir = .GlobalEnv)
assign("plotR_line", plotR_line, envir = .GlobalEnv)
assign("plotR_bar", plotR_bar, envir = .GlobalEnv)
assign("plotR_pie", plotR_pie, envir = .GlobalEnv)
assign("plotR_donut", plotR_donut, envir = .GlobalEnv)
assign("plotR_stacked_dots", plotR_stacked_dots, envir = .GlobalEnv)
assign("plotR_bubble_map", plotR_bubble_map, envir = .GlobalEnv)
assign("plotR_stacked_waffle", plotR_stacked_waffle, envir = .GlobalEnv)
assign("plotR_isotype", plotR_isotype, envir = .GlobalEnv)
assign("plotR_grid_choropleth", plotR_grid_choropleth, envir = .GlobalEnv)

cat("✅ Professional plotR system loaded!\n")
cat("\n📊 Available chart types:\n")
cat("   • plotR_scatter() - Scatter plots with tooltips\n")
cat("   • plotR_line() - Interactive line charts\n") 
cat("   • plotR_bar() - Bar charts with hover details\n")
cat("   • plotR_pie() - Pie charts\n")
cat("   • plotR_donut() - Donut charts\n")
cat("   • plotR_stacked_dots() - Stacked dot plots\n")
cat("   • plotR_bubble_map() - Bubble maps\n")
cat("   • plotR_stacked_waffle() - Waffle charts\n")
cat("   • plotR_isotype() - Isotype/pictogram charts\n")
cat("   • plotR_grid_choropleth() - Grid choropleth maps\n")
cat("\n🎯 All charts include interactive tooltips!\n")