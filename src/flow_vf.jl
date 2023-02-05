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

    f = __Classical_Flow(alg, abstol, reltol, saveat; kwargs_Flow...)

    return ControlFlow{VectorField, DState, State, Time}(f, rhs!)

end
