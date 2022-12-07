# ------------------------------------------------------------------------------
# p-multigrid example
# ------------------------------------------------------------------------------

using LibCEED: Ceed, GAUSS, GAUSS_LOBATTO, create_tensor_h1_lagrange_basis
using LFAToolkit
using LibCEED2LFAToolkit
using LinearAlgebra

# problem data
finep = 2
coarsep = 1
numbercomponents = 1
dimension = 2

# libCEED basis
ceed = Ceed("/cpu/self")
fineceedbasis = create_tensor_h1_lagrange_basis(
    ceed,
    dimension,
    numbercomponents,
    finep + 1,
    finep + 1,
    GAUSS,
)
coarseceedbasis = create_tensor_h1_lagrange_basis(
    ceed,
    dimension,
    numbercomponents,
    coarsep + 1,
    finep + 1,
    GAUSS,
)
ctofceedbasis = create_tensor_h1_lagrange_basis(
    ceed,
    dimension,
    numbercomponents,
    coarsep + 1,
    finep + 1,
    GAUSS_LOBATTO,
)

# LFA setup
mesh = Mesh2D(1.0, 1.0)
finelfabasis = converttensorbasis(fineceedbasis)
coarselfabasis = converttensorbasis(coarseceedbasis)
ctoflfabasis = converttensorbasis(ctofceedbasis)

# weak form
function diffusionweakform(du::Array{Float64}, w::Array{Float64})
    dv = du * w[1]
    return [dv]
end

# diffusion operator builder utility
function buildoperator(lfabasis, mesh)
    inputs = [
        OperatorField(lfabasis, [EvaluationMode.gradient]),
        OperatorField(lfabasis, [EvaluationMode.quadratureweights]),
    ]
    outputs = [OperatorField(lfabasis, [EvaluationMode.gradient])]
    Operator(diffusionweakform, mesh, inputs, outputs)
end

# diffusion operators
finediffusion = buildoperator(finelfabasis, mesh)
coarsediffusion = buildoperator(coarselfabasis, mesh)

# Chebyshev smoother
chebyshev = Chebyshev(finediffusion)

# p-multigrid preconditioner
multigrid = PMultigrid(finediffusion, coarsediffusion, chebyshev, [ctoflfabasis])

# compute operator symbols
A = computesymbols(multigrid, [3], [1, 1], [π, π])
eigenvalues = real(eigvals(A))

# ------------------------------------------------------------------------------
