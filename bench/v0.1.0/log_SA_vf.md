## Benchmark of `bench_SA_function.jl`

```julia
t0 = 0.0
tf = 100.0
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]
V(z) = [z[2], z[4], 0.0, -z[3]]
```

```julia
z = Flow(VectorField(V))
z0 = [x0; p0]
t = @benchmark zf = z(t0, z0, tf)
```

```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  33.417 μs …  19.855 ms  ┊ GC (min … max): 0.00% … 99.52%
 Time  (median):     36.743 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   39.518 μs ± 198.354 μs  ┊ GC (mean ± σ):  5.00% ±  1.00%

         ▄▆█▆▃▂▂▁                                               
  ▂▂▄▅▆▇█████████▇▅▄▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▂▂▂▂▁▁▂▁▁▂▁▂ ▃
  33.4 μs         Histogram: frequency by time         53.1 μs <

 Memory estimate: 24.53 KiB, allocs estimate: 276.
```

```julia
z0 = SA[x0..., p0...]
t = @benchmark zf = z(t0, z0, tf)
```

```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  224.907 μs …  20.202 ms  ┊ GC (min … max): 0.00% … 98.13%
 Time  (median):     235.660 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   249.574 μs ± 427.931 μs  ┊ GC (mean ± σ):  3.79% ±  2.19%

   ▅▇█▇▇███▇▆▆▅▄▃▂▁▂▁ ▁           ▁▂▂▂▂▂▂▂▂▁                    ▃
  ██████████████████████▆▇█████▇██████████████▅▇▄▆▅▅▅▁▁▃▄▆▅▄▄▃▆ █
  225 μs        Histogram: log(frequency) by time        314 μs <

 Memory estimate: 80.14 KiB, allocs estimate: 2093.
 ```