from cython.operator cimport dereference as deref
from libc.stdlib cimport malloc, calloc, realloc, free
from libc.string cimport memcpy, memset


cimport scratch


def reference_dereference():
    cdef double golden_ratio
    cdef double *p_double

    p_double = &golden_ratio
    p_double[0] = 1.618

    print(golden_ratio)
    # => 1.618

    print(p_double[0])
    # => 1.618

    print(deref(p_double))
    # => 1.618

cdef struct st_t:
    int a

def struct_access() -> int:
    cdef st_t ss = st_t(a=2)
    cdef st_t *p_st = &ss
    cdef int a_doubled = p_st.a + p_st.a
    return a_doubled



 # Example: A C-level trampoline function to call a Python callback
cdef void c_callback_wrapper(int data, void* user_data) noexcept:
    python_callback = <object>user_data
    python_callback(data)



# cdef class CallbackDemo:
#     cdef mystruct* ptr
#     cdef bint owner

#     def __cinit__(self):
#         self.ptr = <mystruct*>malloc(sizeof(mystruct))
#         if self.ptr is NULL:
#             raise MemoryError()
#         self.ptr.callback = NULL
#         self.ptr.user_data = NULL

#     def __dealloc__(self):
#         if self.ptr is not NULL:
#             free(self.ptr)

#     def setup_python_callback(self, object python_func):
#         register_callback(self.ptr, c_callback_wrapper, <void*>python_func)

#     def call(self, int data):
#         self.ptr.callback(<int>data, <void*>self.ptr.user_data)

cdef class CallbackDemo1:
    cdef mystruct* ptr
    cdef bint owner

    def __cinit__(self):
        self.ptr = <mystruct*>malloc(sizeof(mystruct))
        if self.ptr is NULL:
            raise MemoryError()
        self.ptr.callback = NULL
        self.ptr.user_data = NULL

    def __dealloc__(self):
        if self.ptr is not NULL:
            free(self.ptr)

    def call(self, int data, object python_func):
        call_callback(self.ptr, c_callback_wrapper, data, <void*>python_func)

