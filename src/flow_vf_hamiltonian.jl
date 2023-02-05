# --------------------------------------------------------------------------------------------
# Hamiltonian Vector Field
# --------------------------------------------------------------------------------------------
@callable struct HamiltonianVectorField end

# Fonction permettant de calculer le flot d'un système hamiltonien
function Flow(hv::HamiltonianVectorField, description...;
        alg=__alg(), abstol=__abstol(), reltol=__reltol(), saveat=__saveat(), kwargs_Flow...)

    hv_(t, x, p, λ...) = isnonautonomous(makeDescription(description...)) ? hv(t, x, p, λ...) : hv(x, p, λ...)

    function rhs!(dz::DCoTangent, z::CoTangent, λ, t::Time)
        n = size(z, 1) ÷ 2
        dz[:] = isempty(λ) ? hv_(t, z[1:n], z[n+1:2*n]) : hv_(t, z[1:n], z[n+1:2*n], λ...)
    end

    f = __Hamiltonian_Flow(alg, abstol, reltol, saveat; kwargs_Flow...)

    return ControlFlow{HamiltonianVectorField, DCoTangent, CoTangent, Time}(f, rhs!)

end;
