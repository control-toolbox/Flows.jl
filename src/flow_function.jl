# --------------------------------------------------------------------------------------------
# From a function: we consider it as a Hamiltonian
# --------------------------------------------------------------------------------------------

# Flow from a function
"""
	flow(f::Function, description...; kwargs_Flow...)

TBW
"""
function flow(f::Function, description...;
                use_static_arrays=__use_sa_hamiltonian(),
                alg=__alg(), abstol=__abstol(), reltol=__reltol(), saveat=__saveat(), kwargs_Flow...)
    return flow(Hamiltonian(f), description...;
                    use_static_arrays=use_static_arrays,
                    alg=alg, abstol=abstol, reltol=reltol, saveat=saveat, kwargs_Flow...)
end
