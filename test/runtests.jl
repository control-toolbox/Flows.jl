using HamiltonianFlows
using StaticArrays
using Test

 @testset verbose = true showtiming = true "HamiltonianFlows" begin
     for name in (
         "hamiltonian", 
         "vector_field", 
         "hamiltonian_vf", 
         "function",
         "static_arrays"
         )
         @testset "$name" begin
             include("test_$name.jl")
         end
     end
 end