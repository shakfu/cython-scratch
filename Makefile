.phony: all build clean test

all: build


build:
	@make -C scratch
	@make -C forward_typedef
	@make -C queue

clean:
	@make -C scratch clean
	@make -C forward_typedef clean
	@make -C queue clean

