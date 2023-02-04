module HamiltonianFlows

# Packages needed: 
using ForwardDiff: jacobian, gradient, ForwardDiff
using DifferentialEquations: ODEProblem, solve, Tsit5, DifferentialEquations
import Base: isempty, Base
using StaticArrays

#
using ControlToolboxTools

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
__use_sa_hamiltonian() = false
__use_sa_hv() = false

# -------------------------------------------------------------------------------------------------- 
# desription 

# default is autonomous
isnonautonomous(desc::Description) = :nonautonomous ∈ desc

# --------------------------------------------------------------------------------------------------
# Aliases for types
#
# const AbstractVector{T} = AbstractArray{T,1}.
const MyNumber = Real
const MyVector = AbstractVector{<:MyNumber}

const Time = MyNumber

const State = MyVector # Vector{de sous-type de Number}
const Adjoint = MyVector
const CoTangent = MyVector
const Control = MyVector

const DState = MyVector
const DAdjoint = MyVector
const DCoTangent = MyVector

# const StaticVector{N, T} = StaticArray{Tuple{N}, T, 1}
isstatic(v::MyVector) = v isa StaticVector{E, <:MyNumber} where {E}

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
export Flow

end
