## Layouts {#sec:makie_layouts}

Um _canvas/layout_ completo é definido por `Figure`, que pode ser preenchido com conteúdo após ser criado.
omeçaremos com um arranjo simples de um `Axis`, uma `Legend` e uma `Colorbar`.
Para esta tarefa, podemos pensar no canvas como um arranjo de `linhas` e `colunas` na indexação de uma `Figure` bem como um `Array`/`Matrix` regular.
O conteúdo do `Axis` estará na _linha 1, coluna 1_, por exemplo `fig[1, 1]`, a `Colorbar` na _linha 1, coluna 2_, ou seja, `fig[1, 2]`.
E a `Legend` na _linha 2_ e nas _colunas 1 e 2_, ou seja, `fig[2, 1:2]`.

```jl
@sco JDS.first_layout()
```

Isso já parece bom, mas poderia ser melhor. Podemos corrigir problemas de espaçamento usando as seguintes palavras-chave e métodos:

- `figure_padding=(left, right, bottom, top)`
- `padding=(left, right, bottom, top)`

Levar em consideração o tamanho real de uma `Legend` ou `Colorbar` é feito por

> - `tellheight=true` ou `false`
> - `tellwidth=true` ou `false`
>
> _Definir como `true` levará em consideração o tamanho real (altura ou largura) para uma `Legend` ou `Colorbar`_.
> Consequentemente, as coisas serão redimensionadas de acordo.

O espaço entre colunas e linhas é especificado como

> - `colgap!(fig.layout, col, separation)`
> - `rowgap!(fig.layout, row, separation)`
>
> _Column gap_ (`colgap!`), se `col` for fornecido, a lacuna será aplicada a essa coluna específica.
>_Row gap_ (`rowgap!`) , se a `linha` for fornecido, a lacuna será aplicada a essa linha específica.

Além disso, veremos como colocar conteúdo nas **protrusões**, _i.e._ o espaço reservado para _título: `x` e `y`; ou `ticks` ou `label`_.
Fazemos isso plotando em `fig[i, j, protrusion]` onde _`protrusion`_ pode ser `Esquerda()`, `Direita()`, `Inferior()` e `Superior()`, ou para cada canto `SuperiorEsquerdo()`, `SuperiorDireito()`, `InferiorDireito()`, `InferiorEsquerdo()`.
Veja abaixo como essas opções estão sendo utilizadas:

```jl
@sco JDS.first_layout_fixed()
```

Aqui, ter o rótulo `(a)` no `SuperiorEsquerdo()` provavelmente não é necessário, isso só fará sentido para mais de dois plots.
Para o nosso próximo exemplo vamos continuar usando as ferramentas anteriores e mais algumas para criar uma figura mais rica e complexa.

Você pode ocultar decorações e espinhas de eixos com:

> - `hidedecorations!(ax; kwargs...)`
> - `hidexdecorations!(ax; kwargs...)`
> - `hideydecorations!(ax; kwargs...)`
> - `hidespines!(ax; kwargs...)`

Lembre-se, sempre podemos pedir ajuda para ver que tipo de argumentos podemos usar, por exemplo,

```jl
s = """
    help(hidespines!)
    """
sco(s)
```

Alternativamente, para decorações

```jl
s = """
    help(hidedecorations!)
    """
sco(s)
```

Para elementos que **você não deseja ocultar**, apenas passe-os com `false`, ou seja, `hideydecorations!(ax; ticks=false, grid=false)`.


A sincronização do seu `Axis` é feita via:

> - `linkaxes!`, `linkyaxes!` e `linkxaxes!`
>
> Isso pode ser útil quando eixos compartilhados são desejados.
> Outra maneira de obter eixos compartilhados será definindo `limites!`.

Definir `limites` de uma vez ou independentemente para cada eixo é feito chamando

> - `limites!(ax; l, r, b, t)`, onde `l` é esquerda, `r` direita, `b` inferior e `t` superior.
>
> You can also do `ylims!(low, high)` or `xlims!(low, high)`, and even open ones by doing `ylims!(low=0)` or `xlims!(high=1)`.

Now, the example:

```jl
@sco JDS.complex_layout_double_axis()
```

So, now our `Colorbar` needs to be horizontal and the bar ticks need to be in the lower part.
This is done by setting `vertical=false` and `flipaxis=false`.
Additionally, note that we can call many `Axis` into `fig`, or even `Colorbar`'s and `Legend`'s, and then afterwards build the layout.

Another common layout is a grid of squares for heatmaps:

```jl
@sco JDS.squares_layout()
```

where all labels are in the **protrusions** and each `Axis` has an `AspectData()` ratio.
The `Colorbar` is located in the third column and expands from row 1 up to row 2.

The next case uses the so called `Mixed()` **alignmode**, which is especially useful when dealing with large empty spaces between `Axis` due to long ticks.
Also, the `Dates` module from Julia's standard library will be needed it for this example.

```
using Dates
```

```jl
@sco JDS.mixed_mode_layout()
```

Here, the argument `alignmode=Mixed(bottom=0)` is shifting the bounding box to the bottom, so that this will align with the panel on the left filling the space.

Also, see how `colsize!` and `rowsize!` are being used for different columns and rows.
You could also put a number instead of `Auto()` but then everything will be fixed.
And, additionally, one could also give a `height` or `width` when defining the `Axis`, as in `Axis(fig, heigth=50)` which will be fixed as well.

### Nested `Axis` (_subplots_)

It is also possible to define a set of `Axis` (_subplots_) explicitly, and use it to build a main figure with several rows and columns.
For instance, the following its a "complicated" arrangement of `Axis`:

```jl
@sc nested_sub_plot!(fig)
```

which, when used to build a more complex figure by doing several calls, we obtain:

```jl
@sco JDS.main_figure()
```

Note that different subplot functions can be called here.
Also, each `Axis` here is an independent part of `Figure`.
So that, if you need to do some `rowgap!`'s or `colsize!`'s operations, you will need to do it in each one of them independently or to all of them together.

For grouped `Axis` (_subplots_) we can use `GridLayout()` which, then, could be used to composed a more complicated `Figure`.

### Nested GridLayout

By using `GridLayout()` we can group subplots, allowing more freedom to build complex figures.
Here, using our previous `nested_sub_plot!` we define three sub-groups and one normal `Axis`:

```jl
@sco JDS.nested_Grid_Layouts()
```

Now, using `rowgap!` or `colsize!` over each group is possible and `rowsize!, colsize!` can also be applied to the set of `GridLayout()`s.

### Inset plots

Currently, doing `inset` plots is a little bit tricky.
Here, we show two possible ways of doing it by initially defining auxiliary functions.
The first one is by doing a `BBox`, which lives in the whole `Figure` space:

```jl
@sc add_box_inset(fig)
```

Then, the `inset` is easily done, as in:

```jl
@sco JDS.figure_box_inset()
```

where the `Box` dimensions are bound by the `Figure`'s `resolution`.
Note, that an inset can be also outside the `Axis`.
The other approach, is by defining a new `Axis` into a position `fig[i, j]` specifying his `width`, `height`, `halign` and `valign`.
We do that in the following function:

```jl
@sc add_axis_inset()
```

See that in the following example the `Axis` with gray background will be rescaled if the total figure size changes.
The _insets_ are bound by the `Axis` positioning.

```jl
@sco JDS.figure_axis_inset()
```

And this should cover most used cases for layouting with Makie.
Now, let's do some nice 3D examples with  `GLMakie.jl`.
