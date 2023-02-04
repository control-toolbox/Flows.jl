#
t0 = 0.0
tf = 1.0

#
control(x, p) = p[2]
H(x, p, l) = p[1] * x[2] + p[2] * control(x, p) + 0.5 * l * control(x, p)^2

#
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]
z = Flow(Hamiltonian(H))
xf, pf = z(t0, x0, p0, tf, -1.0)
@test xf ≈ [0.0, 0.0] atol = 1e-5
@test pf ≈ [12.0, -6.0] atol = 1e-5

# use Static Array
x0 = SA[-1.0; 0.0]
p0 = SA[12.0; 6.0]
z = Flow(Hamiltonian(H))
xf, pf = z(t0, x0, p0, tf, -1.0)
@test xf ≈ [0.0, 0.0] atol = 1e-5
@test pf ≈ [12.0, -6.0] atol = 1e-5