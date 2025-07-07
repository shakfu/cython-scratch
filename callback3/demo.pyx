from libc.stdlib cimport malloc, free


cdef extern from "Python.h":
    void Py_INCREF(object o)
    void Py_DECREF(object o)

cdef extern from *:
    """
    typedef int (*c_callback_func)(int data, void* user_data);

    typedef struct mystruct {
        c_callback_func callback;
        void* user_data;
    } mystruct;

    int call_callback(mystruct* x, c_callback_func func, int data, void* user_data)
    {
        return func(data, user_data);
    }
    """

    ctypedef int (*c_callback_func)(int data, void* user_data)

    ctypedef struct mystruct:
        c_callback_func callback
        void* user_data

    int call_callback(mystruct* x, c_callback_func func, int data, void* user_data)


# Example: A C-level trampoline function to call a Python callback
cdef int c_callback_wrapper(int data, void* user_data) noexcept:
    python_callback = <object>user_data
    return python_callback(data)


cdef class CallbackDemo3:
    cdef mystruct* ptr
    cdef bint owner

    def __cinit__(self):
        self.ptr = <mystruct*>malloc(sizeof(mystruct))
        if self.ptr is NULL:
            raise MemoryError()
        self.ptr.callback = c_callback_wrapper
        self.ptr.user_data = NULL

    def __dealloc__(self):
        if self.ptr is not NULL:
            free(self.ptr)

    def register_pycallback(self, object python_func):
        if self.ptr.user_data is not NULL:
            Py_DECREF(<object>self.ptr.user_data)
        Py_INCREF(python_func)  # <- this is KEY!
        self.ptr.user_data = <void*>python_func

    def call(self, int data) -> int:
        return call_callback(
            self.ptr, self.ptr.callback, data, <void*>self.ptr.user_data)
