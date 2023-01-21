# in-place form vs no

#
t0 = 0.0
tf = 1.0

# from a function: should be as a Hamiltonian
control(x, p) = p[2]
H(x, p, l) = p[1] * x[2] + p[2] * control(x, p) + 0.5 * l * control(x, p)^2

#
#println("")
#println("------------------------")
#println("no init SA, no use of SA")
x0 = [-1.0; 0.0]
p0 = [12.0; 6.0]
z = flow(H, use_static_arrays=false)
xf, pf = z(t0, x0, p0, tf, -1.0)
@test xf ≈ [0.0; 0.0] atol = 1e-5
@test pf ≈ [12.0; -6.0] atol = 1e-5

#
#println("---")
#println("no init SA, use of SA")
x0 = [-1.0; 0.0]
p0 = [12.0; 6.0]
z = flow(H, use_static_arrays=true)
xf, pf = z(t0, x0, p0, tf, -1.0)
@test xf ≈ [0.0; 0.0] atol = 1e-5
@test pf ≈ [12.0; -6.0] atol = 1e-5

#
#println("---")
#println("init SA, use of SA")
x0 = @SVector [-1.0; 0.0]
p0 = @SVector [12.0; 6.0]
z = flow(H)
xf, pf = z(t0, x0, p0, tf, -1.0)
@test xf ≈ [0.0; 0.0] atol = 1e-5
@test pf ≈ [12.0; -6.0] atol = 1e-5