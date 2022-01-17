## CairoMakie.jl {#sec:cairomakie}

Vamos começar com nosso primeiro plot, um gráfico de dispersão com algumas observações conectadas por linhas:

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

Observe que o gráfico anterior é a saída padrão, que provavelmente precisaremos ajustar usando nomes de eixo e rótulos.

Observe também que toda função de plotagem como `scatterlines` cria e retorna novos objetos do tipo `Figure`, `Axis` e `plot` dentro de uma coleção chamada `FigureAxisPlot`.
Estes são conhecidos como os métodos _non-mutating_ (imutáveis).
Por outro lado, os métodos _mutating_ (mutáveis, por exemplo, `scatterlines!`, observe o `!`) apenas retornam um objeto do tipo _plot_ que pode ser anexado a um determinado `axis` (eix) ou à `current_figure()` (figura atual).

A próxima pergunta que se pode ter é: como mudo a cor ou o tipo de marcador?
Isso pode ser feito por meio de `attributes` (atributos), o que faremos na próxima seção.
