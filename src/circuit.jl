"""
# Function call

`∥(z...)`

Type `\parallel` and hit the `tab` key to autocomplete the parallel symbol ∥

# Description

This calculates the parallell connection of impedances. Optionally, the
calculation can be performed using units from the module Unitiful.

# Variables

`z` Vector of impedances

# Examples

```julia
julia> using Unitful,Unitful.DefaultSymbols,EE
julia> ∥(4,6)
2.4
julia> ∥(4Ω,6Ω)
2.4 Ω
julia> 4Ω∥6Ω
2.4 Ω
julia> 2.4Ω∥(4Ω∥6Ω)
1.2 Ω
```

Type `\Omega` and hit the `tab` key to autocomplete the parallel symbol Ω
"""
function ∥(z...)
    ypar = 0/unit(z[1])
    for k=1:length(z)
        ypar = ypar + 1/z[k]
    end
    return 1/ypar
end
