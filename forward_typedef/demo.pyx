from libc.stdlib cimport malloc, free
from libc.string cimport memset

cdef extern from *:
    """
    typedef struct t_context t_context;

    typedef struct t_style {
        int padding;
    } t_style;

    struct t_context {
        int frame;
        t_style* style;
    };
    """

    ctypedef struct t_context

    ctypedef struct t_style:
        int padding

    ctypedef struct t_context:
        int frame
        t_style* style


cdef class Style:
    cdef t_style* ptr
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
        raise TypeError("This class cannot be instantiated directly.")

    @staticmethod
    cdef Style from_ptr(t_style* ptr, bint owner=False):
        cdef Style wrapper = Style.__new__(Style)
        wrapper.ptr = ptr
        wrapper.owner = owner
        return wrapper

    @staticmethod
    cdef Style new():
        cdef t_style* _ptr = <t_style*>malloc(sizeof(t_style))
        if _ptr is NULL:
            raise MemoryError("Failed to allocate Style")
        memset(_ptr, 0, sizeof(t_style))
        return Style.from_ptr(_ptr, owner=True)

    @property
    def padding(self) -> int:
        return self.ptr.padding

    @padding.setter
    def padding(self, int value):
        self.ptr.padding = value


cdef class Context:
    cdef t_context* ptr
    cdef bint owner

    def __cinit__(self):
        self.ptr = NULL
        self.owner = False

    def __dealloc__(self):
        # De-allocate if not null and flag is set
        if self.ptr is not NULL and self.owner is True:
            free(self.ptr.style)
            free(self.ptr)
            self.ptr = NULL

    def __init__(self):
        self.ptr = <t_context*>malloc(sizeof(t_context))
        if self.ptr is NULL:
            raise MemoryError("Failed to allocate Context")
        self.ptr.frame = 0
        self.ptr.style = <t_style*>malloc(sizeof(t_style))
        if self.ptr.style is NULL:
            raise MemoryError("Failed to allocate context.style")
        self.owner = True

    @staticmethod
    cdef Context from_ptr(t_context* ptr, bint owner=False):
        cdef Context wrapper = Context.__new__(Context)
        wrapper.ptr = ptr
        wrapper.owner = owner
        return wrapper

    @staticmethod
    cdef Context new():
        cdef t_context* _ptr = <t_context*>malloc(sizeof(t_context))
        if _ptr is NULL:
            raise MemoryError("Failed to allocate Context")
        return Context.from_ptr(_ptr, owner=True)

    @property
    def style(self) -> Style:
        return Style.from_ptr(<t_style*>self.ptr.style)
