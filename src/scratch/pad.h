#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct foo foo;


typedef struct {
    void* hole;
    int padding;
    int spacing;
    int indent;
    int title_height;
    int scrollbar_size;
    int thumb_size;
} my_Style;


typedef struct myStruct {
    int field1;
    int field2;
    foo* field3;
    my_Style* style;
} myStruct;


myStruct* create_mystruct();
void free_mystruct(myStruct* ptr);



typedef struct mu_Context mu_Context;
typedef void* mu_Font;

typedef struct mu_Vec2 {
    int x, y;
} mu_Vec2;


typedef struct mu_Color {
    unsigned char r, g, b, a;
} mu_Color;


typedef struct mu_Style {
    mu_Font font;
    mu_Vec2 size;
    int padding;
    int spacing;
    int indent;
    int title_height;
    int scrollbar_size;
    int thumb_size;
    mu_Color colors[14];
} mu_Style;


typedef struct mu_Context {
    mu_Style _style;
    mu_Style* style;
} mu_Context ;


mu_Vec2 mu_vec2(int x, int y);
mu_Color mu_color(int r, int g, int b, int a);

void mu_init(mu_Context* ctx);
