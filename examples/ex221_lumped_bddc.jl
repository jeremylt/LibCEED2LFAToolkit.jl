# ------------------------------------------------------------------------------
# lumped BDDC example
# ------------------------------------------------------------------------------

using LFAToolkit
using LinearAlgebra

using LibCEED: Ceed, GAUSS, create_tensor_h1_lagrange_basis
using LFAToolkit
using LibCEED2LFAToolkit
using LinearAlgebra

# libCEED basis
ceed = Ceed("/cpu/self")
ceedbasis = create_tensor_h1_lagrange_basis(ceed, 2, 1, 4, 4, GAUSS)

# LFA setup
mesh = Mesh2D(1.0, 1.0)
lfabasis = converttensorbasis(ceedbasis)

# weak form
function diffusionweakform(du::Array{Float64}, w::Array{Float64})
    dv = du * w[1]
    return [dv]
end

# diffusion operator
inputs = [
    OperatorField(lfabasis, [EvaluationMode.gradient]),
    OperatorField(lfabasis, [EvaluationMode.quadratureweights]),
]
outputs = [OperatorField(lfabasis, [EvaluationMode.gradient])]
diffusion = Operator(diffusionweakform, mesh, inputs, outputs)

# lumped BDDC preconditioner
bddc = LumpedBDDC(diffusion)

# compute operator symbols
A = computesymbols(bddc, [0.2], [π, π])
eigenvalues = real(eigvals(A))

# ------------------------------------------------------------------------------
