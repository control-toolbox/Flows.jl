# --------------------------------------------------------------------------------------------
#
function __Hamiltonian_Flow(alg, abstol, reltol, saveat; kwargs_Flow...)

    function f(tspan::Tuple{Time,Time}, x0::State, p0::Adjoint, λ...; _t_stops_interne, DiffEqRHS, tstops=__tstops(), kwargs...)
        z0 = [x0; p0]
        args = isempty(λ) ? (DiffEqRHS, z0, tspan) : (DiffEqRHS, z0, tspan, λ)
        ode = DifferentialEquations.ODEProblem(args...)
        append!(_t_stops_interne, tstops); t_stops_all = unique(sort(_t_stops_interne))
        sol = DifferentialEquations.solve(ode, alg=alg, abstol=abstol, reltol=reltol, saveat=saveat, tstops=t_stops_all; kwargs_Flow..., kwargs...)
        return sol
    end

    function f(t0::Time, x0::State, p0::Adjoint, tf::Time, λ...; _t_stops_interne, DiffEqRHS, tstops=__tstops(), kwargs...)
        sol = f((t0, tf), x0, p0, λ...; _t_stops_interne=_t_stops_interne, DiffEqRHS=DiffEqRHS, tstops=tstops, kwargs...)
        n = size(x0, 1)
        return sol[1:n, end], sol[n+1:2*n, end]
    end

    return f

end

# --------------------------------------------------------------------------------------------
#
function __Classical_Flow(alg, abstol, reltol, saveat; kwargs_Flow...)

    # kwargs has priority wrt kwargs_flow
    function f(tspan::Tuple{Time,Time}, x0::State, λ...; _t_stops_interne, DiffEqRHS, tstops=__tstops(), kwargs...)
        args = isempty(λ) ? (DiffEqRHS, x0, tspan) : (DiffEqRHS, x0, tspan, λ)
        ode = DifferentialEquations.ODEProblem(args...)
        append!(_t_stops_interne, tstops); t_stops_all = unique(sort(_t_stops_interne))
        sol = DifferentialEquations.solve(ode, alg=alg, abstol=abstol, reltol=reltol, saveat=saveat, tstops=t_stops_all; kwargs_Flow..., kwargs...)
        return sol
    end

    function f(t0::Time, x0::State, t::Time, λ...; _t_stops_interne, DiffEqRHS, tstops=__tstops(), kwargs...)
        sol = f((t0, t), x0, λ...; _t_stops_interne=_t_stops_interne, DiffEqRHS=DiffEqRHS, tstops=tstops, kwargs...)
        n = size(x0, 1)
        return sol[1:n, end]
    end

    return f

end