# Por que Julia? {#sec:why_julia}

O mundo da ciência de dados é repleto de diferentes linguagens open source.

A Indústria tem, em grande parte, adotado as linguagens Python e R.
**Por que aprender uma outra linguagem?**
Para responder a essa questão, abordaremos duas situações bastante comuns:

1. **Nunca programou antes** -- see @sec:non-programmers.

2. **Já programou** -- see @sec:programmers.

## Para os que nunca programaram {#sec:non-programmers}

Para a primeira situação, acreditamos que o ponto em comum seja:

A ciência de dados te atrai, você tem vontade de aprender sobre e entender como ela pode ajudar sua carreira seja na academia, seja no mercado.
Então, você tenta encontrar formas de aprender essa nova habilidade e cai em um mundo de acrônimos complexos:
`pandas`, `dplyr`, `data.table`, `numpy`, `matplotlib`, `ggplot2`, `bokeh`, e a lista continua.

E, do nada, você ouve: "Julia".
O que é isso?
Como seria diferente de qualquer outra ferramenta usada para ciência de dados?

Por que você deveria gastar seu tempo para aprender uma linguagem de programação que quase nunca é mencionada em processos seletivos, posições em laboratórios, pós-doutorados ou qualquer outro trabalho acadêmico?
A respota para a questão é que **Julia é uma nova abordagem** tanto para programação, quanto para ciência de dados.
Tudo que você faz em Python ou R, você pode fazer em Julia com a vantagem de poder escrever um código legível [^readable], rápido e poderoso.
Assim, Julia tem ganhado força por uma série de motivos.

Então, **se você não tem nenhum conhecimento prévio de programação, recomendamos que aprenda Julia** como uma primeira linguagem de programação e ferramenta para ciência de dados.

## Para programadores {#sec:programmers}

Na segunda situação, a história por trás muda um pouco.
Você é uma pessoa que não só sabe programar, como também, provavelmente, vive disso.
Você tem familiaridade com uma ou mais linguagens de programação e deve transitar bem entre elas.
Você ouviu falar sobre "ciência de dados" e quer surfar essa onda.
Você começou a aprender a fazer coisas em `numpy`, a manipular `DataFrames` em `pandas` e como plotar em `matplotlib`.
Ou talvez você tenha aprendido tudo isso em R usando tidyverse e `tibbles`, `data.frames`, `%>%` (pipes) e `geom_*`...

Então, por alguém ou por algum lugar, você ouviu falar dessa nova linguagem chamada "Julia".
Por que se importar?
Você já domina Python ou R e consegue fazer tudo que precisa.
Bom, vamos analisar alguns possíveis cenários.

**Alguma vez você já fez em Python ou R:**

1. Algo que não tenha conseguido alcançar a performance necessária?
Então, **em Julia, minutos no Python ou R se transformam em segundos**^[e até em milésimos de segundo.].
Nós separamos o @sec:julia_wild para exemplificar casos de sucesso em Julia tanto na academia quanto no mercado.

2. Tentou algo diferente das convenções `numpy`/`dplyr` e descobriu que o código estava lento e provavelmente precisaria de magia ^[`numba`, or even `Rcpp` or `cython`?] para torná-lo mais rápido?
**Em Julia, você pode personalizar uma série de coisas sem perder desempenho**.

3. Precisou executar um debug em um código e caiu num código Fortran ou C/C++, sem ter ideia alguma do que fazer?
**Em Julia, você lê apenas códigos de Julia, não é preciso programar em outra linguagem para tornar a original mais rápida**.
Isso é chamado o "problema das duas linguagens" (see @sec:two_language).
É também o caso quando "você tem uma ideia interessante e tenta contribuir com um pacote open source, mas desiste porque quase tudo não está nem em Python, nem em R, mas em C/C++ ou Fortran"^[dê uma olhada em algumas bibliotecas de aprendizado profundo no GitHub e você descobrirá que Python é apenas 25% -33% da base de código.].

