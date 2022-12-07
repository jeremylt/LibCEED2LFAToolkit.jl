# libCEED2LFAToolkit

Convert libCEED.jl objects into LFAToolkit objects.

## Introduction


This package provides utilities for converting libCEED.jl objects into LFAToolkit.jl objects to facilitate easier analysis of libCEED.jl operators.

## Installing

To install a development version, run

```
$ julia --project -e 'using Pkg; Pkg.build();'
```

To install and test, run

```
$ julia --project -e 'using Pkg; Pkg.build(); Pkg.test("LFAToolkit")'
```

## Examples

Examples can be found in the ``examples`` directory, with interactive examples in Jupyter notebooks found in the ``examples/jupyter`` directory.

## Documentation

Documentation can be found at the url listed above.
To build the documentation locally, run

```
$ julia --project=docs/ -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate(); Pkg.build()'
```

followed by

```
$ DOCSARGS=local julia --project=docs/ docs/make.jl
```
