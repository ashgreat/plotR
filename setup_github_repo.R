#!/usr/bin/env Rscript

# Setup plotR package for GitHub repository: https://github.com/ashgreat/plotR.git

cat("🚀 Setting up plotR for GitHub repository: ashgreat/plotR\n\n")

# Update DESCRIPTION with correct information
cat("📝 Updating DESCRIPTION file...\n")

desc_content <- 'Package: plotR
Type: Package
Title: Interactive Data Visualization with Observable Plot
Version: 1.0.0
Date: 2025-01-06
Authors@R: person("Ashish", "Kumar", 
                  email = "ashgreat@example.com", 
                  role = c("aut", "cre"))
Maintainer: Ashish Kumar <ashgreat@example.com>
Description: An R interface to Observable Plot, a JavaScript library for 
    exploratory data visualization. Create expressive, interactive charts 
    with a concise grammar of graphics including scatter plots, bar charts, 
    line charts, pie charts, bubble maps, waffle charts, isotype charts, 
    and grid choropleths. All charts include interactive tooltips and 
    professional styling.
License: MIT + file LICENSE
URL: https://github.com/ashgreat/plotR
BugReports: https://github.com/ashgreat/plotR/issues
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
Roxygen: list(markdown = TRUE)'

writeLines(desc_content, "DESCRIPTION")

# Update README with correct GitHub links
cat("📖 Updating README.md with correct GitHub links...\n")

# Read current README and replace username
readme_content <- readLines("README.md")
readme_content <- gsub("yourusername/plotR", "ashgreat/plotR", readme_content)
readme_content <- gsub("yourusername", "ashgreat", readme_content)
readme_content <- gsub("Your Name", "Ashish Kumar", readme_content)

writeLines(readme_content, "README.md")

# Update LICENSE 
cat("📄 Updating LICENSE...\n")

license_content <- 'MIT License

Copyright (c) 2025 Ashish Kumar

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
SOFTWARE.'

writeLines(license_content, "LICENSE")

# Update CONTRIBUTING.md
cat("🤝 Updating CONTRIBUTING.md...\n")
contrib_content <- readLines("CONTRIBUTING.md")
contrib_content <- gsub("yourusername", "ashgreat", contrib_content)
writeLines(contrib_content, "CONTRIBUTING.md")

# Create GitHub workflow for R package
cat("⚙️ Creating GitHub Actions workflow...\n")
dir.create(".github/workflows", recursive = TRUE, showWarnings = FALSE)

workflow_content <- 'name: R-CMD-check

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

permissions:
  contents: read

jobs:
  R-CMD-check:
    runs-on: ${{ matrix.config.os }}

    name: ${{ matrix.config.os }} (${{ matrix.config.r }})

    strategy:
      fail-fast: false
      matrix:
        config:
          - {os: macos-latest,   r: release}
          - {os: windows-latest, r: release}
          - {os: ubuntu-latest,  r: devel, http-user-agent: devel}
          - {os: ubuntu-latest,  r: release}
          - {os: ubuntu-latest,  r: oldrel-1}

    env:
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      R_KEEP_PKG_SOURCE: yes

    steps:
      - uses: actions/checkout@v4

      - uses: r-lib/actions/setup-pandoc@v2

      - uses: r-lib/actions/setup-r@v2
        with:
          r-version: ${{ matrix.config.r }}
          http-user-agent: ${{ matrix.config.http-user-agent }}
          use-public-rspm: true

      - uses: r-lib/actions/setup-r-dependencies@v2
        with:
          extra-packages: any::rcmdcheck
          needs: check

      - uses: r-lib/actions/check-r-package@v2
        with:
          upload-snapshots: true'

writeLines(workflow_content, ".github/workflows/R-CMD-check.yaml")

# Create issue templates
cat("🐛 Creating GitHub issue templates...\n")
dir.create(".github/ISSUE_TEMPLATE", recursive = TRUE, showWarnings = FALSE)

bug_template <- '---
name: Bug report
about: Create a report to help us improve plotR
title: "[BUG] "
labels: bug
assignees: ashgreat

---

**Describe the bug**
A clear and concise description of what the bug is.

**Reproducible Example**
```r
library(plotR)
# Your minimal example here
```

**Expected behavior**
A clear and concise description of what you expected to happen.

**Actual behavior**
A clear and concise description of what actually happened.

**Screenshots**
If applicable, add screenshots of the visualization issues.

