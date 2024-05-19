# Contributing

Contributions are welcome at a later stage.

## Rendering Documentation

To render the `.qmd` file in the `data` folder to the `.md` files in the `docs` folder, run the `Render_Quarto.R` script located in the `R/data_gen` directory.

## Building the Package

### Building in R

To build the R package, simply check in the files. If another user wants to build the package, they can simply check it out. However, using  `devtools::install_github("tensorchiefs/data/R/edudat")` is slow since it involves cloning, see also https://github.com/tensorchiefs/data/issues/2

### Installation of the R Package (current version w/o building)**:
    -   Install the `devtools` package if you haven't already:
        ``` r
        install.packages("devtools")
        ```
    
    -   Install the `edudat` package directly from GitHub:
    
        ``` r
        devtools::install_github("tensorchiefs/data/R/edudat")
        ```


### Build the source in R:
```bash
data % R CMD build R/edudat
```

The from the github side upload the tar.gz file and do a new release (Create a new release in https://github.com/tensorchiefs/data). This can be downloaded via:

```R
install.packages("https://github.com/tensorchiefs/data/releases/download/testrelease/edudat_0.1.tar.gz", repos = NULL, type = "source")
```

##### Local Building
To check the package, run `build_and_check.R` in the `R` directory. This also change the NAMESPACE file to include all the functions in the package which should be exposed. Hint: If you sourced the functions in development, this a good idea to restart R.


### Building in Python

The project is hosted on [PyPI](https://pypi.org/project/edudat/). To build the Python package, run the following commands:

```bash
cd data/python
python setup.py sdist bdist_wheel
twine upload dist/*


#### Local installation

Local installation of the python module:

``` bash
pip install -e edudat 
```
