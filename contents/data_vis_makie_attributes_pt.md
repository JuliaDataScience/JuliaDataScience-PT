## Atributos {#sec:datavisMakie_attributes}

Um gráfico personalizado pode ser criado usando `attributes` (atributos).
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

Ou como uma chamada de dicionário (`Dict`), `pltobject.attributes.attributes`.

Pedir ajuda no `REPL` como `?lines` ou `help(lines)` para qualquer função de plotagem mostrará seus atributos correspondentes acrescidos de uma breve descrição de como usar essa função específica.
Por exemplo, para `lines`:

```jl
s = """
    help(lines)
    """
sco(s)
```

Não apenas os objetos de tipo _plot_ têm atributos, como também os objetos `Axis` (eixo) e `Figure` (figura) os possuem.
Por exemplo, para figura, temos `backgroundcolor` (cor de fundo), `resolution` (resolução), `font` (fonte) e `fontsize` (tamanho da fonte) e o `figure_padding` (preenchimento ou passe-partout) que altera a quantidade de espaço ao redor do conteúdo da figura, veja a área cinza no plot, Figure (@ fig:custom_plot).
Ele aceita como argumentos um número único para todos os lados, ou uma tupla de quatro números para esquerda, direita, inferior e superior, representando cada um dos lados.

`Axis` tem muito mais atributos, alguns deles são `backgroundcolor` (cor de fundo), `xgridcolor` (cor da grade do eixo x) e `title` (título).
Para uma lista completa basta digitar `help(Axis)`.

Assim, para nosso próximo plot, designaremos vários atributos de uma só vez, como segue:

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
Provavelmente, também seria bom ter uma `legend` (legenda).
O que fará mais sentido quando utilizarmos mais de uma função de visualização.
Então, vamos `append` (acrescentar) outra mutação em nosso `plot object` e adicionar as legendas correspondentes chamando `axislegend`.
A legenda criada irá coletar todos os `labels` que você pode ter passado para suas funções de plotagem e por padrão estará localizada na posição superior direita.
Para uma posição diferente, o argumento `position=:ct` é chamado, onde `:ct` significa que vamos colocar nosso rótulo no 'centro' e no 'topo', veja Figura @fig:custom_plot_leg:

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

Outras posições também estão disponíveis ao combinarmos `left(l), center(c), right(r)` com `bottom(b), center(c), top(t)`.
Por exemplo, para o topo superior esquerdo, use `:lt`.

No entanto, escrever essa quantidade de código apenas para duas linhas é complicado.
Portanto, se você planeja fazer muitos plots com a mesma estética geral, definir um tema é sempre melhor.
Podemos fazer isso com `set_theme!()` como ilustrado pelo exemplo abaixo.

A plotagem da figura anterior deve ter as novas configurações padrão definidas por `set_theme!(kwargs)`:

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

Perceba que a última linha é `set_theme!()`, que irá redefinir as configurações padrão do Makie.
Para mais `themes` por favor vá a @sec:themes.

Antes de passarmos para a próxima seção, vale a pena ver um exemplo onde um `array` de atributos é passado de uma só vez para uma função de plotagem.
Para esse exemplo, usaremos a função de plotagem `scatter` para fazer um gráfico de dispersão.

Os dados para isso podem ser um `array` com 100 linhas e 3 colunas, aqui gerados aleatoriamente a partir de uma distribuição normal.
Aqui, a primeira coluna pode ser as posições no eixo `x`, a segunda as posições em `y` e a terceira um valor associado intrínseco para cada ponto.
O último pode ser representado em um gráfico por uma 'cor' diferente ou com um tamanho de marcador diferente. Em um gráfico de dispersão podemos fazer os dois.

```jl
s = """
    using Random: seed!
    seed!(28)
    xyvals = randn(100, 3)
    xyvals[1:5, :]
    """
sco(s)
```

A seguir, o plot correspondente pode ser visto em @fig:bubble:

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

onde decompomos a tupla `FigureAxisPlot` em `fig, ax, pltobj`, para podermos adicionar um `Legend` e `Colorbar` fora do objeto plotado.
Vamos discutir opções de layout mais detalhadamente em in @sec:makie_layouts.

Fizemos alguns exemplos básicos, mas ainda interessantes, para mostrar como usar o `Makie.jl` e agora você deve estar se perguntando: o que mais podemos fazer?
Quais são todas as possíveis funções de plotagem disponíveis em `Makie.jl`?
Para responder essa pergunta, contamos com uma _cheat sheet_ em @fig:cheat_sheet_cairomakie.
Isso funciona especialemnte bem com o backend `CairoMakie.jl`.

![Funções de plotagem: Cheat Sheet. Saída dada por Cairomakie.](images/makiePlottingFunctionsHide.png){#fig:cheat_sheet_cairomakie}

Para completar, em @fig:cheat_sheet_glmakie, mostramos as funções correspondentes _cheat sheet_ para `GLMakie.jl`, que dá suporte principalmente para plotagens 3D.
Elas serão explicadas em detalhes em @sec:glmakie.

![Funções de plotagem: Cheat Sheet. Saída dada por GLMakie.](images/GLMakiePlottingFunctionsHide.png){#fig:cheat_sheet_glmakie}

Agora que temos uma ideia de todas as coisas que podemos fazer, vamos voltar e continuar com o básico.
É hora de aprendermos a mudar a aparência geral dos nossos plots.
