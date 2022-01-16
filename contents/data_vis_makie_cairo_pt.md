## CairoMakie.jl {#sec:cairomakie}

Vamos começar com nosso primeiro plot, alguns pontos de dispersão com linhas entre eles::

```
using CairoMakie
CairoMakie.activate!()
```

```jl
s = """
    CairoMakie.activate!() # hide
    fig = scatterlines(1:10, 1:10)
    label = "firstplot" # hide
    caption = "First plot." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Observe que o plot anterior é a saída padrão, que provavelmente precisamos ajustar usando nomes e rótulos de eixo.

Observe também que toda função de plotagem como `scatterlines` cria e retorna um novo objeto `Figure`, `Axis` e `plot` em uma coleção chamada `FigureAxisPlot`.
Estes são conhecidos como os métodos `non-mutating.
Por outro lado, os métodos `mutating` (por exemplo, `scatterlines!`, observe o `!`) apenas retornam um objeto plot que pode ser anexado a um determinado `axis` ou `current_figure()`.

A próxima pergunta que se pode ter é: como mudo a cor ou o tipo de marcador?
Isso pode ser feito via `attributes`, que faremos na próxima seção.