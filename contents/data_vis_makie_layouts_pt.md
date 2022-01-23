## Layouts {#sec:makie_layouts}

Um _canvas_/_layout_ completo é definido por `Figure`, que pode ser preenchido com conteúdo após ser criado.
Começaremos com um arranjo simples de um `Axis`, uma `Legend` e uma `Colorbar`.
Para esta tarefa, podemos pensar no canvas como um arranjo de `rows` e `columns` na indexação de uma `Figure` bem como um `Array`/`Matrix` regular.
O conteúdo do `Axis` estará na _linha 1, coluna 1_, por exemplo `fig[1, 1]`, a `Colorbar` na _linha 1, coluna 2_, ou seja, `fig[1, 2]`.
E a `Legend` na _linha 2_ e nas _colunas 1 e 2_, ou seja, `fig[2, 1:2]`.

```jl
@sco JDS.first_layout()
```

Isso já parece bom, mas poderia ser melhor.
Podemos corrigir problemas de espaçamento usando as seguintes palavras-chave e métodos:

- `figure_padding=(left, right, bottom, top)`
- `padding=(left, right, bottom, top)`

Levar em consideração o tamanho real de uma `Legend` ou `Colorbar` é feito por:

> - `tellheight=true` ou `false`
> - `tellwidth=true` ou `false`
>
> _Definir como `true` levará em consideração o tamanho real (altura ou largura) para uma `Legend` ou `Colorbar`_.
> Consequentemente, as coisas serão redimensionadas de acordo.

O espaço entre colunas e linhas é especificado como:

> - `colgap!(fig.layout, col, separation)`
> - `rowgap!(fig.layout, row, separation)`
>
> _Column gap_ (`colgap!`), se `col` for fornecido, a lacuna será aplicada a essa coluna específica.
>_Row gap_ (`rowgap!`) , se a `linha` for fornecido, a lacuna será aplicada a essa linha específica.

Além disso, veremos como colocar conteúdo nas **protrusões**, _i.e._ o espaço reservado para título: `x` e `y`; ou `ticks` ou `label`.
Fazemos isso plotando em `fig[i, j, protrusion]` onde `protrusion` pode ser `Left()`, `Right()`, `Bottom()` e `Top()`, ou para cada canto `TopLeft()`, `TopRight()`, `BottomRight()`, `BottomLeft()`.
Veja abaixo como essas opções estão sendo utilizadas:

```jl
@sco JDS.first_layout_fixed()
```

Aqui, ter o rótulo `(a)` no `TopLeft()` provavelmente não é necessário, isso só fará sentido para mais de dois _plots_.
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

Alternativamente, para decorações:

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

Definir limites de uma vez ou independentemente para cada eixo é feito chamando

> - `limits!(ax; l, r, b, t)`, onde `l` é esquerda, `r` direita, `b` inferior e `t` superior.
>
> Você também pode fazer `ylims!(low, high)` ou `xlims!(low, high)`, e até mesmo abrir fazendo `ylims!(low=0)` ou `xlims!(high=1)`.

Agora, o exemplo:

```jl
@sco JDS.complex_layout_double_axis()
```

Então, agora nosso `Colorbar` precisa ser horizontal e as marcações da barra precisam estar na parte inferior.
Isso é feito configurando `vertical=false` e `flipaxis=false`.
Além disso, observe que podemos chamar muitos `Axis` em `fig`, ou mesmo `Colorbar` e `Legend`, e depois construir o layout.

Outro layout comum é uma grade de quadrados para mapas de calor:

```jl
@sco JDS.squares_layout()
```

onde todos os rótulos estão em **protrusões** e cada `Axis` tem uma razão `AspectData()`.
A `Colorbar` está localizada na terceira coluna e se expande da linha 1 até a linha 2.

O próximo caso usa o chamado **modo de alinhamento** `Mixed()`, o que é especialmente útil ao lidar com grandes espaços vazios entre `Axis` devido a tiques longos.
Ainda, o módulo `Dates` da biblioteca padrão de Julia será necessário para esse exemplo.

```
using Dates
```

```jl
@sco JDS.mixed_mode_layout()
```

Aqui, o argumento `alignmode=Mixed(bottom=0)` desloca a caixa delimitadora para a parte inferior, de forma a alinhar com o painel à esquerda preenchendo o espaço.

Também, veja como `colsize!` e `rowsize!` estão sendo usados para diferentes colunas e linhas.
Você também pode colocar um número ao invés de `Auto()` mas então tudo vai ser corrigido.
E, além disso, pode-se também dar um `height` ou `width` ao definir o `Axis`, como em `Axis(fig, heigth=50)` que será corrigido também.

### `Axis` aninhado (_subplots_)

Também é possível definir um conjunto de `Axis` (_subplots_) explicitamente e use-o para construir uma figura principal com várias linhas e colunas.
Por exemplo, o seguinte é um arranjo "complicado" de `Axis`:

```jl
@sc nested_sub_plot!(fig)
```

que, quando usado para construir uma figura mais complexa fazendo várias chamadas, obtemos:

```jl
@sco JDS.main_figure()
```

Observe que diferentes funções de _subplot_ podem ser chamadas aqui.
Também, cada `Axis` aqui é uma parte independente de `Figure`.
Então, se você precisar fazer alguma operação `rowgap!` ou `colsize!`, você precisará fazê-lo em cada um deles de forma independente ou em todos eles juntos.

Para `Axis` (_subplots_) agrupados podemos usar `GridLayout()` que, então, poderia ser usado para compor um `Figure`.

### GridLayout aninhado

Ao usar o `GridLayout()` podemos agrupar _subplots_, permitindo mais liberdade na construção de figuras complexas.
Aqui, usando nosso `nested_sub_plot!` anterior, definimos três subgrupos e um `Axis` normal:

```jl
@sco JDS.nested_Grid_Layouts()
```

Agora, usando `rowgap!` ou `colsize!` sobre cada grupo é possível `rowsize!, colsize!` também pode ser aplicado ao conjunto de `GridLayout()`.

### _Plots_ `inset`

Atualmente, fazer gráficos `inset` é um pouco complicado.
Aqui, mostramos duas maneiras possíveis de fazer isso definindo inicialmente as funções auxiliares.
A primeira é fazendo um `BBox`, que fica em todo o espaço `Figure`:

```jl
@sc add_box_inset(fig)
```

Então, o `inset` é feito facilmente, como em:

```jl
@sco JDS.figure_box_inset()
```

onde as dimensões `Box` estão vinculadas ao `resolution` `Figure`.
Observe que um inset também pode estar fora do `Axis`.
A outra abordagem é definir um novo `Axis` em uma posição `fig[i, j]` especificando seu `width`, `height`, `halign` and `valign`.
Fazemos isso na seguinte função:

```jl
@sc add_axis_inset()
```

Veja que no exemplo a seguir o `Axis` com fundo cinza será redimensionado se o tamanho total da figura for alterado.
Os _insets_ são limitados pelo posicionamento do `Axis`.

```jl
@sco JDS.figure_axis_inset()
```

E isso deve cobrir os casos mais usados para layout com Makie.
Agora, vamos fazer alguns bons exemplos 3D com  `GLMakie.jl`.
