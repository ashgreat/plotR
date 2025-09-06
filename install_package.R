#!/usr/bin/env Rscript

# Install the plotR package

cat("Installing plotR package...\n")

# Check and install dependencies
required_packages <- c("htmlwidgets", "htmltools", "jsonlite", "magrittr", "devtools")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat(paste("Installing", pkg, "...\n"))
    install.packages(pkg, repos = "https://cran.r-project.org")
  }
}

# Install the package from the current directory
library(devtools)
devtools::install(pkg = ".", dependencies = TRUE, build_vignettes = FALSE)

cat("\nPackage installed successfully!\n")
cat("\nTo test the package, run:\n")
cat("  library(plotR)\n")
cat("  # Simple test\n")
cat("  plot_chart(\n")
cat("    spec = list(\n")
cat("      marks = list(\n")
cat("        plot_dot(options = list(x = 'speed', y = 'dist'))\n")
cat("      )\n")
cat("    ),\n")
cat("    data = cars\n")
cat("  )\n")

# Try to load and test
tryCatch({
  library(plotR)
  cat("\nPackage loaded successfully!\n")
}, error = function(e) {
  cat("\nError loading package:", e$message, "\n")
})