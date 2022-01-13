## Desempenho {#sec:df_performance}

Até agora, não pensamos em fazer nosso código `DataFrames.jl` **rápido**.
Como tudo em Julia, `DataFrames.jl` pode ser bem veloz.
Nesta seção, daremos algumas dicas e truques de desempenho.

### Operações in-loco {#sec:df_performance_inplace}

Como explicamos em @sec:function_bang, funções que terminam com uma exclamação `!` são um padrão comum para denotar funções que modificam um ou mais de seus argumentos.
O contexto do código de alta performance em Julia, *significa* que **funções com `!` apenas mudarão no local os objetos que fornecemos como argumentos.

Quase todas as funções `DataFrames.jl` que vimos tem uma \"`!` gêmea\".
Por exemplo, `filter` tem um _in-loco_ `filter!`, `select` tem `select!`, `subset` tem `subset!`, e assim por diante.
Observe que essas funções **não** retornam um novo `DataFrame`, mas, ao invés vez disso, elas **atualizam** o `DataFrame` sobre o qual atuam.
Além disso, `DataFrames.jl` (versão 1.3 em diante) suporta in-loco `leftjoin` com a função `leftjoin!`.
Essa função atualiza o `DataFrame` esquerdo com as colunas unidas do `DataFrame` direito.
Há uma ressalva de que cada linha da tabela esquerda deve corresponder a *no máximo* uma linha da tabela direita.

Se você deseja a mais alta velocidade e desempenho em seu código, definitivamente deve usar as funções `!` ao invés das funções regulares de `DataFrames.jl`.

Vamos voltar para o exemplo da função `select` no começo de @sec:select.
Aqui está o `DataFrame` responses:

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

Aqui está a função _in-loco_:

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
Além do mais, a sintaxe `df.col` é a mesma que `df[!, :col]` com a exclamação `!` como a seletora de linha.

A segunda forma de acessar uma coluna `DataFrame` é a `df[:, :col]` com os dois pontos `:` como o seletor de linha.
Esse tipo de acesso **copia** a coluna `col`, portanto, tenha cuidado, pois isso pode produzir alocações indesejadas.

Como antes, vamos experimentar essas duas maneiras de acessar uma coluna no `DataFrame` responses:

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

Se você der uma olhada no output ajuda para `CSV.read`, você verá que existe uma função de conveniência idêntica à função chamada `CSV.File` com os mesmos argumentos de palavras-chave.
Ambos `CSV.read` e `CSV.File` vão ler o conteúdo de um arquivo CSV, mas eles se diferem no comportamento padrão.
**`CSV.read`, por padrão, não fará cópias** dos dados de entrada.
Ao invés disso, `CSV.read` irá passar todos os dados para o segundo argumento (conhecido como "sink").

Então, algo assim:

```julia
df = CSV.read("file.csv", DataFrame)
```

passará todos os dados recebidos de `file.csv` para o sink `DataFrame`, retornando assim um tipo `DataFrame` que vamos armazenar na variável `df`.

Para o caso do **`CSV.File`, o comportamento padrão é o oposto: ele fará cópias de todas as colunas contidas no arquivo CSV**.
Além disso, a sintaxe é um pouco diferente.
Precisamos embrulhar tudo que o `CSV.File` retorna em uma função construtora `DataFrame`:

```julia
df = DataFrame(CSV.File("file.csv"))
```

Ou, com o operador pipe `|>`:

```julia
df = CSV.File("file.csv") |> DataFrame
```

Como dissemos, `CSV.File` fará cópias de cada coluna no arquivo CSV subjacente.
Em última análise, se você quiser o máximo de desempenho, você definitivamente usaria `CSV.read` em vez de `CSV.File`.
É por isso que cobrimos apenas `CSV.read` em @sec:csv.

### Múltiplos Arquivos CSV.jl {#sec:df_performance_csv_multiple}

Agora vamos voltar nossa atenção para o `CSV.jl`.
Especificamente, o caso em que temos vários arquivos CSV para ler em um único `DataFrame`.
Desde a versão 0.9 do `CSV.jl` podemos fornecer um vetor de strings representando nomes de arquivos.
Antes, precisávamos realizar algum tipo de leitura de vários arquivos e, em seguida, concatenar verticalmente os resultados em um único `DataFrame`.
Para exemplificar, o código abaixo lê vários arquivos CSV e os concatena verticalmente usando `vcat` em um único `DataFrame` com a função `reduce`:

