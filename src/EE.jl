__precompile__(true)
module EE

    # Implementation of EE is based on
    # - PyPlot              Plotting phasors
    # - Unitful             Handling of quantity units
    using PyPlot, Unitful

    export j

    """
    `j = 1im` equals the imaginary unit
    """
    const j=1im

    export phasor
    include("phasor.jl")

    export ∥
    include("circuit.jl")

end
