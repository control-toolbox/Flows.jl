module Bench

# to use it: 
# include("bench/Bench.jl"); using .Bench
# bench()

#
import Pkg: Operations.testdir, Operations.testfile, Pkg.Operations, Pkg

Operations.testdir(source_path::String) = joinpath(source_path, "bench")
Operations.testfile(source_path::String) = joinpath(testdir(source_path), "runbenchs.jl")
bench = Pkg.test

export bench

end