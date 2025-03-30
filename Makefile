# Bootstrap Makefile for dotfiles setup
# This handles configuration files for both MacOS and Linux

UNAME := $(shell uname -s)
ifeq ($(UNAME), Darwin)
	OS := macos
else ifeq ($(UNAME), Linux)
	OS := linux
else
	$(error Unsupported operating system: $(UNAME))
endif

HOME_DIR := $(shell echo $$HOME)
DOTFILES_DIR := $(shell pwd)

ifeq ($(DEBUG), 1)
	@echo "DEBUG: HOME_DIR: $(HOME_DIR), DOTFILES_DIR: $(DOTFILES_DIR)"
endif

.PHONY: debug

sinclude make/common.mk
sinclude make/$(OS).mk

ifeq ($(wildcard make/$(OS).mk),)
$(error Missing OS-specific makefile: makefiles/$(OS).mk)
endif

.DEFAULT_GOAL := debug

debug:
	@echo "DEBUG: HOME_DIR: $(HOME_DIR), DOTFILES_DIR: $(DOTFILES_DIR)"
