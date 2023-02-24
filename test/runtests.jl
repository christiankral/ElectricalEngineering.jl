# test/runtests.jl
using ElectricalEngineering, Unitful, Unitful.DefaultSymbols, PyPlot, Test

function tests()
  @testset "Subset of tests" begin
    @test ∥(2,3) ≈ 1.2 atol=1E-6
    @test abs(pol(1,45°)) ≈ 1 atol=1E-6
    @test angle(pol(1,45°)) ≈ π/4 atol=1E-6
    @test angle(∠(45°)) ≈ π/4 atol=1E-6
    @test par(3,5) ≈ 3 * 5 / (3 + 5) atol = 1E-6
    @test ∥(3,5) ≈ 3 * 5 / (3 + 5) atol = 1E-6
  end
end

tests()
