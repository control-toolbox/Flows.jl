using HamiltonianFlows
using Test
import Base: *
#
ControlFlow = HamiltonianFlows.ControlFlow
#
MyNumber = Real
MyVector = AbstractVector{<:MyNumber}
Time = MyNumber
State = MyVector # Vector{de sous-type de Number}
Adjoint = MyVector
CoTangent = MyVector
Control = MyVector
DState = MyVector
DAdjoint = MyVector
DCoTangent = MyVector

# concatenate two flows
function concatenate(F::ControlFlow{Hamiltonian}, p::Tuple{MyNumber, ControlFlow{Hamiltonian}})
    
    #
    t_switch, G = p

    #
    function rhs!(dz::DCoTangent, z::CoTangent, λ, t::Time)
        t < t_switch ? F.rhs!(dz, z, λ, t) : G.rhs!(dz, z, λ, t)
    end

    # on choisit le f de F, c-a-d que l'on considère les options de F
    return ControlFlow{Hamiltonian}(F.f, rhs!)

end

function *(F::ControlFlow{T}, p::Tuple{MyNumber, ControlFlow{T}}) where {T}
    return concatenate(F, p)
end

# todo: 
# - use event detection
# - manage concatenation of autonomous and non autonomous flows
# - remove the possibility to set kwargs in Flow since after a concatenation
# it is unusable.

@testset "Concatenation" begin

#
t0 = 0.0
tf = 1.0
x0 = [-1.0, 0.0]
p0 = [12.0, 6.0]

#
control(x, p) = p[2]
H1(x, p) = p[1] * x[2] + p[2] * control(x, p) - 0.5 * control(x, p)^2
H2(x, p) = -H1(x, p)

#
f1 = Flow(Hamiltonian(H1))
f2 = Flow(Hamiltonian(H2))

# one flow is used because t1 > tf
t1 = 2.0
f = f1 * (t1, f2)
xf, pf = f(t0, x0, p0, tf)
@test xf ≈ [0.0, 0.0] atol = 1e-5
@test pf ≈ [12.0, -6.0] atol = 1e-5

# two flows: going back
t1 = 0.5
f = f1 * (t1, f2)
xf, pf = f(t0, x0, p0, tf)
@test xf ≈ x0 atol = 1e-5
@test pf ≈ p0 atol = 1e-5

# three flows: go forward
f = f1 * (0.25, f2) * (0.5, f1)
xf, pf = f(t0, x0, p0, tf+0.5)
@test xf ≈ [0.0, 0.0] atol = 1e-5
@test pf ≈ [12.0, -6.0] atol = 1e-5

end