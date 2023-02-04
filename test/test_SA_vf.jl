#
t0 = 0.0
tf = 1.0
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]

#
V(z) = [z[2], z[4], 0.0, -z[3]]
z = Flow(VectorField(V))

#
z0 = [x0; p0]
zf = z(t0, z0, tf)
@test zf ≈ [0.0, 0.0, 12.0, -6.0] atol = 1e-5

# use Static Array
z0 = SA[x0..., p0...]
zf = z(t0, z0, tf)
@test zf ≈ [0.0, 0.0, 12.0, -6.0] atol = 1e-5