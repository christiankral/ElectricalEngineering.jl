# test/runtests.jl
using EE, Unitful, PyPlot, Compat.Test

function tests()
  @testset "Subset of tests" begin
    @test ∥(2,3) ≈ 1.2 atol=1E-6
    @test abs(pol(1,45°)) ≈ 1 atol=1E-6
    @test angle(pol(1,45°)) ≈ π/4 atol=1E-6
    @test angle(∠(45°)) ≈ π/4 atol=1E-6
  end
end

tests()