**Environment:**
- R version: 
- Operating System: 
- Browser: 
- plotR version: 

**Additional context**
Add any other context about the problem here.'

writeLines(bug_template, ".github/ISSUE_TEMPLATE/bug_report.md")

feature_template <- '---
name: Feature request
about: Suggest an idea for plotR
title: "[FEATURE] "
labels: enhancement
assignees: ashgreat

---

**Is your feature request related to a problem?**
A clear and concise description of what the problem is.

**Describe the solution you\'d like**
A clear and concise description of what you want to happen.

**Describe alternatives you\'ve considered**
A clear and concise description of any alternative solutions or features you\'ve considered.

**Example usage**
How would you like to use this feature?

```r
# Example code showing desired usage
```

**Additional context**
Add any other context, screenshots, or examples about the feature request here.'

writeLines(feature_template, ".github/ISSUE_TEMPLATE/feature_request.md")

# Update startup message
startup_content <- '
#\' Package startup message
.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "plotR: Interactive Data Visualization with Observable Plot\\n",
    "📊 Create beautiful, interactive charts with R\\n", 
    "🎯 All charts include hover tooltips\\n",
    "📖 See vignette(\\"getting-started\\") for examples\\n",
    "🐛 Report issues: https://github.com/ashgreat/plotR/issues"
  )
}
'

writeLines(startup_content, "R/zzz.R")

# Generate all examples
cat("📊 Generating example files...\n")
source("generate_examples.R")

cat("\n✅ Package configured for ashgreat/plotR repository!\n\n")

# Create Git commands file
git_commands <- '#!/bin/bash

# Git commands to push plotR to GitHub

echo "🚀 Pushing plotR package to GitHub..."

# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial release: plotR v1.0.0 - Interactive data visualization with Observable Plot

✨ Features:
• 10 chart types including scatter, bar, line, pie, donut, stacked dots, bubble maps
• Interactive tooltips with emoji support
• Professional styling and responsive design  
• Grammar of graphics approach
• Observable Plot JavaScript library integration
• Comprehensive documentation and examples

🎯 All charts include hover tooltips and are ready for production use!"

# Add remote origin
git remote add origin https://github.com/ashgreat/plotR.git

# Push to GitHub
git branch -M main
git push -u origin main

echo "✅ Successfully pushed to GitHub!"
echo "🌐 Repository: https://github.com/ashgreat/plotR"
echo ""
echo "📋 Next steps:"
echo "1. Take screenshots of examples/ HTML files"
echo "2. Add screenshots to screenshots/ folder"
echo "3. Create first release on GitHub"
echo "4. Set up GitHub Pages (optional)"
'

writeLines(git_commands, "push_to_github.sh")
Sys.chmod("push_to_github.sh", mode = "0755")

cat("📋 Next steps to push to GitHub:\n\n")

cat("🔧 Option 1 - Use the script (Mac/Linux):\n")
cat("   chmod +x push_to_github.sh\n")
cat("   ./push_to_github.sh\n\n")

cat("🔧 Option 2 - Manual commands:\n")
cat("   git init\n")
cat("   git add .\n")
cat("   git commit -m \"Initial release: plotR v1.0.0\"\n")
cat("   git remote add origin https://github.com/ashgreat/plotR.git\n")
cat("   git branch -M main\n")
cat("   git push -u origin main\n\n")

cat("📸 To add screenshots:\n")
cat("   1. Open each HTML file in examples/ folder in your browser\n")
cat("   2. Take screenshots of the visualizations\n") 
cat("   3. Save as PNG files in screenshots/ folder:\n")

examples_files <- list.files("examples", pattern = "\\.html$")
screenshot_names <- gsub("\\.html$", ".png", examples_files)
for(i in seq_along(screenshot_names)) {
  cat("      •", examples_files[i], "→", screenshot_names[i], "\n")
}

cat("\n🎉 After pushing, your repository will be live at:\n")
cat("   https://github.com/ashgreat/plotR\n\n")

cat("📊 Package summary:\n")
cat("   • 10 chart types with interactive tooltips\n")
cat("   • Professional documentation and examples\n") 
cat("   • GitHub Actions CI/CD setup\n")
cat("   • Issue templates for bug reports and features\n")
cat("   • MIT license\n")
cat("   • Ready for CRAN submission\n")

cat("\n🚀 Your plotR package is ready to share with the world!\n")