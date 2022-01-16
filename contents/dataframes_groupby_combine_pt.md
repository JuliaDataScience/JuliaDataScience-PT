## Groupby e Combine {#sec:groupby_combine}

Para a linguagem de programação R, @wickham2011split popularizou a chamada estratégia _split-apply-combine (ou dividir-aplicar-combinar) para transformações de dados.
Em essência, essa estratégia **divide** o dataset em grupos distintos, **aplica** uma ou mais funções para cada grupo e, depois, **combina** o resultado.
`DataFrames.jl` suporta totalmente o método dividir-aplicar-combinar.
Usaremos o exemplo das notas do aluno como antes.
Suponha que queremos saber a nota média de cada aluno:

```jl
@sco process=without_caption_label all_grades()
```

A estratégia é **dividir** o dataset em alunos distintos, **aplicar** a função média para cada aluno e **combinar** o resultado.

A divisão é chamada `groupby` e passamos como segundo argumento o ID da coluna em que queremos dividir o dataset:

```jl
s = "groupby(all_grades(), :name)"
sco(s; process=string, post=plainblock)
```

Nós aplicamos a função `mean` da biblioteca padrão de Julia no módulo `Statistics`:

```
using Statistics
```

Para aplicá-la, utilizamos a função `combine`:

```jl
s = """
    gdf = groupby(all_grades(), :name)
    combine(gdf, :grade => mean)
    """
sco(s; process=without_caption_label)
```

Imagine ter que fazer isso sem as funções `groupby` e `combine`.
Precisaríamos iterar sobre nossos dados para dividi-los em grupos, em seguida, iterar sobre os registros em cada divisão para aplicar a função **e**, finalmente, iterar sobre cada grupo para obter o resultado final.
Vê-se assim que é muito bom conhecer a técnica dividir-aplicar-combinar.

### Múltiplas Colunas de Origem {#sec:groupby_combine_multiple_source}

Mas, e se quisermos aplicar uma função à várias colunas de nosso dataset?

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

Perceba que usamos o operador dot `.` antes da seta à direita `=>` para indicar que o `mean` tem que ser aplicado a múltiplas colunas de origem `[:X, :Y]`.

Para usar funções compostas, uma maneira simples é criar uma função que faça as transformações compostas pretendidas.
Por exemplo, para uma série de valores, vamos primeiro pegar o `mean` seguido de `round` para um número inteiro (também conhecido como um inteiro `Int`):

```jl
s = """
    gdf = groupby(df, :group)
    rounded_mean(data_col) = round(Int, mean(data_col))
    combine(gdf, [:X, :Y] .=> rounded_mean; renamecols=false)
    """
sco(s; process=without_caption_label)
```
