# ------------------------------------------------------------------------------
# test suite
# ------------------------------------------------------------------------------

using Test, Documenter, LibCEED2LFAToolkit
DocMeta.setdocmeta!(
    LibCEED2LFAToolkit,
    :DocTestSetup,
    :(using LibCEED2LFAToolkit);
    recursive = true,
)

# ------------------------------------------------------------------------------
# documentation tests
# ------------------------------------------------------------------------------

@testset "  documentation tests  " begin
    doctest(LibCEED2LFAToolkit; manual = false)
end

# ------------------------------------------------------------------------------
