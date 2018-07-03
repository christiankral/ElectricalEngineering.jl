__precompile__(true)
module EE

    # Implementation of EE is based on
    # - PyPlot              Plotting phasors
    # - Unitful             Handling of quantity units
    using PyPlot, Unitful

    export j,phasor

    """
    `j = 1im` equals the imaginary unit
    """
    const j=1im

    include("phasor.jl")

end
