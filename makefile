# https://www.gnu.org/software/make/manual/make.html
SHELL=bash
.PHONY: default
default:

docker=docker

pip_tools_version=6.4.0
requirements_in_file="/scripts/requirements.in"
requirements_txt_file="/output/requirements.txt"
python_image_digest="3.8-slim-buster@sha256:50d7ea31bccbab5c34567c1b14765b359f03ff1aeb202dd30be8ecbf169c581e"


.PHONY: generate-dependencies
generate-dependencies:
	$(docker) run --rm --volume $$(pwd)/scripts:/scripts:ro --volume $$(pwd):/output docker.io/library/python:$(python_image_digest) /bin/bash /scripts/install-dependencies.sh $(pip_tools_version) $(requirements_in_file) $(requirements_txt_file)

.PHONY: install-dependencies
install-dependencies:
	python -m pip install --require-hashes --requirement requirements.txt
	npm install

.PHONY: lint
lint:
	npx prettier --check .
	python -m yamllint .

.PHONY: format
format:
	npx prettier --write .