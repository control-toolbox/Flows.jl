module HamiltonianFlows

# Packages needed: 
using ForwardDiff: jacobian, gradient, ForwardDiff
using DifferentialEquations: ODEProblem, solve, Tsit5, DifferentialEquations
import Base: isempty, Base
using StaticArrays

#
# using Descriptions
include("ControlToolboxTools-src/ControlToolboxTools.jl"); using .ControlToolboxTools

#
Base.isempty(p::DifferentialEquations.SciMLBase.NullParameters) = true

# --------------------------------------------------------------------------------------------
# Default options for flows
# --------------------------------------------------------------------------------------------
__abstol() = 1e-10
__reltol() = 1e-10
__saveat() = []
__alg() = DifferentialEquations.Tsit5()
__use_sa() = true

# -------------------------------------------------------------------------------------------------- 
# desription 

# default is autonomous
isnonautonomous(desc::Description) = :nonautonomous ∈ desc

# --------------------------------------------------------------------------------------------------
# Aliases for types
#
const MyNumber = Real
const MyVector = Union{SVector{N, <:MyNumber} where N, Vector{<:MyNumber}}

const Time = Number

const State = MyVector # Vector{de sous-type de Number}
const Adjoint = MyVector
const CoTangent = MyVector
const Control = MyVector

const DState = MyVector
const DAdjoint = MyVector
const DCoTangent = MyVector

isstatic(v::MyVector) = v isa SVector{N, <:MyNumber} where N

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
