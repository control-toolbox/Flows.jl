t0 = 0.0
tf = 100.0

#
Hv(x, p) = [x[2]; p[2]; 0.0; -p[1]]

#
println("")
println("------------------------")
println("Hamiltonian vector field: no SA")
println("")
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]
z = Flow(HamiltonianVectorField(Hv))
t = @benchmark xf, pf = z(t0, x0, p0, tf)
display(t)

#
println("")
println("------------------------")
println("Hamiltonian vector field: with SA")
println("")
x0 = SA[-1.0, 0.0]
p0 = SA[12.0, 6.0]
z = Flow(HamiltonianVectorField(Hv))
t = @benchmark xf, pf = z(t0, x0, p0, tf)
display(t)