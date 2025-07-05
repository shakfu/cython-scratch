from setuptools import setup, Extension
from Cython.Build import cythonize

setup(
    name='pyqueue',
    ext_modules = cythonize([
        Extension("pyqueue", 
            sources=["pyqueue.pyx", "lib/queue.c"],
            include_dirs=["lib"],
        )
    ])
)
