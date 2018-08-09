# EE.jl

This is a Julia package on electrical engineering (EE) based on [Unitful](docs/Unitful.md) and [PyPlot](https://github.com/JuliaPy/PyPlot.jl). To install these modules, apply `Pkg.add("Unitful")` and `Pkg.add("PyPlot")`
In the EE.jl module the processing and calculation of real and complex quantities is supported. The module is tested with Julia 0.6.2 and 0.6.4.

The non-official package EE.jl can be installed by (has to be done only once):

```julia
Pkg.clone("git://github.com/christiankral/EE.jl.git")
```

In order to update to the actual version of GitHub use:

```julia
Pkg.update("EE")
```

The module EE.jl has to be loaded by `using EE`. In order to use all the features of EE.jl, modules Unitful and PyPlot have to be loaded as well. It is thus recommended to appy:

```julia
using Unitful,Unitful.DefaultSymbols,PyPlot,EE
```

**Note:**  After updating to a newer version of EE.jl, the module can be reloaded without exiting the session by applying `reload("EE")`.

# Features

## Phasors

- Function `phasor`
    - Plot publication ready phasor diagrams
    - LaTeX labeling with absolute or relative rotation of text

![Phasor diagram](https://raw.githubusercontent.com/christiankral/EE.jl/master/resources/phasordiagram.png?raw=true) ![Circuit diagram](https://raw.githubusercontent.com/christiankral/EE.jl/master/resources/RLcircuit.png?raw=true)

- Function `pol` to generate a complex quantity based on the length and the angle (polar representation)
```julia
julia> U1 = pol(2V, pi)
-2 + 0im V
julia> U2 = pol(sqrt(2) * 1V, 45°)
1 + 1im V
```
- Constant `j` representing the imaginary unit equivalent to `1im`

## Circuits and Physics

- Function `∥`
    - Calculate parallel connections of impedances
    - Calculate parallel impedance with or without units
```julia
julia> 4Ω∥6Ω
2.4000000000000004 Ω
julia> 4Ω∥(j * 4Ω)
2.0 + 2.0im Ω
```  

## Inputs and Outputs

- Function `printuln`
    - Print complex variables (including) units in rectangular and polar form
    - Limit output to six significant digits
    - Convert printed quantity optionally into a target unit
    - Works with scalars and vectors of real or complex quantities
```julia
julia> U1 = 300V+j*400V
julia> printuln("U1", U1, kV)
              U1 = 0.3 kV + j 0.4 kV
                 = 0.5 kV ∠ 53.1301°
julia> printuln("real(U1)", real(U1),kV)
        real(U1) = 0.3 kV
julia> printuln("U1", U1, V, label="(a)")
(a)           U1 = 300 V + j 400 V
                 = 500 V ∠ 53.1301°
```
- Function `save3fig`
    - Save one figure in the three file formats `png`, `eps` and `pdf`
    - Optionally crop figures

    ## Plotting

- Assign two different color schemes (may be loaded alternatively)
    - Color scheme `EE.Tab20bc` based on https://matplotlib.org/users/plotting/colormaps/grayscale_01_04.pdf

    - Gray scale scheme `EE.Gray` based on four gray shades
     `colorBlack1`, `colorBlack2`, `colorBlack3`, `colorBlack4`
![Curves](https://raw.githubusercontent.com/christiankral/EE.jl/master/resources/curves.png?raw=true)
- Additional light background color `colorBlack5`
- Different line and marker types
    - `lineStyle1`, `lineStyle2`, `lineStyle3`,` lineStyle4`
    - `lineWidth1`, `lineWidth2`, `lineWidth3`, `lineWidth4`,
    - `marker1`, `marker2` ,`marker3`, `marker4`
    - `markerSize1`, `markerSize2` ,`markerSize3` ,`markerSize4`
    - `legendFontSize`
    - Type `?EE.Gray` or `?EE.Tab20bc` to see application examples
- Assign color schemes to quantities, using either `using EE.Gray` of gray scale graphics or `using EE.Tab20bc`
- Function `arrowaxes`
    - Plot graphs with arrowed axes
    - Add plot labels
![Curves](https://raw.githubusercontent.com/christiankral/EE.jl/master/resources/arrowaxes.png?raw=true)    
