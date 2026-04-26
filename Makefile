EMACS ?= emacs
ROOT := $(CURDIR)

# Compile all local config .el files, excluding third-party packages.
EL_FILES := $(shell find "$(ROOT)" -type f -name "*.el" \
	-not -path "$(ROOT)/elpa/*" \
	-not -path "$(ROOT)/.git/*")

.PHONY: all compile clean

all: compile

compile:
	@echo "Compiling Emacs Lisp files to .elc..."
	@$(EMACS) --batch -Q \
		--eval "(setq user-emacs-directory (file-name-as-directory \"$(ROOT)\"))" \
		--eval "(add-to-list 'load-path (expand-file-name \"lisp\" user-emacs-directory))" \
		--eval "(setq package-user-dir (expand-file-name \"elpa\" user-emacs-directory))" \
		--eval "(require 'package)" \
		--eval "(package-initialize)" \
		--eval "(byte-recompile-directory user-emacs-directory 0)" \
		--eval "(message \"Byte compilation finished\")"

clean:
	@echo "Removing generated .elc files..."
	@find "$(ROOT)" -type f -name "*.elc" \
		-not -path "$(ROOT)/elpa/*" \
		-delete
