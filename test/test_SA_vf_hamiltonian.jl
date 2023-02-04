#
t0 = 0.0
tf = 1.0

control(x, p) = p[2]

#
Hv(x, p) = [x[2]; control(x, p); 0.0; -p[1]]

#
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]
z = Flow(HamiltonianVectorField(Hv))
xf, pf = z(t0, x0, p0, tf)
@test xf ≈ [0.0, 0.0] atol = 1e-5
@test pf ≈ [12.0, -6.0] atol = 1e-5

# use Static Array
x0 = SA[-1.0, 0.0]
p0 = SA[12.0, 6.0]
z = Flow(HamiltonianVectorField(Hv))
xf, pf = z(t0, x0, p0, tf)
@test xf ≈ [0.0, 0.0] atol = 1e-5
@test pf ≈ [12.0, -6.0] atol = 1e-5