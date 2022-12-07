# ------------------------------------------------------------------------------
# documentation
# ------------------------------------------------------------------------------

using Documenter, DocumenterTools, Markdown, LibCEED2LFAToolkit
DocMeta.setdocmeta!(
    LibCEED2LFAToolkit,
    :DocTestSetup,
    :(import Pkg; Pkg.add("LibCEED"); Pkg.add("LFAToolkit"); using LibCEED2LFAToolkit);
    recursive = true,
)

# The DOCSARGS environment variable can be used to pass additional arguments to make.jl.
# This is useful on CI, if you need to change the behavior of the build slightly but you
# can not change the .travis.yml or make.jl scripts any more (e.g. for a tag build).
if haskey(ENV, "DOCSARGS")
    for arg in split(ENV["DOCSARGS"])
        (arg in ARGS) || push!(ARGS, arg)
    end
end

# ------------------------------------------------------------------------------
# make
# ------------------------------------------------------------------------------

makedocs(
    modules = [LibCEED2LFAToolkit],
    clean = false,
    # strict = true, Bug: https://github.com/JuliaDocs/Documenter.jl/issues/1883
    sitename = "LibCEED2LFAToolkit.jl",
    authors = "Jeremy L Thompson",
    format = Documenter.HTML(
        # Use clean URLs, unless built as a "local" build
        prettyurls = !("local" in ARGS),
        canonical = "https://jeremylt.github.io/LibCEED2LFAToolkit.jl/stable/",
        highlights = ["yaml"],
    ),
    pages = [
        "Introduction" => "index.md",
        "Public API" => "public.md",
        "Release Notes" => "release_notes.md",
    ],
)

# ------------------------------------------------------------------------------
# deploy
# ------------------------------------------------------------------------------

deploydocs(
    repo = "github.com/jeremylt/LibCEED2LFAToolkit.jl.git",
    devbranch = "main",
    target = "build",
    push_preview = true,
)

# ------------------------------------------------------------------------------
