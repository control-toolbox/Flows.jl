module Descriptions

# -------------------------------------------------------------------------------------------------- 
# A desription is a tuple of symbols
const DescVarArg = Vararg{Symbol} # or Symbol...
const Description = Tuple{DescVarArg}

#
include("./exceptions.jl")
include("./utils.jl")

export Description
export DescriptionsException
export AmbiguousDescription
export makeDescription
export add
export getFullDescription

end # module Descriptions
