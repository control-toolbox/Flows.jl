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
z = Flow(H)
t = @benchmark xf, pf = z(t0, x0, p0, tf)
```

```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  153.842 μs …  19.154 ms  ┊ GC (min … max): 0.00% … 98.64%
 Time  (median):     163.334 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   180.158 μs ± 489.523 μs  ┊ GC (mean ± σ):  7.13% ±  2.61%

  ▅█▇▆█▇▅▃▂▂▂                                                   ▂
  ████████████████▇▇▇▇▆▆▃▄▆▅▄▅▄▄▆▆▆▅▆▅▆▄▄▅▃▄▄▄▄▁▁▄▃▄▄▄▄▁▄▄▃▃▄▃▄ █
  154 μs        Histogram: log(frequency) by time        296 μs <

 Memory estimate: 103.61 KiB, allocs estimate: 1229.
```

```julia
x0 = SA[-1.0, 0.0]
p0 = SA[12.0, 6.0]
z = Flow(H)
t = @benchmark xf, pf = z(t0, x0, p0, tf)
```

```
BenchmarkTools.Trial: 10000 samples with 1 evaluation.
 Range (min … max):  271.682 μs …  21.323 ms  ┊ GC (min … max): 0.00% … 97.36%
 Time  (median):     285.972 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   307.183 μs ± 545.800 μs  ┊ GC (mean ± σ):  4.98% ±  2.76%

    ▁▄▄▃▁▂▆█▄                                                    
  ▃▅██████████▅▄▃▃▃▃▃▂▂▂▂▂▂▂▂▂▂▂▃▃▃▃▃▄▄▄▃▃▂▂▂▂▂▂▂▂▂▂▂▂▁▂▂▂▂▂▂▂▂ ▃
  272 μs           Histogram: frequency by time          372 μs <

 Memory estimate: 112.91 KiB, allocs estimate: 2480.
```