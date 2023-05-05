pushfirst!(LOAD_PATH, joinpath(@__DIR__, "..")) # add Oceanostics to environment
using Pkg
CI = get(ENV, "CI", nothing) == "true" || get(ENV, "GITHUB_TOKEN", nothing) !== nothing
CI && Pkg.instantiate()

using Documenter
using Oceananigans
using Oceanostics


pages = ["Home" => "index.md",
         "Example" => "quick_start.md",
         "Function library" => "library.md",
        ]


format = Documenter.HTML(collapselevel = 1,
                         prettyurls = CI, # Makes links work when building locally
                         mathengine = MathJax3(),
                         warn_outdated = true,
                         )

makedocs(sitename = "Oceanostics.jl",
         authors = "Tomas Chor and contributors",
         pages = pages,
         modules = [Oceanostics],
         doctest = true,
         strict = :doctest,
         clean = true,
         format = format,
         )

if CI
    deploydocs(repo = "github.com/tomchor/Oceanostics.jl.git",
               push_preview = true,
               )
end
