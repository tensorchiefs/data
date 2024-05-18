# Data Repository

This repository contains datasets as well as R and Python packages for teaching statistics, data science and the like.

## Structure

- `data/`: Contains the CSV data.
- `R/`: Contains the R package `edudat`.
- `python/`: Contains the Python package `edudat`.

## Installation and Usage

### R

1. **Installation of the R Package**:
   - Install the `devtools` package if you haven't already:
     ```R
     install.packages("devtools")
     ```

   - Install the `edudat` package directly from GitHub:
     ```R
     devtools::install_github("tensorchiefs/data/R/edudat")
     ```

2. **Using the R Package**:
   - Load the `edudat` package and datasets:
     ```R
     library(edudat)
     df <- load_data("challenger.csv")
     ```
     
    - Using additional functions (currently only in R), like plot_data:
     ```R
      plot_data(df)
     ```
     Note that not all datasets have additional functions. They need to be defined in an accompanying qmd script. 

### Python

1. **Installation of the Python Package**:
   - Install the `edudat` package from PyPI:
     ```bash
     pip install edudat
     ```

2. **Using the Python Package**:
   - Load the CSV data in Python:
     ```python
     from edudat import load_data

     df1 = load_data("challenger.csv")
     ```

## Contributing

If you would like to contribute to this repository, have a look at the [contribution howto](CONTRIBUTING.md).


