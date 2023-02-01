# --------------------------------------------------------------------------------------------
# Hamiltonian
# --------------------------------------------------------------------------------------------

struct Hamiltonian
    f::Function
end

function (h::Hamiltonian)(x::State, p::Adjoint, λ...)
    return h.f(x, p, λ...)
end

function (h::Hamiltonian)(t::Time, x::State, p::Adjoint, λ...)
    return h.f(t, x, p, λ...)
end

# Flow from a Hamiltonian
function Flow(h::Hamiltonian, description...;
                use_static_arrays=__use_sa(),
                alg=__alg(), abstol=__abstol(), reltol=__reltol(), saveat=__saveat(), kwargs_Flow...)

    h_(t, x, p, λ...) = isnonautonomous(makeDescription(description...)) ? h(t, x, p, λ...) : h(x, p, λ...)

    function rhs!(dz::DCoTangent, z::CoTangent, λ, t::Time)
        n = size(z, 1) ÷ 2
        foo = isempty(λ) ? (z -> h_(t, z[1:n], z[n+1:2*n])) : (z -> h_(t, z[1:n], z[n+1:2*n], λ...))
        dh = ForwardDiff.gradient(foo, z)
        dz[1:n] = dh[n+1:2n]
        dz[n+1:2n] = -dh[1:n]
    end

    function rhs(z::CoTangent, λ, t::Time)
        n = size(z, 1) ÷ 2
        foo = isempty(λ) ? (z -> h_(t, z[1:n], z[n+1:2*n])) : (z -> h_(t, z[1:n], z[n+1:2*n], λ...))
        #dh = SA[ForwardDiff.gradient(foo, z)...]
        dh = ForwardDiff.gradient(foo, z)
        return SA[dh[n+1:2n]...; -dh[1:n]...]
    end

    function f(tspan::Tuple{Time,Time}, x0::State, p0::Adjoint, λ...; kwargs...)
        if use_static_arrays
            #println("use SA")
            z0 = SA[x0...; p0...]
        else
            #println("no use SA")
            z0 = [x0; p0]
        end
        if !isstatic(z0) && !use_static_arrays
            #println("no init SA, no use of SA")
            args = isempty(λ) ? (rhs!, z0, tspan) : (rhs!, z0, tspan, λ)
        else
            #println("init SA or use of SA")
            args = isempty(λ) ? (rhs, z0, tspan) : (rhs, z0, tspan, λ)
        end
        ode = DifferentialEquations.ODEProblem(args...)
        sol = DifferentialEquations.solve(ode, alg=alg, abstol=abstol, reltol=reltol, saveat=saveat;
                kwargs_Flow..., kwargs...)
        return sol
    end

    function f(t0::Time, x0::State, p0::Adjoint, tf::Time, λ...; kwargs...)
        sol = f((t0, tf), x0, p0, λ...; kwargs...)
        n = size(x0, 1)
        return sol[1:n, end], sol[n+1:2*n, end]
    end

    return f

end;
