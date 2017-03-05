# This Makefile adheres to Clark Grubb's "Makefile Style Guide":
#   http://clarkgrubb.com/makefile-style-guide
#
# The build goals that are expected to be used are as follows:
#
# all
# ---
# Day to day developer tasks, updates source files that are auto-generated.  Default target.
#
# setup
# -----
# Use this to setup your environment (after you have activated a python virtual environment).
#
# ci
# --
# Builds CI environment that is used for both running tests *and* shipping production builds.
#
# test
# ----
# Runs all tests, depends on the `ci` build target.
#
# clean
# -----
# Removes all built files.
#
#
# The variables documented below can be set with `make sometarget FOO="my value"`:
#
# NOSEARGS
# ---------
# Allows for passing extra options to the nose test runner (eg: NOSEARGS="--pdb")
#
# TESTARGS
# ---------
# Allows for changing the options passed to the nose test runner entirely (eg: TESTARGS="-a wip").
#

### prologue
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

### environment variables


### internal variables
all :=
clean :=


.PHONY: lint
lint:
	prospector


all += $(wildcard requirements-*.txt)
requirements-%.txt: requirements-%.in
	pip-compile ${PIP_COMPILE_OPTS} --annotate --output-file "$@" "$<"

requirements-dev.txt: requirements-prod.txt


all: $(all)
