# ------------------------------------------------------------------------------
# finite element bases
# ------------------------------------------------------------------------------

"""
```julia
converttensorbasis(ceedbasis)
```

Convert a tensor product basis

Note: LFAToolkit.jl currently does not use the basis nodes but the `Basis` constructors require these values.
LibCEED.jl does not store or provide an accessor for nodes.
This function passes in an array of `numnodes1d` linearly spaced nodes between `[-1.0, 1.0]`.
If LFAToolkit.jl makes changes to use the nodal locations in the future, then any related functionality will not work unless storage and an accesor for these values is added to libCEED and LibCEED.jl.

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
    LFATensorBasis(
        Int(getnumnodes1d(ceedbasis)),
        Int(getnumqpts1d(ceedbasis)),
        Int(getnumcomponents(ceedbasis)),
        Int(getdimension(ceedbasis)),
        LinRange(-1, 1, Int(getnumnodes1d(ceedbasis))),
        # note: these values are copies of the internal libCEED data
        getqref(ceedbasis)[1:Int(getnumqpts1d(ceedbasis))],
        getqweights(ceedbasis)[1:Int(getnumqpts1d(ceedbasis))],
        getinterp1d(ceedbasis),
        getgrad1d(ceedbasis);
        numberelements1d = 1,
    )
end

# ------------------------------------------------------------------------------
