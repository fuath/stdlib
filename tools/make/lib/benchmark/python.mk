
# TARGETS #

#/
# Runs Python benchmarks consecutively.
#
# ## Notes
#
# -   This recipe assumes that benchmark files can be run via Python.
# -   This recipe is useful when wanting to glob for Python benchmark files (e.g., run all Python benchmarks for a particular package).
#
#
# @param {string} [BENCHMARKS_FILTER] - filepath pattern (e.g., `.*/math/base/special/digamma/.*`)
#
# @example
# make benchmark-python
#
# @example
# make benchmark-python BENCHMARKS_FILTER=.*/math/base/special/digamma/.*
#/
benchmark-python:
	$(QUIET) $(FIND_PYTHON_BENCHMARKS_CMD) | grep '^[\/]\|^[a-zA-Z]:[/\]' | while read -r file; do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		$(PYTHON) $$file || exit 1; \
	done

.PHONY: benchmark-python

#/
# Runs a specified list of Python benchmarks consecutively.
#
# ## Notes
#
# -   This recipe assumes that benchmark files can be run via Python.
# -   This recipe is useful when wanting to run a list of Python benchmark files generated by some other command (e.g., a list of changed Python benchmark files obtained via `git diff`).
#
#
# @param {string} FILES - list of Python benchmark file paths
#
# @example
# make benchmark-python-files FILES='/foo/benchmark.py /bar/benchmark.py'
#/
benchmark-python-files:
	$(QUIET) for file in $(FILES); do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		$(PYTHON) $$file || exit 1; \
	done

.PHONY: benchmark-python-files
