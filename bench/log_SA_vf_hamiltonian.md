## Benchmark of `bench_SA_function.jl`

```julia
t0 = 0.0
tf = 100.0
Hv(x, p) = [x[2]; p[2]; 0.0; -p[1]]
```

```julia
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]
z = Flow(HamiltonianVectorField(Hv))
t = @benchmark xf, pf = z(t0, x0, p0, tf)
```

```julia
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  40.348 μs …  19.859 ms  ┊ GC (min … max): 0.00% … 99.58%
 Time  (median):     44.382 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   49.045 μs ± 273.416 μs  ┊ GC (mean ± σ):  7.86% ±  1.41%

        ▁▁▂▃▄▆▇█▇▆▃▂                                            
  ▁▁▂▄▆█████████████▇▆▆▆▆▆▄▄▃▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▃
  40.3 μs         Histogram: frequency by time         57.9 μs <

 Memory estimate: 34.67 KiB, allocs estimate: 409.
```

```julia
x0 = SA[-1.0, 0.0]
p0 = SA[12.0, 6.0]
z = Flow(HamiltonianVectorField(Hv))
t = @benchmark xf, pf = z(t0, x0, p0, tf)
```

```julia
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  235.009 μs …  19.363 ms  ┊ GC (min … max): 0.00% … 98.10%
 Time  (median):     246.396 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   261.761 μs ± 445.504 μs  ┊ GC (mean ± σ):  4.14% ±  2.40%

     ▅█▇▂ ▁▃▄▂▁                                                  
  ▁▂▆████████████▇▅▄▃▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂▂▃▃▃▂▂▂▁▁▁▁▁▁▁▁ ▃
  235 μs           Histogram: frequency by time          306 μs <

 Memory estimate: 87.23 KiB, allocs estimate: 2163.
```