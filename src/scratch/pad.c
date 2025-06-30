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