t0 = 0.0
tf = 100.0

control(x, p) = p[2]
H(x, p) = p[1] * x[2] + p[2] * control(x, p) - 0.5 * control(x, p)^2

#
println("")
println("------------------------")
println("Hamiltonian: no SA")
println("")
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]
z = Flow(Hamiltonian(H))
t = @benchmark xf, pf = z(t0, x0, p0, tf)
display(t)

#
println("")
println("------------------------")
println("Hamiltonian: with SA")
println("")
x0 = SA[-1.0, 0.0]
p0 = SA[12.0, 6.0]
z = Flow(Hamiltonian(H))
t = @benchmark xf, pf = z(t0, x0, p0, tf)
display(t)