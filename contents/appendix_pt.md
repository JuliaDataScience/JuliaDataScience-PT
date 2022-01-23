# Apêndice {#sec:appendix}

## Versões dos Pacotes {#sec:appendix_pkg}

Esse livro foi feito com Julia `jl string(VERSION)` e os seguintes pacotes:

```jl
JDS.pkg_deps()
```

```jl
let
    date = today()
    hour = Dates.hour(now())
    min = Dates.minute(now())

    "Build: $date $hour:$min UTC"
end
```
