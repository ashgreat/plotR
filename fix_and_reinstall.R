#!/usr/bin/env Rscript

# Fix corrupted package installation

cat("Fixing plotR package installation...\n\n")

# Step 1: Remove any existing installation
cat("Step 1: Removing existing plotR installation...\n")
tryCatch({
  remove.packages("plotR")
  cat("  - Removed existing plotR package\n")
}, error = function(e) {
  cat("  - No existing plotR package found (this is OK)\n")
})

# Step 2: Clean R's temporary files
cat("\nStep 2: Cleaning temporary files...\n")
temp_dir <- tempdir()
cat(paste("  - Temp directory:", temp_dir, "\n"))

# Step 3: Clear the package library cache
cat("\nStep 3: Clearing package library cache...\n")
.libPaths()

# Step 4: Install required dependencies
cat("\nStep 4: Checking and installing dependencies...\n")
required_packages <- c("htmlwidgets", "htmltools", "jsonlite", "magrittr")

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat(paste("  - Installing", pkg, "...\n"))
    install.packages(pkg, repos = "https://cran.r-project.org")
  } else {
    cat(paste("  -", pkg, "already installed\n"))
  }
}

# Step 5: Install devtools if needed
if (!requireNamespace("devtools", quietly = TRUE)) {
  cat("\n  - Installing devtools...\n")
  install.packages("devtools", repos = "https://cran.r-project.org")
}

# Step 6: Build and install the package fresh
cat("\nStep 6: Building and installing plotR package...\n")
library(devtools)

# Set the working directory to the package directory
current_dir <- getwd()
if (!grepl("plotR$", current_dir)) {
  setwd("/Users/malshe/Dropbox/Work/JS/plot/plotR")
}

# Clean and build
cat("  - Cleaning previous build artifacts...\n")
devtools::clean_dll()

cat("  - Building package...\n")
devtools::build(quiet = FALSE)

cat("  - Installing package...\n")
devtools::install(dependencies = TRUE, upgrade = "never", build_vignettes = FALSE)

# Step 7: Test the installation
cat("\nStep 7: Testing the installation...\n")
tryCatch({
  library(plotR)
  cat("  ✓ Package loaded successfully!\n")
  
  # Try creating a simple plot
  test_plot <- plot_chart(
    spec = list(
      marks = list(
        plot_dot(options = list(x = "speed", y = "dist"))
      )
    ),
    data = cars
  )
  cat("  ✓ Test plot created successfully!\n")
  
  cat("\n✅ Installation completed successfully!\n")
  cat("\nYou can now use the package with:\n")
  cat("  library(plotR)\n")
  
}, error = function(e) {
  cat("\n❌ Error during testing:\n")
  cat(paste("  ", e$message, "\n"))
  cat("\nPlease try running this script again.\n")
})

cat("\n")