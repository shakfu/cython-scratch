# cython-scratch

A repo for throwaway tests, demos of cython examples, techniques, etc.


- **callback1**: using a C-level trampoline function to call a Python callback

- **callback2**: same as callback1 but with callback returning a value

- **callback3**: same as callback2 but separate registration of python callback function to demonstrate the requirement to `Py_INCREF` the callback object.

- **callback4**: same as callback3 but with a dedicated wrapper to set the c-callback wrapper or the python callback function

- **forward_typedef**: highlight an error due to using an empty struct foward decl instead of a forward struct decl

- **nested**: how to handle nested cython extension classes

- **queue**: the canonoical cython wrapping example in full

- **scratch**: misc scratchpad

# Links

- [where the language is messey](https://cython.readthedocs.io/en/latest/src/userguide/troubleshooting.html#where-the-language-is-messy)

- [how do I autoconvert a struct* to a dict?](https://stackoverflow.com/questions/47943390/how-do-i-autoconvert-a-struct-to-a-dict)

