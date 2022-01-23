## Usando LaTeXStrings.jl

Suporte LaTeX em `Makie.jl` também está disponível via `LaTeXStrings.jl`:

```
using LaTeXStrings
```

Casos de uso simples mostraremos abaixo (@fig:latex_strings).
Um exemplo básico inclui strings LaTeX para rótulos e legendas x-y:

```jl
@sc LaTeX_Strings()
```

```jl
s = """
    CairoMakie.activate!() # hide
    with_theme(LaTeX_Strings, publication_theme())
    label = "latex_strings" # hide
    caption = "Plot with LaTeX strings." # hide
    link_attributes = "width=60%" # hide
    Options(current_figure(); filename=label, caption, label, link_attributes) # hide
    """
sco(s)
```

Um exemplo mais complicado será com alguma equação como texto e aumentando a numeração de legenda para curvas em um _plot_:

```jl
@sco JDS.multiple_lines()
```

Mas, algumas linhas têm cores repetidas, então isso não é bom.
Adicionar alguns marcadores e estilos de linha geralmente ajuda.
Então, vamos fazer isso usando [`Cycles`](http://makie.juliaplots.org/stable/documentation/theming/index.html#cycles) para esses tipos.
Definir `covary=true` permite alternar todos os elementos juntos:

```jl
@sco JDS.multiple_scatters_and_lines()
```

E voilà.
Um _plot_ de qualidade de publicação está aqui.
O que mais podemos pedir?
Bem, e quanto a diferentes cores ou paletas padrão?
Em nossa próxima seção, veremos como usar novamente [`Cycles`](http://makie.juliaplots.org/stable/documentation/theming/index.html#cycles) e conheça um pouco mais sobre eles, além de algumas palavras-chave adicionais para conseguir isso.
