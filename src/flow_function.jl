# --------------------------------------------------------------------------------------------
# From a function: we consider it as a Hamiltonian
# --------------------------------------------------------------------------------------------

# Flow from a function
"""
	flow(f::Function, description...; kwargs_Flow...)

TBW
"""
function flow(f::Function, description...; 
                alg=__alg(), abstol=__abstol(), reltol=__reltol(), saveat=__saveat(), kwargs_Flow...)
    return flow(Hamiltonian(f), description...; 
                    alg=alg, abstol=abstol, reltol=reltol, saveat=saveat, kwargs_Flow...)
end
