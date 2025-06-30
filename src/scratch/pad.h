#include <stdlib.h>


typedef struct foo foo;


typedef struct {
    void* hole;
    int padding;
    int spacing;
    int indent;
    int title_height;
    int scrollbar_size;
    int thumb_size;
} mu_Style;


typedef struct myStruct {
    int field1;
    int field2;
    foo* field3;
    mu_Style* style;
} myStruct;


myStruct* create_mystruct();
void free_mystruct(myStruct* ptr);
