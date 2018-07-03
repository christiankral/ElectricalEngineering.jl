__precompile__(true)
module EE

    # Implementation of EE is based on
    # - PyPlot              Plotting phasors
    # - Unitful             Handling of quantity units
    using PyPlot, Unitful

    export j,phasor,polar
    include("phasor.jl")

    export ∥
    include("circuit.jl")

    export printuln
    include("io.jl")

end
