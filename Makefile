# Bootstrap Makefile for dotfiles setup
# This handles configuration files for both MacOS and Linux
# Compatible with GNU Make 3.81

# Debug mode (set with DEBUG=1)
DEBUG ?= 0
ifeq ($(DEBUG), 1)
	SHELL := /bin/bash -x
	# For Make 3.81, simplify the debug print function
	DEBUG_PREFIX := "DEBUG: "
else
	DEBUG_PREFIX := ""
endif

# Detect OS
UNAME := $(shell uname -s)
ifeq ($(UNAME), Darwin)
	OS := macos
else ifeq ($(UNAME), Linux)
	OS := linux
else
	$(error Unsupported operating system: $(UNAME))
endif

# Home directory for dotfiles
HOME_DIR := $(shell echo $$HOME)
DOTFILES_DIR := $(shell pwd)

# Debug information - use conditionals instead of call
ifeq ($(DEBUG), 1)
	@echo "DEBUG: HOME_DIR: $(HOME_DIR), DOTFILES_DIR: $(DOTFILES_DIR)"
endif

.PHONY: all install backup clean list help debug

# Default goal - Make 3.81 supports this
.DEFAULT_GOAL := help

# Colors for better output
YELLOW := "\033[1;33m"
GREEN := "\033[1;32m"
BLUE := "\033[1;34m"
NC := "\033[0m" # No Color

help:
	@echo $(GREEN)"Dotfiles Management Makefile"$(NC)
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  all      Install all dotfiles for $(OS)"
	@echo "  install  Create symlinks for dotfiles"
	@echo "  backup   Backup existing dotfiles before installing"
	@echo "  clean    Remove symlinks to dotfiles"
	@echo "  list     List all managed dotfiles"
	@echo "  debug    Print debug information about environment"
	@echo ""
	@echo "Options:"
	@echo "  DEBUG=1  Run with debug output (make DEBUG=1 install)"
	@echo ""

debug:
	@echo $(BLUE)"Debug Information:"$(NC)
	@echo "Operating System: $(OS) ($(UNAME))"
	@echo "Home Directory: $(HOME_DIR)"
	@echo "Dotfiles Directory: $(DOTFILES_DIR)"
	@echo "Files to manage:"
	@for file in $(DOTFILES); do \
		if [ -f $(DOTFILES_DIR)/$$file ]; then \
			echo "  ✓ $$file (exists)"; \
		else \
			echo "  ✗ $$file (missing)"; \
		fi; \
	done
	@echo "Make Version: $(shell make --version | head -n 1)"
	@echo "Shell: $(shell echo $$SHELL)"
