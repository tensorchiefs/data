# Contributing

Contributions are welcomed at a later stage.

## Building

### Building in R

To build the package, run build_and_check.R in the R directory.

### Building in Python

The project is hosted at [PyPI](https://pypi.org/project/edudat/). To build the package, run the following commands:

``` bash
cd data/python
python setup.py sdist bdist_wheel
twine upload dist/*
```

#### Local installation

Local installation of the python module:

``` bash
pip install -e edudat 
```
