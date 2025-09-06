#!/usr/bin/env Rscript

# Fix charts using only working Observable Plot marks
cat("🔧 Fixing charts with confirmed working Observable Plot marks...\n\n")

# Load professional plotR system
source("plotR_professional.R")

# Let's use the working plotR functions that we know work instead of creating new ones

# 1. Fix Browser Waffle using working bar chart approach
cat("📊 Creating browser chart using working bar approach...\n")

browser_data <- data.frame(
  browser = c("Chrome", "Safari", "Edge", "Firefox", "Other"),
  share = c(65, 18, 9, 5, 3)
)

# Use the working plotR_bar function
plotR_bar(
  data = browser_data,
  x = "browser",
  y = "share", 
  title = "Browser Market Share 2023",
  save_as = "gallery_fixed/browser_waffle.html"
)

# 2. Fix Energy using working pie chart function
cat("📊 Creating energy chart using working pie function...\n")

energy_data <- data.frame(
  source = c("Natural Gas", "Coal", "Nuclear", "Renewable", "Petroleum"),
  percentage = c(32, 24, 19, 17, 8)
)

# Use the working plotR_pie function
plotR_pie(
  data = energy_data,
  labels = "source",
  values = "percentage",
  title = "US Energy Production by Source 2023", 
  save_as = "gallery_fixed/energy_pie.html"
)

# 3. Fix Grid using working scatter approach with size encoding
cat("📊 Creating grid using working scatter approach...\n")

grid_data <- data.frame(
  state = c("WA", "OR", "CA", "NV", "ID", "UT", "AZ", "MT", "WY", "CO", "NM"),
  x = c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3),
  y = c(1, 2, 3, 2, 1, 2, 3, 1, 2, 3, 4),
  population = c(7.7, 4.2, 39.5, 3.1, 1.8, 3.3, 7.3, 1.1, 0.6, 5.8, 2.1)
)

# Use working scatter plot with size encoding to simulate grid
plotR_scatter(
  data = grid_data,
  x = "x",
  y = "y",
  size = "population",
  fill = "population",
  title = "Western US States Population Grid",
  save_as = "gallery_fixed/us_population_grid.html"
)

# 4. Let's also create a working waffle-style chart using multiple small bars
cat("📊 Creating true waffle using stacked approach...\n")

# Create waffle data with small squares
waffle_squares <- data.frame()
browsers <- c("Chrome", "Safari", "Edge", "Firefox", "Other") 
shares <- c(65, 18, 9, 5, 3)

square_id <- 1
for (i in 1:length(browsers)) {
  n_squares <- shares[i]
  for (j in 1:n_squares) {
    row <- ceiling(square_id / 10)  # 10 squares per row
    col <- ((square_id - 1) %% 10) + 1
    
    waffle_squares <- rbind(waffle_squares, data.frame(
      browser = browsers[i],
      share = shares[i],
      x = col,
      y = row,
      square_id = square_id
    ))
    square_id <- square_id + 1
  }
}

# Use scatter plot to create waffle effect
plotR_scatter(
  data = waffle_squares,
  x = "x", 
  y = "y",
  fill = "browser",
  size = rep(50, nrow(waffle_squares)),  # Fixed size for squares
  title = "Browser Market Share - Waffle Chart (Each dot = 1%)",
  save_as = "gallery_fixed/browser_waffle_squares.html"
)

cat("\n✅ All charts fixed using proven plotR functions!\n")
cat("📂 Updated files in gallery_fixed/ folder:\n")
cat("   • browser_waffle.html (bar chart version)\n")
cat("   • energy_pie.html (working pie chart)\n")
cat("   • us_population_grid.html (scatter with size encoding)\n") 
cat("   • browser_waffle_squares.html (true waffle as scatter)\n")
cat("\n🌐 All charts should now render without errors!\n")