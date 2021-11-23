# Julia Basics {#sec:julia_basics}

> **_NOTE:_**
> Neste capítulo, descreveremos o básico de Julia como linguagem de programação.
> Por favor, note que isso não é *estritamente necessário* para você usar Julia como uma ferramenta de manipulação e visualização de dados.
> Ter um conhecimento básico de Julia definitivamente o tornará mais *eficaz* e *eficiente* no uso de Julia.
> No entanto, se você preferir começar imediatamente, pode pular para @sec:dataframes e aprenda sobre dados tabulares em `DataFrames.jl`.

Aqui, vamos trazer uma visão mais geral sobre a linguagem de Julia, *não* algo aprofundado.
Se você já está familiarizado e confortável com outras linguagens de programação, nós encorajamos você a ler a documentação de Julia (<https://docs.julialang.org/>).
Os documentos são um excelente recurso para você se aprofundar em Julia.
Eles cobrem todos os fundamentos e casos extremos, mas podem ser complicados, especialmente se você não estiver familiarizado com a documentação do software.

Cobriremos o básico de Julia.
Imagine que Julia é um carro sofisticado repleto de recursos, como um Tesla novo.
Vamos apenas explicar a você como "dirigir o carro, estacioná-lo e como navegar no trânsito".
Se você quer saber o que "todos os botões no volante e painel fazem", este não é o livro que você está procurando.

## Sintaxe da linguagem {#sec:syntax}

Julia é uma **linguagem de tipo-dinâmico** com um compilador just-in-time.
Isso significa que você não precisa compilar seu programa antes de executá-lo, como precisaria fazer com C++ ou FORTRAN.
Em vez disso, Julia pegará seu código, adivinhará os tipos quando necessário e compilará partes do código antes de executá-lo.
Além disso, você não precisa especificar explicitamente cada tipo.
Julia vai supor os tipos para você.

As principais diferenças entre Julia e outras linguagens dinâmicas como R e Python são:
Primeiro, Julia **permite ao usuário especificar declarações de tipo**.
Você já viu algumas declarações de tipo em *Por que Julia?* (@sec:why_julia): eles são aqueles dois pontos duplos `::` que às vezes vem depois das variáveis.
No entanto, se você não quiser especificar o tipo de suas variáveis ou funções, Julia terá o prazer de inferir (adivinhar) para você.

Em segundo lugar, Julia permite que os usuários definam o comportamento da função em muitas combinações de tipos de argumento por meio de múltiplos despachos.
Também falamos sobre despachos múltiplos em @sec:julia_accomplish.
Definimos um comportamento de tipo diferente, definindo novas assinaturas de função para tipos de argumento enquanto usamos o mesmo nome de função.

### Variáveis {#sec:variable}

As variáveis são valores que você diz ao computador para armazenar com um nome específico, para que você possa recuperar ou alterar seu valor posteriormente.
Julia tem diversos tipos de variáveis, mas, em ciência de dados, usamos principalmente:

* Números inteiros: `Int64`
* Números reais: `Float64`
* Booleana: `Bool`
* Strings: `String`

Inteiros e números reais são armazenados usando 64 bits por padrão, é por isso que eles têm o sufixo `64` no nome do tipo.
Se você precisar de mais ou menos precisão, existem os tipos `Int8` ou `Int128`, por exemplo, onde maior significa mais precisão.
Na maioria das vezes, isso não será um problema, então você pode simplesmente seguir os padrões.

Criamos novas variáveis escrevendo o nome da variável à esquerda e seu valor à direita, e no meio usamos o `=` operador de atribuição.
Por exemplo:

```jl
s = """
    name = "Julia"
    age = 9
    """
scob(s)
```

Observe que a saída de retorno da última instrução (`idade`) foi impresso no console.
Aqui, estamos definindo duas novas variáveis: `nome` e `idade`.
Podemos recuperar seus valores digitando os nomes dados na atribuição:

```jl
scob("name")
```

Se quiser definir novos valores para uma variável existente, você pode repetir as etapas da atribuição.
Observe que Julia agora substituirá o valor anterior pelo novo.
Suponho que o aniversário de Julia já passou e agora fez 10 anos:

```jl
scob("age = 10")
```

Podemos fazer o mesmo com `name`. Suponha que Julia tenha ganho alguns títulos devido à sua velocidade incrível.
Mudaríamos a variável `name` para o novo valor:

```jl
s = """
    name = "Julia Rapidus"
    """
scob(s)
```

Também podemos fazer operações em variáveis como adição ou divisão.
Vamos ver quantos anos Julia tem, em meses, multiplicando `age` por 12:

```jl
s = "12 * age"
scob(s)
```
Podemos inspecionar os tipos de variáveis usando a função `typeof`:

```jl
sco("typeof(age)")
```

A próxima pergunta então se torna:
"O que mais posso fazer com os inteiros?"
Há uma função boa e útil, `methodswith` que expõe todas as funções disponíveis, junto com sua assinatura, para um certo tipo.
Aqui, vamos restringir a saída às primeiras 5 linhas:

```jl
s = """
    first(methodswith(Int64), 5)
    """
sco(s; process=catch_show)
```

### Tipos definidos pelo usuário {#sec:struct}

Ter variáveis sem qualquer tipo de hierarquia ou relacionamento não é ideal.
Em Julia, podemos definir esse tipo de dado estruturado com um `struct` (também conhecido como tipo composto).
Dentro de cada `struct`, você pode especificar um conjunto de campos `field`s.
Eles diferem dos tipos primitivos (por exemplo, inteiro e flutuantes) que já são definidos por padrão dentro do núcleo da linguagem Julia.
Já que a maioria dos `struct` são definidos pelo usuário, eles são conhecidos como tipos definidos pelo usuário.

Por exemplo, vamos criar um `struct` para representar linguagens de programação científica em código aberto.
Também definiremos um conjunto de campos junto com os tipos correspondentes dentro do `struct`:

```jl
s = """
    struct Language
        name::String
        title::String
        year_of_birth::Int64
        fast::Bool
    end
    """
sco(s; post=x -> "")
```

Para inspecionar os nomes dos campos, você pode usar o `fieldnames` e passar o `struct` desejado como argumento:

```jl
sco("fieldnames(Language)")
```

Para usar os `struct`, devemos instanciar instâncias individuais (ou "objetos"), cada um com seus próprios valores específicos para os campos definidos dentro do `struct`.
Vamos instanciar duas instâncias, uma para Julia e outra para Python:

```jl
s = """
    julia = Language("Julia", "Rapidus", 2012, true)
    python = Language("Python", "Letargicus", 1991, false)
    """
sco(s)
```

Algo importante de se notar com os `struct` é que não podemos alterar seus valores, uma vez que são instanciados.
Podemos resolver isso com `mutable struct`.
Além disso, observe que objetos mutáveis geralmente serão mais lentos e mais propensos a erros.
Sempre que possível, faça que tudo seja *imutável*.
Vamos criar uma `mutable struct`.

```jl
s = """
    mutable struct MutableLanguage
        name::String
        title::String
        year_of_birth::Int64
        fast::Bool
    end

    julia_mutable = MutableLanguage("Julia", "Rapidus", 2012, true)
    """
sco(s)
```

Suponha que queremos mudar o título `julia_mutable`.
Agora podemos fazer isso já que `julia_mutable` é um `mutable struct` instanciado:

```jl
s = """
    julia_mutable.title = "Python Obliteratus"

    julia_mutable
    """
sco(s)
```

### Operadores booleanos e comparações numéricas

Agora que cobrimos os tipos, podemos passar para os operadores booleanos e a comparação numérica.

Nós temos três operadores booleanos em Julia:

* `!`: **NOT**
* `&&`: **AND**
* `||`: **OR**

Aqui estão exemplos com alguns deles:

```jl
scob("!true")
```

```jl
scob("(false && true) || (!false)")
```

```jl
scob("(6 isa Int64) && (6 isa Real)")
```

Com relação à comparação numérica, Julia tem três tipos principais de comparações:

1. **Igualdade**: ou algo é *igual* ou *não igual* em relação a outro
    * == "igual"
    * != ou ≠ "não igual"
1. **Menos que**: ou algo é *menos que* ou *menos que ou igual a*
    * <  "menos que"
    * <= ou ≤ "menos que ou igual a"
1. **Maior que**: ou algo é *maior que* ou *maior que ou igual a*
    * \> "maior que"
    * \>= ou ≥ "maior que ou igual a"

Aqui temos alguns exemplos:

```jl
scob("1 == 1")
```

```jl
scob("1 >= 10")
```

Equilibra os trabalhos entre diferentes tipos:

```jl
scob("1 == 1.0")
```

Também podemos misturar e combinar operadores booleanos com comparações numéricas:

```jl
scob("(1 != 10) || (3.14 <= 2.71)")
```

### Funções {#sec:function}

Agora que já sabemos como definir variáveis e tipos personalizados como `struct`, vamps voltar nossa atenção para as **funções**.
Em Julia, a função **mapeia os valores do argumento para um ou mais valores de retorno**.
A sintaxe básica é assim:

```julia
function function_name(arg1, arg2)
    result = stuff with the arg1 and arg2
    return result
end
```

A declaração da função começa com a palavra-chave `function` seguida do nome da função.
Então, entre parênteses `()`, nós definimos os argumentos separados por uma vírgula `,`.
Dentro da função, especificamos o que queremos que Julia faça com os parâmetros que fornecemos.
Todas as variáveis que definimos dentro de uma função são excluídas após o retorno da função. Isso é bom porque é como se realizasse uma limpeza automática.
Depois que todas as operações no corpo da função forem concluídas, instruímos Julia a retornar o resultado com a palavra-chave `return`.
Por fim, informamos a Julia que a definição da função terminou com a palavra-chave `end`.

Existe também o compacto **formulário de atribuição**:

```julia
f_name(arg1, arg2) = stuff with the arg1 and arg2
```

É a **mesma função** que antes, mas com um formulário diferente, mais compacto.
Como regra geral, quando seu código pode caber facilmente em uma linha de até 92 caracteres, a forma compacta é adequada.
Caso contrário, basta usar o formulário mais longo com a palavra-chave `function`.
Vamos mergulhar em alguns exemplos.

#### Criando novas funções {#sec:function_example}

Vamos criar uma nova função que adiciona números:

```jl
s = """
    function add_numbers(x, y)
        return x + y
    end
    """
sco(s)
```

Agora, podemos usar nossa função `add_numbers`:

```jl
scob("add_numbers(17, 29)")
```

And it works also with floats:

```jl
scob("add_numbers(3.14, 2.72)")
```

Além disso, podemos definir o comportamento personalizado, especificando declarações de tipo.
Suponha que queremos ter uma função `round_number` que se comporta de maneira diferente se seu argumento for um `Float64` ou `Int64`:

```jl
s = """
    function round_number(x::Float64)
        return round(x)
    end

    function round_number(x::Int64)
        return x
    end
    """
sco(s)
```

Podemos ver que é uma função com múltiplos métodos:

```jl
sco("methods(round_number)")
```

Existe um problema: o que acontece se quisermos arredondar um float de 32 bits, `Float32`?
Ou um inteiro de 8 bits, `Int8`?

Se você quiser que algo funcione em todos os tipos de float e inteiros, voc~e pode usar um **tipo abstrato** como a assinatura de tipo `AbstractFloat` ou `Integer`:

```jl
s = """
    function round_number(x::AbstractFloat)
        return round(x)
    end
    """
sco(s)
```

Agora, funcionará como esperado em qualquer tipo de float:

```jl
s = """
    x_32 = Float32(1.1)
    round_number(x_32)
    """
scob(s)
```

> **_NOTE:_**
> Podemos inspecionar tipos com as funções `supertypes` e `subtypes`.

Vamos voltar ao nosso `Language` `struct` que definimos anteriormente.
Isso é um exemplode despacho múltiplo.
Vamos estender a função `Base.show` que imprime a saída de tipos instanciados e de `struct`.

Por padrão, uma `struct` tem um output básico, que você pode observar do caso de `python`.
Podemos definir um nove método `Base.show` para nosso tipo `Language`, assim temos uma boa impressão para nossas instâncias de linguagens de programação.
Queremos comunicar claramente os nomes, títulos e idades em anos das linguagens de programação.
A função `Base.show` aceita como argumentos um tipo `IO` chamado `io` seguido pelo tipo que você deseja para definir o comportamento personalizado:

```jl
s = """
    Base.show(io::IO, l::Language) = print(
        io, l.name, " ",
        2021 - l.year_of_birth, ", years old, ",
        "has the following titles: ", l.title
    )
    """
sco(s; post=x -> "")
```

Agora, vamos ver como o output de `python` será:

```jl
sco("python")
```

#### Valores de Retorno Múltiplo {#sec:function_multiple}

Uma função também pode retornar dois ou mais valores.
Veja a nova função `add_multiply` abaixo:

```jl
s = """
    function add_multiply(x, y)
        addition = x + y
        multiplication = x * y
        return addition, multiplication
    end
    """
sco(s)
```

Nesse caso, podemos fazer duas coisas:

1. Podemos, analogamente aos valores de retorno, definir duas variáveis para conter os valores de retorno da função, uma para cada valor de retorno:

   ```jl
   s = """
       return_1, return_2 = add_multiply(1, 2)
       return_2
       """
   scob(s)
   ```

2. Ou podemos definir apenas uma variável para manter os valores de retorno da função e acessá-los com `first` ou `last`:

   ```jl
   s = """
       all_returns = add_multiply(1, 2)
       last(all_returns)
       """
   scob(s)
   ```

#### Argumentos de Palavra-Chave {#sec:function_keyword_arguments}

Algumas funções podem aceitar argumentos de palavra-chave ao invés de argumentos posicionais.
Esses argumentos são como argumentos regulares, exceto por eles serem definidos após os argumentos da função regular e separados por um ponto e vírgula `;`.
Por exemplo, vamos definir uma função `logarithm` que por padrão usa base $e$ (2.718281828459045) como um argumento de palavra-chave.
Perceba que aqui, estamos usando o tipo abstrato `Real` para que possamos cobrir todos os tipos derivados de `Integer` e `AbstractFloat`, sendo ambos subtipos de `Real`:

```jl
scob("AbstractFloat <: Real && Integer <: Real")
```

```jl
s = """
    function logarithm(x::Real; base::Real=2.7182818284590)
        return log(base, x)
    end
    """
sco(s)
```

Funciona sem especificar o argumento `base` já que fornecemos um **valor de argumento padrão** na declaração da função:

```jl
scob("logarithm(10)")
```

E também com o argumento de palavra-chave `base` diferente de seu valor padrão:

```jl
s = """
    logarithm(10; base=2)
    """
scob(s)
```

#### Funções anônimas {#sec:function_anonymous}

Muitas vezes não nos importamos com o nome da função e queremos rapidamente criar um.
O que precisamos são das **funções anônimas**.
Elas são muito usadas no fluxo de trabalho de ciência de dados em Julia.
Por exemplo, quando usamos `DataFrames.jl` (@sec:dataframes) ou `Makie.jl` (@sec:DataVisualizationMakie), às vezes precisamos de uma função temporária para filtrar dados ou formatar rótulos de plotagem.
É aí que usamos as funções anônimas.
Elas são especialmente úteis quando não queremos criar uma função e uma instrução simples seria o suficiente.

A sintaxe é simples.
Nós usamos o operador `->`.
À esquerda do `->` definimos o nome do parâmetro.
E à direita do `->` definimos quais operações queremos realizar no parâmetro que definimos à esquerda de `->`.
Segue um exemplo.
Suponha que queremos desfazer a transformação de log usando uma exponenciação:

```jl
scob("map(x -> 2.7182818284590^x, logarithm(2))")
```

Aqui, estamos usando a função `map` para mapear convenientemente a função anônima (primeiro argumento) para `logarithm(2)` (segundo argumento).
Como resultado, obtemos o mesmo número, porque o logaritmo e a exponenciação são inversos (pelo menos na base que escolhemos -- 2.7182818284590)

### Condicional If-Else-Elseif {#sec:conditionals}

Na maioria das linguagens de programação, o usuário tem permissão para controlar o fluxo de execução do computador.
Dependendo da situação, queremos que o computador faça uma coisa ou outra.
Em Julia, podemos controlar o fluxo de execução com as palavras-chave `if`, `elseif` e `else`.
Estas são conhecidas como declarações condicionais.

A palavra-chave `if` comanda Julia a avaliar uma expressão e, dependendo se é `true` ou `false`, executa certas partes do código.
Podemos combinar várias condições `if` com a palavra-chave `elseif` para um fluxo de controle complexo.
Assim, podemos definir uma parte alternativa a ser executada se qualquer coisa dentro de `if` ou` elseif` for avaliada como `true`.
Esse é o propósito da palavra-chave `else`.
Finalmente, como em todos os operadores de palavra-chave anteriores que vimos, devemos informar a Julia quando a declaração condicional for concluída com a palavra-chave `end`.

Aqui, temos um exemplo com todas as palavras-chave `if`-`elseif`-`else`:

```jl
s = """
    a = 1
    b = 2

    if a < b
        "a is less than b"
    elseif a > b
        "a is greater than b"
    else
        "a is equal to b"
    end
    """
scob(s)
```

Podemos até incluir isso em uma função chamada `compare`:

```jl
s = """
    function compare(a, b)
        if a < b
            "a is less than b"
        elseif a > b
            "a is greater than b"
        else
            "a is equal to b"
        end
    end

    compare(3.14, 3.14)
    """
sco(s)
```


### Loop For {#sec:for}

O clássico loop for em Julia segue uma sintaxe semelhante à das declarações condicionais.
Você começa com a palavra-chave, nessa caso `for`.
Em seguida, você especifica o que Julia deve "loop", ou seja, uma sequência.
Além disso, como em tudo mais, você deve terminar com a palavra-chave `end`.

Então, para fazer Julia imprimir todos os números de 1 a 10, você pode usar o seguinte loop for:

```jl
s = """
    for i in 1:10
        println(i)
    end
    """
sco(s; post=x -> "")
```

### Loop While {#sec:while}

O loop while é uma mistura das declarações condicionais anteriores e os loops for.
Aqui, o loop é executado toda vez que a condicional é `true`.
A sintaxe segue a mesma forma da anterior.
Começamos com a palavra-chave `while`, seguido por uma declaração que avalia se é `true` ou `false`.
Como de costume, devemos terminar com a palavra-chave `end`.

Segue um exemplo:

```jl
s = """
    n = 0

    while n < 3
        global n += 1
    end

    n
    """
scob(s)
```

Como pode ver, devemos usar a palavra-chave `global`.
Isso se deve ao **escopo variável**.
Variáveis definidas dentro das declarações condicionais, loops e funções existem apenas dentro delas.
Isso é conhecido como o *escopo* da variável.
Aqui, precisamos avisar Julia que o `n` dentro do loop `while` está no escopo global junto com a palavra-chave `global`.

Por fim, também usamos o operador `+=` que é uma boa abreviatura para `n = n + 1`.

## Estruturas de dados nativos {#sec:data_structures}

Julia possui diversas estruturas de dados nativos.
Elas são abstrações de dados que representam alguma forma de dado estruturado.
Vamos cobrir os mais usados.
Eles mantêm dados homogêneos ou heterogêneos.
Uma vez que são coleções, podem ser *looped* over with the `for` loops.

Nós cobriremos `String`, `Tuple`, `NamedTuple`, `UnitRange`, `Arrays`, `Pair`, `Dict`, `Symbol`.

Quando você se depara com uma estrutura de dados em Julia, você pode encontrar métodos que a aceitam como um argumento com a função `methodswith`.
Em Julia, a distinção entre métodos e funções é a seguinte:
Cada função pode ter mútiplos métodos, como mostramos anteriormente.
A função `methodswith` é boa de se ter por perto.
Vejamos o que podemos fazer com a `String`:

```jl
s = "first(methodswith(String), 5)"
sco(s; process=catch_show)
```

### Broadcasting Operadores e Funções {#sec:broadcasting}

Antes de mergulharmos nas estruturas de dados, precisamos conversar sobre broadcasting (também conhecido como *vetorização*) e o operador "dot" `.`.

Também podemos vetorizar operações matemáticas como `*` (multiplicação) ou `+` (adição) usando o operador dot.
Por exemplo, vetorizar adição implica em mudar `+` para `.+`:

```jl
sco(
"""
[1, 2, 3] .+ 1
"""
)
```

Também funciona automaticamente com funções.
(Tecnicamente, as operações matemáticas, ou operadores infixos, também são funções, mas isso não é tão importante saber.)
Lembra da nossa função `logarithm`?

```jl
sco("logarithm.([1, 2, 3])")
```

#### Funciona com um estrondo `!` {#sec:function_bang}

É uma convenção de Julia acrescentar um estrondo `!` a nomes de funções que modificam um ou mais de seus argumentos.
Esta convenção avisa o usuário que a função **não é pura**, ou seja, que tem *efeitos colaterais*.
Uma função com efeitos colaterais é útil quando você deseja atualizar uma grande estrutura de dados ou contêiner de variáveis sem ter toda a sobrecarga da criação de uma nova instância.

Por exemplo, podemos criar uma função que adiciona 1 a cada elemento de um vetor `V`:

```jl
s = """
    function add_one!(V)
        for i in 1:length(V)
            V[i] += 1
        end
        return nothing
    end
    """
sc(s)
```

```jl
s = """
    my_data = [1, 2, 3]

    add_one!(my_data)

    my_data
    """
sco(s)
```

### String {#sec:string}

**Strings** são representadas delimitadas por aspas duplas:

```jl
s = """
    typeof("This is a string")
    """
sco(s)
```

Também podemos escrever uma string multilinha:

```jl
s = """
    text = "
    This is a big multiline string.
    As you can see.
    It is still a String to Julia.
    "
    """
sco(s; post=output_block)
```

Mas, geralmente, é mais claro usar aspas triplas:

```jl
sco("""
s = \"\"\"
    This is a big multiline string with a nested "quotation".
    As you can see.
    It is still a String to Julia.
    \"\"\"
"""; post=output_block)
```

Ao usar backticks triplos, o recuo e a nova linha no início são ignorados por Julia.
Isso melhora a legibilidade do código porque você pode recuar o bloco em seu código-fonte sem que esses espaços acabem em sua string.

#### Concatenação de Strings {#sec:string_concatenation}

Uma operação de string comum é a **concatenação de string**.
Suponha que você queira construir uma nova string que é a concatenação de duas ou mais strings.
Isso é realizado em Julia com o operador `*` ou a função `join`.
Este símbolo pode soar como uma escolha estranha e na verdade é.
Por enquanto, muitas bases de código de Julia estão usando este símbolo, então ele permanecerá na linguagem.
Se você estiver interessado, pode ler uma discussão de 2015 sobre isso em
<https://github.com/JuliaLang/julia/issues/11030>.

```jl
s = """
    hello = "Hello"
    goodbye = "Goodbye"

    hello * goodbye
    """
scob(s)
```

Como você pode ver, está faltando um espaço entre `hello` e `goodbye`.
Poderíamos concatenar uma string adicional `" "` com `*`, mas isso seria complicado para mais de duas strings.
É onde a função `join` vem a calhar.
Nós apenas passamos como argumentos as strings dentro dos colchetes `[]` e do separador:

```jl
scob("""join([hello, goodbye], " ")""")
```

#### Interpolação de String {#sec:string_interpolation}

Concatenar strings pode ser complicado.
Podemos ser muito mais expressivos com **interpolação de string**.
Funciona assim: você especifica o que quer que seja incluído em sua string com o cifrão `$`.
Aqui está o exemplo anterior, mas agora usando interpolação:

```jl
s = """
    "\$hello \$goodbye"
    """
scob(s)
```

Ela até funciona dentro de funções.
Vamos revisitar nossa função `test` a partir de @sec:conditionals:

```jl
s = """
    function test_interpolated(a, b)
        if a < b
            "\$a is less than \$b"
        elseif a > b
            "\$a is greater than \$b"
        else
            "\$a is equal to \$b"
        end
    end

    test_interpolated(3.14, 3.14)
    """
scob(s)
```

#### Manipulações de Strings {#sec:string_manipulations}

Existem várias funções para manipular strings em Julia.
Vamos demonstrar os mais comuns.
Além disso, observe que a maioria dessas funções aceita um [Regular Expression (RegEx)](https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions) como argumentos.
Não cobriremos RegEx neste livro, mas te encorajamos a aprender sobre eles, especialmente se a maior parte de seu trabalho usa dados textuais.

Primeiro, vamos definir uma string para brincarmos:

```jl
s = """
    julia_string = "Julia is an amazing opensource programming language"
    """
scob(s)
```


1. `occursin`, `startswith` e `endswith`: Uma condicional (retorna `true` ou `false`) se o primeiro argumento é um:
    * **substring** do segundo argumento

       ```jl
       scob("""occursin("Julia", julia_string)""")
       ```

    * **prefix** do segundo argumento

       ```jl
       scob("""startswith("Julia", julia_string)""")
       ```

    * **suffix** do segundo argumento

       ```jl
       scob("""endswith("Julia", julia_string)""")
       ```

2. `lowercase`, `uppercase`, `titlecase` e `lowercasefirst`:

     ```jl
     scob("lowercase(julia_string)")
     ```

     ```jl
     scob("uppercase(julia_string)")
     ```

     ```jl
     scob("titlecase(julia_string)")
     ```

     ```jl
     scob("lowercasefirst(julia_string)")
     ```

3. `replace`: introduz uma nova sintaxe, chamada de `Pair`

     ```jl
     scob("""replace(julia_string, "amazing" => "awesome")""")
     ```

4. `split`: divide uma string por um delimitador:

     ```jl
     sco("""split(julia_string, " ")""")
     ```

#### Conversões de String {#sec:string_conversions}

Muitas vezes, precisamos **converter** entre os tipos em Julia.
Para converter um número em uma string, podemos usar a função `string`:

```jl
s = """
    my_number = 123
    typeof(string(my_number))
    """
sco(s)
```

Às vezes, queremos o oposto: converter uma string em um número.
Julia tem uma função útil para isso: `parse`.

```jl
sco("""typeof(parse(Int64, "123"))""")
```

Às vezes, queremos jogar pelo seguro com essas conversões.
É aí que entra a função `tryparse`.
Tem a mesma funcionalidade que `parse` mas retorna um valor do tipo solicitado ou `nothing`.
Isso faz com que a `tryparse` seja útil quando buscamos evitar erros.
Claro, você precisará lidar com todos aqueles valores `nothing` depois.

```jl
sco("""tryparse(Int64, "A very non-numeric string")""")
```

### Tupla {#sec:tuple}

Julia tem uma estrutura de dados chamada **tupla**.
Ela é muito *especial* em Julia porque ela é frequentemente usada em relação às funções.
Uma vez que as funções são um recurso importante em Julia, todo usuário precisa saber o básico das tuplas.

Uma tupla é uma **recipiente de comprimento fixo que pode conter vários tipos diferentes**.
Uma tupla é um **objeto imutável**, o que significa que não pode ser modificado após a instanciação.
Para construir uma tupla, use parênteses `()` para delimitar o início e o fim, junto com vírgulas `,` como delimitadores entre valores:

```jl
sco("""my_tuple = (1, 3.14, "Julia")""")
```

Aqui, estamos criando uma tupla com três valores.
Cada um dos valores é um tipo diferente.
Podemos acessá-los por meio de indexação.
Assim:

```jl
scob("my_tuple[2]")
```

Também podemos fazer um loop em tuplas com a palavra-chave `for`.
E até mesmo aplicar funções as tuplas.
Mas nós nunca podemos **mudar qualquer valor de uma tupla** já que elas são **imutáveis**.

Você se lembra funções que retornam vários valores em @sec:function_multiple?
Vamos inspecionar o que nossa função `add_multiply` retorna:

```jl
s = """
    return_multiple = add_multiply(1, 2)
    typeof(return_multiple)
    """
sco(s)
```

Isso ocorre porque `return a, b` é o mesmo que `return (a, b)`:

```jl
sco("1, 2")
```

Agora você pode ver por que elas são frequentemente relacionadas.

Mais uma coisa para pensarmos sobre as tuplas.
**Quando você deseja passar mais de uma variável para uma função anônima, adivinhe o que você precisa usar? Tuplas!**

```jl
scob("map((x, y) -> x^y, 2, 3)")
```

Ou ainda, mais do que dois argumentos:

```jl
scob("map((x, y, z) -> x^y + z, 2, 3, 1)")
```

### Tupla nomeada {#sec:namedtuple}

Às vezes, você deseja nomear os valores em tuplas.
É aí que entram as **tuplas nomeadas**.
Sua funcionalidade é praticamente a mesma das tuplas:
são **imutáveis** e podem conter **todo tipo de valor**.

A construção das tuplas nomeadas é ligeiramente diferente das tuplas.
Você tem os familiares parênteses `()` e a vírgula `,` separadora de valor.
Mas agora, você **nomeia os valores**:

```jl
sco("""my_namedtuple = (i=1, f=3.14, s="Julia")""")
```

Podemos acessar os valores de uma tupla nomeada por meio da indexação como tuplas regulares ou, alternativamente, **acesso por seus nomes** com o `.`:

```jl
scob("my_namedtuple.s")
```

Encerrando nossa discussão sobre tuplas nomeadas, há uma sintaxe *rápida* importante que você verá muito no código de Julia.
Frequentemente, os usuários de Julia criam uma tupla nomeada usando o parêntese familiar `()` e vírgulas `,`, mas sem nomear os valores.
Para fazer isso, **comece a construção da tupla nomeada especificando primeiro um ponto e vírgula `;` antes dos valores**.
Isto é especialmente útil quando os valores que iriam compor a tupla nomeada já estão definidos em variáveis ou quando você deseja evitar linhas longas:

```jl
s = """
    i = 1
    f = 3.14
    s = "Julia"

    my_quick_namedtuple = (; i, f, s)
    """
sco(s)
```

### Ranges {#sec:ranges}

Uma **range** em Julia representa um intervalo entre os limites de início e parada.
A sintaxe é `start:stop`:

```jl
sco("1:10")
```

Como você pode ver, nosso range instanciado é do tipo `UnitRange{T}` onde `T` é um tipo dentro de `UnitRange`:

```jl
sco("typeof(1:10)")
```

And, if we gather all the values, we get:

```jl
sco("[x for x in 1:10]")
```

Também podemos construir ranges para outros tipos:

```jl
sco("typeof(1.0:10.0)")
```

Às vezes, queremos mudar o comportamento do tamanho do intervalo padrão.
Podemos fazer isso adicionando um tamanho de passo na sintaxe do range `start:step:stop`.
Por exemplo, suponha que queremos um range de `Float64` que vá de 0 a 1 com passos do tamanho de 0.2:

```jl
sco("0.0:0.2:1.0")
```

Se você quer "materializar" a range para uma coleção, você pode usar a função `collect`:

```jl
sco("collect(1:10)")
```

Nós temos um arranjo do tipo especificado no range entre os limites que definimos.
Vamos conversar sobre arranjos.

### Arranjo {#sec:array}

Na sua forma mais básica, **arranjos** seguram múltiplos objetos.
Por exemplo, eles podem armazenar múltiplos números em uma dimensão:

```jl
sco("myarray = [1, 2, 3]")
```

Na maioria das vezes você gostaria de **arranjos de um único tipo para problemas de performance**, mas observe que eles também podem conter objetos de diferentes tipos:

```jl
sco("myarray = [\"text\", 1, :symbol]"; process=output_block)
```

Eles são o "pão com manteiga" da ciência de dados, porque os arranjos são o que está por trás da maior parte do fluxo de trabalho em **manipulação de dados** e **visualização de dados**.

Portanto, **arranjos são uma estrutura de dados essencial**.

#### Tipos de arranjo {#sec:array_types}

Vamos começar com os **tipos de arranjos**.
Existem vários, mas vamos nos concentrar nos dois mais usados em ciência de dados:

* `Vector{T}`: arranjo **unidimensional**. Alias para `Array{T, 1}`.
* `Matrix{T}`: arranjo **bidimensional**. Alias para `Array{T, 2}`.

Observe aqui que `T` é o tipo do arranjo subjacente.
Então, por exemplo, `Vector{Int64}` é um `Vector` no qual todos os elementos são `Int64`s, e `Matrix{AbstractFloat}` é a `Matrix` em que todos os elementos são subtipos de `AbstractFloat`.

Na maioria das vezes, especialmente ao lidar com dados tabulares, estamos usando arranjos unidimensionais ou bidimensionais.
Ambos são tipos `Array` para Julia.
Mas, podemos usar os úteis aliases `Vector` e `Matrix` para uma sintaxe clara e concisa.

#### Construção de Arranjo {#sec:array_construction}

Como **construímos** um arranjo?
Nesta seção, começamos construindo arranjos num nível mais baixo.
Isso pode ser necessário para escrever código de alto desempenho em algumas situações.
No entanto, na maioria das situações, isso não é necessário e podemos usar métodos mais convenientes para criar arranjos com segurança.
Esses métodos mais convenientes serão descritos posteriormente nesta seção.

O construtor de baixo nível para arranjos em Julia é o **construtor padrão**.
Ele aceita o tipo de elemento como o parâmetro de tipo dentro dos colchetes `{}` e dentro do construtor você passará o tipo de elemento seguido pelas dimensões desejadas.
É comum inicializar vetores e matrizes com elementos indefinidos usando o argumento para tipo `undef`.
Um vetos de 10 elementos `undef` `Float64` pode ser construído como:

```jl
s = """
    my_vector = Vector{Float64}(undef, 10)
    """
sco(s)
```

Para matrizes, uma vez que estamos lidando com objetos bidimensionais, precisamos passar dois argumentos de dimensão dentro do construtor: um para **filas** e outro para **colunas**.
Por exemplo, uma matriz com 10 linhas e 2 colunas de elementos `undef` pode ser instanciada como:

```jl
s = """
    my_matrix = Matrix{Float64}(undef, 10, 2)
    """
sco(s)
```

Nós também temos alguns **aliases de sintaxe** para os elementos mais comuns na construção de arranjos:

* `zeros` para todos os elementos inicializados em zero.
  Observe que o tipo padrão é `Float64` que pode ser alterado se necessário:

     ```jl
     s = """
         my_vector_zeros = zeros(10)
         """
     sco(s)
     ```

     ```jl
     s = """
         my_matrix_zeros = zeros(Int64, 10, 2)
         """
     sco(s)
     ```

* `ones` para todos os elementos inicializados em um:

     ```jl
     s = """
         my_vector_ones = ones(Int64, 10)
         """
     sco(s)
     ```

     ```jl
     s = """
         my_matrix_ones = ones(10, 2)
         """
     sco(s)
     ```

Para outros elementos, podemos primeiro instanciar um arranjo com elementos `undef` e usar a função `fill!` para preencher todos os elementos de um arranjo com o elemento desejado.
Segue um exemplo com `3.14` ($\pi$):

```jl
s = """
    my_matrix_π = Matrix{Float64}(undef, 2, 2)
    fill!(my_matrix_π, 3.14)
    """
sco(s)
```

Também podemos criar arranjos com **literais de arranjo**.
Por exemplo, segue uma matriz 2x2 de inteiros:

```jl
s = """
    [[1 2]
     [3 4]]
    """
sco(s)
```

Literais de arranjo também aceita uma especificação de tipo antes do colchetes `[]`.
Então, se quisermos o mesmo arranjo 2x2 de antes mas agora como floats, podemos:

```jl
s = """
    Float64[[1 2]
            [3 4]]
    """
sco(s)
```

Também funciona para vetores:

```jl
s = """
    Bool[0, 1, 0, 1]
    """
sco(s)
```

Você pode até **misturar e combinar** literais de arranjo com os construtores:

```jl
s = """
    [ones(Int, 2, 2) zeros(Int, 2, 2)]
    """
sco(s)
```

```jl
s = """
    [zeros(Int, 2, 2)
     ones(Int, 2, 2)]
    """
sco(s)
```


```jl
s = """
    [ones(Int, 2, 2) [1; 2]
     [3 4]            5]
    """
sco(s)
```

Outra maneira poderosa de criar um arranjo é escrever uma **compreensão do arranjo**.
Esta maneira de criar arranjos é melhor na maioria dos casos: evita loops, indexação e outras operações sujeitas a erros.
Você especifica o que deseja fazer dentro dos colchetes `[]`.
Por exemplo, digamos que queremos criar um vetor de quadrados de 1 a 10:

```jl
s = """
    [x^2 for x in 1:10]
    """
sco(s)
```

Eles também suportam múltiplas entradas:

```jl
s = """
    [x*y for x in 1:10 for y in 1:2]
    """
sco(s)
```

E condicionais:

```jl
s = """
    [x^2 for x in 1:10 if isodd(x)]
    """
sco(s)
```

Tal como acontece com literais de arranjo, você pode especificar o tipo desejado antes dos colchetes `[]`:

```jl
s = """
    Float64[x^2 for x in 1:10 if isodd(x)]
    """
sco(s)
```

Finalmente, também podemos criar arranjos com **funções de concatenação**.
Concatenação é um termo padrão em programação e significa "para acorrentar juntos".
Por exemplo, podemos concatenar strings com "aa" e "bb" para conseguir "aabb":

```jl
s = """
    "aa" * "bb"
    """
sco(s)
```

E podemos concatenar arranjos para criar novos arranjos:

* `cat`: concatenar arranjos de entrada ao longo de uma dimensão específica `dims`

     ```jl
     sco("cat(ones(2), zeros(2), dims=1)")
     ```

     ```jl
     sco("cat(ones(2), zeros(2), dims=2)")
     ```

* `vcat`: concatenação vertical, uma abreviatura para `cat(...; dims=1)`

     ```jl
     sco("vcat(ones(2), zeros(2))")
     ```

* `hcat`: concatenação horizontal, uma abreviatura para `cat(...; dims=2)`

     ```jl
     sco("hcat(ones(2), zeros(2))")
     ```

#### Inspeção de Arranjos {#sec:array_inspection}

Assim que tivermos arranjos, o próximo passo lógico seria **inspeciona-los**.
Existem várias funções úteis que permitem ao usuário ter uma visão de qualquer arranjo.

É muito útil saber que **tipo de elementos** existem dentro de um arranjo.
Fazemos isso com `eltype`:

```jl
sco("eltype(my_matrix_π)")
```

Depois de conhecer seus tipos, alguém pode se interessar nas **dimensões do arranjo**.
Julia tem várias funções para inspecionar as dimensões do arranjo:

* `length`: número total de elementos

     ```jl
     scob("length(my_matrix_π)")
     ```

* `ndims`: número de dimensões

     ```jl
     scob("ndims(my_matrix_π)")
     ```

* `size`: esse é um pouco complicado.
    Por padrão, ele retornará uma tupla contendo as dimensões do arranjo.

     ```jl
     sco("size(my_matrix_π)")
     ```

    Você pode obter uma dimensão específica com um segundo argumento para `size`.
    Aqui, o segundo eixo são as colunas

     ```jl
     scob("size(my_matrix_π, 2)")
     ```

#### Indexação e Divisão de Arranjo {#sec:array_indexing}

Às vezes, queremos inspecionar apenas certas partes de um arranjo.
Chamamos isso de **indexação** and **divisão**.
Se você quiser uma observação particular de um vetor, ou uma linha ou coluna de uma matriz, você provavelmente precisará **indexar um arranjo**.

Primeiro, vou criar um vetor e uma matriz de exemplo para brincar:

```jl
s = """
    my_example_vector = [1, 2, 3, 4, 5]

    my_example_matrix = [[1 2 3]
                         [4 5 6]
                         [7 8 9]]
    """
sc(s)
```

Vamos começar com vetores.
Supondo que você queira o segundo elemento de um vetor.
Você anexa colchetes `[]` com o **index** desejado dentro:

```jl
scob("my_example_vector[2]")
```

A mesma sintaxe segue com os arranjos.
Mas, como os arranjos são arranjos bidimensionais, temos que especificar *ambas* linhas e colunas.
Vamos recuperar o elemento da segunda linha (primeira dimensão) e primeira coluna (segunda dimensão):

```jl
scob("my_example_matrix[2, 1]")
```

Júlia também possui palavras-chave convencionais para o **primeiro** e **último** elementos de um arranjo: `begin` e `end`.
Por exemplo, o penúltimo elemento de um vetor pode ser recuperado como:

```jl
scob("my_example_vector[end-1]")
```

Isso também funciona para matrizes.
Vamos recuperar o elemento da última linha e segunda coluna:

```jl
scob("my_example_matrix[end, begin+1]")
```

Muitas vezes, não estamos só interessados em apenas um elemento do arranjo, mas em um todo **subconjunto de elementos do arranjo**.
Podemos fazer isso **dividindo** um arranjo.
Usamos a mesma sintaxe de índice, mas com os dois pontos adicionados `:` para denotar os limites que estamos cortando através do arranjo.
Por exemplo, suponha que queremos obter do 2º ao 4º elemento de um vetor:

```jl
sco("my_example_vector[2:4]")
```

Poderíamos fazer o mesmo com matrizes.
Particularmente com matrizes, se quisermos selecionar **todos os elementos** em uma dimensão seguinte, podemos fazer isso com apenas dois pontos `:`.
Por exemplo, para obter todos os elementos da segunda linha:

```jl
sco("my_example_matrix[2, :]")
```

Você pode interpretar isso com algo como "pegue a 2ª linha e todas as colunas".

Também suporta `begin` e `end`:

```jl
sco("my_example_matrix[begin+1:end, end]")
```

#### Manipulações de Arranjo {#sec:array_manipulation}

Existem várias formas para **manipular** um arranjo.
O primeiro seria manipular um **único elemento do arranjo**.
Nós apenas indexamos o arranjo pelo elemento desejado e procedemos com uma atribuição `=`:

```jl
s = """
    my_example_matrix[2, 2] = 42
    my_example_matrix
    """
sco(s)
```

Ou, você pode manipular um determinado **subconjunto de elementos do arranjo**.
Nesse caso, precisamos dividir o arranjo e, em seguida, atribuir com `=`:

```jl
s = """
    my_example_matrix[3, :] = [17, 16, 15]
    my_example_matrix
    """
sco(s)
```

Observe que tivemos que atribuir um vetor porque nosso arranjo dividido é do tipo `Vector`:

```jl
s = """
    typeof(my_example_matrix[3, :])
    """
sco(s)
```

A segunda maneira de manipular um arranjo é **alterar sua forma**.
Suponha que você tenha um vetor de 6 elementos e deseja torná-lo uma matriz 3x2.
Você pode fazer isso com `reshape`, usando o arranjo como o primeiro argumento e uma tupla de dimensões como segundo argumento:

```jl
s = """
    six_vector = [1, 2, 3, 4, 5, 6]
    tree_two_matrix = reshape(six_vector, (3, 2))
    tree_two_matrix
    """
sco(s)
```

Você pode convertê-lo de volta em um vetor especificando uma tupla com apenas uma dimensão como o segundo argumento:

```jl
sco("reshape(tree_two_matrix, (6, ))")
```

A terceira forma que podemos manipular um arranjo é **aplicando uma função em cada elemento do arranjo**.
Aqui é onde o operador "dot" `.`, também conhecido como _broadcasting_, entra.

```jl
sco("logarithm.(my_example_matrix)")
```

O operador dot em Julia é extremamente versátil.
Você pode até mesmo usá-lo para vetorizar operadores infixos:

```jl
sco("my_example_matrix .+ 100")
```

Uma alternativa para broadcasting uma função por um vetor é usar `map`:

```jl
sco("map(logarithm, my_example_matrix)")
```

Para funções anônimas, `map` geralmente é mais legível.
Por exemplo,

```jl
sco("map(x -> 3x, my_example_matrix)")
```

é bastante claro.
No entanto, o mesmo broadcast se parece com a seguinte:

```jl
sco("(x -> 3x).(my_example_matrix)")
```

Em seguida, `map` funciona com a divisão:

```jl
sco("map(x -> x + 100, my_example_matrix[:, 3])")
```

Finalmente, às vezes, e especialmente ao lidar com dados tabulares, queremos aplicar uma **função sobre todos os elementos em uma dimensão de arranjo específica**.
Isso pode ser feito com a função `mapslices`.
Parecido com `map`, o primeiro argumento é a função e o segundo argumento é o arranjo.
A única mudança é que precisamos especificar o argumento `dims` argument para sinalizar em qual dimensão queremos transformar os elementos.

Por exemplo, vamos usar `mapslice` com a função `sum` em ambas as linhas (`dims=1`) e colunas (`dims=2`):

```jl
sco(
"""
# rows
mapslices(sum, my_example_matrix; dims=1)
"""
)
```

```jl
sco(
"""
# columns
mapslices(sum, my_example_matrix; dims=2)
"""
)
```

#### Iteração de arranjo {#sec:array_iteration}

Uma operação comum é **iterar sobre um arranjo com um loop `for`**.
O **loop regular `for` sobre um arranjo retorna cada elemento**.

O exemplo mais simples é com um vetor.

```jl
sco(
"""
simple_vector = [1, 2, 3]

empty_vector = Int64[]

for i in simple_vector
    push!(empty_vector, i + 1)
end

empty_vector
"""
)
```

Às vezes, você não quer fazer um loop sobre cada elemento, mas na verdade sobre cada índice de arranjo.
**Podemos usar a função `eachindex` combinada com um loop `for` para iterar sobre cada índice de arranjo**.

Novamente, vamos mostrar um exemplo com um vetor:

```jl
sco(
"""
forty_twos = [42, 42, 42]

empty_vector = Int64[]

for i in eachindex(forty_twos)
    push!(empty_vector, i)
end

empty_vector
"""
)
```

Nesse exemplo, o `eachindex(forty_twos)` retorna os índices de `forty_twos`, namely `[1, 2, 3]`.

Da mesma forma, podemos iterar sobre matrizes.
O padrão loop `for` vai primeiro sobre as colunas e depois sobre as linhas.
Ele irá primeiro percorrer todos os elementos na coluna 1, da primeira à última linha, em seguida, ele se moverá para a coluna 2 de maneira semelhante até cobrir todas as colunas.

Para aqueles familiarizados com outras linguagens de programação:
Julia, como a maioria das linguagens de programação científica, é "column-major".
Column-major significa que os elementos da coluna são armazenados lado a lado na memória[^pointers].
Isso também significa que iterar sobre os elementos em uma coluna é muito mais rápido do que sobre os elementos em uma linha.

[^pointers]: ou, que os ponteiros de endereço de memória para os elementos na coluna são armazenados um ao lado do outro

Ok, vamos mostrar isso em um exemplo:

```jl
sc(
"""
column_major = [[1 3]
                [2 4]]

row_major = [[1 2]
             [3 4]]
"""
)
```

Se fizermos um loop sobre o vetor armazenado em ordem column-major, então a saída é classificada:

```jl
sco(
"""
indexes = Int64[]

for i in column_major
    push!(indexes, i)
end

indexes
"""
)
```

No entanto, a saída não é classificada ao fazer um loop sobre a outra matriz:

```jl
sco(
"""
indexes = Int64[]

for i in row_major
    push!(indexes, i)
end

indexes
"""
)
```

Muitas vezes é melhor usar funções especializadas para esses loops:

* `eachcol`: iterates over an array column first

     ```jl
     sco("first(eachcol(column_major))")
     ```

* `eachrow`: iterates over an array row first

     ```jl
     sco("first(eachrow(column_major))")
     ```

### Par {#sec:pair}

Em comparação com a enorme seção sobre arranjos, esta seção sobre pares será breve.
**`Par` é uma estrutura de dados que contém dois objetos** (which typically belong to each other).
Construímos um par em Julia usando a seguinte sintaxe:

```jl
sco("""my_pair = "Julia" => 42""")
```

Os elementos são armazenados nos campos `first` e `second`.

```jl
scob("my_pair.first")
```

```jl
scob("my_pair.second")
```

Mas, na maioria dos casos, é mais fácil usar `first` e `last`[^easier]:

```jl
scob("first(my_pair)")
```

```jl
scob("last(my_pair)")
```

[^easier]: é mais fácil porque `first` e `last` também funcionam em muitas outras coleções, então você não precisa se lembrar de tanta coisa.

Os pares serão muito usados na manipulação e visualização de dados, uma vez que ambos `DataFrames.jl` (@sec:dataframes) e/ou `Makie.jl` (@sec:DataVisualizationMakie) pegam objetos do tipo `Pair` em suas funções principais.
Por exemplo, com `DataFrames.jl` veremos que `:a => :b` pode ser usado para renomear a coluna `:a` a `:b`.

### Dict {#sec:dict}

If you understood what a `Pair` is, then `Dict` won't be a problem.
For all practical purposes, **`Dict`s are mappings from keys to values**.
By mapping, we mean that if you give a `Dict` some key, then the `Dict` can tell you which value belongs to that key.
`key`s and `value`s can be of any type, but usually `key`s are strings.

There are two ways to construct `Dict`s in Julia.
The first is by passing a vector of tuples as `(key, value)` to the `Dict` constructor:

```jl
sco(
"""
# tuples # hide
name2number_map = Dict([("one", 1), ("two", 2)])
"""
)
```

There is a more readable syntax based on the `Pair` type described above.
You can also pass `Pair`s of `key => value`s to the `Dict` constructor:

```jl
sco(
"""
# pairs # hide
name2number_map = Dict("one" => 1, "two" => 2)
"""
)
```

You can retrieve a `Dict`s `value` by indexing it by the corresponding `key`:

```jl
scob("""name2number_map["one"]""")
```

To add a new entry, you index the `Dict` by the desired `key` and assign a `value` with the assignment `=` operator:

```jl
scob(
"""
name2number_map["three"] = 3
"""
)
```

If you want to check if a `Dict` has a certain `key` you can use `keys` and `in`:

```jl
scob("\"two\" in keys(name2number_map)")
```

To delete a `key` you can use either the `delete!` function:

```jl
sco(
"""
delete!(name2number_map, "three")
"""
)
```

Or, to delete a key while returning its value, you can use `pop!`:

```jl
scob("""popped_value = pop!(name2number_map, "two")""")
```

Now, our `name2number_map` has only one `key`:

```jl
sco("name2number_map")
```

`Dict`s are also used for data manipulation by `DataFrames.jl` (@sec:dataframes) and for data visualization by `Makie.jl` (@sec:DataVisualizationMakie).
So, it is important to know their basic functionality.

There is another useful way of constructing `Dict`s.
Suppose that you have two vectors and you want to construct a `Dict` with one of them as `key`s and the other as `value`s.
You can do that with the `zip` function which "glues" together two objects (just like a zipper):

```jl
sco(
"""
A = ["one", "two", "three"]
B = [1, 2, 3]

name2number_map = Dict(zip(A, B))
"""
)
```

For instance, we can now get the number 3 via:

```jl
scob("""name2number_map["three"]""")
```

### Symbol {#sec:symbol}

`Symbol` is actually *not* a data structure.
It is a type and behaves a lot like a string.
Instead of surrounding the text by quotation marks, a symbol starts with a colon (:) and can contain underscores:

```jl
sco("sym = :some_text")
```

We can easily convert a symbol to string and vice versa:

```jl
scob("s = string(sym)")
```

```jl
sco("sym = Symbol(s)")
```

One simple benefit of symbols is that you have to type one character less, that is, `:some_text` versus `"some text"`.
We use `Symbol`s a lot in data manipulations with the `DataFrames.jl` package (@sec:dataframes) and data visualizations with the `Makie.jl` package (@sec:DataVisualizationMakie).

### Splat Operator {#sec:splat}

In Julia we have the "splat" operator `...` which is used in function calls as a **sequence of arguments**.
We will occasionally use splatting in some function calls in the **data manipulation** and **data visualization** chapters.

The most intuitive way to learn about splatting is with an example.
The `add_elements` function below takes three arguments to be added together:

```jl
sco("add_elements(a, b, c) = a + b + c")
```

Now, suppose that we have a collection with three elements.
The naïve way to this would be to supply the function with all three elements as function arguments like this:

```jl
scob("""
my_collection = [1, 2, 3]

add_elements(my_collection[1], my_collection[2], my_collection[3])
""")
```

Here is where we use the "splat" operator `...` which takes a collection (often an array, vector, tuple, or range) and converts it into a sequence of arguments:

```jl
scob("add_elements(my_collection...)")
```

The `...` is included after the collection that we want to "splat" into a sequence of arguments.
In the example above, the following are the same:

```jl
scob("""
add_elements(my_collection...) == add_elements(my_collection[1], my_collection[2], my_collection[3])
""")
```

Anytime Julia sees a splatting operator inside a function call, it will be converted on a sequence of arguments for all elements of the collection separated by commas.

It also works for ranges:

```jl
scob("add_elements(1:3...)")
```

## Filesystem {#sec:filesystem}

In data science, most projects are undertaken in a collaborative effort.
We share code, data, tables, figures and so on.
Behind everything, there is the **operating system (OS) filesystem**.
In a perfect world, the same program would give the **same** output when running on **different** operating systems.
Unfortunately, that is not always the case.
One instance of this is the difference between Windows paths, such as `C:\\user\john\`, and Linux paths, such as `/home/john`.
This is why it is important to discuss **filesystem best practices**.

Julia has native filesystem capabilities that **handle the differences between operating systems**.
They are located in the [`Filesystem`](https://docs.julialang.org/en/v1/base/file/) module from the core `Base` Julia library.

Whenever you are dealing with files such as CSV, Excel files or other Julia scripts, make sure that your code **works on different OS filesystems**.
This is easily accomplished with the `joinpath`, `@__FILE__` and `pkgdir` functions.

If you write your code in a package, you can use `pkgdir` to get the root directory of the package.
For example, for the Julia Data Science (JDS) package that we use to produce this book:

```jl
root = pkgdir(JDS)
```

as you can see, the code to produce this book was running on a Linux computer.
If you're using a script, you can get the location of the script file via

```julia
root = dirname(@__FILE__)
```

The nice thing about these two commands is that they are independent of how the user started Julia.
In other words, it doesn't matter whether the user started the program with `julia scripts/script.jl` or `julia script.jl`, in both cases the paths are the same.

The next step would be to include the relative path from `root` to our desired file.
Since different OS have different ways to construct relative paths with subfolders (some use forward slashes `/` while other might use backslashes `\`), we cannot simply concatenate the  file's relative path with the `root` string.
For that, we have the `joinpath` function, which will join different relative paths and filenames according to your specific OS filesystem implementation.

Suppose that you have a script named `my_script.jl` inside your project's directory.
You can have a robust representation of the filepath to `my_script.jl` as:

```jl
scob("""joinpath(root, "my_script.jl")""")
```

`joinpath` also handles **subfolders**.
Let's now imagine a common situation where you have a folder named `data/` in your project's directory.
Inside this folder there is a CSV file named `my_data.csv`.
You can have the same robust representation of the filepath to `my_data.csv` as:

```jl
scob("""joinpath(root, "data", "my_data.csv")""")
```

It's a good habit to pick up, because it's very likely to save problems for you or other people later.

## Julia Standard Library {#sec:standardlibrary}

Julia has a **rich standard library** that is available with *every* Julia installation.
Contrary to everything that we have seen so far, e.g. types, data structures and filesystem; you **must load standard library modules into your environment** to use a particular module or function.

This is done via `using` or `import`.
In this book, we will load code via `using`:

```julia
using ModuleName
```

After doing this, you can access all functions and types inside `ModuleName`.

### Dates {#sec:dates}

Knowing how to handle dates and timestamps is important in data science.
As we said in *Why Julia?* (@sec:why_julia) section, Python's `pandas` uses its own `datetime` type to handle dates.
The same is true in the R tidyverse's `lubridate` package, which also defines its own `datetime` type to handle dates.
In Julia packages don't need to write their own dates logic, because Julia has a dates module in its standard library called `Dates`.

To begin, let's load the `Dates` module:

```julia
using Dates
```

#### `Date` and `DateTime` Types {#sec:dates_types}

The `Dates` standard library module has **two types for working with dates**:

1. `Date`: representing time in days and
2. `DateTime`: representing time in millisecond precision.

We can construct `Date` and `DateTime` with the default constructor either by specifying an integer to represent year, month, day, hours and so on:

```jl
sco(
"""
Date(1987) # year
"""
)
```

```jl
sco(
"""
Date(1987, 9) # year, month
"""
)
```

```jl
sco(
"""
Date(1987, 9, 13) # year, month, day
"""
)
```

```jl
sco(
"""
DateTime(1987, 9, 13, 21) # year, month, day, hour
"""
)
```

```jl
sco(
"""
DateTime(1987, 9, 13, 21, 21) # year, month, day, hour, minute
"""
)
```

For the curious, September 13th 1987, 21:21 is the official time of birth of the first author, Jose.

We can also pass `Period` types to the default constructor.
**`Period` types are the human-equivalent representation of time** for the computer.
Julia's `Dates` have the following `Period` abstract subtypes:

```jl
sco("subtypes(Period)")
```

which divide into the following concrete types, and they are pretty much self-explanatory:

```jl
sco("subtypes(DatePeriod)")
```

```jl
sco("subtypes(TimePeriod)")
```

So, we could alternatively construct Jose's official time of birth as:

```jl
sco("DateTime(Year(1987), Month(9), Day(13), Hour(21), Minute(21))")
```

#### Parsing Dates {#sec:dates_parsing}

Most of the time, we won't be constructing `Date` or `DateTime` instances from scratch.
Actually, we will probably be **parsing strings as `Date` or `DateTime` types**.

The `Date` and `DateTime` constructors can be fed a string and a format string.
For example, the string `"19870913"` representing September 13th 1987 can be parsed with:

```jl
sco("""Date("19870913", "yyyymmdd")""")
```

Notice that the second argument is a string representation of the format.
We have the first four digits representing year `y`, followed by two digits for month `m` and finally two digits for day `d`.

It also works for timestamps with `DateTime`:

```jl
sco("""DateTime("1987-09-13T21:21:00", "yyyy-mm-ddTHH:MM:SS")""")
```

You can find more on how to specify different date formats in the [Julia `Dates`' documentation](https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.DateFormat).
Don't worry if you have to revisit it all the time, we ourselves do that too when working with dates and timestamps.

According to [Julia `Dates`' documentation](https://docs.julialang.org/en/v1/stdlib/Dates/#Constructors), using the `Date(date_string, format_string)` method is fine if it's only called a few times.
If there are many similarly formatted date strings to parse, however, it is much more efficient to first create a `DateFormat` type, and then pass it instead of a raw format string.
Then, our previous example becomes:

```jl
s = """
    format = DateFormat("yyyymmdd")
    Date("19870913", format)
    """
sco(s)
```

Alternatively, without loss of performance, you can use the string literal prefix `dateformat"..."`:

```jl
sco("""Date("19870913", dateformat"yyyymmdd")""")
```

#### Extracting Date Information {#sec:dates_information}

It is easy to **extract desired information from `Date` and `DateTime` objects**.
First, let's create an instance of a very special date:

```jl
sco("""my_birthday = Date("1987-09-13")""")
```

We can extract anything we want from `my_birthday`:

```jl
scob("year(my_birthday)")
```

```jl
scob("month(my_birthday)")
```

```jl
scob("day(my_birthday)")
```

Julia's `Dates` module also has **compound functions that return a tuple of values**:

```jl
sco("yearmonth(my_birthday)")
```

```jl
sco("monthday(my_birthday)")
```

```jl
sco("yearmonthday(my_birthday)")
```

We can also see the day of the week and other handy stuff:

```jl
scob("dayofweek(my_birthday)")
```

```jl
scob("dayname(my_birthday)")
```

```jl
scob("dayofweekofmonth(my_birthday)")
```

Yep, Jose was born on the second Sunday of September.

> **_NOTE:_**
> Here's a handy tip to just recover weekdays from `Dates` instances.
> Just use a `filter` on `dayofweek(your_date) <= 5`.
> For business day you can checkout the [`BusinessDays.jl`](https://github.com/JuliaFinance/BusinessDays.jl) package.

#### Date Operations {#sec:dates_operations}

We can perform **operations** in `Dates` instances.
For example, we can add days to a `Date` or `DateTime` instance.
Notice that Julia's `Dates` will automatically perform the adjustments necessary for leap years, and for months with 30 or 31 days (this is known as *calendrical* arithmetic).

```jl
sco("my_birthday + Day(90)")
```

We can add as many as we like:

```jl
sco("my_birthday + Day(90) + Month(2) + Year(1)")
```

In case you're ever wondering: "What can I do with dates again? What is available?", then you can use `methodswith` to check it out.
We show only the first 20 results here:

```jl
s = "first(methodswith(Date), 20)"
sco(s; process=catch_show)
```

From this, we can conclude that we can also use the plus `+` and minus `-` operator.
Let's see how old Jose is, in days:

```jl
sco("today() - my_birthday")
```

The **default duration** of `Date` types is a `Day` instance.
For the `DateTime`, the default duration is `Millisecond` instance:

```jl
sco("DateTime(today()) - DateTime(my_birthday)")
```

#### Date Intervals {#sec:dates_intervals}

One nice thing about `Dates` module is that we can also easily construct **date and time intervals**.
Julia is clever enough to not have to define the whole interval types and operations that we covered in @sec:ranges.
It just extends the functions and operations defined for range to `Date`'s types.
This is known as multiple dispatch and we already covered this in *Why Julia?* (@sec:why_julia).

For example, suppose that you want to create a `Day` interval.
This is easy done with the colon `:` operator:

```jl
sco("""Date("2021-01-01"):Day(1):Date("2021-01-07")""")
```

There is nothing special in using `Day(1)` as the interval, we can **use whatever `Period` type** as interval.
For example, using 3 days as the interval:

```jl
sco("""Date("2021-01-01"):Day(3):Date("2021-01-07")""")
```

Or even months:

```jl
sco("""Date("2021-01-01"):Month(1):Date("2021-03-01")""")
```

Note that the **type of this interval is a `StepRange` with the `Date` and concrete `Period` type** we used as interval inside the colon `:` operator:

```jl
s = """
    date_interval = Date("2021-01-01"):Month(1):Date("2021-03-01")
    typeof(date_interval)
    """
sco(s)
```

We can convert this to a **vector** with the `collect` function:

```jl
sco("collected_date_interval = collect(date_interval)")
```

And have all the **array functionalities available**, like, for example, indexing:

```jl
sco("collected_date_interval[end]")
```

We can also **broadcast date operations** to our vector of `Date`s:

```jl
sco("collected_date_interval .+ Day(10)")
```

Similarly, these examples work for `DateTime` types too.

### Random Numbers {#sec:random}

Another important module in Julia's standard library is the `Random` module.
This module deals with **random number generation**.
`Random` is a rich library and, if you're interested, you should consult [Julia's `Random` documentation](https://docs.julialang.org/en/v1/stdlib/Random/).
We will cover *only* three functions: `rand`, `randn` and `seed!`.

To begin, we first load the `Random` module.
Since we know exactly what we want to load, we can just as well explicitly load the methods that we want to use:

```julia
using Random: rand, randn, seed!
```

We have **two main functions that generate random numbers**:

* `rand`: samples a **random element** of a data structure or type.
* `randn`: generates a random number that follows a **standard normal distribution** (mean 0 and standard deviation 1) of a specific type.

> **_NOTE:_**
> Note that those two functions are already in the Julia `Base` module.
> So, you don't need to import `Random` if you're planning to use them.

#### `rand` {#sec:random_rand}

By default, if you call `rand` without arguments it will return a `Float64` in the interval $[0, 1)$, which means between 0 inclusive to 1 exclusive:

```jl
scob("rand()")
```

You can modify `rand` arguments in several ways.
For example, suppose you want more than 1 random number:

```jl
sco("rand(3)")
```

Or, you want a different interval:

```jl
scob("rand(1.0:10.0)")
```

You can also specify a different step size inside the interval and a different type.
Here we are using numbers without the dot `.` so Julia will interpret them as `Int64`:

```jl
scob("rand(2:2:20)")
```

You can also mix and match arguments:

```jl
sco("rand(2:2:20, 3)")
```

It also supports a collection of elements as a tuple:

```jl
scob("""rand((42, "Julia", 3.14))""")
```

And also arrays:

```jl
scob("rand([1, 2, 3])")
```

`Dict`s:

```jl
sco("rand(Dict(:one => 1, :two => 2))")
```

To finish off all the `rand` arguments options, you can specify the desired random number dimensions in a tuple.
If you do this, the returned type will be an array.
For example, here's a 2x2 matrix of `Float64` numbers between 1.0 and 3.0:

```jl
sco("rand(1.0:3.0, (2, 2))")
```

#### `randn` {#sec:random_randn}

`randn` follows the same general principle from `rand` but now it only returns numbers generated from the **standard normal distribution**.
The standard normal distribution is the normal distribution with mean 0 and standard deviation 1.
The default type is `Float64` and it only allows for subtypes of `AbstractFloat` or `Complex`:

```jl
scob("randn()")
```

We can only specify the size:

```jl
sco("randn((2, 2))")
```

#### `seed!` {#sec:random_seed}

To finish off the `Random` overview, let's talk about **reproducibility**.
Often, we want to make something **replicable**.
Meaning that, we want the random number generator to generate the **same random sequence of numbers**.
We can do so with the `seed!` function:

```jl
s = """
    seed!(123)
    rand(3)
    """
sco(s)
```

```jl
s = """
    seed!(123)
    rand(3)
    """
sco(s)
```

In order to avoid tedious and inefficient repetition of `seed!` all over the place, we can instead define an instance of a `seed!` and pass it as a first argument of **either `rand` or `randn`**.

```jl
sco("my_seed = seed!(123)")
```


```jl
sco("rand(my_seed, 3)")
```

```jl
sco("rand(my_seed, 3)")
```

> **_NOTE:_**
> If you want your code to be reproducible you can just call `seed!` in the beginning of your script.
> This will take care of reproducibility in sequential `Random` operations.
> No need to use it all `rand` and `randn` usage.

### Downloads {#sec:downloads}

One last thing from Julia's standard library for us to cover is the **`Download` module**.
It will be really brief because we will only be covering a single function named `download`.

Suppose you want to **download a file from the internet to your local storage**.
You can accomplish this with the `download` function.
The first and only required argument is the file's url.
You can also specify as a second argument the desired output path for the downloaded file (don't forget the filesystem best practices!).
If you don't specify a second argument, Julia will, by default, create a temporary file with the `tempfile` function.

Let's load the `download` method:

```julia
using Download: download
```

For example, let's download our [`JuliaDataScience` GitHub repository](https://github.com/JuliaDataScience/JuliaDataScience) `Project.toml` file.
Note that `download` function is not exported by `Downloads` module, so we have to use the `Module.function` syntax.
By default, it returns a string that holds the file path for the downloaded file:

```jl
s = """
    url = "https://raw.githubusercontent.com/JuliaDataScience/JuliaDataScience/main/Project.toml"

    my_file = Downloads.download(url) # tempfile() being created
    """
scob(s)
```

With `readlines`, we can look at the first 4 lines of our downloaded file:

```jl
s = """
    readlines(my_file)[1:4]
    """
sco(s; process=catch_show)
```

> **_NOTE:_**
> For more complex HTTP interactions such as interacting with web APIs, see the [`HTTP.jl` package](https://github.com/JuliaWeb/HTTP.jl) package.
