"""
# Function call

`∥(z...)`

Type `\parallel` and hit the `tab` key to autocomplete the parallel symbol

# Description

This calculates the parallell connection of impedances. Optionally, the
calculation can be performed using units from the module Unitiful.

# Variables

`z` Vector of impedances
"""
function ∥(z...)
    ypar = 0/unit(z[1])
    for k=1:length(z)
        ypar = ypar + 1/z[k]
    end
    return 1/ypar
end
