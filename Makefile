SHELL := /bin/bash
COVERAGE_FLAGS := --rcfile .coveragerc

.PHONY: build clean init test 

activate:
	. ./venv/bin/activate

build: activate
	python3 -m build

clean:
	if [ -d ./venv ]; then rm -rf ./venv; fi;		

init: clean
	python3 -m venv venv
	make activate
	pip3 install -r requirements.txt


test: test-coverage test-lint

test-coverage: activate
	coverage run $(COVERAGE_FLAGS) -m unittest discover -p '*_test.py'
	coverage report $(COVERAGE_FLAGS)

test-lint: activate
	pylint *.py	--rcfile .pylintrc
	black *.py --config pyproject.toml --check
