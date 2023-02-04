using HamiltonianFlows
using BenchmarkTools
using StaticArrays
using Test

#@testset verbose = true showtiming = true "HamiltonianFlows bench" begin
    for name in (
        "SA_function",
        "SA_hamiltonian",
        "SA_vf_hamiltonian",
        "SA_vf",
        )
        #@testset "$name" 
        begin
            include("bench_$name.jl")
        end
    end
#end