4. Quis usar uma estrutura de dados definida em outro pacote e descobriu que não ia funcionar, e que você precisaria construir uma interface^[esse é um problema do ecossistema Python e, ainda que o R não sofra tanto com isso, também não é tão eficaz.].
**Julia permite que usuários compartilhem e reutilizem códigos de diferentes pacotes.**
A maior parte dos tipos e funções definidas pelos usuários de Julia, funcionam perfeitamente^[ou com pouquíssimo esforço.] e alguns usuários ficam maravilhados ao descobrir como seus pacotes estão sendo usados por outros pacotes, das mais diversas formas, algo que nunca poderiam ter imaginado.
Temos alguns exemplos em @sec:multiple_dispatch.

5. Precisou de uma melhor gestão de projetos, com crontrole rígido de versões e dependências, de fácil usabilidade e replicável?
**Julia tem soluções incríveis para a gestão de projetos e um ótimo gerenciador de pacotes**.
Diferentemente dos gerenciadores de pacotes tradicionais, que instalam e gerenciam um único conjunto global de pacotes, o gerenciador de pacotes de Julia é projetado em torno de "ambientes":
conjuntos independentes de pacotes que podem ser locais para um projeto individual ou compartilhados entre projetos.
Cada projeto mantém, independentemente, seu próprio conjunto de versões de pacotes.

Se nós chamamos a sua ateção expondo situações familiares ou mesmo plausíveis, talvez você se interesse em aprender um pouco mais sobre Julia.

Vamos começar!

## O que Julia pretende alcançar? {#sec:julia_accomplish}

> **_NOTE:_**
> Nessa seção explicaremos com detalhe o que faz de Julia uma linguagem de programação brilhante.
> Se essa explicação for muito técnica para você, vá direto para @sec:dataframes to learn about tabular data with `DataFrames.jl`.

A linguagem de programação Julia [@bezanson2017julia] é relativamente nova, foi lançada em 2012, e procura ser **fácil e rápida**.
Ela "roda como C^[às vezes até mais rápido], mas lê como Python" [@perkelJuliaComeSyntax2019].
Foi idealizada inicialmente para computação científica, capaz de lidar com **uma grande quantidade de dados e demanda computacional** sendo, ao mesmo tempo, **fácil de manipular, criar e prototipar códigos**.

