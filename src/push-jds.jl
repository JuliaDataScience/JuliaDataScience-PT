"Push the Portugese output to the original JDS gh-pages."
function push_to_jds()
    jds_dir = mktempdir()
    run(`git clone --branch=gh-pages https://github.com/JuliaDataScience/JuliaDataScience $jds_dir`)
    from = "."
    to = joinpath(jds_dir, "pt")
    mkpath(to)
    cp(from, to; force=true)
    cd(jds_dir) do
        run(`git add .`)
        run(`git commit -m 'deploy from JuliaDataScience-PT'`)
        run(`git push`)
    end
    return nothing
end
