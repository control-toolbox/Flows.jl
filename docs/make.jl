using Documenter
using Flows

makedocs(
    sitename = "Flows.jl",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Introduction" => "index.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/control-toolbox/Flows.jl.git",
    devbranch = "main"
)