Os criadores de Julia explicaram porque desenvolveram a linguagem [2012 blogpost](https://julialang.org/blog/2012/02/why-we-created-julia/).
Eles afirmam:

> Somos ambiciosos: queremos mais.
> Queremos uma linguagem open source, com uma licença permissiva.
> Queremos a velocidade do C com o dinamismo do Ruby.
> Queremos uma linguagem que seja homoicônica, com verdadeiros macros como Lisp, mas com uma noção matemética óbvia e familiar como Matlab.
> Queremos algo que seja útil para programação em geral como Python, fácil para estatística como R, tão natural para processamento de strings quanto Perl, tão poderoso para álgebra linear quanto Matlab, tão bom para colar programas juntos quanto shell.
> Algo que seja simples de aprender, mas que deixe os hackers mais sérios felizes.
> Queremos que seja interativo e estático.

A maioria dos usuários se sente atraída por Julia em função da sua **velocidade superior**.
Afinal, Julia é membro de um clube prestigiado e exclusivo.
O [**petaflop club**](https://www.hpcwire.com/off-the-wire/julia-joins-petaflop-club/) é composto por linguagens que excedem a velocidade de **um petaflop^[um petaflop equivale a mil trilhões, ou um quatrilhão de operações por segundo] por segundo no desempenho máximo**.
Atualmente, apenas C, C++, Fortran e Julia fazem parte do [petaflop club](https://www.nextplatform.com/2017/11/28/julia-language-delivers-petascale-hpc-performance/).

Mas velocidade não é tudo que Julia pode oferecer.
A **facilidade de uso**, **caracteres Unicode** e ser uma linguagem que torna **o compartilhamento de códigos algo muito simples** são algumas das características de Julia.
Falaremos de todas essas qualidades nessa seção, mas focaremos no compartilhamento de códigos por enquanto.

O ecossistema de pacotes de Julia é algo único.
Permite não só o compartilhamento de códigos, como também permite a criação de tipos definidos pelos usuários. 
Por exemplo, o `pandas` do Python usa seu próprio tipo de `Datetime` para lidar com datas.
O mesmo ocorre com o pacote `lubridate` do tidyverse do R, que também define o seu tipo próprio de `datetime` para lidar com datas.
Julia não precisa disso, ela tem todos os tipos e funcionalidades de datas incluidas na sua biblioteca padrão.
Isso significa que outros pacotes não precisam se preocupar com datas.
Eles só precisam estender os tipos de `DateTime` de Julia para novas funcionalidades, ao definirem novas funções, sem a necessidade de definirem novos tipos. 
O módulo de `Dates` Julia faz coisas incríveis, mas não discutiremos isso agora.
Vamos falar de outras características de Julia.

### Julia Versus outras linguagens de programação

Em [@fig:language_comparison], uma representação altamente opinativa é demonstrada e divide as principais linguagens open source e de computação científica em um diagrama 2x2 com dois eixos:
**Lento-Rápido** e **Fácil-Difícil**.
Deixamos de fora as linguagens fechadas, porque os benefícios são maiores quando permitimos que outras pessoas usem nossos códigos gratuitamente, afinal o código-fonte acaba sendo revisado a todo momento, caso surja algum problema.

Consideramos que o C++ e o FORTRAN estão no quadrante Difícil e Rápido.
Por serem linguagens estáticas que precisam de compilação, verificação de tipo e outros cuidados e atenção profissional, elas são realmente difíceis de aprender e lentas para prototipar.
A vantagem é que elas são linguagens **muito rápidas**.

R e Python estão no quadrante Fácil e Lento.
Elas são linguagens dinâmicas, que não são compiladas e executam em tempo de execução.
Por causa disso, elas são fáceis de aprender e rápidas para prototipar.
Claro que isso tem desvantagens:
elas são linguagens **muito lentas**.

Julia é a única linguagem no quadrante Fácil e Rápido.
Nós não conhecemos nenhuma linguagem séria qualificada no quadrante Difícil e Lento.

![Comparações entre linguagens de computação científicas: logos para FORTRAN, C++, Python, R e Julia.](images/language_comparisons.png){#fig:language_comparison}

**Julia é rápida!
Muito rápida!**
Foi desenvolvida para ser veloz desde o início.
E alcança esse objetivo com múltiplos despachos.
Basicamente, a ideia é gerar códigos LLVM[^LLVM] muito eficientes.
Códigos LLVM, também conhecido como instruções LLVM, são de nível-baixo, ou seja, muito próximos das operações reais que seu computador está executando.
Portanto, em essência, Julia converte seu código escrito a mão e fácil de se ler em código máquina LLVM, o que é muito difícil para humanos lerem, mas muito fácil para um computador.
Por exemplo, se você definir uma função recebendo um argumento e passar um inteiro para a função, Julia criará um _specialized_ `MethodInstance`.
Na próxima vez que você passar um inteiro como argumento para a função, Julia buscará o `MethodInstance` criado anteriormente e referir a execução a isso.
Agora, o **grande** truque é que você também pode fazer isso dentro de uma função que chama a função.
Por exemplo, se certo tipo de dado é passado dentro da função `f` e `f` chama a função `g` e os tipos de dados conhcecidos e que são sempre os mesmos passam para `g`, então a função `g` gerada pode ser codificada na função `f`!
Isso significa que Julia não precisa sequer buscar `MethodInstances`, por isso o código consegue rodar de forma eficiente.
A compensação aqui é que existem casos onde as suposições anteriores sobre a decodificação dos `MethodInstances` são invalidadas.
Então, o `MethodInstance` precisa ser recriado, o que leva tempo.
Além disso, a desvantagem é que leva tempo para inferir o que pode ser codificado e o que não pode.
Isso explica por que demora para que Julia faça a primeira coisa:
num segundo plano, está otimizando seu código.

O compilador, por sua vez, faz o que faz de melhor: otimiza o código de máquina^[se quer saber mais sobre como Julia foi projetada, acesse @bezanson2017julia.].
Você encontra [benchmarks](https://julialang.org/benchmarks/) para Julia e para outras linguagens aqui.
@fig:benchmarks foi retirado de [Julia's website benchmarks section^[observe que os resultados de Julia descritos acima não incluem o tempo de compilação.]](https://julialang.org/benchmarks/).
Como você pode perceber, Julia é **de fato** rápida.

![Julia versus outras linguagens de programação.](images/benchmarks.png){#fig:benchmarks}

Nós realmente acreditamos em Julia.
Caso contrário, não teríamos escrito este livro.
Nós acreditamos que Julia é **o futuro da computação científica e da análise de dados científicos**.
Ela permite que o usuário desenvolva códigos rápidos e poderosos com uma sintaxe simples.
Normalmente, pesquisadores desenvolvem códigos usando linguagens fáceis, mas muito lentas.
Uma vez que o código rode corretamente e cumpra seus objetivos, aí começa o processo de conversão do código para uma linguagem rápida, porém difícil.
Esse é o "problema das duas linguagens" e discutiremos ele melhor a seguir.

### O Problema das Duas Linguagens {#sec:two_language}

O "Problema das Duas Linguagens" é bastante comum na computação científica, quando um pesquisador concebe um algoritmo, ou quando desenvolve uma solução para um problema desejado, ou mesmo quando realiza algum tipo de análise.
Em seguida, a solução é prototipada em uma linguagem fácil de codificar (como Python ou R).
Se o protótipo funciona, o pesquisador codifica em uma linguagem rápida que não seria fácil de prototipar (C++ ou FORTRAN).
Assim, temos duas linguagens envolvidas no processo de desenvolvimento de uma nova solução.
Uma que é fácil de prototipar, mas não é adequada para implementação (principalmente por ser lenta).
E outra que não é tão simples de codificar e, conseqüentemente, não é fácil de prototipar, mas adequada para implementação porque é rápida.
Julia evita esse tipo de situação por ser a **a mesma linguagem que você prototipa (fácil de usar) e implementa a solução (rápida)**.

Além disso, Julia permite que você use **caracteres Unicode como variáveis ou parâmetros**.
Isso significa que não é preciso mais usar `sigma` ou `sigma_i`, e ao invés disso use apenas $σ$ ou $σᵢ$ como você faria em notação matemática.
Quando você vê o código de um algoritmo ou de uma equação matemática, você vê quase a mesma notação e expressões idiomáticas.
Chamamos esse recurso poderoso de **"Código Um para Um e Relação Matemática"**.

Acreditamos que o "Problema das Duas Linguagens" e o "Código Um para Um e Relação Matemática" são melhor descritos por um dos criadores de Julia, Alan Edelman, em [TEDx Talk](https://youtu.be/qGW0GT1rCvs) [@tedxtalksProgrammingLanguageHeal2020].

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/qGW0GT1rCvs' frameborder='0' allowfullscreen></iframe></div>

### Despacho Múltiplo {#sec:multiple_dispatch}

Despacho múltiplo é um recurso poderoso que nos permite estender funções existentes ou definir comportamento personalizado e complexo para novos tipos.
Supondo que você queira definir dois novos `struct`s para denotar dois animais diferentes:

```jl
s = """
    abstract type Animal end
    struct Fox <: Animal
        weight::Float64
    end
    struct Chicken <: Animal
        weight::Float64
    end
    """
sc(s)
```

Basicamente, isso diz "defina que uma raposa é um animal" e "defina que uma galinha é um animal".
Em seguida, podemos ter uma raposa chamada Fiona e uma galinha chamada Big Bird.

```jl
s = """
    fiona = Fox(4.2)
    big_bird = Chicken(2.9)
    """
sc(s)
```

A seguir, queremos saber quanto elas pesam juntas, para o qual podemos escrever uma função:

```jl
sco("combined_weight(A1::Animal, A2::Animal) = A1.weight + A2.weight")
```

E queremos saber se elas vão bem juntas.
Uma maneira de implementar isso é usar condicionais:

```jl
s = """
    function naive_trouble(A::Animal, B::Animal)
        if A isa Fox && B isa Chicken
            return true
        elseif A isa Chicken && B isa Fox
            return true
        elseif A isa Chicken && B isa Chicken
            return false
        end
    end
    """
sco(s)
```

Agora, vamos ver se deixar Fiona e Big Bird juntas daria problema:

```jl
scob("naive_trouble(fiona, big_bird)")
```

OK, isso parece correto.
Escrevendo a função `naive_trouble` parece ser o suficiente. No entanto, usar despacho múltiplo para criar uma nova função `trouble` pode ser benéfico. Vamos criar novas funções:

```jl
s = """
    trouble(F::Fox, C::Chicken) = true
    trouble(C::Chicken, F::Fox) = true
    trouble(C1::Chicken, C2::Chicken) = false
    """
sco(s)
```

Depois da definição dos métodos, `trouble` fornece o mesmo resultado que `naive_trouble`.
Por exemplo:

```jl
scob("trouble(fiona, big_bird)")
```

E deixar Big Bird sozinha com outra galinha chamada Dora também é bom

```jl
s = """
    dora = Chicken(2.2)
    trouble(dora, big_bird)
    """
scob(s)
```

Portanto, neste caso, a vantagem do despacho múltiplo é que você pode apenas declarar tipos e Julia encontrará o método correto para seus tipos.
Ainda mais, para muitos casos quando o despacho múltiplo é usado dentro do código, o compilador Julia irá realmente otimizar as chamadas de função.
Por exemplo, poderíamos escrever:

```
function trouble(A::Fox, B::Chicken, C::Chicken)
    return trouble(A, B) || trouble(B, C) || trouble(C, A)
end
```

Dependendo do contexto, Julia pode otimizar isso para:

```
function trouble(A::Fox, B::Chicken, C::Chicken)
    return true || false || true
end
```

porque o compilador **sabe** que `A` é a raposa, `B` é a galinha e então isso pode ser substituído pelo conteúdo do método `trouble(F::Fox, C::Chicken)`.
O mesmo vale para `trouble(C1::Chicken, C2::Chicken)`.
Em seguida, o compilador pode otimizar isso para:

```
function trouble(A::Fox, B::Chicken, C::Chicken)
    return true
end
```

Outro benefício do despacho múltiplo é que quando outra pessoa chega e quer comparar os animais existentes com seu animal, uma zebra por exemplo, é possível.
Em seu pacote, eles podem definir um Zebra:

```jl
s = """
    struct Zebra <: Animal
        weight::Float64
    end
    """
sc(s)
```

e também como as interações com os animais existentes seriam:

```jl
s = """
    trouble(F::Fox, Z::Zebra) = false
    trouble(Z::Zebra, F::Fox) = false
    trouble(C::Chicken, Z::Zebra) = false
    trouble(Z::Zebra, F::Fox) = false
    """
sco(s)
```

Agora, podemos ver se Marty (nossa zebra) está a salvo com Big Bird:

```jl
s = """
    marty = Zebra(412)
    trouble(big_bird, marty)
    """
scob(s)
```

Ainda melhor, conseguimos calcular **o peso combinado de zebras e outros animais sem definir qualquer função extra**:

```jl
scob("combined_weight(big_bird, marty)")
```

Então, em resumo, o código que foi escrito pensando apenas para Raposa e Galinha funciona para tipos que **nunca tinham sido vistos**!
Na prática, isso significa que Julia facilita o reuso do código de outros projetos.

Se você está tão animado quanto nós com o despacho múltiplo, aqui estão mais dois exemplos aprofundados.
O primeiro é uma [rápida e elegante implementação de um vetor one-hot](https://storopoli.io/Bayesian-Julia/pages/1_why_Julia/#example_one-hot_vector) por @storopoli2021bayesianjulia.
O segundo é uma entrevista com [Christopher Rackauckas](https://www.chrisrackauckas.com/) no [Tanmay Bakshi YouTube's Channel](https://youtu.be/moyPIhvw4Nk?t=2107) (assista do minuto 35:07 em diante) [@tanmaybakshiBakingKnowledgeMachine2021].
Chris explica que, enquanto usando [`DifferentialEquations.jl`](https://diffeq.sciml.ai/dev/), um pacote que ele desenvolveu e mantém atualmente, um usuário registrou um problema que seu solucionador ODE quaternion baseado em GPU não funcionava.
Chris ficou bastante surpreso com este pedido, já que ele não esperava que alguém combinasse cálculos de GPU com quatérnions e resolvendo EDOs.
Ele ficou ainda mais surpreso quando descobriu que o usuário cometeu um pequeno erro e que tudo funcionou.
A maior parte do mérito é devido ao múltiplo despacho e alto compartilhamento de código/tipo de usuário.

Para concluir, pensamos que o despacho múltiplo é melhor explicado por um dos criadores de Julia:
[Stefan Karpinski at JuliaCon 2019](https://youtu.be/kc9HwsxE1OY).

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/kc9HwsxE1OY' frameborder='0' allowfullscreen></iframe></div>


## Julia na Natureza {#sec:julia_wild}

Em @sec:julia_accomplish, explicamos por que achamos que Julia é uma linguagem de programação única.
Mostramos exemplos simples sobre os principais recursos de Julia.
Se você quiser se aprofundar em como Julia está sendo usada, temos alguns **casos interessantes**:

1. NASA usa Julia em um supercomputador que analisa o ["O maior lote de planetas do tamanho da Terra já encontrado"](https://exoplanets.nasa.gov/news/1669/seven-rocky-trappist-1-planets-may-be-made-of-similar-stuff/) e alcançar uma extraordinária **aceleração de 1.000x** para catalogar 188 milhões de objetos astronômicos em 15 minutos.
2. [The Climate Modeling Alliance (CliMa)](https://clima.caltech.edu/) usa Julia para **modelar clima no GPU e CPU**.
Lançado em 2018 em colaboração com pesquisadores da Caltech, o NASA Jet Propulsion Laboratory, e a Naval Postgraduate School, CliMA está utilizando o progresso recente da ciência computacional para desenvolver um modelo do sistema terrestre que pode prever secas, ondas de calor e chuva com precisão e velocidade sem precedentes.
3. [US Federal Aviation Administration (FAA) está desenvolvendo um **Airborne Collision Avoidance System (ACAS-X)** usando Julia](https://youtu.be/19zm1Fn0S9M).
Esse é um bom exemplo do "Problema das Duas Linguagens" (see @sec:julia_accomplish).
Soluções anteriores usavam Matlab para desenvolver os algoritmos e C++ para uma implementação mais rápida.
Agora, FAA usa uma única linguagem para tudo isso: Julia.
4. [**Aceleração de 175x** para modelos de farmacologia da Pfizer usando GPUs em Julia](https://juliacomputing.com/case-studies/pfizer/).
Foi apresentado como um [poster](https://chrisrackauckas.com/assets/Posters/ACoP11_Poster_Abstracts_2020.pdf) na 11ª American Conference of Pharmacometrics (ACoP11) e [ganhou um prêmio de qualidade](https://web.archive.org/web/20210121164011/https://www.go-acop.org/abstract-awards).
5. [O Attitude and Orbit Control Subsystem (AOCS) do satélite brasileiro Amazonia-1 é **escrito 100% em Julia**](https://discourse.julialang.org/t/julia-and-the-satellite-amazonia-1/57541) por Ronan Arraes Jardim Chagas (<https://ronanarraes.com/>).
6. [Banco Nacional de Desenvolvimento Econômico e Social (BNDES) do Brasil abandonou uma solução paga e optou pela modelagem de Julia de código aberto e ganhou uma **aceleração de 10x**.](https://youtu.be/NY0HcGqHj3g)

Se isso não for suficiente, existem mais estudos de caso em [Julia Computing website](https://juliacomputing.com/case-studies/).

[^readable]: no C++ or FORTRAN API calls.
[^LLVM]: LLVM stands for **L**ow **L**evel **V**irtual **M**achine, you can find more at the LLVM website (<http://llvm.org>).

