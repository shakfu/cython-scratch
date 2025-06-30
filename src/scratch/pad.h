#include <stdlib.h>


typedef struct foo foo;

typedef struct myStruct {
    int field1;
    int field2;
    foo* field3;
} myStruct;

myStruct* create_mystruct();
void free_mystruct(myStruct* ptr);
