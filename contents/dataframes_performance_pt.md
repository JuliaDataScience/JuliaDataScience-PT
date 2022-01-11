## Desempenho {#sec:df_performance}

Até agora, não pensamos em fazer nosso código `DataFrames.jl` **rápido**.
Como tudo em Julia, `DataFrames.jl` pode ser bem veloz.
Nesta seção, daremos algumas dicas e truques de desempenho.

### Operações in-loco {#sec:df_performance_inplace}

Como explicamos em @sec:function_bang, funções que terminam com um estrondo `!` são um padrão comum para denotar funções que modificam um ou mais de seus argumentos.
O contexto do código de alta performance em Julia, *significa* que **funções com `!` apenas mudarão no local os objetos que fornecemos como argumentos.

Quase todas as funções `DataFrames.jl` que vims tem uma \"`!` gêmea\".
Por exemplo, `filter` tem um _in-loco_ `filter!`, `select` tem `select!`, `subset` tem `subset!`, e assim por diante.
Observe que essas funções **não** retornam um novo `DataFrame`, mas, ao invés vez disso, elas **atualizam** o `DataFrame` sobre o qual atuam.
Além disso, `DataFrames.jl` (versão 1.3 em diante) suporta in-loco `leftjoin` com a função `leftjoin!`.
Essa função atualiza o `DataFrame` esquerdo com as colunas unidas do `DataFrame` direito.
Há uma ressalva de que cada linha da tabela esquerda deve corresponder a *no máximo* uma linha da tabela direita.

Se você deseja a mais alta velocidade e desempenho em seu código, definitivamente deve usar as funções `!` ao invés das funções regulares de `DataFrames.jl`.

Vamos voltar para o exemplo da função `select` no começo de @sec:select.
Aqui estão as respostas do `DataFrame`:

```jl
sco("responses()"; process=without_caption_label)
```

Agora vamos desempenhar a seleção com a função `select`, como fizemos antes:

```jl
s = """
    # allocating function # hide
    select(responses(), :id, :q1)
    """
sco(s, process=without_caption_label)
```

Aqui está a função _in loco_:

```jl
s = """
    # non allocarting function # hide
    select!(responses(), :id, :q1)
    """
sco(s; process=without_caption_label)
```

O macro `@allocated` nos diz quanta memória foi alocada.
Em outras palavras, **quanta informação nova o computador teve que armazenar em sua memória enquanto executava o código**.
Vamos ver qual será o desempenho:

```jl
s = """
    # allocation # hide
    df = responses()
    @allocated select(df, :id, :q1)
    """
sco(s; process=string, post=plainblock)
```

```jl
s = """
    # non allocation # hide
    df = responses()
    @allocated select!(df, :id, :q1)
    """
sco(s; process=string, post=plainblock)
```

Como pudemos ver, `select!` aloca menos que `select`.
Portanto, é mais rápido e consome menos memória.

### Copiar vs Não Copiar Colunas {#sec:df_performance_df_copy}

Existem **duas formas de acessar a coluna DataFrame**.
Elas diferem na forma como são acessadas: uma cria uma "visualização" para a coluna sem copiar e a outra cria uma coluna totalmente nova copiando a coluna original.

A primeira usa o operador dot regular `.` seguido pelo nome da coluna, como em `df.col`.
Essa forma de acesso **não copia** a coluna `col`.
Ao invés disso `df.col` cria uma "visualização" que é um link para a coluna original sem realizar nenhuma alocação.
Além do mais, a sintaxe `df.col` é a mesma que `df[!, :col]` com o estrondo `!` como o seletor de linha.

A segunda forma de acessar uma coluna `DataFrame` é a `df[:, :col]` com os dois pontos `:` como o seletor de linha.
Esse tipo de acesso **copia** a coluna `col`, portanto, tenha cuidado, pois isso pode produzir alocações indesejadas.

Como antes, vamos experimentar essas duas maneiras de acessar uma coluna nas respostas `DataFrame`:

```jl
s = """
    # allocation # hide
    df = responses()
    @allocated col = df[:, :id]
    """
sco(s; process=string, post=plainblock)
```


```jl
s = """
    # non allocation # hide
    df = responses()
    @allocated col = df[!, :id]
    """
sco(s; process=string, post=plainblock)
```

Quando acessamos uma coluna sem copiá-la estamos fazendo alocações zero e nosso código deve ser mais rápido.
Então, se você não precisa de uma cópia, sempre acesse suas colunas `DataFrame`s com `df.col` ou `df[!, :col]` ao invés de `df[:, :col]`.

### CSV.read versus CSV.File {#sec:df_performance_csv_read_file}

If you take a look at the help output for `CSV.read`, you will see that there is a convenience function identical to the function called `CSV.File` with the same keyword arguments.
Both `CSV.read` and `CSV.File` will read the contents of a CSV file, but they differ in the default behavior.
**`CSV.read`, by default, will not make copies** of the incoming data.
Instead, `CSV.read` will pass all the data to the second argument (known as the "sink").

