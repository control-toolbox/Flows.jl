# --------------------------------------------------------------------------------------------
# Hamiltonian
# --------------------------------------------------------------------------------------------
@callable struct Hamiltonian end

# Flow from a Hamiltonian
function Flow(h::Hamiltonian, description...;
                alg=__alg(), abstol=__abstol(), reltol=__reltol(), saveat=__saveat(), kwargs_Flow...)

    h_(t, x, p, λ...) = isnonautonomous(makeDescription(description...)) ? h(t, x, p, λ...) : h(x, p, λ...)

    function rhs!(dz::DCoTangent, z::CoTangent, λ, t::Time)
        n = size(z, 1) ÷ 2
        foo = isempty(λ) ? (z -> h_(t, z[1:n], z[n+1:2*n])) : (z -> h_(t, z[1:n], z[n+1:2*n], λ...))
        dh = ForwardDiff.gradient(foo, z)
        dz[1:n] = dh[n+1:2n]
        dz[n+1:2n] = -dh[1:n]
    end

    f = __Hamiltonian_Flow(alg, abstol, reltol, saveat; kwargs_Flow...)

    return ControlFlow{Hamiltonian, DCoTangent, CoTangent, Time}(f, rhs!)

end

