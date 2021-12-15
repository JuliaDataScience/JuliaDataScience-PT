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

Okay, so no worries if you didn't get this description.
The result on the grades datasets looks like this:

```jl
s = "innerjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Note that only "Sally" and "Hank" are in both datasets.
The name _inner_ join makes sense since, in mathematics, the _set intersection_ is defined by "all elements in $A$, that are also in $B$, or all elements in $B$ that are also in $A$".

### outerjoin {#sec:outerjoin}

Maybe you're now thinking "aha, if we have an _inner_, then we probably also have an _outer_".
Yes, you've guessed right!

The **`outerjoin`** is much less strict than the `innerjoin` and just takes any row it can find which contains a name in **at least one of the datasets**:

```jl
s = "outerjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

So, this method can create `missing` data even though none of the original datasets had missing values.

### crossjoin {#sec:crossjoin}

We can get even more `missing` data if we use the **`crossjoin`**.
This gives the **Cartesian product of the rows**, which is basically multiplication of rows, that is, for every row create a combination with any other row:

```jl
s = "crossjoin(grades_2020(), grades_2021(); on=:id)"
sce(s; post=trim_last_n_lines(2))
```

Oops.
Since `crossjoin` doesn't take the elements in the row into account, we don't need to specify the `on` argument for what we want to join:

```jl
s = "crossjoin(grades_2020(), grades_2021())"
sce(s; post=trim_last_n_lines(6))
```

Oops again.
This is a very common error with `DataFrame`s and `join`s.
The tables for the 2020 and 2021 grades have a duplicate column name, namely `:name`.
Like before, the error that `DataFrames.jl` outputs shows a simple suggestion that might fix the issue.
We can just pass `makeunique=true` to solve this:

```jl
s = "crossjoin(grades_2020(), grades_2021(); makeunique=true)"
sco(s; process=without_caption_label)
```

So, now, we have one row for each grade from everyone in grades 2020 and grades 2021 datasets.
For direct queries, such as "who has the highest grade?", the Cartesian product is usually not so useful, but for "statistical" queries, it can be.

### leftjoin and rightjoin {#sec:leftjoin_rightjoin}

**More useful for scientific data projects are the `leftjoin` and `rightjoin`**.
The left join gives all the elements in the _left_ `DataFrame`:

```jl
s = "leftjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Here, grades for "Bob" and "Alice" were `missing` in the grades 2021 table, so that's why there are also `missing` elements.
The right join does sort of the opposite:

```jl
s = "rightjoin(grades_2020(), grades_2021(); on=:name)"
sco(s; process=without_caption_label)
```

Now, grades in 2020 are missing.

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
