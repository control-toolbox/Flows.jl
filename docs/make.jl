using Documenter
using HamiltonianFlows

makedocs(
    sitename = "HamiltonianFlows.jl",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Introduction" => "index.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/control-toolbox/HamiltonianFlows.jl.git",
    devbranch = "main"
)
