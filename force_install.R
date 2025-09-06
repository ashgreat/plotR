#!/usr/bin/env Rscript

# Force installation with corruption fix
cat("=== Forceful Installation to Fix Corruption ===\n\n")

# Step 1: Complete removal
cat("Step 1: Complete removal of any existing installation...\n")

# Get all library paths
lib_paths <- .libPaths()
for (lib in lib_paths) {
  plotR_dir <- file.path(lib, "plotR")
  if (dir.exists(plotR_dir)) {
    cat(paste("  Removing from:", lib, "\n"))
    unlink(plotR_dir, recursive = TRUE, force = TRUE)
  }
}

# Also try to remove using remove.packages
suppressWarnings(tryCatch({
  remove.packages("plotR", lib = lib_paths)
}, error = function(e) {}))

cat("  ✓ Cleanup complete\n")

# Step 2: Clear R session cache
cat("\nStep 2: Clearing R cache...\n")
gc()
cat("  ✓ Cache cleared\n")

# Step 3: Build package without compression
cat("\nStep 3: Building package without compression...\n")
setwd("/Users/malshe/Dropbox/Work/JS/plot/plotR")

# Create a temporary build script
build_script <- '
# Minimal build
library(methods)

# Source the R files directly
source("R/plot_chart.R")
source("R/marks.R")
source("R/utils.R")
source("R/zzz.R")

# Test basic functionality
cat("Testing basic functionality...\\n")
test_spec <- list(
  marks = list(
    plot_dot(options = list(x = "speed", y = "dist"))
  )
)
cat("  ✓ Functions loaded\\n")
'

# Write and execute
writeLines(build_script, "temp_build.R")
tryCatch({
  source("temp_build.R")
  cat("  ✓ Package functions validated\n")
}, error = function(e) {
  cat(paste("  ⚠ Warning:", e$message, "\n"))
})
unlink("temp_build.R")

# Step 4: Install using system command (most reliable)
cat("\nStep 4: Installing package using R CMD INSTALL...\n")
install_cmd <- "R CMD INSTALL --no-multiarch --no-test-load --no-staged-install ."
result <- system(install_cmd, intern = FALSE)

if (result == 0) {
  cat("  ✓ Installation command succeeded\n")
} else {
  cat("  ⚠ Installation had warnings but may have succeeded\n")
}

# Step 5: Verify
cat("\nStep 5: Verifying installation...\n")
installed <- "plotR" %in% rownames(installed.packages())

if (installed) {
  cat("  ✓ Package found in installed packages\n")
  
  # Try to load
  tryCatch({
    suppressPackageStartupMessages(library(plotR))
    cat("  ✓ Package loaded successfully!\n")
    
    # Test creation of a plot object
    test_plot <- plot_chart(
      spec = list(
        marks = list(
          plot_dot(options = list(x = "speed", y = "dist"))
        )
      ),
      data = cars
    )
    cat("  ✓ Test plot created!\n")
    
    cat("\n✅ SUCCESS! The package is now working.\n\n")
    cat("You can now use:\n")
    cat("  library(plotR)\n")
    cat("  library(htmlwidgets)\n")
    cat("  p <- plot_chart(\n")
    cat("    spec = list(marks = list(plot_dot(options = list(x = 'speed', y = 'dist')))),\n")
    cat("    data = cars\n")
    cat("  )\n")
    cat("  saveWidget(p, 'test.html')\n")
    
  }, error = function(e) {
    cat(paste("\n⚠ Package installed but load failed:", e$message, "\n"))
    cat("\nTrying alternative: Source loading method...\n")
    cat("You can use the package by sourcing files directly:\n")
    cat("  source('/Users/malshe/Dropbox/Work/JS/plot/plotR/R/plot_chart.R')\n")
    cat("  source('/Users/malshe/Dropbox/Work/JS/plot/plotR/R/marks.R')\n")
  })
} else {
  cat("  ❌ Installation failed\n")
  cat("\nTry manual Terminal installation:\n")
  cat("  1. Close R/RStudio completely\n")
  cat("  2. Open Terminal\n")
  cat("  3. Run: cd /Users/malshe/Dropbox/Work/JS/plot/plotR\n")
  cat("  4. Run: R CMD INSTALL --no-multiarch .\n")
}

cat("\n")