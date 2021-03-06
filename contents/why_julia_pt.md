# Por que Julia? {#sec:why_julia}

O mundo da ciência de dados é repleto de diferentes linguagens open source.

A Indústria tem, em grande parte, adotado as linguagens Python e R.
**Por que aprender uma outra linguagem?**
Para responder a essa questão, abordaremos duas situações bastante comuns:

1. **Nunca programou antes** -- see @sec:non-programmers.

2. **Já programou** -- see @sec:programmers.

## Para os que nunca programaram {#sec:non-programmers}

Para a primeira situação, acreditamos que o ponto em comum seja o seguinte.

A ciência de dados te atrai, você tem vontade de aprender sobre e entender como ela pode ajudar sua carreira seja na academia, seja no mercado.
Então, você tenta encontrar formas de aprender essa nova habilidade e cai em um mundo de acrônimos complexos:
`pandas`, `dplyr`, `data.table`, `numpy`, `matplotlib`, `ggplot2`, `bokeh`, e a lista continua.

E, do nada, você ouve: "Julia".
O que é isso?
Como seria diferente de qualquer outra ferramenta usada para ciência de dados?

Por que você deveria gastar seu tempo para aprender uma linguagem de programação que quase nunca é mencionada em processos seletivos, posições em laboratórios, pós-doutorados ou qualquer outro trabalho acadêmico?
A resposta para a questão é que **Julia é uma nova abordagem** tanto para programação, quanto para ciência de dados.
Tudo que você faz em Python ou R, você pode fazer em Julia com a vantagem de poder escrever um código legível[^readable], rápido e poderoso.
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

2. Tentou algo diferente das convenções `numpy`/`dplyr` e descobriu que o código estava lento e provavelmente precisaria de magia^[`numba`, ou mesmo o `Rcpp` ou o `cython`?] para torná-lo mais rápido?
**Em Julia, você pode fazer seu próprio código customizado sem perder desempenho**.

3. Precisou debugar um código e de repente se viu lendo código fonte em Fortran ou C/C++, sem ter ideia alguma do que fazer?
**Em Julia, você lê apenas códigos de Julia, não é preciso programar em outra linguagem para tornar a original mais rápida**.
Isso é chamado o "problema das duas linguagens" (see @sec:two_language).
É também o caso quando "você tem uma ideia interessante e tenta contribuir com um pacote open source, mas desiste porque quase tudo não está nem em Python, nem em R, mas em C/C++ ou Fortran"^[dê uma olhada em algumas bibliotecas de aprendizado profundo no GitHub e você descobrirá que Python é apenas 25%-33% do código fonte delas.].

4. Quis usar uma estrutura de dados definida em outro pacote e descobriu que não ia funcionar e que você precisaria construir uma interface^[esse é um problema do ecossistema Python e, ainda que o R não sofra tanto com isso, também não é tão eficaz.].
**Julia permite que usuários compartilhem e reutilizem códigos de diferentes pacotes com facilidade.**
A maior parte dos tipos e funções definidas pelos usuários de Julia, funcionam de imediato^[ou com pouquíssimo esforço.] e alguns usuários ficam maravilhados ao descobrir como seus pacotes estão sendo usados por outras bibliotecas, das mais diversas formas, algo que nunca poderiam ter imaginado.
Temos alguns exemplos em @sec:multiple_dispatch.

5. Precisou de uma melhor gestão de projetos, com controle rígido de versões e dependências, de fácil usabilidade e replicável?
**Julia tem uma solução de gestão de projetos incrível e um ótimo gerenciador de pacotes**.
Diferentemente dos gerenciadores de pacotes tradicionais, que instalam e gerenciam um único conjunto global de pacotes, o gerenciador de pacotes de Julia é projetado em torno de "ambientes":
conjuntos independentes de pacotes que podem ser locais para um projeto individual ou compartilhados entre projetos.
Cada projeto mantém, independentemente, seu próprio conjunto de versões de pacotes.

Se nós chamamos a sua atenção expondo situações familiares ou mesmo plausíveis, talvez você se interesse em aprender um pouco mais sobre Julia.

Vamos começar!

## O que Julia pretende alcançar? {#sec:julia_accomplish}

> **_NOTE:_**
> Nessa seção explicaremos com detalhes o que faz de Julia uma linguagem de programação brilhante.
> Se essa explicação for muito técnica para você, vá direto para @sec:dataframes para aprender sobre dados tabulares com `DataFrames.jl`.

A linguagem de programação Julia [@bezanson2017julia] é relativamente nova, foi lançada em 2012, e procura ser **fácil e rápida**.
Ela "roda como C^[às vezes até mais rápido], mas lê como Python" [@perkelJuliaComeSyntax2019].
Foi idealizada inicialmente para computação científica, capaz de lidar com **uma grande quantidade de dados e demanda computacional** sendo, ao mesmo tempo, **fácil de manipular, criar e prototipar códigos**.

