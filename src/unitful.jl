export upstrip

"""
# Function call

`upstrip(u, U)`

# Description

Returns the number of any physical quantity `u`. If the optional unit `U` is not
specified the quantity is converted to its coherent (preferred) unit before
determining the number.

# Variables

`u` Variable to be processed

`U` Optional target unit; if not provided, the quantity is converted to its coherent (preferred) unit before
determining the number.

# Examples
```julia
julia> I1 = 1.0mA
julia> upstrip(I1)
0.001
julia> usprint(I1, mA)
1.0
"""
function upstrip(u, U=unit(upreferred(u)))
    q=uconvert(U, u)
    return ustrip(q)
end
