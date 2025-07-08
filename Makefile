.phony: all build clean test

all: build


build:
	@make -C scratch
	@make -C forward_typedef
	@make -C queue
	@make -C nested
	@make -C callback1
	@make -C callback2
	@make -C callback3
	@make -C callback4

clean:
	@make -C scratch clean
	@make -C forward_typedef clean
	@make -C queue clean
	@make -C nested clean
	@make -C callback1 clean
	@make -C callback2 clean
	@make -C callback3 clean
	@make -C callback4 clean
