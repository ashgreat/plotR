# Standalone version of plotR - no installation required
# Source this file to use plotR functions without installing the package

cat("Loading plotR functions (standalone mode)...\n")

# Load required libraries
if (!require(htmlwidgets)) stop("Please install htmlwidgets: install.packages('htmlwidgets')")
if (!require(jsonlite)) stop("Please install jsonlite: install.packages('jsonlite')")

# Set the base path
plotR_base <- "/Users/malshe/Dropbox/Work/JS/plot/plotR"

# Source the R functions
source(file.path(plotR_base, "R", "utils.R"))
source(file.path(plotR_base, "R", "marks.R"))

# Modified plot_chart function for standalone use
plot_chart <- function(spec = list(), data = NULL, width = NULL, height = NULL, 
                       elementId = NULL) {
  
  # If data is provided, convert to list for JSON serialization
  if (!is.null(data)) {
    data <- as.data.frame(data)
  }
  
  # Create the widget data
  x <- list(
    spec = spec,
    data = data
  )
  
  # Remove NULL values
  x <- Filter(Negate(is.null), x)
  
  # Get the dependencies - D3 first, then Plot, then our binding
  d3_dep <- htmltools::htmlDependency(
    name = "d3",
    version = "7.9.0",
    src = file.path(plotR_base, "inst", "htmlwidgets", "lib", "d3"),
    script = "d3.min.js"
  )
  
  plot_dep <- htmltools::htmlDependency(
    name = "plot",
    version = "0.6.17",
    src = file.path(plotR_base, "inst", "htmlwidgets", "lib", "plot"),
    script = "plot.min.js"
  )
  
  plotR_binding_dep <- htmltools::htmlDependency(
    name = "plotR-binding",
    version = "0.1.0",
    src = file.path(plotR_base, "inst", "htmlwidgets"),
    script = "plotR.js"
  )
  
  # Create the widget with explicit dependencies
  htmlwidgets::createWidget(
    name = 'plotR',
    x = x,
    width = width,
    height = height,
    elementId = elementId,
    dependencies = list(d3_dep, plot_dep, plotR_binding_dep),
    sizingPolicy = htmlwidgets::sizingPolicy(
      defaultWidth = "100%",
      defaultHeight = 400,
      viewer.defaultWidth = "100%",
      viewer.defaultHeight = "100%",
      browser.defaultWidth = "100%",
      browser.defaultHeight = 400,
      knitr.defaultWidth = "100%",
      knitr.defaultHeight = 400,
      knitr.figure = FALSE
    )
  )
}

# Shiny functions
plot_output <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'plotR', width, height, 
                                 package = NULL,
                                 inline = FALSE,
                                 reportSize = TRUE)
}

render_plot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) }
  htmlwidgets::shinyRenderWidget(expr, plot_output, env, quoted = TRUE)
}

# Export functions to global environment
assign("plot_chart", plot_chart, envir = .GlobalEnv)
assign("plot_output", plot_output, envir = .GlobalEnv)
assign("render_plot", render_plot, envir = .GlobalEnv)

# Also export all mark functions
mark_functions <- ls(pattern = "^plot_", envir = environment())
for (fn in mark_functions) {
  assign(fn, get(fn), envir = .GlobalEnv)
}

cat("✓ plotR functions loaded successfully!\n")
cat("\nExample usage:\n")
cat("  p <- plot_chart(\n")
cat("    spec = list(marks = list(plot_dot(options = list(x = 'speed', y = 'dist')))),\n")
cat("    data = cars\n")
cat("  )\n")
cat("  htmlwidgets::saveWidget(p, 'test.html')\n")