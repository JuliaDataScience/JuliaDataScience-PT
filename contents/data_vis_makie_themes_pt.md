## Temas {#sec:themes}

Existem várias maneiras de modificar a aparência geral de seus plots.
Ou, você pode usar um [tema predefinido](http://makie.juliaplots.org/stable/documentation/theming/predefined_themes/index.html) ou seu próprio tema personalizado.
Por exemplo, use um tema escuro predefinido via `with_theme(your_plot_function, theme_dark())`.
Ou construa o seu próprio com `Theme(kwargs)` ou até mesmo atualize o que está ativo com `update_theme!(kwargs)`.

Você também pode fazer `set_theme!(theme; kwargs...)` para alterar o tema do padrão atual para `theme` e substituir ou adicionar atributos fornecidos por `kwargs`.
Se você fizer isso e quiser redefinir todas as configurações anteriores, faça `set_theme!()` sem argumentos.
Veja os exemplos a seguir, onde preparamos uma função de plotagem de teste com características diferentes, de forma que a maioria dos atributos para cada tema possa ser apreciada.

```jl
sco(
"""
using Random: seed!
seed!(123)
y = cumsum(randn(6, 6), dims=2)
"""
)
```

Uma matrix de tamanho `(20, 20)` com entradas aleatórias, para que possamos plotar um mapa de calor.
O intervalo em $x$ e $y$ também é especificado.

```jl
sco(
"""
using Random: seed!
seed!(13)
xv = yv = LinRange(-3, 0.5, 20)
matrix = randn(20, 20)
matrix[1:6, 1:6] # first 6 rows and columns
"""
)
```

Portanto, nossa função de plotagem se parece com o seguinte:

```jl
@sc demo_themes(y, xv, yv, matrix)
```

Observe que a função `series` foi usada para plotar várias linhas e dispersões de uma só vez com seus rótulos correspondentes.
Além disso, um mapa de calor com sua barra de cores foi incluído.
Atualmente, existem dois temas escuros, um chamado `theme_dark()` e outro `theme_black()`, veja Figures.

```jl
s = """
    CairoMakie.activate!() # hide
    filenames = ["theme_dark", "theme_black"] # hide
    objects = [ # hide
    # Don't indent here because it indent the output incorrectly. # hide
    with_theme(theme_dark()) do
        demo_themes(y, xv, yv, matrix)
    end
    with_theme(theme_black()) do
        demo_themes(y, xv, yv, matrix)
    end
    ] # hide
    link_attributes = "width=60%" # hide
    Options(obj, filename, link_attributes) = Options(obj; filename, link_attributes) # hide
    Options.(objects, filenames, link_attributes) # hide
    """
sco(s)
```

E mais três temas esbranquiçados chamados, `theme_ggplot2()`, `theme_minimal()` e `theme_light()`. Útil para plots de tipo de publicação mais padrão.

```jl
s = """
    CairoMakie.activate!() # hide
    filenames = ["theme_ggplot2", # hide
        "theme_minimal", "theme_light"] # hide
    objects = [ # hide
    # Don't indent here because it indent the output incorrectly. # hide
    with_theme(theme_ggplot2()) do
        demo_themes(y, xv, yv, matrix)
    end
    with_theme(theme_minimal()) do
        demo_themes(y, xv, yv, matrix)
    end
    with_theme(theme_light()) do
        demo_themes(y, xv, yv, matrix)
    end
    ] # hide
    link_attributes = "width=60%" # hide
    Options(obj, filename, link_attributes) = Options(obj; filename, link_attributes) # hide
    Options.(objects, filenames, link_attributes) # hide
    """
sco(s)
```

Outra alternativa é definir um `Theme` fazendo `with_theme(your_plot, your_theme())`.
Por exemplo, o tema a seguir pode ser uma versão simples para um modelo de qualidade de publicação:

```jl
@sc publication_theme()
```

Que, por simplicidade, usamos para traçar `scatterlines` e um `heatmap`.

```jl
@sc plot_with_legend_and_colorbar()
```

Então, usando o `Theme` definido anteriormente, a saída é mostrada na Figure (@fig:plot_with_legend_and_colorbar).

```jl
s = """
    CairoMakie.activate!() # hide
    with_theme(plot_with_legend_and_colorbar, publication_theme())
    label = "plot_with_legend_and_colorbar" # hide
    caption = "Themed plot with Legend and Colorbar." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, label, caption, link_attributes) # hide
    """
sco(s)
```

Agora, se algo precisar ser alterado após `set_theme!(your_theme)`, podemos fazer isso com `update_theme!(resolution=(500, 400), fontsize=18)`, por exemplo.
Outra abordagem será passar argumentos adicionais para a função `with_theme`:

```jl
s = """
    CairoMakie.activate!() # hide
    fig = (resolution=(600, 400), figure_padding=1, backgroundcolor=:grey90)
    ax = (; aspect=DataAspect(), xlabel=L"x", ylabel=L"y")
    cbar = (; height=Relative(4 / 5))
    with_theme(publication_theme(); fig..., Axis=ax, Colorbar=cbar) do
        plot_with_legend_and_colorbar()
    end
    label = "plot_theme_extra_args" # hide
    caption = "Theme with extra args." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Agora, vamos seguir em frente e fazer um plot com strings LaTeX e um tema personalizado.
