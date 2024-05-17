from setuptools import setup, find_packages

setup(
    name="edudat",
    version="0.001",
    packages=["edudat"],
    install_requires=[
        "pandas",
        "requests",
    ],
    author="Oliver Dürr",
    description="A package for educational datasets",
    url="https://github.com/oduerr/data",
)
