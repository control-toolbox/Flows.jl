t0 = 0.0
tf = 10.0

#
Hv(x, p) = [x[2]; p[2]; 0.0; -p[1]]

#
println("")
println("------------------------")
println("no init SA, no use of SA")
println("")
x0 = [-1.0; 0.0]
p0 = [12.0; 6.0]
z = flow(HamiltonianVectorField(Hv), use_static_arrays=false)
t = @benchmark xf, pf = z(t0, x0, p0, tf)
display(t)

#
println("")
println("------------------------")
println("no init SA, use of SA")
println("")
x0 = [-1.0; 0.0]
p0 = [12.0; 6.0]
z = flow(HamiltonianVectorField(Hv), use_static_arrays=true)
t = @benchmark xf, pf = z(t0, x0, p0, tf)
display(t)

#
println("")
println("------------------------")
println("init SA, use of SA")
println("")
x0 = SA[-1.0; 0.0]
p0 = SA[12.0; 6.0]
z = flow(HamiltonianVectorField(Hv), use_static_arrays=true)
t = @benchmark xf, pf = z(t0, x0, p0, tf)
display(t)