.phony: all build clean test

all: build


build:
	@make -C scratch
	@make -C forward_typedef
	@make -C queue
	@make -C callback1
	@make -C callback2
	@make -C callback3

clean:
	@make -C scratch clean
	@make -C forward_typedef clean
	@make -C queue clean
	@make -C callback1 clean
	@make -C callback2 clean
	@make -C callback3 clean
