

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

    ctypedef struct myStruct:
        int field1
        int field2
        foo* field3

    myStruct* create_mystruct()

    void free_mystruct(myStruct* ptr)
