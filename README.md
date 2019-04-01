# ElectricalEngineering.jl

This is a Julia package on electrical engineering based on [Unitful](docs/Unitful.md) and [PyPlot](https://github.com/JuliaPy/PyPlot.jl). The package ElectricalEngineering.jl is tested with Julia 1.1.0. To install the package, start Julia and hit `]` to switch to the package manager.

```julia-repl
add Pyplot Unitful ElectricalEngineering
```
In order to update to the actual version of GitHub in the package manager, hit `]` and apply:

```julia-repl
update ElectricalEngineering
```

To switch back to the Julia REPL and to start working hit `Backspace`.

The module ElectricalEngineering.jl has to be loaded by `using ElectricalEngineering`. In order to use all the features of ElectricalEngineering.jl, modules Unitful and PyPlot have to be loaded as well. It is thus recommended to appy:

```julia
using Unitful, Unitful.DefaultSymbols, PyPlot, ElectricalEngineering
```

# Features

## Phasors

- Function `pol` to generate a complex quantity based on the length and the angle (polar representation)
```julia
julia> U1 = pol(2V, pi)
-2 + 0im V
julia> U2 = pol(sqrt(2) * 1V, 45°)
1 + 1im V
```
- Constant `j` representing the imaginary unit equivalent to `1im`
- Function `phasor`
    - Plot publication ready phasor diagrams
    - LaTeX labeling with absolute or relative rotation of text

![Phasor diagram](https://raw.githubusercontent.com/christiankral/ElectricalEngineering.jl/master/resources/phasordiagram.png?raw=true) ![Circuit diagram](https://raw.githubusercontent.com/christiankral/ElectricalEngineering.jl/master/resources/RLcircuit.png?raw=true)
- Function `phasorsine`
    - Plot phasor in the left subplot of a figure
    - Plot sine wave corresponding to the phasor in the right subplot
![Phasor and sine wave](https://raw.githubusercontent.com/christiankral/ElectricalEngineering.jl/master/resources/phasorsine.png?raw=true)
- Function `angulardimension`
    - Draw arc to indicate angle between phasors
    - Chose between different arrow shapes
    - Create dimension of phasor
- Function `phasordimension`
    - Create auxiliary lines and parallel shifted dimensions
![Length dimension](https://raw.githubusercontent.com/christiankral/ElectricalEngineering.jl/master/resources/phasordimension.png?raw=true)    

## Circuits and Physics

- Function `∥`
    - Calculate parallel connections of impedances
    - Calculate parallel impedance with or without units
```julia
julia> 4Ω∥6Ω
2.4000000000000004 Ω
julia> 4Ω∥(j*4Ω)
2.0 + 2.0im Ω
```  

## Inputs and Outputs

- Function `printuln`
    - Print complex variables (including) units in rectangular and polar form
    - Limit output to six significant digits
    - Convert printed quantity optionally into a target unit
    - Works with scalars and vectors of real or complex quantities
```julia
julia> U1 = 300V + j*400V
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
    - Color scheme `ElectricalEngineering.Tab20bc` based on https://matplotlib.org/users/plotting/colormaps/grayscale_01_04.pdf

    - Gray scale scheme `ElectricalEngineering.Gray` based on four gray shades
     `colorBlack1`, `colorBlack2`, `colorBlack3`, `colorBlack4`
![Curves](https://raw.githubusercontent.com/christiankral/ElectricalEngineering.jl/master/resources/curves.png?raw=true)
- Additional light background color `colorBlack5`
- Different line and marker types
    - `lineStyle1`, `lineStyle2`, `lineStyle3`,` lineStyle4`
    - `lineWidth1`, `lineWidth2`, `lineWidth3`, `lineWidth4`,
    - `marker1`, `marker2` ,`marker3`, `marker4`
    - `markerSize1`, `markerSize2` ,`markerSize3` ,`markerSize4`
    - `legendFontSize`
    - Type `?ElectricalEngineering.Gray` or `?ElectricalEngineering.Tab20bc` to see application examples
- Assign color schemes to quantities, using either `using ElectricalEngineering.Gray` of gray scale graphics or `using ElectricalEngineering.Tab20bc`
- Function `removeaxes`
    - Removes the axes of the active plot
- Function `arrowaxes`
    - Plot graphs with arrowed axes
    - Add plot labels
![Curves](https://raw.githubusercontent.com/christiankral/ElectricalEngineering.jl/master/resources/arrowaxes.png?raw=true)    
- Function `lengthdimension`
    - Create length dimension with arrows
    - Create auxiliary lines and parallel shifted dimensions
![Length dimension](https://raw.githubusercontent.com/christiankral/ElectricalEngineering.jl/master/resources/lengthdimension.png?raw=true)    