Os criadores de Julia explicaram porque desenvolveram a linguagem em uma postagem em seu blog em [2012](https://julialang.org/blog/2012/02/why-we-created-julia/).
Eles afirmam:

> Somos ambiciosos: queremos mais.
> Queremos uma linguagem open source, com uma licença permissiva.
> Queremos a velocidade do C com o dinamismo do Ruby.
> Queremos uma linguagem que seja homoicônica, com verdadeiros macros como Lisp, mas com uma notação matemática óbvia e familiar como Matlab.
> Queremos algo que seja útil para programação em geral como Python, fácil para estatística como R, tão natural para processamento de strings quanto Perl, tão poderoso para álgebra linear quanto Matlab, tão bom para integrar programas juntos quanto shell.
> Algo que seja simples de aprender, mas que deixe os hackers mais sérios felizes.
> Queremos que seja interativa e que seja compilada.

A maioria dos usuários se sentem atraídos por Julia em função da sua **velocidade superior**.
Afinal, Julia é membro de um clube prestigiado e exclusivo.
O [**petaflop club**](https://www.hpcwire.com/off-the-wire/julia-joins-petaflop-club/) é composto por linguagens que excedem a velocidade de **um petaflop^[um petaflop equivale a mil trilhões, ou um quatrilhão de operações com pontos flutuantes por segundo.] no desempenho máximo**.
Atualmente, apenas C, C++, Fortran e Julia fazem parte do [petaflop club](https://www.nextplatform.com/2017/11/28/julia-language-delivers-petascale-hpc-performance/).

Mas velocidade não é tudo que Julia pode oferecer.
A **facilidade de uso**, **o suporte a caracteres Unicode** e ser uma linguagem que torna **o compartilhamento de códigos algo muito simples** são algumas das características de Julia.
Falaremos de todas essas qualidades nessa seção, mas focaremos no compartilhamento de códigos por enquanto.

O ecossistema de pacotes de Julia é algo único.
Permite não só o compartilhamento de códigos, como também permite a criação de tipos definidos pelos usuários.
Por exemplo, o `pandas` do Python usa seu próprio tipo de `DateTime` para lidar com datas.
O mesmo ocorre com o pacote `lubridate` do tidyverse do R, que também define o seu tipo próprio de `datetime` para lidar com datas.
Julia não precisa disso, ela tem todos os tipos e funcionalidades de datas incluidas na sua biblioteca padrão.
Isso significa que outros pacotes não precisam se preocupar com datas.
Eles só precisam estender os tipos de `DateTime` de Julia para novas funcionalidades, ao definirem novas funções, sem a necessidade de definirem novos tipos.
O módulo `Dates` de Julia faz coisas incríveis, mas estamos nos adiantando.
Primeiro, vamos falar de outras características de Julia.

### Julia Versus outras linguagens de programação

Em [@fig:language_comparison], uma representação altamente opinativa, dividimos as principais linguagens open source e de computação científica em um diagrama 2x2 com dois eixos:
**Lento-Rápido** e **Fácil-Difícil**.
Deixamos de fora as linguagens de código fechado, porque os benefícios são maiores quando permitimos que outras pessoas usem nossos códigos gratuitamente, assim como quando têm a liberdade para inspecionar elas mesmas o código fonte para sanar dúvidas e resolver problemas.

Consideramos que o C++ e o FORTRAN estão no quadrante Difícil e Rápido.
Por serem linguagens estáticas que precisam de compilação, verificação de tipo e outros cuidados e atenção profissional, elas são realmente difíceis de aprender e lentas para prototipar.
A vantagem é que elas são linguagens **muito rápidas**.

R e Python estão no quadrante Fácil e Lento.
Elas são linguagens dinâmicas, que não são compiladas e executam em tempo de execução.
Por causa disso, elas são fáceis de aprender e rápidas para prototipar.
Claro que isso tem desvantagens:
elas são linguagens **muito lentas**.

Julia é a única linguagem no quadrante Fácil e Rápido.
Nós não conhecemos nenhuma linguagem séria que almejaria ser Difícil e Lenta, por isso esse quadrante está vazio.

![Comparações entre linguagens de computação científicas: logos para FORTRAN, C++, Python, R e Julia.](images/language_comparisons.png){#fig:language_comparison}

**Julia é rápida!
Muito rápida!**
Foi desenvolvida para ser veloz desde o início.
E alcança esse objetivo por meio do despacho múltiplo.
Basicamente, a ideia é gerar códigos LLVM[^LLVM] muito eficientes.
Códigos LLVM, também conhecidos como instruções LLVM, são de baixo-nível, ou seja, muito próximos das operações reais que seu computador está executando.
Portanto, em essência, Julia converte o código que você escreveu — que é fácil de se ler — em código de máquina LLVM, que é muito difícil para humanos lerem, mas muito fácil para um computador.
Por exemplo, se você definir uma função que recebe um argumento e passar um inteiro para a função, Julia criará um `MethodInstance` _especializado_.
Na próxima vez que você passar um inteiro como argumento para a função, Julia buscará o `MethodInstance` criado anteriormente e redirecionará a execução a ele.
Agora, o **grande** truque é que você também pode fazer isso dentro de uma função que chama uma outra função.
Por exemplo, se certo tipo de dado é passado dentro da função `f` e `f` chama a função `g`, e se os tipos de dados passados para `g` são conhecidos e sempre os mesmos, então a função `g` gerada pode ser codificada de forma pré-definida pelo Julia na função `f`!
Isso significa que Julia não precisa sequer buscar `MethodInstances` de `f` para `g`, pois o código consegue rodar de forma eficiente.
A compensação aqui é que existem casos onde as suposições anteriores sobre a decodificação dos `MethodInstances` são invalidadas.
Então, o `MethodInstance` precisa ser recriado, o que leva tempo.
Além disso, a desvantagem é que também leva tempo para inferir o que pode ser codificado de forma pré-definida e o que não pode.
Isso explica por que Julia demora para executar um código pela primeira vez:
ela está otimizando seu código em segundo-plano.
A segunda e subsequentes execuções serão extremamente rápidas.

O compilador, por sua vez, faz o que ele faz de melhor: otimiza o código de máquina^[se quer saber mais sobre como Julia foi projetada, acesse @bezanson2017julia.].
Você encontra [benchmarks](https://julialang.org/benchmarks/) para Julia e para outras linguagens aqui.
@fig:benchmarks foi retirado da [seção de Benchmarks do site de Julia^[observe que os resultados de Julia descritos acima não incluem o tempo de compilação.]](https://julialang.org/benchmarks/).
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

O "Problema das Duas Linguagens" é bastante comum na computação científica, quando um pesquisador concebe um algoritmo, ou quando desenvolve uma solução para um problema, ou mesmo quando realiza algum tipo de análise.
Em seguida, a solução é prototipada em uma linguagem fácil de codificar (como Python ou R).
Se o protótipo funciona, o pesquisador codifica em uma linguagem rápida que, em geral, não é fácil de prototipar (como C++ ou FORTRAN).
Assim, temos duas linguagens envolvidas no processo de desenvolvimento de uma nova solução.
Uma que é fácil de prototipar, mas não é adequada para implementação (principalmente por ser lenta).
E outra que não é tão simples de codificar e, consequentemente, não é fácil de prototipar, mas adequada para implementação porque é rápida.
Julia evita esse tipo de situação por ser a **a mesma linguagem que você prototipa (fácil de usar) e implementa a solução (rápida)**.

Além disso, Julia permite que você use **caracteres Unicode como variáveis ou parâmetros**.
Isso significa que não é preciso mais usar `sigma` ou `sigma_i`: ao invés disso use apenas $σ$ ou $σᵢ$ como você faria em notação matemática.
Quando você vê o código de um algoritmo ou para uma equação matemática, você vê quase a mesma notação e expressões idiomáticas.
Chamamos esse recurso poderoso de **"Relação Um para Um entre Código e Matemática"**.

Acreditamos que o "Problema das Duas Linguagens" e a "Relação Um para Um entre Código e Matemática" são melhor descritos por um dos criadores de Julia, Alan Edelman, em um [TEDx Talk](https://youtu.be/qGW0GT1rCvs) [@tedxtalksProgrammingLanguageHeal2020].

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/qGW0GT1rCvs' frameborder='0' allowfullscreen></iframe></div>

### Despacho Múltiplo {#sec:multiple_dispatch}

Despacho múltiplo é um recurso poderoso que nos permite estender funções existentes ou definir comportamento personalizado e complexo para novos tipos.
Suponha que você queira definir dois novos `struct`s para denotar dois animais diferentes:

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

Basicamente, isso diz "defina uma raposa, que é um animal" e "defina uma galinha, que é um animal".
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

E queremos saber se elas vão se dar bem.
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
Escrevendo a função `naive_trouble` parece ser o suficiente.
No entanto, usar despacho múltiplo para criar uma nova função `trouble` pode ser benéfico. Vamos criar novas funções:

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

Então, em resumo, o código que foi escrito pensando apenas para Raposa e Galinha funciona para tipos que **ele nunca tinham visto**!
Na prática, isso significa que Julia facilita o reuso do código de outros projetos.

Se você está tão animado quanto nós com o despacho múltiplo, aqui estão mais dois exemplos aprofundados.
O primeiro é uma [rápida e elegante implementação de um vetor one-hot](https://storopoli.io/Bayesian-Julia/pages/1_why_Julia/#example_one-hot_vector) por @storopoli2021bayesianjulia.
O segundo é uma entrevista com [Christopher Rackauckas](https://www.chrisrackauckas.com/) no [canal do YouTube de Tanmay Bakshi](https://youtu.be/moyPIhvw4Nk?t=2107) (assista do minuto 35:07 em diante) [@tanmaybakshiBakingKnowledgeMachine2021].
Chris explica que, enquanto utilizava o [`DifferentialEquations.jl`](https://diffeq.sciml.ai/dev/), um pacote que ele desenvolveu e mantém atualmente, um usuário registrou um problema que seu solucionador de Equações Diferenciais Ordinais (EDO) com quaternions baseado em GPU não funcionava.
Chris ficou bastante surpreso com este pedido, já que ele não esperava que alguém combinasse cálculos da GPU com quaternions e resolvendo EDOs.
Ele ficou ainda mais surpreso quando descobriu que o usuário cometeu um pequeno erro e que tudo funcionou.
A maior parte do mérito é devido ao múltiplo despacho e alto compartilhamento de código/tipos definidos pelo usuário.

Para concluir, pensamos que o despacho múltiplo é melhor explicado por um dos criadores de Julia:
[Stefan Karpinski na JuliaCon 2019](https://youtu.be/kc9HwsxE1OY).

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/kc9HwsxE1OY' frameborder='0' allowfullscreen></iframe></div>


## Julia Por Aí {#sec:julia_wild}

Em @sec:julia_accomplish, explicamos por que achamos que Julia é uma linguagem de programação única.
Mostramos exemplos simples sobre os principais recursos de Julia.
Se você quiser se aprofundar em como Julia está sendo usada, temos alguns **casos de uso interessantes**:

1. NASA usa Julia em um supercomputador que analisa ["o maior lote de planetas do tamanho da Terra já encontrado"](https://exoplanets.nasa.gov/news/1669/seven-rocky-trappist-1-planets-may-be-made-of-similar-stuff/) e alcançou uma extraordinária otimização que tornou a execução **1.000x mais rápida** para catalogar 188 milhões de objetos astronômicos em 15 minutos.
2. [A Aliança para a Modelagem Climática (Climate Model Alliance - CliMa)](https://clima.caltech.edu/) usa Julia para **modelar o clima na GPU e CPU**.
Lançado em 2018 em colaboração com pesquisadores da Caltech, do NASA Jet Propulsion Laboratory, e da Naval Postgraduate School, a CliMA está utilizando o progresso recente da ciência computacional para desenvolver um modelo do sistema terrestre que pode prever secas, ondas de calor e chuva com precisão e velocidade sem precedentes.
3. [O Departamento de Aviação Federal dos Estados Unidos (US Federal Aviation Administration - FAA) está desenvolvendo um **Sistema de Prevenção de Colisões Aéreas (Airborne Collision Avoidance System - ACAS-X)** usando Julia](https://youtu.be/19zm1Fn0S9M).
Esse é um bom exemplo do "Problema das Duas Linguagens" (see @sec:julia_accomplish).
Soluções anteriores usavam Matlab para desenvolver os algoritmos e C++ para uma implementação mais rápida.
Agora, FAA usa uma única linguagem para tudo isso: Julia.
4. [**Aceleração de 175x** para modelos de farmacologia da Pfizer usando GPUs em Julia](https://juliacomputing.com/case-studies/pfizer/).
Foi apresentado como um [poster](https://chrisrackauckas.com/assets/Posters/ACoP11_Poster_Abstracts_2020.pdf) na 11ª American Conference of Pharmacometrics (ACoP11) e [ganhou um prêmio de qualidade](https://web.archive.org/web/20210121164011/https://www.go-acop.org/abstract-awards).
5. [O Subsistema de Controle de Atitude e Órbita (Attitude and Orbit Control Subsystem - AOCS) do satélite brasileiro Amazonia-1 é **escrito 100% em Julia**](https://discourse.julialang.org/t/julia-and-the-satellite-amazonia-1/57541) por Ronan Arraes Jardim Chagas (<https://ronanarraes.com/>).
6. [O Banco Nacional de Desenvolvimento Econômico e Social (BNDES) do Brasil abandonou uma solução paga e optou pela modelagem em Julia (que é código aberto) e teve uma otimização de velocidade de execução em um fator de  **10x**.](https://youtu.be/NY0HcGqHj3g)

Se isso não for suficiente, existem mais estudos de caso em [Julia Computing website](https://juliacomputing.com/case-studies/).

[^readable]: sem quaisquer chamadas de API em C++ ou FORTRAN.
[^LLVM]: LLVM significa "Máquina Virtual de Baixo-Nível", ou, em inglês, **L**ow **L**evel **V**irtual **M**achine. Você pode encontrar mais sobre a LLVM no site: (<http://llvm.org>).

