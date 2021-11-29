# DataFrames.jl {#sec:dataframes}

Os dados são fornecidos, geralmente, em formato tabular.
Por tabular, queremos dizer que os dados consistem em uma tabela que contém linhas e colunas.
As colunas normalmente contêm o mesmo tipo de dados, enquanto as linhas são de tipos diferentes.
As linhas, na prática, denotam observações enquanto as colunas indicam variáveis.
Por exemplo, podemos ter uma tabela de programas de TV contendo o país em que cada um foi produzido e nossa classificação pessoal, acesse @tbl:TV_shows.

```{=comment}
Vamos usar um exemplo diferente do resto do capítulo para tornar o texto um pouco mais interessante.
Poderíamos até mesmo pedir ao leitor que responda às perguntas descritas abaixo como exercícios.
```

```jl
tv_shows = DataFrame(
        name=["Game of Thrones", "The Crown", "Friends", "..."],
        country=["United States", "England", "United States", "..."],
        rating=[8.2, 7.3, 7.8, "..."]
    )
Options(tv_shows; label="TV_shows")
```

Aqui, as reticências significam que esta pode ser uma tabela muito longa e mostramos apenas algumas linhas.
Ao analisar dados, muitas vezes levantamos questões interessantes sobre eles.
Para tabelas grandes, os computadores são capazes de responder a  perguntas desse tipo muito mais rápido do que você faria manualmente.
Alguns exemplos de questões para os dados seriam:

- Qual programa de TV foi melhor classificado?
- Quais programas de TV foram produzidos nos Estados Unidos?
- Quais programas de TV foram produzidos no mesmo país?

Mas, como pesquisador, a ciência real muitas vezes começa com várias tabelas ou fontes de dados.
Por exemplo, se também tivéssemos dados das classificações de outra pessoa para os programas de TV (@tbl:ratings):

```jl
ratings = DataFrame(
    name=["Game of Thrones", "Friends", "..."],
    rating=[7, 6.4, "..."])
Options(ratings; label="ratings")
```

Agora, alguns questionamentos que poderíamos fazer:

- Qual é a avaliação média de Game of Thrones?
- Quem deu a classificação mais alta para Friends?
- Quais programas de TV foram avaliados por você, mas não pela outra pessoa?

Ao longo deste capítulo, mostraremos como você pode responder facilmente a essas perguntas em Julia.
Para fazer isso, primeiro mostramos porque precisamos de um pacote Julia chamado `DataFrames.jl`.
Nas próximas seções, mostramos como você pode usar este pacote e também, como escrever transformações de dados (@sec:df_performance).

Vejamos uma tabela de notas como a @tbl:grades_for_2020:

```jl
JDS.grades_for_2020()
```

Aqui, o nome da coluna tem um tipo `string`, idade tem um tipo `integer` e nota um tipo `float`.

Até agora, este livro tratou apenas do básico de Julia.
Esse básico é bom para muitas coisas, mas não para tabelas.
Para mostrar que precisamos de mais, vamos tentar armazenar os dados tabulares em arrays:

```jl
@sc JDS.grades_array()
```

Agora, os dados são armazenados na chamada forma de coluna principal, o que é complicado quando queremos obter dados de uma linha:

```jl
@sco JDS.second_row()
```

Ou, se você quiser ter a nota de Alice, primeiro você precisa descobrir em que linha Alice está:

```jl
scob("""
function row_alice()
    names = grades_array().name
    i = findfirst(names .== "Alice")
end
row_alice()
""")
```

e então podemos obter o valor:

```jl
scob("""
function value_alice()
    grades = grades_array().grade_2020
    i = row_alice()
    grades[i]
end
value_alice()
""")
```

`DataFrames.jl` resolve esses problemas facilmente.
Você pode começar carregando `DataFrames.jl` com `using`:

```
using DataFrames
```

Com `DataFrames.jl`, podemos definir uma `DataFrame` para armazenar nossos dados tabulares:

