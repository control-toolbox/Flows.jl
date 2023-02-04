t0 = 0.0
tf = 100.0
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]

#
V(z) = [z[2], z[4], 0.0, -z[3]]

#
println("")
println("------------------------")
println("Vector field: no SA")
println("")
z = Flow(VectorField(V))
z0 = [x0; p0]
t = @benchmark zf = z(t0, z0, tf)
display(t)

#
println("")
println("------------------------")
println("Vector field: with SA")
println("")
z0 = SA[x0..., p0...]
t = @benchmark zf = z(t0, z0, tf)
display(t)