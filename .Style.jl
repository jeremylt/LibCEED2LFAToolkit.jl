# ------------------------------------------------------------------------------
# formatter
# ------------------------------------------------------------------------------

using Pkg
Pkg.add("JuliaFormatter")
using JuliaFormatter

# ------------------------------------------------------------------------------
# run JuliaFormatter
# ------------------------------------------------------------------------------

format(["src", "test", "examples", "docs"], format_docstrings = true)

# ------------------------------------------------------------------------------
