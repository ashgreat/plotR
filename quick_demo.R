#!/usr/bin/env Rscript

# Quick demo that should work

cat("Loading plotR system...\n")
source("/Users/malshe/Dropbox/Work/JS/plot/plotR/plotR_complete.R")

cat("\nCreating simple demo plot...\n")
plotR_scatter(
  data = cars[1:10, ], # Just first 10 points for testing
  x = "speed", 
  y = "dist",
  title = "Cars: Speed vs Distance (Demo)",
  save_as = "quick_demo.html"
)

cat("✅ Demo plot saved to quick_demo.html\n")
cat("This should have interactive tooltips that work!\n")