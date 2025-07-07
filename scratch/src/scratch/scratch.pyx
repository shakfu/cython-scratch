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

