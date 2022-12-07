# ------------------------------------------------------------------------------
# mass matrix example
# ------------------------------------------------------------------------------

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
function massweakform(u::Array{Float64}, w::Array{Float64})
    v = u * w[1]
    return [v]
end

# mass operator
inputs = [
    OperatorField(lfabasis, [EvaluationMode.interpolation]),
    OperatorField(lfabasis, [EvaluationMode.quadratureweights]),
]
outputs = [OperatorField(lfabasis, [EvaluationMode.interpolation])]
mass = Operator(massweakform, mesh, inputs, outputs)

# compute operator symbols
A = computesymbols(mass, [π, π])
eigenvalues = real(eigvals(A))

# ------------------------------------------------------------------------------
