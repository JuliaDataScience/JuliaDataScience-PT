## Transformações de Variáveis

```{=comment}
Precisamos cobrir `ifelse` e `case_when`
```

Em @sec:filter, vimos que `filter` funciona pegando uma ou mais colunas de origem e filtrando-as aplicando uma função de "filtragem".
Para recapitular, aqui está um exemplo de filtro usando a sintaxe `source => f::Function`: `filter(:name => name -> name == "Alice", df)`.

Em @sec:select, vimos que `select` pode pegar uma ou mais colunas de origem e colocá-las em uma ou mais colunas de destino `source => target`.
Também para recapitular aqui está um exemplo: `select(df, :name => :people_names)`.

Nesta seção, discutimos como **transformar** variáveis, é assim que consegumos **modificar dados**.
Em `DataFrames.jl`, a sintaxe é `source => transformation => target`.

Como antes, usamos o dataset `grades_2020`:

```jl
@sco process=without_caption_label grades_2020()
```

Suponha que queremos aumentar todas as notas em `grades_2020` por 1.
Primeiro, definimos uma função que leva como argumento um vetor de dados e retorna todos os seus elementos acrescidos de 1.
Depois usamos a função `transform` do `DataFrames.jl` que, como todas as funções nativas `DataFrames.jl`', pega o `DataFrame` como primeiro argumento seguido pela sintaxe de transformação:

```jl
s = """
    plus_one(grades) = grades .+ 1
    transform(grades_2020(), :grade_2020 => plus_one)
    """
sco(s; process=without_caption_label)
```

Aqui, a função `plus_one` recebe toda a coluna `:grade_2020`.
Essa é a razão pela qual adicionamos o broadcasting "dot" `.` antes do operador `+`.
Para uma recapitulação sobre broadcasting por favor veja @sec:broadcasting.

Como dissemos acima, a minilinguagem `DataFrames.jl` é sempre `source => transformation => target`.
Então, se quisermos manter a nomenclatura da coluna `target` no output podemos:

```jl
s = """
    transform(grades_2020(), :grade_2020 => plus_one => :grade_2020)
    """
sco(s; process=without_caption_label)
```

Também podemos usar o argumento de palavra-chave `renamecols=false`:

```jl
s = """
    transform(grades_2020(), :grade_2020 => plus_one; renamecols=false)
    """
sco(s; process=without_caption_label)
```

A mesma transformação também pode ser escrita com `select`:

```jl
s = """
    select(grades_2020(), :, :grade_2020 => plus_one => :grade_2020)
    """
sco(s; process=without_caption_label)
```

onde o `:` significa "selecione todas as colunas" como descrito em @sec:select.
Como alternativa, você também pode utilizar o broadcasting de Julia e modificar a coluna `grade_2020` acessando-a com `df.grade_2020`:

```jl
s = """
    df = grades_2020()
    df.grade_2020 = plus_one.(df.grade_2020)
    df
    """
sco(s; process=without_caption_label)
```

Mas, embora o último exemplo seja mais fácil, pois se baseia em operações nativas de Julia, **é altamente recomendável usar as funções fornecidas por `DataFrames.jl` na maioria dos casos porque são mais capazes e fáceis de trabalhar.**

### Transformações Múltiplas {#sec:multiple_transform}

Para mostrar como transformar duas colunas ao mesmo tempo, usamos os dados unidos à esquerda de @sec:join:

```jl
s = """
    leftjoined = leftjoin(grades_2020(), grades_2021(); on=:name)
    """
sco(s; process=without_caption_label)
```

Com isso, podemos adicionar uma coluna dizendo se alguém foi aprovado pelo critério de que todas as suas notas estivessem acima 5.5:

```jl
s = """
    pass(A, B) = [5.5 < a || 5.5 < b for (a, b) in zip(A, B)]
    transform(leftjoined, [:grade_2020, :grade_2021] => pass; renamecols=false)
    """
sco(s; process=without_caption_label)
```

```{=comment}
Eu não acredito que você cobriu o vetor de símbolos como seletor de coletor...
Você pode ter que fazer isso no `dataframes_select.md`
```

Podemos limpar o resultado e colocar a lógica em uma função para obter uma lista de todos os alunos aprovados:

```jl
@sco only_pass()
```
