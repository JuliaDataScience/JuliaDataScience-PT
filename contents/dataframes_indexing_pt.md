## Indexação e sumarização

Vamos voltar para o exemplo dos dados `grades_2020()` definidos antes:

```jl
sco("grades_2020()"; process=without_caption_label)
```

Para recuperar um **vetor** para `name`, podemos acessar o `DataFrame` com o `.`, como fizemos anteriormente com `struct`s em @sec:julia_basics:

```jl
@sco JDS.names_grades1()
```

ou podemos indexar um `DataFrame` de modo muito parecido com uma `Array` utilizando símbolos e caracteres especiais.
O **segundo índice é a indexação da coluna**:

```jl
@sco JDS.names_grades2()
```

Perceba que `df.name` é exatamente o mesmo que o comando `df[!, :name]`, o que você pode verificar fazendo:

```
julia> df = DataFrame(id=[1]);

julia> @edit df.name
```

Em ambos os casos, ele dará a coluna `:name`.
Também existe o comando `df[:, :name]` que copia a coluna `:name`.
Na maioria dos casos, `df[!, :name]` é a melhor aposta, pois é mais versátil e faz uma modificação no local.

Para qualquer **linha**, digamos a segunda linha, podemos usar o **primeiro índice como indexação de linha**:

```jl
s = """
    df = grades_2020()
    df[2, :]
    df = DataFrame(df[2, :]) # hide
    """
sco(s; process=without_caption_label)
```

ou criar uma função para nos dar qualquer linha `i` que quisermos:

```jl
@sco process=without_caption_label JDS.grade_2020(2)
```

Podemos também obter apenas a coluna `names` para as 2 primeiras linhas usando **fatiamento** (novamente, de modo similar a um `Array`):

```jl
@sco JDS.grades_indexing(grades_2020())
```

Se assumirmos que todos os nomes na tabela são únicos, também podemos escrever uma função para obter a nota de uma pessoa por meio de seu `name`.
Para fazer isso, convertemos a tabela de volta para uma das estruturas de dados básicas de Julia (veja @sec:data_structures) que é capaz de criar mapeamentos, a saber `Dict`s:

```jl
@sco post=output_block grade_2020("Bob")
```

que funciona porque `zip` faz itera por `df.name` e `df.grade_2020` ao mesmo tempo como um "zipper":

```jl
sco("""
df = grades_2020()
collect(zip(df.name, df.grade_2020))
""")
```

Entretanto, converter um `DataFrame` para `Dict` só é útil quando os elementos são únicos.
Geralmente esse não é o caso e é por isso que precisamos aprender como `filter` (filtrar) um `DataFrame`.

## Filtro e Subconjunto {#sec:filter_subset}

Existem duas maneiras de remover linhas de um `DataFrame`, uma é `filter` (@sec:filter) e outra é `subset` (@sec:subset).
`filter` foi adicionado à biblioteca `DataFrames.jl` anteriormente, é mais poderoso e também tem uma sintaxe mais coerente em relação às bibliotecas básicas de Julia. É por isso que vamos iniciar essa seção discutindo `filter` primeiro.
`subset` é mais recente e, comumente, é mais conveniente de usar.

### Filter {#sec:filter}

A partir de agora, nós começaremos a adentrar funcionalidades mais robustas da biblioteca `DataFrames.jl`.
Para fazer isso, precisaremos aprender sobre algumas funções, como `select` e `filter`.
Mas não se preocupe!
Pode ser um alívio saber que o **objetivo geral do design de `DataFrames.jl` é manter o número de funções que um usuário deve aprender em um mínimo[^verbos]**.

