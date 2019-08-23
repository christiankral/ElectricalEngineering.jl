__precompile__(true)
@doc raw"""
# ElectricalEngineering

This is a Julia package on electrical engineering based on
[Unitful](https://github.com/PainterQubits/Unitful.jl) and
[PyPlot](https://github.com/JuliaPy/PyPlot.jl). The package
ElectricalEngineering.jl is tested with Julia 1.

## Plotting

- `arrowaxes` Creates a plot with a horizontal and a vertical axis instead of a
- frame

- `removeaxes` Removes the axis of the actual plot

- `lengthdimension` Draws length dimension with label based on rectangular x-
  and y-coordinates. The length dimension arrow can be shifted parallel to the
  specified  coordinates by means the single parameter `par`. Additionally,
  auxiliary lines  from the specified coordinates to the length dimension are
  drawn.

## Complex Phasors

- `pol` Creates a complex quantity with length `r` and angle `phi`

- `∠` Creates a complex quantity with length 1 and angle `phi`

- `phasor` Draws a phasor from a starting point `origin` and end point
  `origin`+`c`. The phasor consists of a shaft and an arrow head. Each phasor
  `c`  is plotted as a relative quantity, i.e., `c/ref` is actually shown the
  plot figure. This concept of plotting a per unit phasor is used to be able to
  plot phasor with different quantities, e.g., voltage and current phasors. It
  is important that the variables `c`, `origin` and `ref` have the same units
  (defined through Unitful).

- `phasorsine` Draws a phasor with magnitude between 0 and 1 on the left subplot
  of a figure and a sine diagram on the right subplot of the figure. Such graph
  is used in electrical engineering to explain the relationship between phasors
  and time domain wave forms.

- `angulardimension` Draws an arrowed arc, intended to label the angle between
  phasors. The arc is drawn from angle `phi1` (begin) to `phi2` (end). The begin
  and end arrow shapes can be set. The arc can be labeled and optionally a dot
  maker can be used to indicate right angles (90°).

- `phasordimension` Draws length dimension with label based on rectangular x-
  and y-coordinates. The length dimension arrow can be shifted parallel to the
  specified  coordinates by means the single parameter `par`. Additionally,
  auxiliary lines  from the specified coordinates to the length dimension are
  drawn.

## Complex Circuit Calculations

- `∥` Calculates the parallel connection of impedances. Optionally, the
  calculation can be performed using units from the module Unitful.


## Input and Output

- `printuln` Prints a real or complex variable in an optionally specified unit

- `usprint` Returns a string containing the number with six digits plus unit
  without space in between, such that the string output can be copied and
  pasted.

- `save3fig` Save the actual figure in the file formats `png`, `eps` and `pdf`
  including subdirectories.  These three graphics format are relevant when
  processing figures in LaTeX, LyX, LibreOffice or other word processors

## See also `?` on

- `ElectricalEngineering.Gray`

- `ElectricalEngineering.Tab20bc`
"""
module ElectricalEngineering

    # Implementation of ElectricalEngineering is based on
    # - PyPlot              Plotting phasors
    # - Unitful             Handling of quantity units
    using Printf, Base, Statistics, PyPlot, Unitful


    # Default colors for plotting (with PyPlot)
    include("plot.jl")
    include("Tab20bc.jl")
    include("Gray.jl")

    # Complex phasor calculation and plotting
    include("phasor.jl")

    # Calculations in ElectricalEngineering circuits
    include("circuit.jl")

    # Winding calculations and winding plot routines
    include("winding.jl")

    # Input and output functions to print phasors, figures, etc.
    include("io.jl")

    # Unitful additional functions
    include("unitful.jl")
end
