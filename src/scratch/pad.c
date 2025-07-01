#include "pad.h"

myStruct* create_mystruct()
{
	myStruct* ptr = (myStruct*)malloc(sizeof(myStruct));
	return ptr;
}

void free_mystruct(myStruct* ptr)
{
	free(ptr);
}


static mu_Style default_style = {
    NULL,       /* font */
    {68, 10},   /* size */
    5,          /* padding */
    4,          /* spacing */
    24,         /* indent */
    24,         /* title_height */
    12,         /* scrollbar_size */
    8,          /* thumb_size */
    {
        { 230, 230, 230, 255 }, /* MU_COLOR_TEXT */
        { 25, 25, 25, 255 },    /* MU_COLOR_BORDER */
        { 50, 50, 50, 255 },    /* MU_COLOR_WINDOWBG */
        { 25, 25, 25, 255 },    /* MU_COLOR_TITLEBG */
        { 240, 240, 240, 255 }, /* MU_COLOR_TITLETEXT */
        { 0, 0, 0, 0 },         /* MU_COLOR_PANELBG */
        { 75, 75, 75, 255 },    /* MU_COLOR_BUTTON */
        { 95, 95, 95, 255 },    /* MU_COLOR_BUTTONHOVER */
        { 115, 115, 115, 255 }, /* MU_COLOR_BUTTONFOCUS */
        { 30, 30, 30, 255 },    /* MU_COLOR_BASE */
        { 35, 35, 35, 255 },    /* MU_COLOR_BASEHOVER */
        { 40, 40, 40, 255 },    /* MU_COLOR_BASEFOCUS */
        { 43, 43, 43, 255 },    /* MU_COLOR_SCROLLBASE */
        { 30, 30, 30, 255 }     /* MU_COLOR_SCROLLTHUMB */
    }
};




void mu_init(mu_Context* ctx)
{
    memset(ctx, 0, sizeof(*ctx));
    // ctx->draw_frame = draw_frame;
    ctx->_style     = default_style;
    ctx->style      = &ctx->_style;
}