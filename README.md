# LibCEED2LFAToolkit

[![CI Status](https://github.com/jeremylt/LibCEED2LFAToolkit.jl/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/jeremylt/LibCEED2LFAToolkit.jl/actions/workflows/test.yml)
[![CodeCov](https://codecov.io/gh/jeremylt/LibCEED2LFAToolkit.jl/branch/main/graph/badge.svg?token=6OKYJIWX2E)](https://codecov.io/gh/jeremylt/LibCEED2LFAToolkit.jl)
[![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)](https://opensource.org/licenses/BSD-2-Clause)
[![Documentation](https://img.shields.io/badge/docs-dev-blue)](https://jeremylt.github.io/LibCEED2LFAToolkit.jl/dev/)

Convert LibCEED.jl objects into LFAToolkit.jl objects

## Introduction


This package provides utilities for converting LibCEED.jl objects into LFAToolkit.jl objects to facilitate easier analysis of LibCEED.jl operators.

## Installing

To install a development version, run

```
$ julia --project -e 'using Pkg; Pkg.build();'
```

To install and test, run

```
$ julia --project -e 'using Pkg; Pkg.build(); Pkg.test("LibCEED2LFAToolkit")'
```

## Examples

Examples can be found in the ``examples`` directory.

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
