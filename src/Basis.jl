# ------------------------------------------------------------------------------
# finite element bases
# ------------------------------------------------------------------------------

"""
```julia
converttensorbasis(ceedbasis)
```

Tensor product basis

# Arguments:

  - `ceedbasis`:  LibCEED.jl tensor product Basis object

# Returns:

  - LFAToolkit.jl tensor product basis object

# Example:

```jldoctest
using LibCEED, LFAToolkit

# libCEED objects
ceed = LibCEED.Ceed("/cpu/self")
ceedbasis = LibCEED.create_tensor_h1_lagrange_basis(ceed, 2, 3, 4, 5, LibCEED.GAUSS)

# convert
lfabasis = converttensorbasis(ceedbasis)
println(lfabasis)

# output

tensor product basis:
    numbernodes1d: 4
    numberquadraturepoints1d: 5
    numbercomponents: 3
    dimension: 2

```
"""
function converttensorbasis(ceedbasis::CeedBasis)
    # basis properties
    numbernodes1d = Int(getnumnodes1d(ceedbasis))
    numberquadraturepoints1d = Int(getnumqpts1d(ceedbasis))
    numbercomponents = Int(getnumcomponents(ceedbasis))
    dimension = Int(getdimension(ceedbasis))

    # copy libCEED basis arrays
    quadraturepoints1d = zeros(numberquadraturepoints1d)
    quadraturepoints1d .= getqref(ceedbasis)[1:Int(getnumqpts1d(ceedbasis))]
    quadratureweights1d = zeros(numberquadraturepoints1d)
    quadratureweights1d .= getqweights(ceedbasis)[1:Int(getnumqpts1d(ceedbasis))]
    interpolation1d = zeros(numberquadraturepoints1d, numbernodes1d)
    interpolation1d .= getinterp1d(ceedbasis)
    gradient1d = zeros(numberquadraturepoints1d, numbernodes1d)
    gradient1d .= getgrad1d(ceedbasis)

    # create LFAToolkit basis
    LFATensorBasis(
        numbernodes1d,
        numberquadraturepoints1d,
        numbercomponents,
        dimension,
        LinRange(-1, 1, numbernodes1d),
        quadraturepoints1d,
        quadratureweights1d,
        interpolation1d,
        gradient1d;
        numberelements1d = 1,
    )
end

# ------------------------------------------------------------------------------
