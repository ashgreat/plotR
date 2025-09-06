#!/usr/bin/env Rscript

# Prepare plotR package for GitHub release

cat("🚀 Preparing plotR package for GitHub...\n\n")

# Load required libraries
if (!require(devtools)) install.packages("devtools")

# 1. Generate all examples
cat("📊 Generating all chart examples...\n")
source("generate_examples.R")

cat("\n📝 Updating package documentation...\n")

# 2. Update DESCRIPTION file
desc_content <- '
Package: plotR
Type: Package
Title: Interactive Data Visualization with Observable Plot
Version: 1.0.0
Date: 2025-01-06
Authors@R: c(
    person("Your Name", "Your Last", 
           email = "your.email@example.com", 
           role = c("aut", "cre"),
           comment = c(ORCID = "0000-0000-0000-0000"))
    )
Maintainer: Your Name <your.email@example.com>
Description: An R interface to Observable Plot, a JavaScript library for 
    exploratory data visualization. Create expressive, interactive charts 
    with a concise grammar of graphics including scatter plots, bar charts, 
    line charts, pie charts, bubble maps, waffle charts, and more.
License: MIT + file LICENSE
URL: https://github.com/yourusername/plotR
BugReports: https://github.com/yourusername/plotR/issues
Encoding: UTF-8
LazyData: false
LazyLoad: no
Depends:
    R (>= 4.0.0)
Imports:
    htmltools,
    jsonlite,
    magrittr
Suggests:
    knitr,
    rmarkdown,
    testthat (>= 3.0.0),
    dplyr
RoxygenNote: 7.3.3
VignetteBuilder: knitr
Roxygen: list(markdown = TRUE)
'

writeLines(trimws(desc_content), "DESCRIPTION")

# 3. Create LICENSE file
license_content <- '
MIT License

Copyright (c) 2025 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'

writeLines(trimws(license_content), "LICENSE")

# 4. Create NEWS.md
news_content <- '
# plotR 1.0.0

## New Features

* Initial release of plotR package
* Support for basic chart types: scatter, line, bar, pie, donut
* Advanced visualizations: stacked dots, bubble maps, waffle charts, isotype charts, grid choropleths
* Interactive tooltips with customizable templates
* Full integration with Observable Plot JavaScript library
* Responsive design and professional styling
* Comprehensive documentation with examples and vignettes

## Chart Types

* `plotR_scatter()` - Interactive scatter plots with color and size encoding
* `plotR_line()` - Line charts for time series and continuous data
* `plotR_bar()` - Bar charts with hover details
* `plotR_pie()` - Pie charts for categorical proportions
* `plotR_donut()` - Donut charts with improved readability
* `plotR_stacked_dots()` - Population pyramid style visualizations
* `plotR_bubble_map()` - Geographic bubble maps
* `plotR_stacked_waffle()` - Square pie charts for part-to-whole relationships
* `plotR_isotype()` - Pictogram charts with emoji icons
* `plotR_grid_choropleth()` - Grid-based choropleth maps

## Features

* Rich interactive tooltips with emoji support
* Automatic responsive sizing
* Professional color schemes
* Grammar of graphics approach
* Seamless R integration
* Standalone HTML output
* No external dependencies for end users
'

writeLines(trimws(news_content), "NEWS.md")

# 5. Update main R function files with proper documentation
cat("📚 Updating function documentation...\n")

# Copy the professional plotR system to main R directory
file.copy("plotR_professional.R", "R/plotR-main.R", overwrite = TRUE)

# 6. Document the package
devtools::document()

# 7. Create .gitignore
gitignore_content <- '
# R specific
.Rproj.user
.Rhistory
.RData
.Ruserdata
*.Rproj

# Output files
*.html
examples/
screenshots/*.png
*.png

# System files
.DS_Store
Thumbs.db

# Temporary files
*~
*.tmp
*.temp

# IDE
.vscode/
*.swp
*.swo

# Build artifacts
*.tar.gz
*.zip
'

writeLines(trimws(gitignore_content), ".gitignore")

# 8. Create package startup message
startup_content <- '
#' Package startup message
.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "plotR: Interactive Data Visualization with Observable Plot\n",
    "📊 Create beautiful, interactive charts with R\n", 
    "🎯 All charts include hover tooltips\n",
    "📖 See vignette(\\"getting-started\\") for examples\n",
    "🐛 Report issues: https://github.com/yourusername/plotR/issues"
  )
}
'

writeLines(startup_content, "R/zzz.R")

# 9. Build and check package
cat("\n🔍 Building and checking package...\n")
devtools::document()

# 10. Create setup instructions for GitHub
github_setup <- '
# GitHub Setup Instructions for plotR

## 1. Create GitHub Repository

1. Go to GitHub.com and create a new repository named "plotR"
2. Make it public
3. Don\'t initialize with README (we already have one)

## 2. Push to GitHub

In your terminal, navigate to the plotR directory and run:

```bash
# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: plotR v1.0.0 - Interactive data visualization with Observable Plot"

# Add remote origin (replace yourusername with your GitHub username)
git remote add origin https://github.com/yourusername/plotR.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## 3. Add Screenshots

1. Run: source("generate_examples.R") 
2. Open each HTML file in examples/ folder
3. Take screenshots of each visualization
4. Save as PNG files in screenshots/ folder with names:
   - scatter_plot.png
   - bar_chart.png
   - line_chart.png
   - pie_chart.png
   - donut_chart.png
   - stacked_dots.png
   - bubble_map.png
   - stacked_waffle.png
   - isotype_chart.png
   - grid_choropleth.png

## 4. Update Repository Settings

1. Go to repository Settings > Pages
2. Enable GitHub Pages from main branch
3. Add repository description: "Interactive data visualization for R using Observable Plot"
4. Add topics: r, data-visualization, observable-plot, interactive-charts, htmlwidgets

## 5. Create First Release

1. Go to Releases > Create a new release
2. Tag: v1.0.0
3. Title: "plotR v1.0.0 - Interactive Data Visualization"
4. Description: Copy from NEWS.md
5. Attach generated example files

## 6. Update README

Replace "yourusername" in README.md with your actual GitHub username.

## Ready to Share! 🚀

Your package is now ready for the R community!
'

writeLines(github_setup, "GITHUB_SETUP.md")

cat("\n✅ Package preparation complete!\n\n")

cat("📦 Package structure:\n")
cat("   ├── R/                     # R functions\n")
cat("   ├── inst/htmlwidgets/      # JavaScript assets\n") 
cat("   ├── vignettes/            # Documentation\n")
cat("   ├── examples/             # Generated examples\n")
cat("   ├── screenshots/          # Screenshot placeholders\n")
cat("   ├── DESCRIPTION           # Package metadata\n")
cat("   ├── README.md             # Main documentation\n")
cat("   ├── NEWS.md               # Version history\n")
cat("   └── LICENSE               # MIT license\n")

cat("\n📋 Next steps:\n")
cat("   1. Review GITHUB_SETUP.md for detailed instructions\n")
cat("   2. Take screenshots of the generated examples\n")
cat("   3. Update README.md with your GitHub username\n")
cat("   4. Initialize git and push to GitHub\n")
cat("   5. Create first release with examples\n")

cat("\n🎯 Example files generated in examples/ folder:\n")
examples <- list.files("examples", pattern = "\\.html$")
for (ex in examples) {
  cat(paste("   •", ex, "\n"))
}

cat("\n🎉 plotR is ready for the world! 🌍✨\n")