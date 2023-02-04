# --------------------------------------------------------------------------------------------
# Vector Field
# --------------------------------------------------------------------------------------------
@callable struct VectorField end

# Flow of a vector field
function Flow(vf::VectorField, description...; 
        alg=__alg(), abstol=__abstol(), reltol=__reltol(), saveat=__saveat(), kwargs_Flow...)

    vf_(t, x, λ...) = isnonautonomous(makeDescription(description...)) ? vf(t, x, λ...) : vf(x, λ...)

    function rhs!(dx::DState, x::State, λ, t::Time)
        dx[:] = isempty(λ) ? vf_(t, x) : vf_(t, x, λ...)
    end

    function rhs(x::State, λ, t::Time)
        v = isempty(λ) ? vf_(t, x) : vf_(t, x, λ...)
        return SA[v...]
    end

    # kwargs has priority wrt kwargs_flow
    function f(tspan::Tuple{Time,Time}, x0::State, λ...; kwargs...)
        if isstatic(x0)
            args = isempty(λ) ? (rhs, x0, tspan) : (rhs, x0, tspan, λ)
        else
            args = isempty(λ) ? (rhs!, x0, tspan) : (rhs!, x0, tspan, λ)
        end
        ode = DifferentialEquations.ODEProblem(args...)
        sol = DifferentialEquations.solve(ode, alg=alg, abstol=abstol, reltol=reltol, saveat=saveat; kwargs_Flow..., kwargs...)
        return sol
    end

    function f(t0::Time, x0::State, t::Time, λ...; kwargs...)
        sol = f((t0, t), x0, λ...; kwargs...)
        n = size(x0, 1)
        return sol[1:n, end]
    end

    return f

end;
