# --------------------------------------------------------------------------------------------
# Hamiltonian Vector Field
# --------------------------------------------------------------------------------------------
struct HamiltonianVectorField
    f::Function
end
(hv::HamiltonianVectorField)(args...; kwargs...) = hv.f(args...; kwargs...)

# Fonction permettant de calculer le flot d'un système hamiltonien
function Flow(hv::HamiltonianVectorField, description...;
        alg=__alg(), abstol=__abstol(), reltol=__reltol(), saveat=__saveat(), kwargs_Flow...)

    hv_(t, x, p, λ...) = isnonautonomous(makeDescription(description...)) ? hv(t, x, p, λ...) : hv(x, p, λ...)

    function rhs!(dz::DCoTangent, z::CoTangent, λ, t::Time)
        n = size(z, 1) ÷ 2
        dz[:] = isempty(λ) ? hv_(t, z[1:n], z[n+1:2*n]) : hv_(t, z[1:n], z[n+1:2*n], λ...)
    end

    function rhs(z::CoTangent, λ, t::Time)
        n = size(z, 1) ÷ 2
        return isempty(λ) ? SA[hv_(t, z[1:n], z[n+1:2*n])...] : SA[hv_(t, z[1:n], z[n+1:2*n], λ...)...]
    end

    function f(tspan::Tuple{Time,Time}, x0::State, p0::Adjoint, λ...; kwargs...)
        z0 = [x0; p0]
        if isstatic(z0)
            args = isempty(λ) ? (rhs, z0, tspan) : (rhs, z0, tspan, λ)
        else
            args = isempty(λ) ? (rhs!, z0, tspan) : (rhs!, z0, tspan, λ)
        end
        ode = DifferentialEquations.ODEProblem(args...)
        sol = DifferentialEquations.solve(ode, alg=alg, abstol=abstol, reltol=reltol, saveat=saveat; kwargs_Flow..., kwargs...)
        return sol
    end

    function f(t0::Time, x0::State, p0::Adjoint, t::Time, λ...; kwargs...)
        sol = f((t0, t), x0, p0, λ...; kwargs...)
        n = size(x0, 1)
        return sol[1:n, end], sol[n+1:2*n, end]
    end

    return f

end;
