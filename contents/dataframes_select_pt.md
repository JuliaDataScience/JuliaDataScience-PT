## Select {#sec:select}

Enquanto **`filter` remove linhas**, **`select` remove colunas**.
Entretanto, `select` é muito mais versátil do que apenas remover colunas, como discutiremos nesta seção.
Primeiro, vamos criar um dataset com múltiplas colunas:

```jl
@sco responses()
```

Aqui, os dados representam respostas para cinco perguntas (`q1`, `q2`, ..., `q5`) em um determinado questionário.
Começaremos "selecionando" algumas colunas deste dataset.
Como de costume, usamos símbolos para especificar colunas:

```jl
s = "select(responses(), :id, :q1)"
sco(s, process=without_caption_label)
```

Também podemos usar strings se quisermos:

```jl
s = """select(responses(), "id", "q1", "q2")"""
sco(s, process=without_caption_label)
```

Para selecionar tudo _menos_ uma ou mais colunas, use `Not` com uma única coluna:

```jl
s = """select(responses(), Not(:q5))"""
sco(s, process=without_caption_label)
```

Ou, com múltiplas colunas:

```jl
s = """select(responses(), Not([:q4, :q5]))"""
sco(s, process=without_caption_label)
```

Também é bom misturar e combinar colunas que queremos preservar com colunas que não `Not` queremos selecionar:

```jl
s = """select(responses(), :q5, Not(:id))"""
sco(s, process=without_caption_label)
```

Perceba como `q5` agora é a primeira coluna no `DataFrame` devolvido por `select`.
Existe uma maneira mais inteligente de conseguir o mesmo usando `:`.
Os dois pontos `:` pode ser pensado como "todas as colunas que ainda não incluímos".
Por exemplo:

```jl
s = """select(responses(), :q5, :)"""
sco(s, process=without_caption_label)
```

Ou, para colocar `q5` na segunda posição[^sudete]:

[^sudete]: obrigado ao Sudete pela sugestão no Discourse (<https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/4>).

```jl
s = "select(responses(), 1, :q5, :)"
sco(s, process=without_caption_label)
```

> **_OBSERVAÇÃO:_**
> Como você deve ter observado, existem várias maneiras de selecionar uma coluna.
> Estes são conhecidos como [_seletores de coluna_](https://bkamins.github.io/julialang/2021/02/06/colsel.html).
>
> Podemos usar:
>
> * `Symbol`: `select(df, :col)`
>
> * `String`: `select(df, "col")`
>
> * `Integer`: `select(df, 1)`

Até mesmo renomear colunas é possível via `select` usando a sintaxe de par `origem => destino`:

```jl
s = """select(responses(), 1 => "participant", :q1 => "age", :q2 => "nationality")"""
sco(s, process=without_caption_label)
```

Além disso, graças ao operador "splat" `...` (see @sec:splat), também podemos escrever:

```jl
s = """
    renames = (1 => "participant", :q1 => "age", :q2 => "nationality")
    select(responses(), renames...)
    """
sco(s, process=without_caption_label)
```

## Tipos e dados ausentes {#sec:missing_data}

```{=comment}
Try to combine with transformations

categorical
allowmissing
disallowmissing
```

As discussed in @sec:load_save, `CSV.jl` will do its best to guess what kind of types your data have as columns.
However, this won't always work perfectly.
In this section, we show why suitable types are important and we fix wrong data types.
To be more clear about the types, we show the text output for `DataFrame`s instead of a pretty-formatted table.
In this section, we work with the following dataset:

```jl
@sco process=string post=output_block wrong_types()
```

Because the date column has the wrong type, sorting won't work correctly:

```{=comment}
Whoa! You haven't introduced the reader to sorting with `sort` yet.
```

```jl
s = "sort(wrong_types(), :date)"
scsob(s)
```

To fix the sorting, we can use the `Date` module from Julia's standard library as described in @sec:dates:

```jl
@sco process=string post=output_block fix_date_column(wrong_types())
```

Now, sorting will work as intended:

```jl
s = """
    df = fix_date_column(wrong_types())
    sort(df, :date)
    """
scsob(s)
```

For the age column, we have a similar problem:

```jl
s = "sort(wrong_types(), :age)"
scsob(s)
```

This isn't right, because an infant is younger than adults and adolescents.
The solution for this issue and any sort of categorical data is to use `CategoricalArrays.jl`:

```
using CategoricalArrays
```

With the `CategoricalArrays.jl` package, we can add levels that represent the ordering of our categorical variable to our data:

```jl
@sco process=string post=output_block fix_age_column(wrong_types())
```

> **_NOTE:_**
> Also note that we are passing the argument `ordered=true` which tells `CategoricalArrays.jl`'s `categorical` function that our categorical data is "ordered".
> Without this any type of sorting or bigger/smaller comparissons would not be possible.

Now, we can sort the data correctly on the age column:

```jl
s = """
    df = fix_age_column(wrong_types())
    sort(df, :age)
    """
scsob(s)
```

Because we have defined convenient functions, we can now define our fixed data by just performing the function calls:

```jl
@sco process=string post=output_block correct_types()
```

Since age in our data is ordinal (`ordered=true`), we can properly compare categories of age:

```jl
s = """
    df = correct_types()
    a = df[1, :age]
    b = df[2, :age]
    a < b
    """
scob(s)
```

which would give wrong comparisons if the element type were strings:

```jl
s = "\"infant\" < \"adult\""
scob(s)
```
