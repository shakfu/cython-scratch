from libc.stdlib cimport malloc, free


cdef extern from "Python.h":
    void Py_INCREF(object o)
    void Py_DECREF(object o)

cdef extern from *:
    """
    typedef int (*c_callback_func)(int data, void* user_data);

    typedef struct t_callback {
        c_callback_func callback;
        void* user_data;
    } t_callback;

    int call_callback(t_callback* x, c_callback_func func, int data, void* user_data)
    {
        return func(data, user_data);
    }
    """

    ctypedef int (*c_callback_func)(int data, void* user_data)

    ctypedef struct t_callback:
        c_callback_func callback
        void* user_data

    int call_callback(t_callback* x, c_callback_func func, int data, void* user_data)


# Example: A C-level trampoline function to call a Python callback
cdef int c_callback_wrapper(int data, void* user_data) noexcept:
    python_callback = <object>user_data
    return python_callback(data)


cdef class Callback:
    cdef t_callback* ptr
    cdef bint owner

    def __cinit__(self):
        self.ptr = <t_callback*>malloc(sizeof(t_callback))
        if self.ptr is NULL:
            raise MemoryError()
        self.ptr.callback = c_callback_wrapper
        self.ptr.user_data = NULL

    def __init__(self, object python_func = None):
        if python_func:
            Py_INCREF(python_func)
            self.ptr.user_data = <void*>python_func

    def __dealloc__(self):
        if self.ptr is not NULL:
            free(self.ptr)

    cdef register_ccallback(self, c_callback_func func):
        self.ptr.callback = func

    def register_pycallback(self, object python_func):
        if self.ptr.user_data is not NULL:
            Py_DECREF(<object>self.ptr.user_data)
        Py_INCREF(python_func)  # <- this is KEY!
        self.ptr.user_data = <void*>python_func

    def call(self, int data) -> int:
        return call_callback(
            self.ptr, self.ptr.callback, data, <void*>self.ptr.user_data)
