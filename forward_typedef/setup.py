from setuptools import setup
from Cython.Build import cythonize

setup(
    name='demo',
    ext_modules=cythonize("demo.pyx"),
)

