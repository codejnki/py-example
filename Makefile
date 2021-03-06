.PHONY: test lint fix install build

project_folder = src
test_folder = test
main_file = main.py
files = $(wildcard **/.py)
test_files = $(wildcard **/test_*.py)

test:
	@pytest -s -v $(test_files) --doctest-modules --cov $(project_folder) --cov-config=.coveragerc --cov-report term-missing

lint:
	@flake8 --statistics --extend-ignore=W292 $(project_folder) $(test_folder)

fix:
	@autopep8 --aggressive --in-place -r $(project_folder) $(test_folder)

install:
	@pip3 install -U -r requirements.txt

build:
	@docker build . -t nifi-cluster-coordinator:$(dockertag)

run:
	@python3 $(project_folder)/$(main_file)