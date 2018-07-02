# isdefined(Base, :__precompile__) && __precompile__()
module EE

    export test

    function test(x)
        return x^2
    end

end
