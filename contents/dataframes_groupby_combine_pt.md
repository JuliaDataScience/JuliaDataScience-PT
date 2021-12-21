## Groupby e Combine {#sec:groupby_combine}

A linguagem de programação R, @wickham2011split popularizou a chamada estratégia dividir-aplicar-combinar para transformações de dados.
Em essência, esta estratégia **divide** o dataset em grupos distintos, **aplica** uma ou mais funções para cada grupo e, depois, **combina** o resultado.
`DataFrames.jl` suporta totalmente dividir-aplicar-combinar.
Usaremos o exemplo das notas do aluno como antes.
Suponha que queremos saber a nota média de cada aluno:

```jl
@sco process=without_caption_label all_grades()
```

A estratégia é **dividir** o dataset em alunos distintos, **aplicar** a função média para cada aluno e **combinar** o resultado.

A divisão é chamada `groupby` e dá como segundo argumento o ID da coluna em que queremos dividir o dataset:

```jl
s = "groupby(all_grades(), :name)"
sco(s; process=string, post=plainblock)
```

Nós aplicamos a função `mean` da biblioteca padrão de Julia no módulo `Statistics`:

```
using Statistics
```

Para aplicar esta função, use a função `combine`:

```jl
s = """
    gdf = groupby(all_grades(), :name)
    combine(gdf, :grade => mean)
    """
sco(s; process=without_caption_label)
```

Imagine ter que fazer isso sem as funções `groupby` e `combine`.
Precisaríamos fazer um loop sobre nossos dados para dividi-los em grupos, em seguida, fazer um loop em cada divisão para aplicar a função **e** finalmente, fazer um loop em cada grupo para obter o resultado final.
Portanto, a técnica dividir-aplicar-combinar é muito boa.

### Múltiplas colunas de origem {#sec:groupby_combine_multiple_source}

Mas, e se quisermos aplicar uma função a várias colunas de nosso dataset?

```jl
s = """
    group = [:A, :A, :B, :B]
    X = 1:4
    Y = 5:8
    df = DataFrame(; group, X, Y)
    """
sco(s; process=without_caption_label)
```

Isso é feito de maneira semelhante:

```jl
s = """
    gdf = groupby(df, :group)
    combine(gdf, [:X, :Y] .=> mean; renamecols=false)
    """
sco(s; process=without_caption_label)
```

Perceba que usamos o operador dot `.` operator antes da seta à direita `=>` para indicar que o `mean` tem que ser aplicado a múltiplas colunas de origem `[:X, :Y]`.

Para usar funções composíveis, uma maneira simples é criar uma função que faça as transformações composíveis pretendidas.
Por exemplo, para uma série de valores, vamos primeiro pegar o `mean` seguido de `round` para um número inteiro (também conhecido como um inteiro `Int`):

```jl
s = """
    gdf = groupby(df, :group)
    rounded_mean(data_col) = round(Int, mean(data_col))
    combine(gdf, [:X, :Y] .=> rounded_mean; renamecols=false)
    """
sco(s; process=without_caption_label)
```
