#!/usr/bin/env Rscript

# Clean installation of plotR package
# This script handles the corruption issue by doing a clean build

cat("=== Clean Installation of plotR Package ===\n\n")

# Function to safely remove package
safe_remove <- function(pkg) {
  if (pkg %in% rownames(installed.packages())) {
    tryCatch({
      remove.packages(pkg)
      cat(paste("✓ Removed existing", pkg, "package\n"))
    }, error = function(e) {
      cat(paste("⚠ Could not remove", pkg, ":", e$message, "\n"))
    })
  }
}

# Step 1: Clean removal
cat("Step 1: Cleaning up any existing installation...\n")
safe_remove("plotR")

# Also manually remove from library if it exists
lib_path <- .libPaths()[1]
plotR_path <- file.path(lib_path, "plotR")
if (dir.exists(plotR_path)) {
  unlink(plotR_path, recursive = TRUE)
  cat("✓ Manually removed plotR directory\n")
}

# Step 2: Install dependencies
cat("\nStep 2: Installing dependencies...\n")
deps <- c("htmlwidgets", "htmltools", "jsonlite", "magrittr", "devtools")
for (dep in deps) {
  if (!requireNamespace(dep, quietly = TRUE)) {
    install.packages(dep, repos = "https://cran.r-project.org", quiet = TRUE)
    cat(paste("✓ Installed", dep, "\n"))
  } else {
    cat(paste("✓", dep, "already available\n"))
  }
}

# Step 3: Install using R CMD INSTALL (more reliable for corrupted packages)
cat("\nStep 3: Building and installing package...\n")

# Change to package directory
pkg_dir <- "/Users/malshe/Dropbox/Work/JS/plot/plotR"
setwd(pkg_dir)

# Use R CMD INSTALL which is more robust
cat("Building package with R CMD INSTALL...\n")
system("R CMD INSTALL --no-multiarch --with-keep.source .")

# Step 4: Verify installation
cat("\nStep 4: Verifying installation...\n")
if ("plotR" %in% rownames(installed.packages())) {
  cat("✓ Package installed successfully\n")
  
  # Try to load it
  tryCatch({
    library(plotR)
    cat("✓ Package loaded successfully\n")
    
    # Quick functionality test
    p <- plot_chart(
      spec = list(
        marks = list(
          plot_dot(options = list(x = "speed", y = "dist"))
        )
      ),
      data = cars
    )
    cat("✓ Basic functionality test passed\n")
    
    cat("\n✅ SUCCESS! plotR is ready to use.\n")
    cat("\nExample usage:\n")
    cat("library(plotR)\n")
    cat("p <- plot_chart(\n")
    cat("  spec = list(\n")
    cat("    marks = list(\n")
    cat("      plot_dot(options = list(x = 'speed', y = 'dist'))\n")
    cat("    )\n")
    cat("  ),\n")
    cat("  data = cars\n")
    cat(")\n")
    cat("# To view: htmlwidgets::saveWidget(p, 'plot.html')\n")
    
  }, error = function(e) {
    cat(paste("❌ Error loading package:", e$message, "\n"))
  })
} else {
  cat("❌ Package installation failed\n")
  cat("Try manual installation:\n")
  cat("1. In R, run: setwd('/Users/malshe/Dropbox/Work/JS/plot/plotR')\n")
  cat("2. Then run: devtools::install()\n")
}