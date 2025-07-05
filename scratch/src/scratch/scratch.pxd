
cdef extern from *:
    """
    typedef void (*c_callback_func)(int data, void* user_data);

    typedef struct mystruct {
        c_callback_func callback;
        void* user_data;
    } mystruct;

    void register_callback(mystruct* x, c_callback_func func, void* user_data)
    {
        x->callback = func;
        x->user_data = user_data;
    }

    void call_callback(mystruct* x, c_callback_func func, int data, void* user_data)
    {
        func(data, user_data);
    }
    
    """

    ctypedef void (*c_callback_func)(int data, void* user_data)
    
    ctypedef struct mystruct:
        c_callback_func callback
        void* user_data

    void register_callback(mystruct*, c_callback_func func, void* user_data)
    void call_callback(mystruct* x, c_callback_func func, int data, void* user_data)

