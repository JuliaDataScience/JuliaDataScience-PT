## Join {#sec:join}

No início deste capítulo, mostramos várias tabelas e levantamos questões também relacionadas às várias tabelas.
No entanto, não falamos sobre a combinação de tabelas ainda, o que faremos nesta seção.
Em `DataFrames.jl`, a combinação de várias tabelas é feita via _joins_.
Os joins são extremamente poderosos, mas pode demorar um pouco para você entendê-los.
Não é necessário saber os joins abaixo de cor, porque a [documentação `DataFrames.jl`](https://DataFrames.juliadata.org/stable/man/joins/), juntamente com este livro, listará-los para você.
Mas, é essencial saber que os joins existem.
Se você alguma vez se pegar dando voltas sobre as linhas de um `DataFrame` e compará-lo com outros dados, então você provavelmente precisará de um dos joins abaixo.

No @sec:dataframes, introduzimos as notas para 2020 com `grades_2020`:

```jl
s = "grades_2020()"
sco(s; process=without_caption_label)
```

Agora, vamos combinar `grades_2020` com notas de 2021:

```jl
s = "grades_2021()"
sco(s; process=without_caption_label)
```

Para fazer isso, vamos os joins.
`DataFrames.jl` ista não menos que sete tipos de join.
Isso pode parecer assustador no início, mas espere porque todos eles são úteis e vamos mostrá-los.

### innerjoin {#sec:innerjoin}

O primeiro é **`innerjoin`**.
Suponha que temos dois datasets `A` e `B` com as respectivas colunas `A_1, A_2, ..., A_n` e `B_1, B_2, ..., B_m` **e** uma das colunas tem o mesmo nome, digamos `A_1` e `B_1` são ambas chamadas `:id`.
Então, o inner join em `:id` irá percorrer todos os elementos em `A_1` e compará-lo aos elementos em `B_1`.
Se os elementos são **os mesmos**, então ele irá adicionar todas as informações de `A_2, ..., A_n` e `B_2, ..., B_m` depois da coluna `:id`.

Ok, não se preocupe se você não conseguiu esta descrição.
O resultado das notas nos datasets será assim:

```jl
s = "innerjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Observe que apenas "Sally" e "Hank" estão em ambos datasets.
O nome _inner_ join az sentido, uma vez que, em matemática, o _set intersection_ é definido por "todos os elementos em $A$, que também estão em $B$, ou todos os elementos em $B$ que também estão em $A$".

### outerjoin {#sec:outerjoin}

Talvez você esteja pensando agora "se temos um _inner_, provavelmente também temos um _outer_".
Sim, você adivinhou certo!

O **`outerjoin`** é muito menos rigoroso do que o `innerjoin` e pega qualquer linha que encontrar que contenha um nome em **em pelo menos um dos datasets**:

```jl
s = "outerjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Portanto, este método pode criar dados `faltantes` mesmo que nenhum dos datasets originais tivesse valores ausentes.

### crossjoin {#sec:crossjoin}

Podemos obter ainda mais dados `faltantes` se usarmos o **`crossjoin`**.
Isso dá o **produto cartesiano das linhas**, que é basicamente a multiplicação de linhas, ou seja, para cada linha crie uma combinação com qualquer outra linha:

```jl
s = "crossjoin(grades_2020(), grades_2021(); on=:id)"
sce(s; post=trim_last_n_lines(2))
```

Ops!
Já que `crossjoin` não leva os elementos na linha em consideração, não precisamos especificar o argumento `on` para o que queremos juntar:

```jl
s = "crossjoin(grades_2020(), grades_2021())"
sce(s; post=trim_last_n_lines(6))
```

Ops de novo!
Esse é um erro bastante comum com `DataFrames` e `joins`.
As tabelas para as notas de 2020 e 2021 têm um nome de coluna duplicado, a saber `:name`.
Como antes, o erro de saída de `DataFrames.jl` mostra uma sugestão simples que pode corrigir o problema.
Podemos apenas passar `makeunique=true` para resolver isso:

```jl
s = "crossjoin(grades_2020(), grades_2021(); makeunique=true)"
sco(s; process=without_caption_label)
```

Então, agora, temos uma linha para cada nota de todos os datasets das séries 2020 e 2021.
Para consultas diretas, como "quem tem a nota mais alta?", o produto cartesiano geralmente não é tão útil, mas para consultas "estatísticas", pode ser.

### leftjoin e rightjoin {#sec:leftjoin_rightjoin}

**Mais úteis para projetos de dados científicos são os `leftjoin` e `rightjoin`**.
A join a esquerda fornece todos os elementos à _esquerda_ do `DataFrame`:

```jl
s = "leftjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Aqui, as notas para "Bob" e "Alice" estavam faltando na tabela de notas de 2021, então é por isso que também existem elementos `faltantes`.
A join a direita faz quase que o oposto:

```jl
s = "rightjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Agora, as notas de 2020 estão faltando.

Note that **`leftjoin(A, B) != rightjoin(B, A)`**, because the order of the columns will differ.
For example, compare the output below to the previous output:

```jl
s = "leftjoin(grades_2021(), grades_2020(); on=:name)"
sco(s; process=without_caption_label)
```

### semijoin and antijoin {#sec:semijoin_antijoin}

Lastly, we have the **`semijoin`** and **`antijoin`**.

The semi join is even more restrictive than the inner join.
It returns **only the elements from the left `DataFrame` which are in both `DataFrame`s**.
This is like a combination of the left join with the inner join.

```jl
s = "semijoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

The opposite of the semi join is the anti join.
It returns **only the elements from the left `DataFrame` which are *not* in the right `DataFrame`**:

```jl
s = "antijoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```
