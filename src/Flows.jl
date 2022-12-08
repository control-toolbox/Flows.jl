module Flows

# Packages needed: 
using ForwardDiff: jacobian, gradient, ForwardDiff
using OrdinaryDiffEq: ODEProblem, solve, Tsit5, OrdinaryDiffEq
import Base: isempty

#
using Descriptions

#
isempty(p::OrdinaryDiffEq.SciMLBase.NullParameters) = true

# --------------------------------------------------------------------------------------------
# Default options for flows
# --------------------------------------------------------------------------------------------
__abstol() = 1e-10
__reltol() = 1e-10
__saveat() = []
__alg() = OrdinaryDiffEq.Tsit5()

# -------------------------------------------------------------------------------------------------- 
# desription 

# default is autonomous
isnonautonomous(desc::Description) = :nonautonomous ∈ desc

# --------------------------------------------------------------------------------------------------
# Aliases for types
#
const Time = Number

const State = Vector{<:Number} # Vector{de sous-type de Number}
const Adjoint = Vector{<:Number}
const CoTangent = Vector{<:Number}
const Control = Vector{<:Number}

const DState = Vector{<:Number}
const DAdjoint = Vector{<:Number}
const DCoTangent = Vector{<:Number}

# --------------------------------------------------------------------------------------------
# all flows
include("flow_hamiltonian.jl")
include("flow_function.jl")
include("flow_hvf.jl")
include("flow_vf.jl")

#todo: ajout du temps, de paramètres...
# ces fichiers sont stockés ailleurs
#include("flows/flow_lagrange_system.jl")
#include("flows/flow_mayer_system.jl")
#include("flows/flow_pseudo_ham.jl")
#include("flows/flow_si_mayer.jl")

export isnonautonomous
export VectorField
export Hamiltonian
export HamiltonianVectorField
export flow

end
