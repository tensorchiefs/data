# Tensorchiefs Data Collection and Tools

This repository contains [datasets](https://github.com/tensorchiefs/data/blob/main/docs/) as well as R and Python packages for teaching statistics, data science, and related subjects.


## Installation and simple Usage

### R

**Installing the Released Version (no release yet)**

    ``` r
       install.packages("https://github.com/tensorchiefs/data/releases/download/testrelease/edudat_0.1.tar.gz", repos = NULL, type = "source")
    ```           
**Using the R Package**:

Load the `edudat` package and datasets:
  
      ```R
        library(edudat)
        df <- load_data("challenger.csv")
      ```
      
Showing the dataset and other functionality
  
      ```R
       show_data(df)
       list_cache_files() #Lists all the cached files
      ```
      
Using additional functions (currently only in R), like plot_data:
  
      ```R
      plot_data(df) + theme_minimal()
      ```
    Note that not all datasets have additional functions. They need to be defined in an accompanying qmd script.

### Python

1.  **Installation of the Python Package**:
    -   Install the `edudat` package from PyPI:

        ``` bash
        pip install edudat
        ```
2.  **Using the Python Package**:
    -   Load the CSV data in Python:

        ``` python
        from edudat import load_data
        df1 = load_data("challenger.csv")
        ```

## Additional information/functionality on data sets

The data sets can be described by quarto (qmd) files. These files contain additional information about the data set, such as a description, the source, the variables, and the data types. The qmd files are located in the `data/` directory and are rendered into the docs branch. The rendered files can be found [https://github.com/tensorchiefs/data/tree/main/docs](https://github.com/tensorchiefs/data/tree/main/docs).


In the cmd files, it is also possible to provide additional code for the data sets. Have a look at the [challenger.qmd](https://github.com/tensorchiefs/data/blob/main/data/challenger.qmd) file for an example, where the R-Code `plot_data` is defined as a named code chunk.

``` r
{r plot_data, echo=TRUE, eval=FALSE}
```

Please ensure that `eval=FALSE` is set in the code chunk options if the code is not supposed to be executed in the automatic rendering.

## Structure

-   `data/`: Contains the CSV data.
-   `R/`: Contains the R package `edudat`.
-   `python/`: Contains the Python package `edudat`.
-   `docs/`: Contain documentation on the dataset

## Advanced Issue

### R

**Installation of the R Package (as in githup main)**:
``` r
install.packages("devtools") #Install the `devtools` package if you haven't already:
#Install the `edudat` package directly from GitHub:
devtools::install_github("tensorchiefs/data/R/edudat")
```

## Contributing

Contributions are welcomed at a later stage, have a look at the [contribution howto](CONTRIBUTING.md).
