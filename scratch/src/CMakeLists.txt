
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/src/scratch)

find_package(
	Python
	COMPONENTS Interpreter Development.Module
	REQUIRED)

add_custom_command(
	OUTPUT "${CMAKE_BINARY_DIR}/scratch.c"
	MAIN_DEPENDENCY "${CMAKE_CURRENT_SOURCE_DIR}/scratch/scratch.pyx"
	VERBATIM
	COMMAND
		Python::Interpreter -m cython
		"${CMAKE_CURRENT_SOURCE_DIR}/scratch/scratch.pyx" --output-file
		"${CMAKE_BINARY_DIR}/scratch.c")

python_add_library(
    scratch
    MODULE
    ${CMAKE_BINARY_DIR}/scratch.c
    WITH_SOABI
)

target_include_directories(
    scratch
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/scratch
)
