using HamiltonianFlows
using StaticArrays
using Test

 @testset verbose = true showtiming = true "HamiltonianFlows" begin
     for name in (
         "flow_function",
         "flow_hamiltonian", 
         "flow_vf_hamiltonian", 
         "flow_vf", 
         )
         @testset "$name" begin
             include("test_$name.jl")
         end
     end
 end