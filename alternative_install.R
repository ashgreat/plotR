#!/usr/bin/env Rscript

# Alternative installation method for plotR
# Use this if the other methods fail

cat("=== Alternative Installation Method ===\n\n")

# Method 1: Using remotes package (often more reliable than devtools)
cat("Method 1: Using remotes package\n")
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# First remove any corrupted installation
tryCatch({
  remove.packages("plotR")
}, error = function(e) {
  # Ignore error if package doesn't exist
})

# Clean library path
lib_path <- .libPaths()[1]
plotR_path <- file.path(lib_path, "plotR")
if (dir.exists(plotR_path)) {
  unlink(plotR_path, recursive = TRUE, force = TRUE)
}

# Install using remotes
library(remotes)
remotes::install_local(
  path = "/Users/malshe/Dropbox/Work/JS/plot/plotR",
  force = TRUE,
  upgrade = "never"
)

# Test
if ("plotR" %in% rownames(installed.packages())) {
  cat("\n✅ Package installed!\n")
  library(plotR)
  cat("✅ Package loaded!\n")
} else {
  cat("\n")
  cat("If this doesn't work, try Method 2:\n\n")
  cat("Method 2: Manual R CMD INSTALL\n")
  cat("1. Open Terminal (not R)\n")
  cat("2. Navigate to the directory:\n")
  cat("   cd /Users/malshe/Dropbox/Work/JS/plot\n")
  cat("3. Run:\n")
  cat("   R CMD INSTALL plotR\n")
  cat("4. Then in R, run:\n")
  cat("   library(plotR)\n")
}