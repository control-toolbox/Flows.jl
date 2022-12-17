using CTFlows
using Test

@testset verbose = true showtiming = true "CTFlows" begin
    for name in (
        "hamiltonian", 
        "vector_field", 
        "hamiltonian_vf", 
        "function"
        )
        @testset "$name" begin
            include("test_$name.jl")
        end
    end
end
