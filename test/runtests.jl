using Flows
using Test

@testset verbose = true showtiming = true "Flows" begin
    for name in (
        "exceptions",
        "description", 
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
