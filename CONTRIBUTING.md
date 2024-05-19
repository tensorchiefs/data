# Contributing

Contributions are welcome at a later stage.

## Rendering Documentation

To render the `.qmd` file in the `data` folder to the `.md` files in the `docs` folder, run the `Render_Quarto.R` script located in the `R/data_gen` directory.

## Building the Package

### Building in R

To build the R package, simply check in the files. If another user wants to build the package, they can simply check it out. 

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
