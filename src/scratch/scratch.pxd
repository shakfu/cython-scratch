

cdef extern from "queue.h":
    ctypedef struct Queue:
        pass
    ctypedef void* QueueValue

    Queue* queue_new()
    void queue_free(Queue* queue)

    int queue_push_head(Queue* queue, QueueValue data)
    QueueValue  queue_pop_head(Queue* queue)
    QueueValue queue_peek_head(Queue* queue)

    int queue_push_tail(Queue* queue, QueueValue data)
    QueueValue queue_pop_tail(Queue* queue)
    QueueValue queue_peek_tail(Queue* queue)

    bint queue_is_empty(Queue* queue)


cdef extern from "pad.h":

    ctypedef struct foo:
        pass


    ctypedef struct my_Style:
        void* hole
        int padding
        int spacing
        int indent
        int title_height
        int scrollbar_size
        int thumb_size


    ctypedef struct myStruct:
        int field1
        int field2
        foo* field3
        my_Style* style

    myStruct* create_mystruct()

    void free_mystruct(myStruct* ptr)


   # Forward declarations
    # ctypedef struct mu_Context: pass #THIS CAUSE STYLE ptr to be returnable!
    ctypedef void* mu_Font


    # Style struct
    ctypedef struct mu_Style:
        # mu_Font font
        # mu_Vec2 size
        int padding
        # int spacing
        # int indent
        # int title_height
        # int scrollbar_size
        # int thumb_size
        # mu_Color colors[MU_COLOR_MAX]


    # Main Context struct
    ctypedef struct mu_Context:
        mu_Style _style
        mu_Style* style


    # Core functions
    void mu_init(mu_Context* ctx)
