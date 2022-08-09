PROJECT := python_cli
COVERAGE_FLAGS := --rcfile .coveragerc

ifeq ($(OS), Windows_NT)
	SHELL=C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe
	ACTIVATE=./venv/Scripts/Activate.ps1
	CLEAN=if (Test-Path .\venv) { Remove-Item .\venv -Force }
	CHAIN=;
	BUILD=pip install wheel; python3 -m build --no-isolation
else
	SHELL=/bin/bash
	ACTIVATE= . ./venv/bin/activate
	CLEAN=if [ -d ./venv ]; then rm -rf ./venv; fi;
	CHAIN=&&
	BUILD=python3 -m build
endif

.PHONY: build clean init test 


build: 
	$(ACTIVATE) $(CHAIN) $(BUILD)

clean:
	$(CLEAN)	

init: clean
	python3 -m venv venv $(CHAIN) $(ACTIVATE) $(CHAIN) python3 -m pip install --upgrade pip $(CHAIN) pip3 install -r requirements.txt 

test: test-coverage test-lint

test-coverage:
	$(ACTIVATE) $(CHAIN) coverage run $(COVERAGE_FLAGS) -m unittest discover -p '*_test.py' $(CHAIN) coverage report $(COVERAGE_FLAGS)

test-lint:
	$(ACTIVATE) $(CHAIN) pylint **/*.py	--rcfile .pylintrc $(CHAIN) black $(PROJECT) --config pyproject.toml --check
