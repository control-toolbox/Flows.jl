## Benchmark of `bench_SA_function.jl`

```julia
t0 = 0.0
tf = 100.0
control(x, p) = p[2]
H(x, p) = p[1] * x[2] + p[2] * control(x, p) - 0.5 * control(x, p)^2
```

```julia
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]
z = Flow(Hamiltonian(H))
t = @benchmark xf, pf = z(t0, x0, p0, tf)
```

```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  158.157 μs …  20.040 ms  ┊ GC (min … max): 0.00% … 98.86%
 Time  (median):     167.363 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   183.048 μs ± 509.024 μs  ┊ GC (mean ± σ):  7.18% ±  2.61%

     ▅▇▆▂   ▁▆█▇▄                                                
  ▂▄█████▇▆▆██████▅▄▃▃▃▃▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▂▂▂▁▂ ▃
  158 μs           Histogram: frequency by time          210 μs <

 Memory estimate: 103.61 KiB, allocs estimate: 1229.
```

```julia
x0 = SA[-1.0, 0.0]
p0 = SA[12.0, 6.0]
z = Flow(Hamiltonian(H))
t = @benchmark xf, pf = z(t0, x0, p0, tf)
```

```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  269.780 μs …  19.965 ms  ┊ GC (min … max): 0.00% … 97.12%
 Time  (median):     285.647 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   309.024 μs ± 536.206 μs  ┊ GC (mean ± σ):  4.87% ±  2.77%

      ▁▂▂▂▃▆█▅▁                                                  
  ▂▃▄██████████▆▄▄▃▃▃▂▂▂▂▂▂▂▂▂▂▂▂▂▂▃▄▅▄▄▄▄▅▅▄▃▂▂▂▂▂▂▂▂▂▂▂▂▂▁▂▂▂ ▃
  270 μs           Histogram: frequency by time          363 μs <

 Memory estimate: 112.91 KiB, allocs estimate: 2480.
```