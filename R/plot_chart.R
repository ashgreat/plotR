#' Create an Observable Plot chart
#'
#' Create an interactive data visualization using Observable Plot
#'
#' @param spec A list containing the plot specification including marks and options
#' @param data Optional data frame to use with the plot
#' @param width Width of the plot in pixels (NULL for automatic sizing)
#' @param height Height of the plot in pixels (NULL for automatic sizing)
#' @param elementId HTML element ID for the widget
#'
#' @return An htmlwidget object
#'
#' @examples
#' \dontrun{
#' # Simple scatter plot
#' plot_chart(
#'   spec = list(
#'     marks = list(
#'       Plot.dot(cars, list(x = "speed", y = "dist"))
#'     )
#'   ),
#'   data = cars
#' )
#' }
#'
#' @import htmlwidgets
#' @export
plot_chart <- function(spec = list(), data = NULL, width = NULL, height = NULL, 
                       elementId = NULL) {
  
  # If data is provided, convert to list for JSON serialization
  if (!is.null(data)) {
    # Convert data frame to list of rows for JavaScript
    # Keep as R list/data.frame - htmlwidgets will handle JSON conversion
    data <- as.data.frame(data)
  }
  
  # Create the widget data
  x <- list(
    spec = spec,
    data = data
  )
  
  # Remove NULL values
  x <- Filter(Negate(is.null), x)
  
  # Create the widget
  htmlwidgets::createWidget(
    name = 'plotR',
    x = x,
    width = width,
    height = height,
    package = 'plotR',
    elementId = elementId,
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

#' Shiny output binding for plotR
#'
#' @param outputId Output variable to read from
#' @param width Width of the plot 
#' @param height Height of the plot
#'
#' @export
plot_output <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'plotR', width, height, package = 'plotR')
}

#' Shiny render binding for plotR
#'
#' @param expr An expression that generates a plotR chart
#' @param env The environment in which to evaluate expr
#' @param quoted Is expr a quoted expression
#'
#' @export
render_plot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) }
  htmlwidgets::shinyRenderWidget(expr, plot_output, env, quoted = TRUE)
}