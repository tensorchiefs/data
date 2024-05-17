# Load necessary libraries
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
library(devtools)

if (!requireNamespace("roxygen2", quietly = TRUE)) {
  install.packages("roxygen2")
}
library(roxygen2)

# Set the working directory to the package directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Document the package
roxygenize()

# Build the package
build()

# Check the package
check()

# Optionally, install the package locally
install()
