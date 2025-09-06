
#' Package startup message
.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "plotR: Interactive Data Visualization with Observable Plot\n",
    "📊 Create beautiful, interactive charts with R\n", 
    "🎯 All charts include hover tooltips\n",
    "📖 See vignette(\"getting-started\") for examples\n",
    "🐛 Report issues: https://github.com/ashgreat/plotR/issues"
  )
}

