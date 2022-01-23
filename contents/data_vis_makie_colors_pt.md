## Cores e mapas de cores {#sec:makie_colors}

Escolher um conjunto apropriado de cores ou barra de cores para sua plotagem é uma parte essencial para apresentação de resultados.
[Colors.jl](https://github.com/JuliaGraphics/Colors.jl) é suportado em `Makie.jl`
para que você possa usar [cores nomeadas](https://juliagraphics.github.io/Colors.jl/latest/namedcolors/) ou passar valores `RGB` ou `RGBA`.
Além disso, os mapas de cores [ColorSchemes.jl](https://github.com/JuliaGraphics/ColorSchemes.jl) e [PerceptualColourMaps.jl](https://github.com/peterkovesi/PerceptualColourMaps.jl) também podem ser usados.
Vale a pena saber que você pode reverter um mapa de cores fazendo `Reverse(:colormap_name)`
para obter uma cor transparente ou mapa de cores com `color=(:red,0.5)` e `colormap=(:viridis, 0.5)`.

Diferentes casos de uso serão mostrados a seguir.
Então vamos definir um tema personalizado com novas cores e uma paleta de cores.

Por padrão `Makie.jl` tem um conjunto predefinido de cores para percorrê-las automaticamente.
Conforme mostrado nas figuras anteriores, onde nenhuma cor específica foi definida.
A substituição desses padrões é feita chamando a palavra-chave `color` na função de plotagem e especificando uma nova cor por meio de um `Symbol` ou `String`.
Veja isso em ação no exemplo a seguir:

```jl
@sco JDS.set_colors_and_cycle()
```

Onde, nas duas primeiras linhas, usamos a palavra-chave `color` para especificar nossa cor.
O resto está usando o padrão do conjunto de cores do ciclo.
Mais tarde, aprenderemos como fazer um ciclo personalizado.

Em relação aos mapas de cores, já estamos familiarizados com a palavra-chave `colormap` para `heatmap`s e `scatter`s.
Aqui, mostramos que um mapa de cores também pode ser especificado por meio de um `Symbol` ou uma `String`, semelhante a cores.
Ou até mesmo um vetor de cores `RGB`.
Vamos fazer nosso primeiro exemplo chamando mapas de cores como `Symbol`, `String` e `cgrad` para valores categóricos.
Cheque `?cgrad` para mais informações.

```jl
scolor = """
    CairoMakie.activate!() # hide
    figure = (; resolution=(600, 400), font="CMU Serif")
    axis = (; xlabel=L"x", ylabel=L"y", aspect=DataAspect())
    fig, ax, pltobj = heatmap(rand(20, 20); colorrange=(0, 1),
        colormap=Reverse(:viridis), axis=axis, figure=figure)
    Colorbar(fig[1, 2], pltobj, label = "Reverse colormap Sequential")
    fig
    label = "Reverse_colormap_sequential" # hide
    caption = "Reverse colormap sequential and colorrange." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, label, caption, link_attributes) # hide
    """
sco(scolor)
```

Ao definir um `colorrange` geralmente os valores fora deste intervalo são coloridos com a primeira e a última cor do mapa de cores.
No entanto, às vezes é melhor especificar a cor desejada em ambas as extremidades.
Fazemos isso com `highclip` e `lowclip`:

```
using ColorSchemes
```

```jl
s = """
    CairoMakie.activate!() # hide
    figure = (; resolution=(600, 400), font="CMU Serif")
    axis = (; xlabel=L"x", ylabel=L"y", aspect=DataAspect())
    fig, ax, pltobj=heatmap(randn(20, 20); colorrange=(-2, 2),
        colormap="diverging_rainbow_bgymr_45_85_c67_n256",
        highclip=:black, lowclip=:white, axis=axis, figure=figure)
    Colorbar(fig[1, 2], pltobj, label = "Diverging colormap")
    fig
    label = "diverging_colormap" # hide
    caption = "Diverging Colormap with low and high clip." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, label, caption, link_attributes) # hide
    """
sco(s)
```

Mas mencionamos que também vetores `RGB` são opções válidas.
Para o nosso próximo exemplo, você pode passar o mapa de cores personalizado _perse_ ou usar `cgrad` para forçar um `Colorbar` categórico.

```
using Colors, ColorSchemes
```

```jl
scat = """
    CairoMakie.activate!() # hide
    figure = (; resolution=(600, 400), font="CMU Serif")
    axis = (; xlabel=L"x", ylabel=L"y", aspect=DataAspect())
    cmap = ColorScheme(range(colorant"red", colorant"green", length=3))
    mygrays = ColorScheme([RGB{Float64}(i, i, i) for i in [0.0, 0.5, 1.0]])
    fig, ax, pltobj = heatmap(rand(-1:1, 20, 20);
        colormap=cgrad(mygrays, 3, categorical=true, rev=true), # cgrad and Symbol, mygrays,
        axis=axis, figure=figure)
    cbar = Colorbar(fig[1, 2], pltobj, label="Categories")
    cbar.ticks = ([-0.66, 0, 0.66], ["-1", "0", "1"])
    fig
    label = "categorical_colormap" # hide
    caption = "Categorical Colormap." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, label, caption, link_attributes) # hide
    """
sco(scat)
```

Por fim, os tiques na barra de cores para o caso categorial não são centralizados por padrão em cada cor.
Isso é corrigido passando ticks personalizados, como em `cbar.ticks = (positions, ticks)`.
A última situação é passar uma tupla de duas cores para o `colormap` como símbolos, strings ou uma mistura.
Você obterá um mapa de cores interpolado entre essas duas cores.

Além disso, cores codificadas em hexadecimal também são aceitas.
Então, no topo do nosso mapa de calor, vamos colocar um ponto semitransparente usando:

```jl
s2color2 = """
    CairoMakie.activate!() # hide
    figure = (; resolution=(600, 400), font="CMU Serif")
    axis = (; xlabel=L"x", ylabel=L"y", aspect=DataAspect())
    fig, ax, pltobj = heatmap(rand(20, 20); colorrange=(0, 1),
        colormap=(:red, "black"), axis=axis, figure=figure)
    scatter!(ax, [11], [11], color=("#C0C0C0", 0.5), markersize=150)
    Colorbar(fig[1, 2], pltobj, label="2 colors")
    fig
    label = "colormap_two_colors" # hide
    caption = "Colormap from two colors." # hide
    link_attributes = "width=60%" # hide
    Options(fig; filename=label, label, caption, link_attributes) # hide
    """
sco(s2color2)
```

### Ciclo personalizado

Aqui, poderíamos definir um `Tema` global com um novo ciclo de cores, mas essa **não é a maneira recomendada** de fazer isso.
É melhor definir um novo tema e usar como mostramos antes.
Vamos definir um novo com um `cycle` para `:color`, `:linestyle`, `:marker` e um novo padrão `colormap`.
Vamos adicionar esses novos atributos ao nosso `publication_theme` anterior.

```jl
@sc new_cycle_theme()
```

E aplique-o a uma função de plotagem como a seguinte:

```jl
@sc scatters_and_lines()
```

```jl
s = """
    CairoMakie.activate!() # hide
    with_theme(scatters_and_lines, new_cycle_theme())
    label = "custom_cycle" # hide
    caption = "Custom theme with new cycle and colormap." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Neste ponto, você deve ter **controle completo** sobre suas cores, estilos de linha, marcadores e mapas de cores para seus _plots_.
A seguir, veremos como gerenciar e controlar **layouts**.
