# Installation and Testing Instructions for plotR

## Prerequisites

Make sure you have R installed with the following packages:
- devtools
- htmlwidgets
- jsonlite
- magrittr
- htmltools

## Installation Steps

1. **Navigate to the plotR directory** in R:
```r
setwd("/Users/malshe/Dropbox/Work/JS/plot/plotR")
```

2. **Install the package**:
```r
# Run the installation script
source("install_package.R")
```

Or manually:
```r
library(devtools)
devtools::install(".", dependencies = TRUE)
```

3. **Load the package**:
```r
library(plotR)
```

## Testing the Package

### Quick Test
```r
# Simple scatter plot
library(plotR)
p <- plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist"))
    )
  ),
  data = cars
)

# Save to HTML to view
library(htmlwidgets)
saveWidget(p, "test.html", selfcontained = TRUE)
# Then open test.html in a web browser
```

### Run All Examples
```r
source("examples.R")
# This will create multiple HTML files with different chart types
```

## Troubleshooting

If plots don't render:

1. **Check console for errors** - Open the browser developer console (F12) when viewing the HTML file

2. **Verify Plot library is loaded**:
   - Check that `/inst/htmlwidgets/lib/plot/plot.min.js` exists
   - The file should be about 200KB

3. **Test the Plot library directly**:
   - Open `simple_test.html` in a browser
   - This tests if the Plot library works independently

4. **Reinstall if needed**:
```r
remove.packages("plotR")
source("install_package.R")
```

## Using in RStudio

The plots should display in the RStudio Viewer pane. If not, save to HTML:

```r
p <- plot_chart(...)
htmlwidgets::saveWidget(p, "myplot.html")
browseURL("myplot.html")
```

## Using in R Markdown

```r
---
output: html_document
---

```{r}
library(plotR)
plot_chart(
  spec = list(
    marks = list(
      plot_dot(options = list(x = "speed", y = "dist"))
    )
  ),
  data = cars
)
```
```

## Using in Shiny

```r
library(shiny)
library(plotR)

ui <- fluidPage(
  plot_output("myplot")
)

server <- function(input, output) {
  output$myplot <- render_plot({
    plot_chart(
      spec = list(
        marks = list(
          plot_dot(options = list(x = "speed", y = "dist"))
        )
      ),
      data = cars
    )
  })
}

shinyApp(ui, server)
```