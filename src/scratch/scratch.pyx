from cython.operator cimport dereference as deref
from libc.stdlib cimport malloc, calloc, realloc, free
from libc.string cimport memcpy, memset
# import numpy as np
# cimport numpy as np

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




cdef class PyQueue:
    """A queue class for C integer values.

    >>> q = Queue()
    >>> q.append(5)
    >>> q.peek()
    5
    >>> q.pop()
    5
    """
    cdef Queue* _c_queue

    def __cinit__(self):
        self._c_queue = queue_new()
        if self._c_queue is NULL:
            raise MemoryError()

    def __dealloc__(self):
        if self._c_queue is not NULL:
            queue_free(self._c_queue)


    cpdef append(self, int value):
        if not queue_push_tail(self._c_queue,
                               <void*> <Py_ssize_t> value):
            raise MemoryError()

    # The `cpdef` feature is obviously not available for the original "extend()"
    # method, as the method signature is incompatible with Python argument
    # types (Python does not have pointers).  However, we can rename
    # the C-ish "extend()" method to e.g. "extend_ints()", and write
    # a new "extend()" method that provides a suitable Python interface by
    # accepting an arbitrary Python iterable.

    cpdef extend(self, values):
        for value in values:
            self.append(value)


    cdef extend_ints(self, int* values, size_t count):
        cdef int value
        for value in values[:count]:  # Slicing pointer to limit the iteration boundaries.
            self.append(value)



    cpdef int peek(self) except? -1:
        cdef int value = <Py_ssize_t> queue_peek_head(self._c_queue)

        if value == 0:
            # this may mean that the queue is empty,
            # or that it happens to contain a 0 value
            if queue_is_empty(self._c_queue):
                raise IndexError("Queue is empty")
        return value


    cpdef int pop(self) except? -1:
        if queue_is_empty(self._c_queue):
            raise IndexError("Queue is empty")
        return <Py_ssize_t> queue_pop_head(self._c_queue)

    def __bool__(self):
        return not queue_is_empty(self._c_queue)



cdef class FooWrapper:
    cdef foo* _ptr

    def __cinit__(self):
        self._ptr  = NULL
    
    @staticmethod
    cdef FooWrapper from_ptr(foo* ptr):
        cdef FooWrapper wrapper = FooWrapper.__new__(FooWrapper)
        wrapper._ptr = ptr
        return wrapper



cdef class Style:
    cdef mu_Style* ptr
    cdef bint owner

    def __cinit__(self):
        self.ptr = NULL
        self.owner = False

    def __dealloc__(self):
        # De-allocate if not null and flag is set
        if self.ptr is not NULL and self.owner is True:
            free(self.ptr)
            self.ptr = NULL

    def __init__(self):
        # Prevent accidental instantiation from normal Python code
        # since we cannot pass a struct pointer into a Python constructor.
        raise TypeError("This class cannot be instantiated directly.")

    @staticmethod
    cdef Style from_ptr(mu_Style* ptr, bint owner=False):
        cdef Style wrapper = Style.__new__(Style)
        wrapper.ptr = ptr
        wrapper.owner = owner
        return wrapper

    @staticmethod
    cdef Style new():
        cdef mu_Style* _ptr = <mu_Style*>malloc(sizeof(mu_Style))
        if _ptr is NULL:
            raise MemoryError("Failed to allocate Style")
        memset(_ptr, 0, sizeof(mu_Style))
        return Style.from_ptr(_ptr, owner=True)
    
    @property
    def padding(self) -> int:
        return self.ptr.padding
    
    @padding.setter
    def padding(self, int value):
        self.ptr.padding = value




cdef class MyStruct:
    cdef myStruct* _ptr

    def __cinit__(self):
        self._ptr = create_mystruct()

    def __dealloc__(self):
        if self._ptr is not NULL:
            free_mystruct(self._ptr)

    @property
    def style(self) -> Style:
        return Style.from_ptr(<mu_Style*>self._ptr.style)

    def to_dict(self):
      return {'field1': self._ptr.field1,
              'field2': self._ptr.field2,
              'field3': FooWrapper.from_ptr(self._ptr.field3),  # or an int if opaque
              'style': Style.from_ptr(self._ptr.style),
             }