[^verbos]: De acordo com Bogumił Kamiński (desenvolvedor e mantenedor líder do `DataFrames.jl`) no Discourse (<https://discourse.julialang.org/t/pull-dataframes-columns-to-the-front/60327/5>).

Como antes, retomamos a partir de `grades_2020`:

```jl
sco("grades_2020()"; process=without_caption_label)
```

Podemos filtrar linhas usando `filter(source => f::Function, df)`.
Perceba como essa função é similar à função `filter(f::Function, V::Vector)` do módulo `Base` de Julia.
Isso ocorre porque `DataFrames.jl` usa **múltiplos despachos** (see @sec:multiple_dispatch) para definir um novo método de `filter` que aceita `DataFrame` como argumento.

À primeira vista, definir e trabalhar com uma função `f` para filtrar pode ser um pouco difícil de se usar na prática.
Aguente firme, esse esforço é bem pago, uma vez que **é uma forma muito poderosa de filtrar dados**.
Como um exemplo simples, podemos criar uma função `equals_alice` que verifica se sua entrada é igual "Alice":

```jl
@sco post=output_block JDS.equals_alice("Bob")
```

```jl
sco("equals_alice(\"Alice\")"; post=output_block)
```

Equipados com essa função, podemos usá-la como nossa função `f` para filtrar todas as linhas para as quais `name` equivale a "Alice":

```jl
s = "filter(:name => equals_alice, grades_2020())"
sco(s; process=without_caption_label)
```

Observe que isso não funciona apenas para `DataFrame`, mas também para vetores:

```jl
s = """filter(equals_alice, ["Alice", "Bob", "Dave"])"""
sco(s)
```

Podemos torná-lo um pouco menos prolixo usando uma **função anônima** (see @sec:function_anonymous):

```jl
s = """filter(n -> n == "Alice", ["Alice", "Bob", "Dave"])"""
sco(s)
```

que também podemos usar em `grades_2020`:

```jl
s = """filter(:name => n -> n == "Alice", grades_2020())"""
sco(s; process=without_caption_label)
```

Recapitulando, esta chamada de função pode ser lida como "para cada elemento na linha `:name`, vamos chamar o elemento `n`, e checar se `n` se iguala a Alice".
Para algumas pessoas, isso ainda é muito prolixo.
Por sorte, Julia adicionou uma _aplicação de função parcial_ de `==`.
Os detalhes não são importantes -- apenas saiba que você pode usá-la como qualquer outra função:

```jl
sco("""
s = "This is here to workaround a bug in books" # hide
filter(:name => ==("Alice"), grades_2020())
"""; process=without_caption_label)
```

Para obter todas as linhas que *não* são Alice, `==` (igualdade) pode ser substituído por `!=` (desigualdade) em todos os exemplos anteriores:

```jl
s = """filter(:name => !=("Alice"), grades_2020())"""
sco(s; process=without_caption_label)
```

Agora, para mostrar **porque funções anônimas são tão poderosas**, podemos criar um filtro um pouco mais complexo.
Neste filtro, queremos as pessoas cujos nomes comecem com A ou B **e** tenham uma nota acima de 6:

```jl
s = """
    function complex_filter(name, grade)::Bool
        interesting_name = startswith(name, 'A') || startswith(name, 'B')
        interesting_grade = 6 < grade
        interesting_name && interesting_grade
    end
    """
sc(s)
```

```jl
s = "filter([:name, :grade_2020] => complex_filter, grades_2020())"
sco(s; process=without_caption_label)
```

### Subset {#sec:subset}

The `subset` function was added to make it easier to work with missing values (@sec:missing_data).
In contrast to `filter`, `subset` works on complete columns instead of rows or single values.
If we want to use our earlier defined functions, we should wrap it inside `ByRow`:

```jl
s = "subset(grades_2020(), :name => ByRow(equals_alice))"
sco(s; process=without_caption_label)
```

Also note that the `DataFrame` is now the first argument `subset(df, args...)`, whereas in `filter` it was the second one `filter(f, df)`.
The reason for this is that Julia defines filter as `filter(f, V::Vector)` and `DataFrames.jl` chose to maintain consistency with existing Julia functions that were extended to `DataFrame`s types by multiple dispatch.

> **_NOTE:_**
> Most of native `DataFrames.jl` functions, which `subset` belongs to, have a **consistent function signature that always takes a `DataFrame` as first argument**.

Just like with `filter`, we can also use anonymous functions inside `subset`:

```jl
s = "subset(grades_2020(), :name => ByRow(name -> name == \"Alice\"))"
sco(s; process=without_caption_label)
```

Or, the partial function application for `==`:

```jl
s = "subset(grades_2020(), :name => ByRow(==(\"Alice\")))"
sco(s; process=without_caption_label)
```

Ultimately, let's show the real power of `subset`.
First, we create a dataset with some missing values:

```jl
@sco salaries()
```

This data is about a plausible situation where you want to figure out your colleagues' salaries, and haven't figured it out for Zed yet.
Even though we don't want to encourage these practices, we suspect it is an interesting example.
Suppose we want to know who earns more than 2000.
If we use `filter`, without taking the `missing` values into account, it will fail:

```jl
s = "filter(:salary => >(2_000), salaries())"
sce(s, post=trim_last_n_lines(25))
```

`subset` will also fail, but it will fortunately point us towards an easy solution:

```jl
s = "subset(salaries(), :salary => ByRow(>(2_000)))"
sce(s, post=trim_last_n_lines(25))
```

So, we just need to pass the keyword argument `skipmissing=true`:

```jl
s = "subset(salaries(), :salary => ByRow(>(2_000)); skipmissing=true)"
sco(s; process=without_caption_label)
```

```{=comment}
Rik, we need a example of both filter and subset with multiple conditions, as in:

`filter(row -> row.col1 >= something1 && row.col2 <= something2, df)`

and:

`subset(df, :col1 => ByRow(>=(something1)), :col2 => ByRow(<=(something2)>))
```
