# ------------------------------------------------------------------------------
# test suite
# ------------------------------------------------------------------------------

using Test, Documenter, LibCEED2LFAToolkit, LinearAlgebra
DocMeta.setdocmeta!(
    LibCEED2LFAToolkit,
    :DocTestSetup,
    :(using LibCEED2LFAToolkit);
    recursive = true,
)

# ------------------------------------------------------------------------------
# documentation tests
# ------------------------------------------------------------------------------

@testset "  documentation tests                        " begin
    doctest(LibCEED2LFAToolkit; manual = false)
end

# ------------------------------------------------------------------------------
# mass matrix example
# ------------------------------------------------------------------------------

@testset "  ex001: mass example                        " begin
    include("../examples/ex001_mass.jl")

    @test minimum(eigenvalues) ≈ 0.008379422444571976
    @test maximum(eigenvalues) ≈ 0.17361111111111088
end

# ------------------------------------------------------------------------------
