# EE.jl

This is a Julia package on electrical engineering based on [Unitful](https://github.com/ajkeller34/Unitful.jl).
The processing and calculation of real and complex quantities is supported. 

The non-official package EE.jl can be installed by:

```
Pkg.clone("git://github.com/christiankral/EE.jl.git")
```

In order to update to the actual version on GitHub use:

```
Pkg.update("EE")
```

The module EE.jl has be loaded by `using EE`. After updating to newer version, 
the module can be reloaded without exiting the session by `reload("EE")`.

# Features

## Implemented Features

- Plot publication ready phasor diagrams including LaTeX labeling  

## Planned Features

- Print complex variables (including) units in rectangular and polar form
