
.PHONY: all build clean test


all: build

build:
	@python3 setup.py build_ext --inplace
	@rm -f demo.c

clean:
	@rm -rf demo.c build demo.*.so
	@find . -type d -name __pycache__ -exec rm -rf {} \; -prune
	@find . -type d -path ".*_cache"  -exec rm -rf {} \; -prune

test:
	@pytest -vv

