## Atributos {#sec:datavisMakie_attributes}

Um plot personalizado pode ser criado usando `attributes`.
Os atributos podem ser definidos através de argumentos de palavras-chave.
Uma lista de `atributos` para cada objeto de plotagem pode ser visualizada via:

```jl
s = """
    CairoMakie.activate!() # hide
    fig, ax, pltobj = scatterlines(1:10)
    pltobj.attributes
    """
sco(s)
```

Ou como uma chamada `Dict`, `pltobject.attributes.attributes`.

Pedir ajuda no `REPL` como `?lines` ou `help(lines)` para qualquer função de plotagem mostrará seus atributos correspondentes mais uma breve descrição de como usar essa função específica.
Por exemplo, para `lines`:

```jl
s = """
    help(lines)
    """
sco(s)
```

Não apenas os objetos plot têm atributos, também os objetos `Axis` e `Figure`.
Por exemplo, para figura, temos `backgroundcolor`, `resolution`, `font` e `fontsize` e o `figure_padding` que altera a quantidade de espaço ao redor do conteúdo da figura, veja a área cinza no plot, Figure (@ fig:custom_plot).
Pode levar um número para todos os lados, ou uma tupla de quatro números para esquerda, direita, inferior e superior.

`Axis` tem bem mais, alguns deles são `backgroundcolor`, `xgridcolor` e `title`.
Para uma lista completa basta digitar `help(Axis)`.

Portanto, para nosso próximo plot, chamaremos vários atributos de uma só vez, como segue:

```jl
s = """
    CairoMakie.activate!() # hide
    lines(1:10, (1:10).^2; color=:black, linewidth=2, linestyle=:dash,
        figure=(; figure_padding=5, resolution=(600, 400), font="sans",
            backgroundcolor=:grey90, fontsize=16),
        axis=(; xlabel="x", ylabel="x²", title="title",
            xgridstyle=:dash, ygridstyle=:dash))
    current_figure()
    filename = "custom_plot" # hide
    link_attributes = "width=60%" # hide
    caption = "Custom plot." # hide
    Options(current_figure(); filename, caption, label=filename, link_attributes) # hide
    """
sco(s)
```

Este exemplo já possui a maioria dos atributos que grande parte dos usuários normalmente executará.
Provavelmente, também será bom ter uma `legend`.
Que para mais de uma função fará mais sentido.
Então, vamos `append` outra mutação `plot object` e adicione as legendas correspondentes chamando `axislegend`.
Isto irá coletar todos os `labels` que você pode ter passado para suas funções de plotagem e por padrão estará localizado na posição superior direita.
Para outro diferente, o argumento `position=:ct` é chamado, onde `:ct` significa que vamos colocar nosso rótulo no 'centro' e no 'topo', veja Figura @fig:custom_plot_leg:

```jl
s = """
    CairoMakie.activate!() # hide
    lines(1:10, (1:10).^2; label="x²", linewidth=2, linestyle=nothing,
        figure=(; figure_padding=5, resolution=(600, 400), font="sans",
            backgroundcolor=:grey90, fontsize=16),
        axis=(; xlabel="x", title="title", xgridstyle=:dash,
            ygridstyle=:dash))
    scatterlines!(1:10, (10:-1:1).^2; label="Reverse(x)²")
    axislegend("legend"; position=:ct)
    current_figure()
    label = "custom_plot_leg" # hide
    link_attributes = "width=60%" # hide
    caption = "Custom plot legend." # hide
    Options(current_figure(); label, filename=label, caption, link_attributes) # hide
    """
sco(s)
```

Other positions are also available by combining `left(l), center(c), right(r)` and `bottom(b), center(c), top(t)`.
For instance, for left top, use `:lt`.

However, having to write this much code just for two lines is cumbersome.
So, if you plan on doing a lot of plots with the same general aesthetics, then setting a theme will be better.
We can do this with `set_theme!()` as the following example illustrates.

Plotting the previous figure should take the new default settings defined by `set_theme!(kwargs)`:

```jl
s = """
    CairoMakie.activate!() # hide
    set_theme!(; resolution=(600, 400),
        backgroundcolor=(:orange, 0.5), fontsize=16, font="sans",
        Axis=(backgroundcolor=:grey90, xgridstyle=:dash, ygridstyle=:dash),
        Legend=(bgcolor=(:red, 0.2), framecolor=:dodgerblue))
    lines(1:10, (1:10).^2; label="x²", linewidth=2, linestyle=nothing,
        axis=(; xlabel="x", title="title"))
    scatterlines!(1:10, (10:-1:1).^2; label="Reverse(x)²")
    axislegend("legend"; position=:ct)
    current_figure()
    set_theme!()
    label = "setTheme" # hide
    link_attributes = "width=60%" # hide
    caption = "Set theme example."
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Note that the last line is `set_theme!()`, which will reset the default settings of Makie.
For more on `themes` please go to @sec:themes.

Before moving on into the next section, it's worthwhile to see an example where an `array` of attributes are passed at once to a plotting function.
For this example, we will use the `scatter` plotting function to do a bubble plot.

The data for this could be an `array` with 100 rows and 3 columns, here we generated these at random from a normal distribution.
Here, the first column could be the positions in the `x` axis, the second one the positions in `y` and the third one an intrinsic associated value for each point.
The later could be represented in a plot by a different `color` or with a different marker size. In a bubble plot we can do both.

```jl
s = """
    using Random: seed!
    seed!(28)
    xyvals = randn(100, 3)
    xyvals[1:5, :]
    """
sco(s)
```

Next, the corresponding plot can be seen in @fig:bubble:

```jl
s = """
    CairoMakie.activate!() # hide
    fig, ax, pltobj = scatter(xyvals[:, 1], xyvals[:, 2]; color=xyvals[:, 3],
        label="Bubbles", colormap=:plasma, markersize=15 * abs.(xyvals[:, 3]),
        figure=(; resolution=(600, 400)), axis=(; aspect=DataAspect()))
    limits!(-3, 3, -3, 3)
    Legend(fig[1, 2], ax, valign=:top)
    Colorbar(fig[1, 2], pltobj, height=Relative(3 / 4))
    fig
    label = "bubble" # hide
    link_attributes = "width=60%" # hide
    caption = "Bubble plot."
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

where we have decomposed the tuple `FigureAxisPlot` into `fig, ax, pltobj`, in order to be able to add a `Legend` and `Colorbar` outside of the plotted object.
We will discuss layout options in more detail in @sec:makie_layouts.

We have done some basic but still interesting examples to show how to use `Makie.jl` and by now you might be wondering: what else can we do?
What are all the possible plotting functions available in `Makie.jl`?
To answer this question, a _cheat sheet_ is shown in @fig:cheat_sheet_cairomakie.
These work especially well with `CairoMakie.jl` backend.

![Plotting functions: Cheat Sheet. Output given by Cairomakie.](images/makiePlottingFunctionsHide.png){#fig:cheat_sheet_cairomakie}

For completeness, in @fig:cheat_sheet_glmakie, we show the corresponding functions _cheat sheet_ for `GLMakie.jl`, which supports mostly 3D plots.
Those will be explained in detail in @sec:glmakie.

![Plotting functions: Cheat Sheet. Output given by GLMakie.](images/GLMakiePlottingFunctionsHide.png){#fig:cheat_sheet_glmakie}

Now, that we have an idea of all the things we can do, let's go back and continue with the basics.
It's time to learn how to change the general appearance of our plots.
