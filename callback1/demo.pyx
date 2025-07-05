from libc.stdlib cimport malloc, free
from libc.string cimport memset

cdef extern from *:
    """
    typedef int (*c_callback_func)(int data, void* user_data);

    typedef struct mystruct {
        int x;
    } mystruct;

    int call_callback(mystruct* x, c_callback_func func, int data, void* user_data)
    {
        return func(data, user_data);
    }
    """

    ctypedef int (*c_callback_func)(int data, void* user_data)
    
    ctypedef struct mystruct:
        int x

    int call_callback(mystruct* x, c_callback_func func, int data, void* user_data)


 # Example: A C-level trampoline function to call a Python callback
cdef int c_callback_wrapper(int data, void* user_data) noexcept:
    python_callback = <object>user_data
    return <int>python_callback(data)


cdef class CallbackDemo1:
    cdef mystruct* ptr
    cdef bint owner

    def __cinit__(self):
        self.ptr = <mystruct*>malloc(sizeof(mystruct))
        if self.ptr is NULL:
            raise MemoryError()

    def __dealloc__(self):
        if self.ptr is not NULL:
            free(self.ptr)

    def call(self, int data, object python_func) -> int:
        return call_callback(
            self.ptr, c_callback_wrapper, data, <void*>python_func)




