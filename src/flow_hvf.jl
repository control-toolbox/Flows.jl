# --------------------------------------------------------------------------------------------
# Hamiltonian Vector Field
# --------------------------------------------------------------------------------------------
struct HamiltonianVectorField
    f::Function
end

function (hv::HamiltonianVectorField)(x::State, p::Adjoint, λ...) # https://docs.julialang.org/en/v1/manual/methods/#Function-like-objects
    return hv.f(x, p, λ...)
end

function (hv::HamiltonianVectorField)(t::Time, x::State, p::Adjoint, λ...)
    return hv.f(t, x, p, λ...)
end

# Fonction permettant de calculer le flot d'un système hamiltonien
function flow(hv::HamiltonianVectorField, description...;
        use_static_arrays=__use_sa_hv(),
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
        if isstatic(x0) && isstatic(p0) # si les deux sont "static"
            z0 = [x0; p0]
        else
            z0 = use_static_arrays ? SA[x0...; p0...] : [x0; p0] # rend static si use static
        end
        if !isstatic(z0) #&& !use_static_arrays
            #println("no init SA, no use of SA")
            args = isempty(λ) ? (rhs!, z0, tspan) : (rhs!, z0, tspan, λ)
        else
            #println("init SA or use of SA")
            args = isempty(λ) ? (rhs, z0, tspan) : (rhs, z0, tspan, λ)
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