```jl
sco("""
names = ["Sally", "Bob", "Alice", "Hank"]
grades = [1, 5, 8.5, 4]
df = DataFrame(; name=names, grade_2020=grades)
without_caption_label(df) # hide
""")
```

o que nos dá uma variável `df` que contém nossos dados no formato de tabela.

> **_OBSERVAÇÃO:_**
> Isso funciona, mas há uma coisa que precisamos mudar imediatamente.
> Neste exemplo, definimos as variáveis `name`, `grade_2020` e `df` em escopo global.
> Isso significa que essas variáveis podem ser acessadas e editadas de qualquer lugar.
> Se continuássemos escrevendo o livro assim, teríamos algumas centenas de variáveis no final do livro, embora os dados que colocamos na variável `name` só podem ser acessados via `DataFrame`!
> As variáveis `name` e `grade_2020` não foram feitas para serem mantidas por muito tempo!
> Agora, imagine se mudássemos `grade_2020` algumas vezes nesse livro.
> Dado apenas o livro como PDF, seria quase impossível descobrir o conteúdo da variável ao final.
>
> Podemos resolver isso facilmente usando funções.

Vamos fazer a mesma coisa de antes, mas agora em uma função:

```jl
@sco grades_2020()
```

Note que `name` e `grade_2020` desaparecem depois que a função retorna, ou seja, só estão disponíveis na função.
Existem dois outros benefícios ao fazer isso.
Primeiro, agora está claro para o leitor onde `name` e `grade_2020` pertencem: eles pertencem as notas de 2020.
Em segundo lugar, é fácil determinar qual a saída de `grades_2020()` estaria em qualquer ponto do livro.
Por exemplo, agora podemos atribuir os dados a uma variável `df`:

```jl
sco("""
df = grades_2020()
"""; process=without_caption_label)
```

Mudar os conteúdos de `df`:

```jl
sco("""
df = DataFrame(name = ["Malice"], grade_2020 = ["10"])
"""; process=without_caption_label)
```

E ainda recuperar os dados originais de volta sem nenhum problema:

```jl
sco("""
df = grades_2020()
"""; process=without_caption_label)
```

Claro, pressupondo que a função não seja redefinida.
Prometemos não fazer isso neste livro, porque é uma má ideia exatamente por este motivo.
Ao invés de "mudarmos" a função, vamos fazer uma nova e daremos um nome claro.

Portanto, de volta ao construtor `DataFrames`.
Como você deve ter visto, a maneira de criar um é simplesmente passar vetores como argumentos para o construtor `DataFrame`.
Você pode criar qualquer vetor de Julia válido e ele funcionará **contanto que os vetores tenham o mesmo comprimento**.
Valores duplicados, símbolos Unicode e qualquer tipo de número são adequados:

```jl
sco("""
DataFrame(σ = ["a", "a", "a"], δ = [π, π/2, π/3])
"""; process=without_caption_label)
```

Normalmente, em seu código, você criaria uma função que envolve uma ou mais funções `DataFrame`s.
Por exemplo, podemos fazer uma função para obter as notas de um ou mais `names`:

```jl
@sco process=without_caption_label JDS.grades_2020([3, 4])
```

Esta forma de usar funções para envolver funcionalidades básicas em linguagens de programação e pacotes é bastante comum.
Basicamente, você pode pensar em Julia e `DataFrames.jl` como peças de Lego.
Eles fornecem peças muito **genéricas** que permitem que você crie coisas para seu uso **específico** como neste exemplo de notas.
Usando essas peças, você pode fazer um script de análise de dados, controlar um robô ou o que você quiser construir.

Até agora, os exemplos eram bastante complicados, porque tínhamos que usar índices.
Nas próximas seções, mostraremos como carregar e salvar dados, e muitas outras peças de Lego poderosas fornecidas por `DataFrames.jl`.
