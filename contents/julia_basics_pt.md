# Básico de Julia {#sec:julia_basics}

> **_OBSERVAÇÃO:_**
> Neste capítulo, descreveremos o básico de Julia como linguagem de programação.
> Por favor, note que isso não é *estritamente necessário* para você usar Julia como uma ferramenta de manipulação e visualização de dados.
> Ter um conhecimento básico de Julia definitivamente o tornará mais *eficaz* e *eficiente* no uso de Julia.
> No entanto, se você preferir começar imediatamente, pode pular para @sec:dataframes e aprender sobre dados tabulares em `DataFrames.jl`.

Aqui, vamos trazer uma visão mais geral sobre a linguagem Julia, *não* algo aprofundado.
Se você já está familiarizado e confortável com outras linguagens de programação, nós encorajamos você a ler a documentação de Julia (<https://docs.julialang.org/>).
Os documentos são um excelente recurso para você se aprofundar em Julia.
Eles cobrem todos os fundamentos e casos extremos, mas podem ser complicados, especialmente se você não estiver familiarizado com a leitura de documentação de software.

Cobriremos o básico de Julia.
Imagine que Julia é um carro sofisticado repleto de recursos, como um Tesla novo.
Vamos apenas explicar a você como "dirigir o carro, estacioná-lo e como navegar no trânsito".
Se você quer saber o que "todos os botões no volante e painel fazem", este não é o livro que você está procurando.

## Sintaxe da linguagem {#sec:syntax}

Julia é uma **linguagem de tipagem dinâmica** com um compilador just-in-time.
Isso significa que você não precisa compilar seu programa antes de executá-lo, como precisaria fazer com C++ ou FORTRAN.
Em vez disso, Julia pegará seu código, adivinhará os tipos quando necessário e compilará partes do código antes de executá-lo.
Além disso, você não precisa especificar explicitamente cada tipo.
Julia vai inferir os tipos para você na hora.

As principais diferenças entre Julia e outras linguagens dinâmicas como R e Python são:
Primeiro, Julia **permite ao usuário especificar declarações de tipo**.
Você já viu algumas declarações de tipo em *Por que Julia?* (@sec:why_julia): eles são aqueles dois pontos duplos `::` que às vezes vem depois das variáveis.
No entanto, se você não quiser especificar o tipo de suas variáveis ou funções, Julia terá o prazer de inferir (adivinhar) para você.

Em segundo lugar, Julia permite que os usuários definam o comportamento da função de acordo com combinações diversas de tipos de argumento por meio do despacho múltiplo.
Também falamos sobre despacho múltiplo em @sec:julia_accomplish.
Por meio do despacho múltiplo, nós definimos um comportamento diferente de uma função para um determinado tipo quando escrevemos uma nova função com o mesmo nome da função anterior, mas cuja assinatura contém a especifcação deste tipo em seus argumentos.

### Variáveis {#sec:variable}

As variáveis são valores que você diz ao computador para armazenar com um nome específico, para que você possa recuperar ou alterar seu valor posteriormente.
Julia tem diversos tipos de variáveis, mas, em ciência de dados, usamos principalmente:

* Números inteiros: `Int64`
* Números reais: `Float64`
* Booleanas: `Bool`
* Strings: `String`

Inteiros e números reais são armazenados usando 64 bits por padrão, é por isso que eles têm o sufixo `64` no nome do tipo.
Se você precisar de mais ou menos precisão, existem os tipos `Int8` ou `Int128`, por exemplo, nos quais um maior número significa uma maior precisão.
Na maioria das vezes, isso não será um problema, então você pode simplesmente seguir os padrões.

Criamos novas variáveis escrevendo o nome da variável à esquerda e seu valor à direita, e no meio usamos o operador de atribuição `=`.
Por exemplo:

```jl
s = """
    name = "Julia"
    age = 9
    """
scob(s)
```

Observe que a saída de retorno da última instrução (`idade`) foi impressa no console.
Aqui, estamos definindo duas novas variáveis: `nome` e `idade`.
Podemos recuperar seus valores digitando os nomes dados na atribuição:

```jl
scob("name")
```

Se quiser definir novos valores para uma variável existente, você pode repetir os passos realizados durante a atribuição.
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
Podemos inspecionar os tipos das variáveis usando a função `typeof`:

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

Ter apenas variáveis à disposição, sem qualquer forma de hierarquia ou relacionamento não é o ideal.
Em Julia, podemos definir essa espécie de dado estruturado com um `struct` (também conhecido como tipo composto).
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

Algo importante de se notar com os `struct` é que não podemos alterar seus valores uma vez que são instanciados.
Podemos resolver isso com `mutable struct`.
Além disso, observe que objetos mutáveis geralmente serão mais lentos e mais propensos a erros.
Sempre que possível, faça com que tudo seja *imutável*.
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

Suponha que queremos mudar o campo título do objeto `julia_mutable`.
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
1. **Menor que**: ou algo é *menor que* ou *menor ou igual a*
    * <  "menor que"
    * <= ou ≤ "menor ou igual a"
1. **Maior que**: ou algo é *maior que* ou *maior ou igual a*
    * \> "maior que"
    * \>= ou ≥ "maior ou igual a"

Aqui temos alguns exemplos:

```jl
scob("1 == 1")
```

```jl
scob("1 >= 10")
```

As comparações funcionam até mesmo entre tipos diferentes:

```jl
scob("1 == 1.0")
```

Também podemos misturar e combinar operadores booleanos com comparações numéricas:

```jl
scob("(1 != 10) || (3.14 <= 2.71)")
```

### Funções {#sec:function}

Agora que já sabemos como definir variáveis e tipos personalizados como `struct`, vamos voltar nossa atenção para as **funções**.
Em Julia, uma função **mapeia os valores de seus argumentos para um ou mais valores de retorno**.
A sintaxe básica é assim:

```julia
function function_name(arg1, arg2)
    result = stuff with the arg1 and arg2
    return result
end
```

A declaração de funções começa com a palavra-chave `function` seguida do nome da função.
Então, entre parênteses `()`, nós definimos os argumentos separados por uma vírgula `,`.
Dentro da função, especificamos o que queremos que Julia faça com os parâmetros que fornecemos.
Todas as variáveis que definimos dentro de uma função são excluídas após o retorno da função. Isso é bom porque é como se realizasse uma limpeza automática.
Depois que todas as operações no corpo da função forem concluídas, instruímos Julia a retornar o resultado com o comando `return`.
Por fim, informamos a Julia que a definição da função terminou com a palavra-chave `end`.

Existe também a maneira compacta de definição de funções por meio da **forma de atribuição**:

```julia
f_name(arg1, arg2) = stuff with the arg1 and arg2
```

É a **mesma função** que antes, mas definida de uma forma diferente, mais compacta.
Como regra geral, quando seu código pode caber facilmente em uma linha de até 92 caracteres, a forma compacta é adequada.
Caso contrário, basta usar o formato mais longo com a palavra-chave `function`.
Vamos mergulhar em alguns exemplos.

#### Criando novas funções {#sec:function_example}

Vamos criar uma nova função que soma números:

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

E ela também funciona com números reais (também chamados em programação de números de ponto-flutuante ou, de forma mais curta, com o jargão "floats"):

```jl
scob("add_numbers(3.14, 2.72)")
```

Além disso, podemos definir comportamentos especializados para nossa função, por meio da especificação de declarações de tipo.
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

Podemos ver que ela é uma função com múltiplos métodos:

```jl
sco("methods(round_number)")
```

Mas há um problema: o que acontece se quisermos arredondar um float de 32 bits, `Float32`?
Ou um inteiro de 8 bits, `Int8`?

Se você quiser que algo funcione em todos os tipos de float e inteiros, você pode usar um **tipo abstrato** na assinatura de tipo, como `AbstractFloat` ou `Integer`:

```jl
s = """
    function round_number(x::AbstractFloat)
        return round(x)
    end
    """
sco(s)
```

Agora, funcionará da forma esperada com qualquer tipo de float:

```jl
s = """
    x_32 = Float32(1.1)
    round_number(x_32)
    """
scob(s)
```

> **_OBSERVAÇÃO:_**
> Podemos inspecionar tipos com as funções `supertypes` e `subtypes`.

Vamos voltar ao nosso `struct` `Language` que definimos anteriormente.
Será um exemplo de despacho múltiplo.
Vamos estender a função `Base.show` que imprime a saída de tipos instanciados e de `struct`.

Por padrão, uma `struct` tem um output básico, que você pôde observar do caso do `python`.
Podemos definir um novo método `Base.show` para nosso tipo `Language`, assim temos uma boa impressão para nossas instâncias de linguagens de programação.
Queremos comunicar claramente os nomes, títulos e idades em anos das linguagens de programação.
A função `Base.show` aceita como argumentos um tipo `IO` chamado `io` seguido pelo tipo para o qual você deseja definir o comportamento personalizado:

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

#### Múltiplos Valores de Retorno {#sec:function_multiple}

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
Esses argumentos são como argumentos comuns, exceto pelo fato de serem definidos após os argumentos de função regulares e separados por um ponto e vírgula `;`.
Por exemplo, vamos definir uma função `logarithm` que por padrão usa base $e$ (2.718281828459045) como um argumento de palavra-chave.
Perceba que aqui estamos usando o tipo abstrato `Real` para que possamos cobrir todos os tipos derivados de `Integer` e `AbstractFloat`, dado que ambos são subtipos de `Real`:

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

#### Funções Anônimas {#sec:function_anonymous}

Muitas vezes não nos importamos com o nome da função e queremos criar uma rapidamente.
O que precisamos é das **funções anônimas**.
Elas são muito usadas no fluxo de trabalho de ciência de dados em Julia.
Por exemplo, quando usamos `DataFrames.jl` (@sec:dataframes) ou `Makie.jl` (@sec:DataVisualizationMakie), às vezes precisamos de uma função temporária para filtrar dados ou formatar os rótulos de um gráfico.
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

A palavra-chave `if` comanda Julia a avaliar uma expressão e, dependendo se ela é verdadeira (`true`) ou falsa (`false`), a executar certas partes do código.
Podemos combinar várias condições `if` com a palavra-chave `elseif` para um fluxo de controle complexo.
Assim, podemos definir uma parte alternativa a ser executada se qualquer coisa dentro de `if` ou` elseif` for avaliada como `true`.
Esse é o propósito da palavra-chave `else`.
Finalmente, como em todos os operadores de palavra-chave que vimos anteriormente, devemos informar a Julia quando a declaração condicional for concluída com a palavra-chave `end`.

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

Podemos até envelopar isso em uma função chamada `compare`:

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


### Laço For {#sec:for}

O clássico laço for em Julia segue uma sintaxe semelhante à das declarações condicionais.
Você começa com a palavra-chave, nessa caso `for`.
Em seguida, você especifica o que Julia deve iterar sobre (ou, no jargão, "loopar"), p. ex., uma sequência.
Além disso, como em tudo mais, você deve terminar com a palavra-chave `end`.

Então, para fazer Julia imprimir todos os números de 1 a 10, você pode usar o seguinte laço for:

```jl
s = """
    for i in 1:10
        println(i)
    end
    """
sco(s; post=x -> "")
```

### Laço While {#sec:while}

O laço while é uma mistura das declarações condicionais anteriores com os laços for.
Aqui, o laço é executado toda vez que a condição é avaliada como `true`.
A sintaxe segue a mesma forma da anterior.
Começamos com a palavra-chave `while`, seguido por uma declaração que é avaliada em `true` ou `false`.
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
Isso se deve ao **escopo de variável**.
Variáveis definidas dentro das declarações condicionais, laços e funções existem apenas dentro delas.
Isso é conhecido como o *escopo* da variável.
Aqui, precisamos avisar Julia que o `n` dentro do laço `while` está no escopo global por meio do uso da palavra-chave `global`.

Por fim, também usamos o operador `+=` que é uma boa abreviatura para `n = n + 1`.

## Estruturas Nativas de Dados {#sec:data_structures}

Julia possui diversas estruturas de dados nativas.
Elas são abstrações de dados que representam alguma forma de dado estruturado.
Vamos cobrir os mais usados.
Eles contém dados homogêneos ou heterogêneos.
Uma vez que são coleções, podemos iterar sobre eles com os laços `for`.

Nós cobriremos `String`, `Tuple`, `NamedTuple`, `UnitRange`, `Arrays`, `Pair`, `Dict`, `Symbol`.

Quando você se depara com uma estrutura de dados em Julia, você pode encontrar métodos que a aceitam como um argumento por meio da função `methodswith`.
Em Julia, a distinção entre métodos e funções é a seguinte:
Cada função pode ter mútiplos métodos, como mostramos anteriormente.
A função `methodswith` é boa de se ter por perto.
Vejamos o que podemos fazer com uma `String`, por exemplo:

```jl
s = "first(methodswith(String), 5)"
sco(s; process=catch_show)
```

### Fazendo Broadcasting de Operadores e Funções {#sec:broadcasting}

Antes de mergulharmos nas estruturas de dados, precisamos conversar sobre broadcasting (também conhecido como *vetorização*) e o operador "dot" `.`.

Podemos vetorizar operações matemáticas como `*` (multiplicação) ou `+` (adição) usando o operador dot.
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

#### Funções com exclamação `!` {#sec:function_bang}

É uma convenção de Julia acrescentar uma exclamação `!` a nomes de funções que modificam um ou mais de seus argumentos.
Esta convenção avisa o usuário que a função **não é pura**, ou seja, que tem *efeitos colaterais*.
Uma função com efeitos colaterais é útil quando você deseja atualizar uma grande estrutura de dados ou coleção de variáveis sem ter toda a sobrecarga da criação de uma nova instância.

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

Ao usar crases triplas, a tabulação e o marcador de nova linha no início são ignorados por Julia.
Isso melhora a legibilidade do código porque você pode indentar o bloco em seu código-fonte sem que esses espaços acabem em sua string.

#### Concatenação de Strings {#sec:string_concatenation}

Uma operação comum de string é a **concatenação de string**.
Suponha que você queira construir uma nova string que é a concatenação de duas ou mais strings.
Isso é realizado em Julia com o operador `*` ou a função `join`.
Este símbolo pode soar como uma escolha estranha e realmente é.
Por enquanto, muitas bases de código em Julia estão usando este símbolo, então ele permanecerá na linguagem.
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
Nós apenas passamos como argumentos as strings dentro dos colchetes `[]` e, em seguida, o separador:

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

Isso funciona mesmo dentro de funções.
Vamos revisitar nossa função `test` que foi definida em @sec:conditionals:

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
Vamos demonstrar as mais comuns.
Além disso, observe que a maioria dessas funções aceita uma [Expressão Regular (RegEx)](https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions) como argumentos.
Não cobriremos RegEx neste livro, mas te encorajamos a aprender sobre elas, especialmente se a maior parte de seu trabalho usa dados textuais.

Primeiro, vamos definir uma string para brincarmos:

```jl
s = """
    julia_string = "Julia is an amazing opensource programming language"
    """
scob(s)
```


1. `occursin`, `startswith` e `endswith`: São condicionais (retornam `true` ou `false`) se o primeiro argumento é um:
    * **substring** do segundo argumento

       ```jl
       scob("""occursin("Julia", julia_string)""")
       ```

    * **prefixo** do segundo argumento

       ```jl
       scob("""startswith("Julia", julia_string)""")
       ```

    * **sufixo** do segundo argumento

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

4. `split`: fatia uma string por um delimitador:

     ```jl
     sco("""split(julia_string, " ")""")
     ```

#### Convertendo em/parseando Strings {#sec:string_conversions}

Muitas vezes, precisamos **converter** tipos de variáveis em Julia.
Para converter um número em uma string, podemos usar a função `string`:

```jl
s = """
    my_number = 123
    typeof(string(my_number))
    """
sco(s)
```

Às vezes, queremos o oposto: converter uma string em um número (ou, como se diz no jargão, parsear essa string).
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

Uma tupla é um **contâiner de tamanho fixo que pode conter vários tipos diferentes**.
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

Também podemos iterar sobre tuplas com a palavra-chave `for`.
E até mesmo aplicar funções sobre tuplas.
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

Agora você pode ver porque tuplas e funções são frequentemente relacionadas.

Mais uma coisa para pensarmos sobre as tuplas.
**Quando você deseja passar mais de uma variável para uma função anônima, adivinhe o que você precisa usar? Tuplas!**

```jl
scob("map((x, y) -> x^y, 2, 3)")
```

Ou ainda, mais do que dois argumentos:

```jl
scob("map((x, y, z) -> x^y + z, 2, 3, 1)")
```

### Tupla Nomeada {#sec:namedtuple}

Às vezes, você deseja nomear os valores contidos nas tuplas.
É aí que entram as **tuplas nomeadas**.
Sua funcionalidade é praticamente a mesma das tuplas:
são **imutáveis** e podem conter **todo tipo de valor**.

A construção das tuplas nomeadas é ligeiramente diferente das tuplas.
Você tem os familiares parênteses `()` e a vírgula `,` separadora de valor.
Mas agora, você **nomeia os valores**:

```jl
sco("""my_namedtuple = (i=1, f=3.14, s="Julia")""")
```

Podemos acessar os valores de uma tupla nomeada por meio da indexação como em tuplas regulares ou, alternativamente, **acessá-los por seus nomes** com o `.`:

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

Como você pode ver, nosso range instanciado é do tipo `UnitRange{T}` onde `T` é o tipo de dados contido dentro de `UnitRange`:

```jl
sco("typeof(1:10)")
```

E, se recolhermos todos os valores, temos:

```jl
sco("[x for x in 1:10]")
```

Também podemos construir ranges para outros tipos:

```jl
sco("typeof(1.0:10.0)")
```

Às vezes, queremos mudar o comportamento padrão do incremento do intervalo.
Podemos fazer isso adicionando um incremento específico por meio da sintaxe da range `start:step:stop`.
Por exemplo, suponha que queremos um range de `Float64` que vá de 0 a 1 com passos do tamanho de 0.2:

```jl
sco("0.0:0.2:1.0")
```

Se você quer "materializar" a range, transformando-a em uma coleção, você pode usar a função `collect`:

```jl
sco("collect(1:10)")
```

Assim, temos uma array do tipo especificado no range entre os limites que definimos.
Já que estamos falando de arrays, vamos conversar sobre eles.

### Array {#sec:array}

Na sua forma mais básica, **arrays** contém múltiplos objetos.
Por exemplo, elas podem armazenar múltiplos números em uma dimensão:

```jl
sco("myarray = [1, 2, 3]")
```

Na maioria das vezes você quer ter **arrays de tipo único para evitar problemas de performance**, mas observe que elas também podem conter objetos de diferentes tipos:

```jl
sco("myarray = [\"text\", 1, :symbol]"; process=output_block)
```

Elas são o "pão com manteiga" da ciência de dados, porque as arrays são o que está por trás da maior parte do fluxo de trabalho em **manipulação de dados** e **visualização de dados**.

Portanto, **arrays são uma estrutura de dados essencial**.

#### Tipos de array {#sec:array_types}

Vamos começar com os **tipos de arrays**.
Existem vários, mas vamos nos concentrar nos dois mais usados em ciência de dados:

* `Vector{T}`: array **unidimensional**. Escrita alternativa para `Array{T, 1}`.
* `Matrix{T}`: array**bidimensional**. Escrita alternativa para `Array{T, 2}`.

Observe aqui que `T` é o tipo da array subjacente.
Então, por exemplo, `Vector{Int64}` é um `Vector` no qual todos os elementos são `Int64`, e `Matrix{AbstractFloat}` é uma `Matrix` em que todos os elementos são subtipos de `AbstractFloat`.

Na maioria das vezes, especialmente ao lidar com dados tabulares, estamos usando arrays unidimensionais ou bidimensionais.
Ambos são tipos `Array` para Julia.
Mas, podemos usar os apelidos úteis `Vector` e `Matrix` para uma sintaxe clara e concisa.

#### Construção de Array {#sec:array_construction}

Como **construímos** uma array?
Nesta seção, começamos construindo arrays de uma forma mais baixo-nível.
Isso pode ser necessário para escrever código de alto desempenho em algumas situações.
No entanto, isso não é necessário na maioria das situações, e podemos, com segurança, usar métodos mais convenientes para criar arrays.
Esses métodos mais convenientes serão descritos posteriormente nesta seção.

O construtor de baixo nível para arrays em Julia é o **construtor padrão**.
Ele aceita o tipo de elemento como o parâmetro de tipo dentro dos colchetes `{}` e dentro do construtor você passará o tipo de elemento seguido pelas dimensões desejadas.
É comum inicializar vetores e matrizes com elementos indefinidos usando o argumento para tipo `undef`.
Um vetor de 10 elementos `undef` `Float64` pode ser construído como:

```jl
s = """
    my_vector = Vector{Float64}(undef, 10)
    """
sco(s)
```

Para matrizes, uma vez que estamos lidando com objetos bidimensionais, precisamos passar dois argumentos de dimensão dentro do construtor: um para **linhas** e outro para **colunas**.
Por exemplo, uma matriz com 10 linhas e 2 colunas de elementos indefinidos `undef` pode ser instanciada como:

```jl
s = """
    my_matrix = Matrix{Float64}(undef, 10, 2)
    """
sco(s)
```

Nós também temos algumas **apelidos sintáticos** para os elementos mais comuns na construção de arrays:

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

Para outros elementos, podemos primeiro instanciar uma array com elementos `undef` e usar a função `fill!` para preencher todos os elementos de uma array com o elemento desejado.
Segue um exemplo com `3.14` ($\pi$):

```jl
s = """
    my_matrix_π = Matrix{Float64}(undef, 2, 2)
    fill!(my_matrix_π, 3.14)
    """
sco(s)
```

Também podemos criar arrays com **literais de array**.
Por exemplo, segue uma matriz 2x2 de inteiros:

```jl
s = """
    [[1 2]
     [3 4]]
    """
sco(s)
```

Literais de array também aceitam uma especificação de tipo antes dos colchetes `[]`.
Então, se quisermos a mesma array 2x2 de antes mas agora como floats, podemos:

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

Você pode até **misturar e combinar** literais de array com os construtores:

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

Outra maneira poderosa de criar uma array é escrever uma **compreensão de array**.
Esta maneira de criar arrays é melhor na maioria dos casos: evita loops, indexação e outras operações sujeitas a erros.
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

Tal como acontece com literais de array, você pode especificar o tipo desejado antes dos colchetes `[]`:

```jl
s = """
    Float64[x^2 for x in 1:10 if isodd(x)]
    """
sco(s)
```

Finalmente, também podemos criar arrays com **funções de concatenação**.
Concatenação é um termo padrão em programação e significa "acorrentar juntos".
Por exemplo, podemos concatenar strings com "aa" e "bb" para conseguir "aabb":

```jl
s = """
    "aa" * "bb"
    """
sco(s)
```

E podemos concatenar arrays para criar novas arrays:

* `cat`: concatenar arrays de entrada ao longo de uma dimensão específica `dims`

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

#### Inspeção de Arrays {#sec:array_inspection}

Assim que tivermos arrays, o próximo passo lógico seria **inspeciona-las**.
Existem várias funções úteis que permitem ao usuário ter uma visão de qualquer array.

É muito útil saber que **tipo de elementos** existem dentro de uma array.
Fazemos isso com `eltype`:

```jl
sco("eltype(my_matrix_π)")
```

Depois de conhecer seus tipos, alguém pode se interessar nas **dimensões da array**.
Julia tem várias funções para inspecionar as dimensões da array:

* `length`: número total de elementos

     ```jl
     scob("length(my_matrix_π)")
     ```

* `ndims`: número de dimensões

     ```jl
     scob("ndims(my_matrix_π)")
     ```

* `size`: esse é um pouco complicado.
    Por padrão, ele retornará uma tupla contendo as dimensões da array.

     ```jl
     sco("size(my_matrix_π)")
     ```

    Você pode obter uma dimensão específica com um segundo argumento para `size`.
    Aqui, o segundo eixo são as colunas

     ```jl
     scob("size(my_matrix_π, 2)")
     ```

#### Indexação e Fatiamento de Array {#sec:array_indexing}

Às vezes, queremos inspecionar apenas certas partes de uma array.
Chamamos isso de **indexação** e **fatiamento**.
Se você quiser uma observação particular de um vetor, ou uma linha ou coluna de uma matriz, você provavelmente precisará **indexar uma array**.

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
Você usa colchetes `[]` com o **índice** desejado dentro:

```jl
scob("my_example_vector[2]")
```

A mesma sintaxe segue com as matrizes.
Mas, como as matrizes são arrays bidimensionais, temos que especificar *ambas* linhas e colunas.
Vamos recuperar o elemento da segunda linha (primeira dimensão) e primeira coluna (segunda dimensão):

```jl
scob("my_example_matrix[2, 1]")
```

Júlia também possui palavras-chave convencionais para o **primeiro** e **último** elementos de uma array: `begin` e `end`.
Por exemplo, o penúltimo elemento de um vetor pode ser recuperado como:

```jl
scob("my_example_vector[end-1]")
```

Isso também funciona para matrizes.
Vamos recuperar o elemento da última linha e segunda coluna:

```jl
scob("my_example_matrix[end, begin+1]")
```

Muitas vezes, não estamos só interessados em apenas um elemento da array, mas em todo um **subconjunto de elementos da array**.
Podemos fazer isso **fatiando** uma array.
Usamos a mesma sintaxe de índice, mas adicionando dois pontos `:` para denotar os limites a partir dos quais estamos fatiando a array.
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

#### Manipulações de Array {#sec:array_manipulation}

Existem várias formas para **manipular** uma array.
O primeiro seria manipular um **único elemento da array**.
Nós apenas indexamos a array pelo elemento desejado e procedemos com uma atribuição `=`:

```jl
s = """
    my_example_matrix[2, 2] = 42
    my_example_matrix
    """
sco(s)
```

Ou, você pode manipular um determinado **subconjunto de elementos da array**.
Nesse caso, precisamos fatiar a array e, em seguida, atribuir com `=`:

```jl
s = """
    my_example_matrix[3, :] = [17, 16, 15]
    my_example_matrix
    """
sco(s)
```

Observe que tivemos que atribuir um vetor porque nossa array fatiada é do tipo `Vector`:

```jl
s = """
    typeof(my_example_matrix[3, :])
    """
sco(s)
```

A segunda maneira de manipular uma array é **alterando suas dimensões**.
Suponha que você tenha um vetor de 6 elementos e deseja torná-lo uma matriz 3x2.
Você pode fazer isso com `reshape`, usando a array como o primeiro argumento e uma tupla de dimensões como segundo argumento:

```jl
s = """
    six_vector = [1, 2, 3, 4, 5, 6]
    tree_two_matrix = reshape(six_vector, (3, 2))
    tree_two_matrix
    """
sco(s)
```

Você pode convertê-la de volta em um vetor especificando uma tupla com apenas uma dimensão como o segundo argumento:

```jl
sco("reshape(tree_two_matrix, (6, ))")
```

A terceira forma pela qual podemos manipular uma array é **aplicando uma função sobre cada elemento da array**.
Aqui é onde o operador "dot" `.`, também conhecido como _broadcasting_, entra.

```jl
sco("logarithm.(my_example_matrix)")
```

O operador dot em Julia é extremamente versátil.
Você pode até mesmo usá-lo para vetorizar operadores infixos:

```jl
sco("my_example_matrix .+ 100")
```

Uma alternativa para fazer o broadcasting de função sobre um vetor é usar `map`:

```jl
sco("map(logarithm, my_example_matrix)")
```

Para funções anônimas, `map` geralmente é mais legível.
Por exemplo,

```jl
sco("map(x -> 3x, my_example_matrix)")
```

é bastante claro.
No entanto, a mesma operação utilizando o operador de broadcast fica da seguinte forma:

```jl
sco("(x -> 3x).(my_example_matrix)")
```

Além disso, `map` funciona com fatiamento:

```jl
sco("map(x -> x + 100, my_example_matrix[:, 3])")
```

Finalmente, às vezes, e especialmente ao lidar com dados tabulares, queremos aplicar uma **função sobre todos os elementos em uma dimensão específica de uma array**.
Isso pode ser feito com a função `mapslices`.
Parecido com `map`, o primeiro argumento é a função e o segundo argumento é a array.
A única mudança é que precisamos especificar o argumento `dims` para sinalizar em qual dimensão queremos transformar os elementos.

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

#### Iteração de array {#sec:array_iteration}

Uma operação comum é **iterar sobre uma array com um laço `for`**.
O **laço `for` regular, quando aplicado sobre uma array retorna cada elemento**.

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

Às vezes, você não quer iterar sobre cada elemento, mas sim sobre cada índice da array.
**Podemos usar a função `eachindex` combinada com um loop `for` para iterar sobre cada índice de array**.

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

Nesse exemplo, o `eachindex(forty_twos)` retorna os índices de `forty_twos`, nomeadamente `[1, 2, 3]`.

Da mesma forma, podemos iterar sobre matrizes.
O laço `for` padrão itera primeiro sobre as colunas e depois sobre as linhas.
Ele irá primeiro percorrer todos os elementos na coluna 1, da primeira à última linha, em seguida, ele se moverá para a coluna 2 de maneira semelhante até cobrir todas as colunas.

Para aqueles familiarizados com outras linguagens de programação:
Julia, como a maioria das linguagens de programação científica, é "colunar".
Colunar significa que os elementos da coluna são armazenados lado a lado na memória[^pointers].
Isso também significa que iterar sobre os elementos em uma coluna é muito mais rápido do que sobre os elementos em uma linha.

[^pointers]: ou, que os ponteiros de endereço de memória para os elementos na coluna são armazenados um ao lado do outro.

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

Se fizermos um loop sobre o vetor armazenado de forma ordenada para as colunas, então o resultado também é ordenado:

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

No entanto, o resultado não fica ordenado ao interarmos sobre a outra matriz:

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

* `eachcol`: itera sobre uma array coluna a coluna

     ```jl
     sco("first(eachcol(column_major))")
     ```

* `eachrow`: itera sobre uma array linha a linha

     ```jl
     sco("first(eachrow(column_major))")
     ```

### Par {#sec:pair}

Em comparação com a enorme seção sobre arrays, esta seção sobre pares será breve.
**`Par` é uma estrutura de dados que contém dois objetos** (que em geral estão relacionados um ao outro).
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

Os pares serão muito usados na manipulação e visualização de dados, uma vez que ambos `DataFrames.jl` (@sec:dataframes) e `Makie.jl` (@sec:DataVisualizationMakie) aceitam objetos do tipo `Pair` em suas funções principais.
Por exemplo, com `DataFrames.jl` veremos que `:a => :b` pode ser usado para renomear a coluna `:a` para `:b`.

### Dict {#sec:dict}

Se você entendeu o que é um `Pair`, então `Dict` não será um problema.
Para todos os propósitos práticos, **`Dict`s são mapeamentos de chaves para valores**.
Por mapeamento, queremos dizer que se você der alguma chave a um `Dict`, então o `Dict` poderá lhe dizer qual valor pertence àquela chave.
Chaves (`key`s) e valores (`value`s) podem ser de qualquer tipo, mas normalmente `key`s são strings.

Existem duas maneiras de construir `Dict`s em Julia.
A primeira é passando um vetor de tuplas como `(key, value)` para o construtor `Dict`:

```jl
sco(
"""
# tuples # hide
name2number_map = Dict([("one", 1), ("two", 2)])
"""
)
```

Existe uma sintaxe mais legível com base no tipo `Pair` descrito acima.
Você também pode passar `Pair`s de `key => value`s para o construtor `Dict`:

```jl
sco(
"""
# pairs # hide
name2number_map = Dict("one" => 1, "two" => 2)
"""
)
```

Você pode recuperar um `value` de um `Dict`s ao indexá-lo pela `key` correspondente:

```jl
scob("""name2number_map["one"]""")
```

Para adicionar uma nova entrada, você indexa o `Dict` pela `key` desejada e atribui um `value` com o operador de atribuição `=`:

```jl
scob(
"""
name2number_map["three"] = 3
"""
)
```

Se você quer checar se um `Dict` tem uma certa `key` você pode usar `keys` e `in`:

```jl
scob("\"two\" in keys(name2number_map)")
```

Para deletar uma `key` você pode usar a função `delete!`:

```jl
sco(
"""
delete!(name2number_map, "three")
"""
)
```

Ou, para excluir uma chave enquanto retorna seu valor, você pode usar `pop!`:

```jl
scob("""popped_value = pop!(name2number_map, "two")""")
```

Agora, nosso `name2number_map` tem apenas uma `key`:

```jl
sco("name2number_map")
```

`Dict`s também são usados para manipulação de dados por `DataFrames.jl` (@sec:dataframes) e para visualização de dados por `Makie.jl` (@sec:DataVisualizationMakie).
Logo, é importante conhecer suas funcionalidades básicas.

Existe outra maneira útil de construir `Dict`s.
Suponha que você tenha dois vetores e deseja construir um `Dict` com um deles como se fosse `key`s e outro como se fosse `value`s.
Você pode fazer isso com uma função `zip` que "junta" dois objetos (como um zíper):

```jl
sco(
"""
A = ["one", "two", "three"]
B = [1, 2, 3]

name2number_map = Dict(zip(A, B))
"""
)
```

Por exemplo, agora podemos obter o número 3 via:

```jl
scob("""name2number_map["three"]""")
```

### Símbolo {#sec:symbol}

`Symbol` na verdade *não* é uma estrutura de dados.
É um tipo e se comporta de modo muito parecido com uma string.
Em vez de colocar o texto entre aspas, um símbolo começa com dois pontos (:) e pode conter sublinhados:

```jl
sco("sym = :some_text")
```

Podemos facilmente converter um símbolo em string e vice-versa:

```jl
scob("s = string(sym)")
```

```jl
sco("sym = Symbol(s)")
```

Um benefício simples dos símbolos é que você digita um caractere a menos, ou seja, `:some_text` versus `"some text"`.
Usamos muito `Symbol`s na manipulação de dados com o package `DataFrames.jl` (@sec:dataframes) e em visualização de dados com o package `Makie.jl` (@sec:DataVisualizationMakie).

### Operador Splat {#sec:splat}

Em Julia, temos o operador "splat" `...` que é usado em chamadas de função como uma **sequência de argumentos**.
Ocasionalmente, usaremos o splat em algumas chamadas de função nos capítulos sobre **manipulação de dados** e **visualização de dados**.

A maneira mais intuitiva de aprender sobre o splat é com um exemplo.
A função `add_elements` abaixo leva três argumentos para serem somados:

```jl
sco("add_elements(a, b, c) = a + b + c")
```

Agora, suponha que temos uma coleção com três elementos.
A maneira ingênua de fazer isso seria fornecer à função todos os três elementos como argumentos de função:

```jl
scob("""
my_collection = [1, 2, 3]

add_elements(my_collection[1], my_collection[2], my_collection[3])
""")
```

Aqui é que usamos o operador "splat" `...` que pega uma coleção (geralmente uma array, vetor, tupla ou range) e a converte em uma sequência de argumentos:

```jl
scob("add_elements(my_collection...)")
```

O `...` deve ser incluído após a coleção que queremos espalhar ou "splat" em uma sequência de argumentos.
Ambos os exemplos apresentados acima têm o mesmo resultado:

```jl
scob("""
add_elements(my_collection...) == add_elements(my_collection[1], my_collection[2], my_collection[3])
""")
```

Sempre que Julia vê um operador splat dentro de uma chamada de função, ele será convertido em uma sequência de argumentos para todos os elementos da coleção separados por vírgulas.

Também funciona para ranges:

```jl
scob("add_elements(1:3...)")
```

## Sistema de Arquivos {#sec:filesystem}

Em ciência de dados, a maioria dos projetos é realizada em um esforço colaborativo.
Compartilhamos código, dados, tabelas, figuras e assim por diante.
Por trás de tudo, está o **sistema de arquivos do sistema operacional (SO)**.
Em um mundo perfeito, o mesmo programa daria a **mesma** saída quando executado em sistemas operacionais **diferentes**.
Infelizmente, nem sempre é esse o caso.
Um exemplo disso é a diferença entre os caminhos do Windows, tal como `C:\\user\john\`, e do Linux, como `/home/john`.
Por isso é importante discutir as **melhores práticas em sistema de arquivos**.

Julia tem recursos de sistema de arquivos nativos que **lidam com as diferenças entre os sistemas operacionais**.
Eles estão localizados no módulo [`Filesystem`](https://docs.julialang.org/en/v1/base/file/) da biblioteca central `Base` de Julia.

Sempre que você estiver lidando com arquivos como CSV, Excel ou qualquer outro script de Julia, certifique-se de que seu código **funciona em sistemas de arquivos de SOs diferentes**.
Isso é facilmente realizado com as funções `joinpath`, `@__FILE__` e `pkgdir`.

Se você escrever seu código em um pacote, você pode usar `pkgdir` para obter o diretório raiz do pacote.
Por exemplo, para o pacote de Julia Data Science (JDS) que usamos para produzir este livro:

```jl
root = pkgdir(JDS)
```

como você pode ver, o código para produzir este livro foi executado em um computador Linux.
Se você está usando um script, você pode obter a localização do arquivo de script via

```julia
root = dirname(@__FILE__)
```

O bom desses dois comandos é que eles são independentes de como o usuário iniciou o Julia.
Em outras palavras, não importa se o usuário iniciou o programa com `julia scripts/script.jl` ou `julia script.jl`, em ambos os casos os caminhos são os mesmos.

A próxima etapa seria incluir o caminho relativo a partir de `root` para o nosso arquivo desejado.
Uma vez que diferentes sistemas operacionais têm maneiras diferentes de construir caminhos relativos com subpastas (alguns usam barras `/` enquanto outros podem usar barras invertidas `\`), não podemos simplesmente concatenar o caminho relativo do arquivo com a string `root`.
Para isso, temos a função `joinpath`, que unirá diferentes caminhos relativos e nomes de arquivos de acordo com a implementação específica do sistema de arquivos do seu sistema operacional.

Supondo que você tenha um script chamado `my_script.jl` dentro do diretório do seu projeto.
Você pode ter uma representação robusta do caminho do arquivo para `my_script.jl` como:

```jl
scob("""joinpath(root, "my_script.jl")""")
```

`joinpath` também lida com **subfolders**.
Agora vamos imaginar uma situação comum em que você tem uma pasta chamada `data/` no diretório do seu projeto.
Dentro desta pasta, há um arquivo CSV chamado `my_data.csv`.
Você pode ter a mesma representação robusta do caminho do arquivo para `my_data.csv` como:

```jl
scob("""joinpath(root, "data", "my_data.csv")""")
```

É um bom hábito de adquirir, porque é muito provável que evite problemas para você ou outras pessoas mais tarde.

## Biblioteca Padrão de Julia {#sec:standardlibrary}

Julia tem uma **biblioteca padrão rica** que está disponível em *toda* instalação de Julia.
Ao contrário de tudo o que vimos até agora, por exemplo, tipos, estruturas de dados e sistema de arquivos; você **deve carregar módulos de biblioteca padrão em seu ambiente** para usar um módulo ou função particular.

Isso é feito via `using` ou `import`.
Neste livro, carregaremos o código via `using`:

```julia
using ModuleName
```

Depois de fazer isso, você pode acessar todas as funções e tipos dentro do módulo chamado `ModuleName`.

### Datas {#sec:dates}

Saber como lidar com datas e timestamps é importante na ciência de dados.
Como dissemos na seção *Por que Julia?* (@sec:why_julia), o `pandas` do Python usa seu próprio tipo de `datetime` para lidar com datas.
O mesmo é verdade no tidyverse de R, no pacote `lubridate`, que também define o seu próprio tipo de `datetime` para lidar com datas.
Em Julia, os pacotes não precisam escrever sua própria lógica de datas, porque Julia tem um módulo de datas em sua biblioteca padrão chamado `Dates`.

Para começar, vamos carregar o módulo `Dates`:

```julia
using Dates
```

#### Tipos `Date` e `DateTime` {#sec:dates_types}

O módulo de biblioteca padrão `Dates` tem **dois tipos para trabalhar com datas**:

1. `Date`: representando o tempo em dias e
2. `DateTime`: representando o tempo com precisão de milisegundos.

Nós podemos construir `Date` e `DateTime` com o construtor padrão especificando um número inteiro para representar ano, mês, dia, horas e assim por diante:

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

Para os curiosos, 13 de setembro de 1987, 21:21 é a hora oficial do nascimento do primeiro autor, José.

Nós também podemos passar tipos "período" ou `Period` para o construtor padrão.
**Tipos `Period` são o equivalente-humano para a representação do tempo** para o computador.
`Dates` em Julia têm os seguintes subtipos abstratos de `Period`:

```jl
sco("subtypes(Period)")
```

que se dividem nos seguintes tipos concretos, e eles são bastante autoexplicativos:

```jl
sco("subtypes(DatePeriod)")
```

```jl
sco("subtypes(TimePeriod)")
```

Assim, poderíamos, alternativamente, construir a hora oficial de nascimento de José como:

```jl
sco("DateTime(Year(1987), Month(9), Day(13), Hour(21), Minute(21))")
```

#### Parseando Datas {#sec:dates_parsing}

Na maioria das vezes, não construiremos instâncias `Date` ou `DateTime` do zero.
Na verdade, nós provavelmente **parsearemos strings para transformá-las em tipos `Date` ou `DateTime`**.

Os construtores `Date` e `DateTime` podem ser alimentados com uma string e uma string de formato de data.
Por exemplo, a string `"19870913"` representando 13 de setembro de 1987 pode ser parseada com:

```jl
sco("""Date("19870913", "yyyymmdd")""")
```

Observe que o segundo argumento é uma representação em string do formato.
Temos os primeiros quatro dígitos que representam o ano `y`, seguido por dois dígitos para o mês `m` e finalmente dois dígitos para dia `d`.

Também funciona para timestamps com `DateTime`:

```jl
sco("""DateTime("1987-09-13T21:21:00", "yyyy-mm-ddTHH:MM:SS")""")
```

Você pode encontrar mais informações sobre como especificar diferentes formatos de data na [documentação `Dates`' de Julia](https://docs.julialang.org/en/v1/stdlib/Dates/#Dates.DateFormat).
Não se preocupe se você tiver que revisitá-lo o tempo todo, nós mesmos fazemos isso ao trabalhar com datas e timestamps.

De acordo com a [documentação `Dates`' de Julia](https://docs.julialang.org/en/v1/stdlib/Dates/#Constructors), usar o método `Date(date_string, format_string)` é satisfatório se ele for chamado apenas algumas vezes.
Se houver muitas strings de data formatadas de forma semelhante para analisar, no entanto, é muito mais eficiente criar primeiro um tipo `DateFormat`, e, em seguida, o passar em vez de uma string de formato bruto.
Então, nosso exemplo anterior se torna:

```jl
s = """
    format = DateFormat("yyyymmdd")
    Date("19870913", format)
    """
sco(s)
```

Como alternativa, sem perda de desempenho, você pode usar o prefixo de string literal `dateformat"..."`:

```jl
sco("""Date("19870913", dateformat"yyyymmdd")""")
```

#### Extraindo Informações de Data {#sec:dates_information}

É fácil **extrair as informações desejadas dos objetos `Date` e` DateTime`**.
Primeiro, vamos criar uma instância de uma data muito especial:

```jl
sco("""my_birthday = Date("1987-09-13")""")
```

Podemos extrair tudo o que quisermos de `my_birthday`:

```jl
scob("year(my_birthday)")
```

```jl
scob("month(my_birthday)")
```

```jl
scob("day(my_birthday)")
```

O módulo `Dates` de Julia também tem **funções compostas que retornam uma tupla de valores**:

```jl
sco("yearmonth(my_birthday)")
```

```jl
sco("monthday(my_birthday)")
```

```jl
sco("yearmonthday(my_birthday)")
```

Também podemos ver o dia da semana e outras coisas úteis:

```jl
scob("dayofweek(my_birthday)")
```

```jl
scob("dayname(my_birthday)")
```

```jl
scob("dayofweekofmonth(my_birthday)")
```

Sim, José nasceu no segundo domingo de setembro.

> **_OBSERVAÇÃO:_**
> Aqui está uma dica útil para recuperar apenas os dias de semana de instâncias de `Dates`.
> Use o `filter` no `dayofweek(your_date) <= 5`.
> Para o dia útil, você pode verificar o pacote [`BusinessDays.jl`](https://github.com/JuliaFinance/BusinessDays.jl).

#### Operações de Data {#sec:dates_operations}

Podemos realizar **operações** em instâncias de `Dates`.
Por exemplo, podemos adicionar dias a uma instância `Date` ou `DateTime`.
Note que as `Dates` em Julia executará automaticamente os ajustes necessários para anos bissextos, e por meses com 30 ou 31 dias (isso é conhecido como aritmética *calendárica*.

```jl
sco("my_birthday + Day(90)")
```

Podemos adicionar quantas quisermos:

```jl
sco("my_birthday + Day(90) + Month(2) + Year(1)")
```

Caso você esteja se perguntando: "O que posso fazer com datas mesmo? O que está disponível?", então você pode usar `methodswith` para verificar.
Mostramos apenas os primeiros 20 resultados aqui:

```jl
s = "first(methodswith(Date), 20)"
sco(s; process=catch_show)
```

A partir disso, podemos concluir que também podemos usar o operador de sinal de mais `+` e menos `-`.
Vamos ver quantos anos o José tem, em dias:

```jl
sco("today() - my_birthday")
```

A **duração padrão** de tipos de `Date` é uma instância de `Day`.
Para o `DateTime`, a duração padrão é uma instância de `Millisecond`:

```jl
sco("DateTime(today()) - DateTime(my_birthday)")
```

#### Intervalos de Data {#sec:dates_intervals}

Uma coisa boa sobre o módulo `Dates` é que também podemos construir facilmente **intervalos de data e hora**.
Julia é inteligente o suficiente para não ter que definir todos os tipos de intervalo e operações que abordamos em @sec:ranges.
Ela apenas estende as funções e operações definidas para range para os tipos `Date`.
Isso é conhecido como despacho múltiplo e já abordamos isso em *Por que Julia?* (@sec:why_julia).

Por exemplo, suponha que você deseja criar um intervalo de tipo `Day`.
Isso é fácil de fazer com o operador dois-pontos `:`:

```jl
sco("""Date("2021-01-01"):Day(1):Date("2021-01-07")""")
```

Não há nada de especial em usar `Day(1)` como o intervalo, podemos **usar qualquer tipo `Period`** como intervalo.
Por exemplo, usando 3 dias como intervalo:

```jl
sco("""Date("2021-01-01"):Day(3):Date("2021-01-07")""")
```

Ou mesmo meses:

```jl
sco("""Date("2021-01-01"):Month(1):Date("2021-03-01")""")
```

Perceba que o **tipo deste intervalo é um `StepRange` com o `Date` e um tipo concreto `Period`** que usamos como intervalo dentro do operador `:`:

```jl
s = """
    date_interval = Date("2021-01-01"):Month(1):Date("2021-03-01")
    typeof(date_interval)
    """
sco(s)
```

Podemos converter isso para um **vetor** com a função `collect`:

```jl
sco("collected_date_interval = collect(date_interval)")
```

E teremos todas as **funcionalidades de array disponíveis**, como, por exemplo, indexação:

```jl
sco("collected_date_interval[end]")
```

Também podemos fazer **broadcast de operações de data** em um vetor de `Date`s:

```jl
sco("collected_date_interval .+ Day(10)")
```

Da mesma forma, esses exemplos funcionam para tipos `DateTime` também.

### Números Aleatórios {#sec:random}

Outro módulo importante na biblioteca padrão de Julia é o módulo `Random`.
Este módulo lida com **geração de números aleatórios**.
`Random` é uma biblioteca rica e, se você está interessado, deve consultar a [documentação `Random` de Julia](https://docs.julialang.org/en/v1/stdlib/Random/).
Vamos cobrir *somente* três funções: `rand`, `randn` e `seed!`.

Para começar, primeiro carregamos o módulo `Random`.
Como sabemos exatamente o que queremos carregar, podemos também carregar explicitamente os métodos que queremos usar:

```julia
using Random: rand, randn, seed!
```

Nós temos **duas funções principais que geram números aleatórios**:

* `rand`: faz a amostragem de um **elemento aleatório** de uma estrutura ou tipo de dados.
* `randn`: gera um número aleatório que segue uma **distribuição normal padrão** (média 0 e desvio padrão 1) de um tipo específico.

> **_OBSERVAÇÃO:_**
> Observe que essas duas funções já estão no módulo `Base` de Julia.
> Então, você não precisa importar `Random` se estiver planejando usá-los.

#### `rand` {#sec:random_rand}

Por padrão, se você chamar `rand` sem argumentos, ele retornará um `Float64` no intervalo $[0, 1)$, o que significa no intervalo compreendido entre os limites 0 inclusivo e 1 exclusivo:

```jl
scob("rand()")
```

Você pode modificar argumentos `rand` de várias maneiras.
Por exemplo, suponha que você queira mais de 1 número aleatório:

```jl
sco("rand(3)")
```

Ou você quer um intervalo diferente:

```jl
scob("rand(1.0:10.0)")
```

Você também pode especificar um tamanho de incremento diferente dentro do intervalo e um tipo diferente.
Aqui estamos usando números sem ponto `.` então Julia irá interpretá-los como `Int64`:

```jl
scob("rand(2:2:20)")
```

Você também pode misturar e combinar argumentos:

```jl
sco("rand(2:2:20, 3)")
```

`rand` também aceita uma coleção de elementos como, por exemplo, uma tupla:

```jl
scob("""rand((42, "Julia", 3.14))""")
```

E também arrays:

```jl
scob("rand([1, 2, 3])")
```

`Dict`s:

```jl
sco("rand(Dict(:one => 1, :two => 2))")
```

Para terminar todas as opções de argumentos `rand`, você pode especificar as dimensões de número aleatório desejadas em uma tupla.
Se você fizer isso, o tipo retornado será uma array.
Por exemplo, aqui uma matriz 2x2 de números `Float64` entre 1.0 e 3.0:

```jl
sco("rand(1.0:3.0, (2, 2))")
```

#### `randn` {#sec:random_randn}

`randn` segue o mesmo princípio geral de `rand`, mas agora ele só retorna números gerados a partir da **distribuição normal padrão**.
A distribuição normal padrão é a distribuição normal com média 0 e desvio padrão 1.
O tipo padrão é `Float64` e só permite subtipos de `AbstractFloat` ou `Complex`:

```jl
scob("randn()")
```

Só podemos especificar o tamanho:

```jl
sco("randn((2, 2))")
```

#### `seed!` {#sec:random_seed}

Para terminar a visão geral de `Random`, vamos falar sobre **reprodutibilidade**.
Muitas vezes, queremos fazer algo **replicável**.
Ou seja, queremos que o gerador de números aleatórios gere a **mesma sequência aleatória de números**.
Podemos fazer isso com a função `seed!`:

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

A fim de evitar a repetição tediosa e ineficiente de `seed!` em todo lugar, podemos definir uma instância de `seed!` e passá-la como o primeiro argumento de **`rand` ou `randn`**.

```jl
sco("my_seed = seed!(123)")
```


```jl
sco("rand(my_seed, 3)")
```

```jl
sco("rand(my_seed, 3)")
```

> **_OBSERVAÇÃO:_**
> Se você quiser que seu código seja reproduzível, basta chamar `seed!` no começo do seu script.
> Isso cuidará da reprodutibilidade sequencial das operações `Random`.
> Não há necessidade de usá-la dentro de todo `rand` e `randn`.

### Downloads {#sec:downloads}

Uma última coisa da biblioteca padrão de Julia para cobrirmos é o **módulo `Download`**.
Será muito breve porque iremos cobrir apenas uma única função chamada `download`.

Suponha que você queira **fazer o download de um arquivo da internet para o seu armazenamento local**.
Você pode fazer isso com a função `download`.
O primeiro e único argumento obrigatório é o url do arquivo.
Você também pode especificar como um segundo argumento o caminho de saída desejado para o arquivo baixado (não se esqueça das práticas recomendadas do sistema de arquivos!).
Se você não especificar um segundo argumento, Julia irá, por padrão, criar um arquivo temporário com a função `tempfile`.

Vamos carregar o método `download`:

```julia
using Download: download
```

Por exemplo, vamos baixar nosso arquivo `Project.toml` do [repositório GitHub `JuliaDataScience`](https://github.com/JuliaDataScience/JuliaDataScience).
Observe que a função `download` não é exportada pelo módulo `Downloads`, então temos que usar a sintaxe `Module.function`.
Por padrão, ele retorna uma string que contém o caminho do arquivo para o arquivo baixado:

```jl
s = """
    url = "https://raw.githubusercontent.com/JuliaDataScience/JuliaDataScience/main/Project.toml"

    my_file = Downloads.download(url) # tempfile() being created
    """
scob(s)
```

Com `readlines`, nós podemos observar as primeiras 4 linhas do arquivo que baixamos:

```jl
s = """
    readlines(my_file)[1:4]
    """
sco(s; process=catch_show)
```

> **_OBSERVAÇÃO:_**
> Para interações HTTP mais complexas, como interação com APIs da web, consulte o pacote [`HTTP.jl`](https://github.com/JuliaWeb/HTTP.jl).
