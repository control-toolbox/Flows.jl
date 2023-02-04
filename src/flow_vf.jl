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

    # kwargs has priority wrt kwargs_flow
    function f(tspan::Tuple{Time,Time}, x0::State, λ...; DiffEqRHS, kwargs...)
        args = isempty(λ) ? (DiffEqRHS, x0, tspan) : (DiffEqRHS, x0, tspan, λ)
        ode = DifferentialEquations.ODEProblem(args...)
        sol = DifferentialEquations.solve(ode, alg=alg, abstol=abstol, reltol=reltol, saveat=saveat; kwargs_Flow..., kwargs...)
        return sol
    end

    function f(t0::Time, x0::State, t::Time, λ...; DiffEqRHS, kwargs...)
        sol = f((t0, t), x0, λ...; DiffEqRHS=DiffEqRHS, kwargs...)
        n = size(x0, 1)
        return sol[1:n, end]
    end

    return ControlFlow{VectorField}(f, rhs!)

end
