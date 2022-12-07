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
# diffusion operator example
# ------------------------------------------------------------------------------

@testset "  ex002: diffusion example                   " begin
    include("../examples/ex002_diffusion.jl")

    @test minimum(eigenvalues) ≈ 0.3321136902208588
    @test maximum(eigenvalues) ≈ 2.131118740197114
end

# ------------------------------------------------------------------------------
# p-multigrid example
# ------------------------------------------------------------------------------

@testset "  ex201: p-multigrid example                 " begin
    include("../examples/ex201_pmultigrid.jl")

    @test maximum(eigenvalues) ≈ 0.026444090458920978
end

# ------------------------------------------------------------------------------
# lumped BDDC example
# ------------------------------------------------------------------------------

@testset "  ex221: lumped BDDC example                 " begin
    include("../examples/ex221_lumped_bddc.jl")

    @test minimum(eigenvalues) ≈ -0.19999999999999862
    @test maximum(eigenvalues) ≈ 0.8000000000000009
end

# ------------------------------------------------------------------------------
# Dirichlet BDDC example
# ------------------------------------------------------------------------------

@testset "  ex223: Dirichlet BDDC example              " begin
    include("../examples/ex223_dirichlet_bddc.jl")

    @test minimum(eigenvalues) ≈ 0.7690030364372471
    @test maximum(eigenvalues) ≈ 0.8000000000000004
end

# ------------------------------------------------------------------------------