So, something like this:

```julia
df = CSV.read("file.csv", DataFrame)
```

will pass all the incoming data from `file.csv` to the `DataFrame` sink, thus returning a `DataFrame` type that we store in the `df` variable.

For the case of **`CSV.File`, the default behavior is the opposite: it will make copies of every column contained in the CSV file**.
Also, the syntax is slightly different.
We need to wrap anything that `CSV.File` returns in a `DataFrame` constructor function:

```julia
df = DataFrame(CSV.File("file.csv"))
```

Or, with the pipe `|>` operator:

```julia
df = CSV.File("file.csv") |> DataFrame
```

Like we said, `CSV.File` will make copies of each column in the underlying CSV file.
Ultimately, if you want the most performance, you would definitely use `CSV.read` instead of `CSV.File`.
That's why we only covered `CSV.read` in @sec:csv.

### CSV.jl Multiple Files {#sec:df_performance_csv_multiple}

Now let's turn our attention to the `CSV.jl`.
Specifically, the case when we have multiple CSV files to read into a single `DataFrame`.
Since version 0.9 of `CSV.jl` we can provide a vector of strings representing filenames.
Before, we needed to perform some sort of multiple file reading and then concatenate vertically the results into a single `DataFrame`.
To exemplify, the code below reads from multiple CSV files and then concatenates them vertically using `vcat` into a single `DataFrame` with the `reduce` function:

```julia
files = filter(endswith(".csv"), readdir())
df = reduce(vcat, CSV.read(file, DataFrame) for file in files)
```

One additional trait is that `reduce` will not parallelize because it needs to keep the order of `vcat` which follows the same ordering of the `files` vector.

With this functionality in `CSV.jl` we simply pass the `files` vector into the `CSV.read` function:

```julia
files = filter(endswith(".csv"), readdir())
df = CSV.read(files, DataFrame)
```

`CSV.jl` will designate a file for each thread available in the computer while it lazily concatenates each thread-parsed output into a `DataFrame`.
So we have the **additional benefit of multithreading** that we don't have with the `reduce` option.

### CategoricalArrays.jl compression {#sec:df_performance_categorical_compression}

If you are handling data with a lot of categorical values, i.e. a lot of columns with textual data that represent somehow different qualitative data, you would probably benefit by using `CategoricalArrays.jl` compression.

By default, **`CategoricalArrays.jl` will use an unsigned integer of size 32 bits `UInt32` to represent the underlying categories**:

```jl
s = """
    typeof(categorical(["A", "B", "C"]))
    """
sco(s; process=string, post=plainblock)
```

This means that `CategoricalArrays.jl` can represent up to $2^{32}$ different categories in a given vector or column, which is a huge value (close to 4.3 billion).
You probably would never need to have this sort of capacity in dealing with regular data[^bigdata].
That's why `categorical` has a `compress` argument that accepts either `true` or `false` to determine whether or not the underlying categorical data is compressed.
If you pass **`compress=true`, `CategoricalArrays.jl` will try to compress the underlying categorical data to the smallest possible representation in `UInt`**.
For example, the previous `categorical` vector would be represented as an unsigned integer of size 8 bits `UInt8` (mostly because this is the smallest unsigned integer available in Julia):

[^bigdata]: also notice that regular data (up to 10 000 rows) is not big data (more than 100 000 rows). So, if you are dealing primarily with big data please exercise caution in capping your categorical values.

```jl
s = """
    typeof(categorical(["A", "B", "C"]; compress=true))
    """
sco(s; process=string, post=plainblock)
```

What does this all mean?
Suppose you have a big vector.
For example, a vector with one million entries, but only 4 underlying categories: A, B, C, or D.
If you do not compress the resulting categorical vector, you will have one million entries stored as `UInt32`.
On the other hand, if you do compress it, you will have one million entries stored instead as `UInt8`.
By using `Base.summarysize` function we can get the underlying size, in bytes, of a given object.
So let's quantify how much more memory we would need to have if we did not compress our one million categorical vector:

```julia
using Random
```

```jl
s = """
    one_mi_vec = rand(["A", "B", "C", "D"], 1_000_000)
    Base.summarysize(categorical(one_mi_vec))
    """
sco(s; process=string, post=plainblock)
```

4 million bytes, which is approximately 3.8 MB.
Don't get us wrong, this is a good improvement over the raw string size:

```jl
s = """
    Base.summarysize(one_mi_vec)
    """
sco(s; process=string, post=plainblock)
```

We reduced 50% of the raw data size by using the default `CategoricalArrays.jl` underlying representation as `UInt32`.

Now let's see how we would fare with compression:

```jl
s = """
    Base.summarysize(categorical(one_mi_vec; compress=true))
    """
sco(s; process=string, post=plainblock)
```

We reduced the size to 25% (one quarter) of the original uncompressed vector size without losing information.
Our compressed categorical vector now has 1 million bytes which is approximately 1.0 MB.

So whenever possible, in the interest of performance, consider using `compress=true` in your categorical data.
