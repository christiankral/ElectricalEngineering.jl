__precompile__(true)
module EE

    # Implementation of EE is based on
    # - PyPlot              Plotting phasors
    # - Unitful             Handling of quantity units
    using PyPlot, Unitful

    # Complex phasor calculation and plotting
    include("phasor.jl")

    # Calculations in EE circuits
    include("circuit.jl")

    # Input and output functions to print phasors, figures, etc.
    include("io.jl")

    # Default colors for plotting (with PyPlot)
    include("plot.jl")
    include("Tab20bc.jl")
    include("Gray.jl")
end
