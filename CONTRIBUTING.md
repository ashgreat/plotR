# Contributing to plotR

We welcome contributions to plotR! This document outlines how to contribute to the project.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/ashgreat/plotR.git
   cd plotR
   ```
3. **Create a new branch** for your feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

### Prerequisites

- R (>= 4.0.0)
- RStudio (recommended)
- Git

### Required R Packages

```r
install.packages(c(
  "devtools", 
  "roxygen2", 
  "testthat",
  "htmlwidgets",
  "jsonlite",
  "magrittr"
))
```

### Installing Development Version

```r
# Load development tools
library(devtools)

# Install package in development mode
devtools::load_all()

# Run tests
devtools::test()

# Build documentation
devtools::document()
```

## Types of Contributions

### 🐛 Bug Reports

When filing a bug report, please include:

- **Reproducible example** - Minimal code that demonstrates the issue
- **Expected behavior** - What you expected to happen
- **Actual behavior** - What actually happened  
- **Environment info** - R version, operating system, browser used
- **Screenshots** - If relevant for visualization issues

Use this template:

```markdown
## Bug Description
Brief description of the bug

## Reproducible Example
```r
library(plotR)
# Your minimal example here
```

## Expected Behavior
What should have happened

## Actual Behavior  
What actually happened

## Environment
- R version: 
- Operating System:
- Browser: 
- plotR version:
```

### ✨ Feature Requests

For new features, please:

1. **Check existing issues** to avoid duplicates
2. **Describe the use case** - Why is this feature needed?
3. **Provide examples** - Show how the feature would be used
4. **Consider implementation** - Any thoughts on how it could work?

### 🔧 Code Contributions

We welcome:

- **New chart types** - Additional Observable Plot mark types
- **Enhanced interactivity** - Better tooltip systems, animations
- **Performance improvements** - Faster rendering, smaller file sizes
- **Documentation** - Examples, vignettes, function documentation
- **Tests** - Unit tests for functions

## Code Style Guidelines

### R Code Style

Follow the [tidyverse style guide](https://style.tidyverse.org/):

- Use `snake_case` for function and variable names
- Use `<-` for assignment, not `=`
- Limit lines to 80 characters
- Use explicit returns: `return(x)`
- Add spaces around operators: `x + y`, not `x+y`

**Good:**
```r
plotR_scatter <- function(data, x, y, fill = NULL, ...) {
  if (is.null(data)) {
    stop("Data cannot be NULL")
  }
  
  result <- create_plot(data, x, y, fill)
  return(result)
}
```

**Avoid:**
```r
plotr_scatter<-function(data,x,y,fill=NULL,...){
if(is.null(data))stop("Data cannot be NULL")
result=create_plot(data,x,y,fill)
result
}
```

### Documentation Style

Use roxygen2 for function documentation:

```r
#' Create an interactive scatter plot
#'
#' This function creates a scatter plot using Observable Plot with 
#' interactive tooltips and customizable aesthetics.
#'
#' @param data A data frame containing the data to plot
#' @param x Character string specifying the x-axis variable
#' @param y Character string specifying the y-axis variable  
#' @param fill Character string specifying the fill color variable (optional)
#' @param size Character string specifying the size variable (optional)
#' @param title Plot title (default: "Scatter Plot")
#' @param save_as Output filename (optional, creates temp file if NULL)
#' @param ... Additional arguments passed to plotR()
#'
#' @return Path to the generated HTML file (invisible)
#'
#' @examples
#' \dontrun{
#' # Basic scatter plot
#' plotR_scatter(mtcars, "wt", "mpg")
#' 
#' # With color encoding
#' plotR_scatter(mtcars, "wt", "mpg", fill = "cyl")
#' }
#'
#' @export
```

### JavaScript Code Style

For JavaScript in HTML templates:

- Use 2-space indentation
- Use semicolons
- Use `const` and `let`, avoid `var`
- Use template literals for strings with variables
- Add error handling with try/catch

**Good:**
```javascript
const data = JSON.parse(dataJson);
const plot = Plot.plot({
  marks: [
    Plot.dot(data, {x: "x", y: "y"})
  ],
  width: 600
});
```

## Testing

### Writing Tests

Add tests for new functions in `tests/testthat/`:

```r
test_that("plotR_scatter creates valid HTML", {
  # Create test data
  test_data <- data.frame(x = 1:5, y = 1:5)
  
  # Create plot
  result <- plotR_scatter(test_data, "x", "y", save_as = tempfile())
  
  # Check file exists
  expect_true(file.exists(result))
  
  # Check HTML content
  html_content <- readLines(result)
  expect_true(any(grepl("Plot\\.dot", html_content)))
})
```

### Running Tests

```r
# Run all tests
devtools::test()

# Run specific test file
devtools::test_file("tests/testthat/test-scatter.R")

# Check test coverage
covr::package_coverage()
```

## Adding New Chart Types

To add a new chart type (e.g., `plotR_violin`):

1. **Study Observable Plot docs** for the mark type
2. **Add function** in `R/chart-functions.R`:

```r
#' Create a violin plot
#' @export
plotR_violin <- function(data, x, y, ...) {
  # Implementation here
}
```

3. **Add to NAMESPACE** exports
4. **Write documentation** with roxygen2
5. **Add tests** in `tests/testthat/test-violin.R`
6. **Add example** to `generate_examples.R`
7. **Update README** with new chart type

## Documentation

### Building Documentation

```r
# Update function documentation
devtools::document()

# Build vignettes
devtools::build_vignettes()

# Check documentation
devtools::check()
```

### Adding Examples

Add working examples to:
- Function documentation (`@examples`)
- README.md
- Vignettes (`vignettes/`)
- Example generation script (`generate_examples.R`)

## Submission Guidelines

### Pull Request Process

1. **Update documentation** for any new features
2. **Add tests** for new functionality
3. **Update NEWS.md** with changes
4. **Check package** runs without errors:
   ```r
   devtools::check()
   ```
5. **Create pull request** with clear description

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature  
- [ ] Documentation update
- [ ] Performance improvement

## Testing
- [ ] Added tests for new functionality
- [ ] All existing tests pass
- [ ] Manual testing completed

## Screenshots
If applicable, add screenshots of new visualizations

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or breaking changes documented)
```

## Release Process

Only for maintainers:

1. Update version in `DESCRIPTION`
2. Update `NEWS.md` with changes
3. Run full checks: `devtools::check()`
4. Build documentation: `pkgdown::build_site()`
5. Create GitHub release with generated examples
6. Submit to CRAN (if applicable)

## Community

### Code of Conduct

Be respectful, inclusive, and constructive in all interactions.

### Getting Help

- **Issues**: For bugs and feature requests
- **Discussions**: For questions and general discussion
- **Email**: For private/security concerns

### Recognition

Contributors are acknowledged in:
- `AUTHORS` file
- Package documentation
- Release notes

## Resources

- [Observable Plot Documentation](https://observablehq.com/plot/)
- [R Package Development](https://r-pkgs.org/)
- [Tidyverse Style Guide](https://style.tidyverse.org/)
- [HTMLWidgets Development](https://www.htmlwidgets.org/develop_intro.html)

Thank you for contributing to plotR! 🚀📊
