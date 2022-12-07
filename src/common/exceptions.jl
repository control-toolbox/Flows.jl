# --------------------------------------------------------------------------------------------------
# General abstract type for exceptions
abstract type FlowsException <: Exception end

# ambiguous description
struct AmbiguousDescription <: FlowsException
    var::Description
end

"""
	Base.showerror(io::IO, e::AmbiguousDescription)

TBW
"""
Base.showerror(io::IO, e::AmbiguousDescription) = print(io, "the description ", e.var, " is ambiguous / incorrect")
