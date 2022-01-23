## Formatação {#sec:notation}

Neste livro, nós tentamos manter a formatação de código-fonte o mais consistente possível.
Isto permite uma melhor leitura e escrita de código-fonte.
Definimos o padrão de formatação em três partes.

### Julia Style Guide

Primeiramente, nós tentamos aderir as convenções do [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/).
Mais importante, escrevemos funções e não scripts (veja também @sec:engineering).
Além disso, usamos convenções de nomenclatura consistente com o módulo `base` de Julia:

- Uso de _camelcase_ para módulos: `module JuliaDataScience`, `struct MyPoint`.
  (Note que a denominação de _camelcase_ é porque a capitalização das palavras, tais como "iPad" ou "CamelCase", faz com que a palavra se assemelhe que nem as costas de um camelo.)
- Denominação de funções usando caixa baixa (_lowercase_) e separando palavras por _underline_ (`_`).
  Também é permitido omitir o separador quando nomeando funções.
  Por exemplo, estes nomes de funções são consistentes com as convenções: `my_function`, `myfunction` e `string2int`.

Adicionalmente, evitamos usar parênteses em condicionais, ou seja, escrevemos `if a == b` ao invés de `if (a == b)` e usamos 4 espaços para cada nível de indentação.

### BlueStyle

O [Blue Style Guide](https://github.com/invenia/BlueStyle) adiciona diversas convenções aos padrões do Guia de Estilo de Julia.
Algumas dessas regras podem soar pedantes, mas descobrimos que elas fazem o código ficar mais legível.

Do Blue Style Guide, nós aderimos especificamente à:

- No máximo 92 caracteres por linha em código-fonte (para arquivos Markdown, linhas mais longas são permitidas).
- Quando carregando código com `using`, usar apenas uma declaração por módulo por linha.
- Não há whitespace no fim das linhas.
  Whitespace no fim das linhas faz com que a inspeção do código seja mais difícil pois eles não mudam o comportamento do código mas podem ser interpretados como mudanças.
- Evitar espacos adicionais dentro dos parênteses.
  Escreva `string(1, 2)` ao invés de `string( 1 , 2 )`.
- Variávies globais devem ser evitadas.
- Tente limitar nomes de funções para apenas uma ou duas palavras.
- Use o ponto-e-virgula para distinção se um argumento é posicional ou de palavra-chave.
  Por exemplo, `func(x; y=3)` ao invés de `func(x, y=3)`.
- Evite usar espaços múltiplos para alinhar coisas.
  Escreva
  ```
  a = 1
  lorem = 2
  ```
  ao invés de
  ```
  a     = 1
  lorem = 2
  ```
- Sempre que apropriado, coloque espaços ao redor de operadores binários, por exemplo, `1 == 2` ou `y = x + 1`.
- Indente quotações triplas:
  ```
  s = """
      my long text:
      [...]
      the end.
      """
  ```
- Não omite zeros in floats (mesmo que Julia permita).
  Portanto, escreva `1.0` ao invés de `1.` e escreva `0.1` ao invés de `.1`.
- Use `in` dentro de loops for e não = ou ∈ (mesmo que Julia permita).

### Nossos incrementos ao Blue Style Guide

- No texto, referenciamos uma chamada de função `M.foo(3, 4)` como `M.foo` e não `M.foo(...)` ou `M.foo()`.
- Quando falando sobre pacotes, tais como o pacote DataFrames, nós explicitamente escrevemos sempre `DataFrames.jl`.
  Isto faz com que seja fácil reconhecer que estamos nos referindo à um pacote.
- Para nome de arquivos, mantemos a notação como "file.txt" e não `file.txt` ou file.txt, pois é consistente com o código-fonte.
- Para nomes e colunas em tabelas, tais como a coluna `x`, usamos a coluna `:x`, porque é consistente com o código-fonte.
- Não usamos símbolos Unicode fora dos blocos de código.
  Isto foi necessário por conta de um bug na geração do PDF.
- A linha antes de cada código de bloco termina com dois pontos (:) para indicar que aquela linha pertence aquele bloco de código.

#### Carregamento de símbolos

Prefira sempre carregar símbolos de maneira explícita, ou seja, prefira `using A: foo` ao invés de `using A` quando não estiver usando o REPL [veja também @jump2021using].
Neste contexto, um símbolo significa um identificado de um objeto.
Por exemplo, mesmo que não parece natural, internamente `DataFrame`, `π` e `CSV` são todos símbolos.
Podemos averiguar isto se usarmos uma função introspectiva de Julia tal como `isdefined`:

```jl
scob("isdefined(Main, :π)")
```

Adjacente de ser explícito no uso de `using`, prefira também `using A: foo` ao invẽs de `import A: foo` porque este último faz com que seja fácil estender acidentalmente `foo`.
Note que isto não é somente aplicável para Julia:
carregament implícito de símbolos por `from <module> import *` também é desencorajado em Python [@pep8].

A razão da importância de ser explícito está relacionada com versionamento semântico.
Com versionamento semântico (<http://semver.org>), o número da versão está relacionado se um pacote possui ou não mudanças _breaking_.
Por exemplo, uma mudança _non-breaking_ que atualiza o pacote `A` se dá quando o pacote migra da versão `0.2.2` para `0.2.3`.
Com tais mudanças _non-breaking_, você não precisa se preocupar se o seu pacote vai quebrar (_break_), em outras palavras, dar um erro ou mudar o comportamento de execução.
Se um pacote `A` migra de versão `0.2` para `1.0`, então esta atualização é _breaking_ e você provavelmente terá que fazer mudanças no seu código para fazer com que o pacote `A` funcione novamente.
**Porém**, exportando símbolos extras é considerado uma mudança _non-breaking_.
Então, com carreamento implícito de símbolos **mudanças _non-breaking_ podem quebrar seu pacote**.
Por isso que é uma boa prática apeans carregar símbolos de maneira explícita.
