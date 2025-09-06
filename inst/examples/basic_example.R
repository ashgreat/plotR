# Basic examples of using plotR package

library(plotR)

# Example 1: Simple scatter plot
plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist"))
    )
  ),
  data = cars
)

# Example 2: Line chart
plot_chart(
  spec = list(
    marks = list(
      plot_line(options = list(x = "speed", y = "dist", stroke = "steelblue"))
    )
  ),
  data = cars
)

# Example 3: Bar chart
plot_chart(
  spec = list(
    marks = list(
      plot_barY(options = list(x = "speed", y = "dist", fill = "orange"))
    )
  ),
  data = cars
)

# Example 4: Multiple marks
plot_chart(
  spec = list(
    marks = list(
      plot_gridY(),
      plot_dot(options = list(x = "speed", y = "dist", fill = "blue")),
      plot_line(options = list(x = "speed", y = "dist", stroke = "red"))
    ),
    grid = TRUE
  ),
  data = cars
)

# Example 5: Using mtcars data with grouping
plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(
        x = "wt", 
        y = "mpg", 
        fill = "cyl",
        r = 5
      ))
    ),
    color = list(scheme = "category10")
  ),
  data = mtcars
)