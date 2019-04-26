export ∥

@doc raw"""
# Function call

`∥(z...)`

Type `\parallel` and hit the `tab` key to autocomplete the parallel symbol ∥

# Description

This calculates the parallel connection of impedances. Optionally, the
calculation can be performed using units from the module Unitful.

**Important note:** Use the ∥ operator in parentheses, since its precedence
is equal to the (low) precedence of relation operators or use the function call
with arguments to avoid miscalculations

# Variables

`z` Vector of impedances

# Examples

```julia
julia> using Unitful,Unitful.DefaultSymbols,ElectricalEngineering
julia> ∥(4,6)
2.4
julia> ∥(4Ω,6Ω)
2.4 Ω
julia> 2Ω+(4Ω∥6Ω) # Parentheses are ALWAYS required since
4.4 Ω
julia> 2Ω+4Ω∥6Ω # Is equal to (2Ω+4Ω)∥6Ω which is usually NOT intended
3.0 Ω
julia> (2.4Ω∥(4Ω∥6Ω))
1.2 Ω
julia> ∥(4Ω,6Ω,2.4Ω)
1.2 Ω

```

Type `\Omega` and hit the `tab` key to autocomplete the parallel symbol Ω
"""
function ∥(z...)
    ypar = 0.0/unit(z[1])
    for k=1:length(z)
        ypar = ypar + 1/z[k]
    end
    return 1/ypar
end
