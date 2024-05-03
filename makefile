# https://www.gnu.org/software/make/manual/make.html
SHELL=bash
.PHONY: default
default:

docker=docker
python=python3

pip_tools_version=6.4.0
requirements_in_file="/scripts/requirements.in"
requirements_txt_file="/output/requirements.txt"
python_image_digest="3.10.1-slim-buster@sha256:d4354e51d606b0cf335fca22714bd599eef74ddc5778de31c64f1f73941008a4"


.PHONY: generate-dependencies
generate-dependencies:
	$(docker) run \
		--rm \
		--volume $$(pwd)/scripts:/scripts:ro \
		--volume $$(pwd):/output \
		docker.io/library/python:$(python_image_digest) \
		/bin/bash /scripts/install-dependencies.sh $(pip_tools_version) $(requirements_in_file) $(requirements_txt_file)

.PHONY: install-dependencies
install-dependencies:
	$(python) -m pip install --require-hashes --requirement requirements.txt
	npm install

.PHONY: lint
lint:
	npx prettier --check .
	$(python) -m yamllint --strict --format github .
	$(python) -m ansible-lint .

.PHONY: format
format:
	npx prettier --write .
