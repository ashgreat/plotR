#' Create Plot marks for use in plot_chart
#'
#' These functions create mark specifications that can be used with plot_chart.
#' They mirror the JavaScript Plot.* mark functions.
#'
#' @name plot_marks
#' @rdname plot_marks
NULL

#' @describeIn plot_marks Create a dot mark
#' @param data Data frame or NULL to use data from plot_chart
#' @param options List of options for the mark (x, y, fill, r, etc.)
#' @export
plot_dot <- function(data = NULL, options = list()) {
  mark <- list(
    type = "dot",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a line mark  
#' @export
plot_line <- function(data = NULL, options = list()) {
  mark <- list(
    type = "line",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a bar mark for vertical bars
#' @export
plot_barY <- function(data = NULL, options = list()) {
  mark <- list(
    type = "barY",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a bar mark for horizontal bars
#' @export
plot_barX <- function(data = NULL, options = list()) {
  mark <- list(
    type = "barX",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create an area mark
#' @export
plot_area <- function(data = NULL, options = list()) {
  mark <- list(
    type = "area",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a rect mark
#' @export
plot_rect <- function(data = NULL, options = list()) {
  mark <- list(
    type = "rect",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a text mark
#' @export
plot_text <- function(data = NULL, options = list()) {
  mark <- list(
    type = "text",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a cell mark
#' @export
plot_cell <- function(data = NULL, options = list()) {
  mark <- list(
    type = "cell",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a rule mark for vertical lines
#' @export
plot_ruleX <- function(data = NULL, options = list()) {
  mark <- list(
    type = "ruleX",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a rule mark for horizontal lines
#' @export
plot_ruleY <- function(data = NULL, options = list()) {
  mark <- list(
    type = "ruleY",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a link mark
#' @export
plot_link <- function(data = NULL, options = list()) {
  mark <- list(
    type = "link",
    options = options
  )
  if (!is.null(data)) {
    mark$data <- data
  } else {
    mark$data <- "@@data@@"
  }
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a frame mark
#' @export
plot_frame <- function(options = list()) {
  mark <- list(
    type = "frame",
    options = options
  )
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create an axisX mark
#' @export
plot_axisX <- function(options = list()) {
  mark <- list(
    type = "axisX",
    options = options
  )
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create an axisY mark
#' @export
plot_axisY <- function(options = list()) {
  mark <- list(
    type = "axisY",
    options = options
  )
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a gridX mark
#' @export
plot_gridX <- function(options = list()) {
  mark <- list(
    type = "gridX",
    options = options
  )
  structure(mark, class = c("plot_mark", "list"))
}

#' @describeIn plot_marks Create a gridY mark
#' @export
plot_gridY <- function(options = list()) {
  mark <- list(
    type = "gridY",
    options = options
  )
  structure(mark, class = c("plot_mark", "list"))
}