```julia
files = filter(endswith(".csv"), readdir())
df = reduce(vcat, CSV.read(file, DataFrame) for file in files)
```

Uma característica adicional é que `reduce` não será paralelizado porque precisa manter a ordem de `vcat` que segue a mesma ordem do vetor `files`.

Com esta funcionalidade em `CSV.jl` nós simplesmente passamos o vetor `files` para a função `CSV.read`:

```julia
files = filter(endswith(".csv"), readdir())
df = CSV.read(files, DataFrame)
```

`CSV.jl` designará um arquivo para cada thread disponível no computador enquanto ele concatena lentamente cada saída analisada por thread em um `DataFrame`.
Portanto, temos o **benefício adicional do multithreading** que não temos com a opção `reduce`.

### Compressão CategoricalArrays.jl {#sec:df_performance_categorical_compression}

Se você estiver lidando com dados com muitos valores categóricos, ou seja, muitas colunas com dados textuais que representam dados qualitativos de alguma forma diferentes, você provavelmente se beneficiaria usando a compressão `CategoricalArrays.jl`.

Por padrão, **`CategoricalArrays.jl` usará um inteiro sem sinal no tamanho de 32 bits `UInt32` para representar as categorias subjacentes**:

```jl
s = """
    typeof(categorical(["A", "B", "C"]))
    """
sco(s; process=string, post=plainblock)
```

Isso significa que `CategoricalArrays.jl` pode representar até $2^{32}$ categorias diferentes em um determinado vetor ou coluna, o que é um valor enorme (perto de 4,3 bilhões).
Você provavelmente nunca precisaria ter esse tipo de capacidade para lidar com dados regulares[^bigdata].
É por isso que `categorical` tem um argumento `compress` que aceita `true` ou `false` para determinar se os dados categóricos subjacentes são compactados ou não.
Se você passar **`compress=true`, `CategoricalArrays.jl` tentará compactar os dados categóricos subjacentes para a menor representação possível em `UInt`**.
Por exemplo, o vetor `categorical` anterior seria representado como um inteiro sem sinal de tamanho 8 bits `UInt8` (principalmente porque este é o menor inteiro sem sinal disponível em Julia):

[^bigdata]: observe também que dados regulares (até 10.000 linhas) não são big data (mais de 100.000 linhas). Portanto, se você estiver lidando principalmente com big data, tenha cuidado ao limitar seus valores categóricos.

```jl
s = """
    typeof(categorical(["A", "B", "C"]; compress=true))
    """
sco(s; process=string, post=plainblock)
```

O que tudo isso significa?
Suponha que você tenha um grande vetor.
Por exemplo, considere um vetor com um milhão de entradas, mas apenas 4 categorias subjacentes: A, B, C ou D.
Se você não compactar o vetor categórico resultante, você terá um milhão de entradas armazenadas como `UInt32`.
Por outro lado, se você compactar, você terá um milhão de entradas armazenadas como `UInt8`.
Usando a função `Base.summarysize` podemos obter o tamanho subjacente, em bytes, de um determinado objeto.
Então, vamos quantificar quanta memória mais precisaríamos ter se não comprimissemos nosso um milhão de vetores categóricos:

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

4 milhões de bytes, que é aproximadamente 3,8 MB.
Não nos entenda mal, esta é uma boa melhoria em relação ao tamanho da string bruta:

```jl
s = """
    Base.summarysize(one_mi_vec)
    """
sco(s; process=string, post=plainblock)
```

Reduzimos 50% do tamanho dos dados brutos usando uma representação subjacente padrão `CategoricalArrays.jl` como `UInt32`.

Agora vamos ver como nos sairíamos com a compressão:

```jl
s = """
    Base.summarysize(categorical(one_mi_vec; compress=true))
    """
sco(s; process=string, post=plainblock)
```

Reduzimos o tamanho para 25% (um quarto) do tamanho original do vetor não compactado sem perder informações.
Nosso vetor categórico compactado agora tem 1 milhão de bytes, que é aproximadamente 1,0 MB.

Portanto, sempre que possível, no interesse do desempenho, considere usar `compress=true` em seus dados categóricos.
