# Prefácio {#sec:preface}

Existem várias linguagens de programação e cada uma delas tem seus pontos fortes e fracos.
Algumas linguagens são mais rápidas, mas bastante verbosas.
Outras linguagens são fáceis de codificar, mas são lentas. Isso é conhecido como o problema de *duas linguagens* e Julia busca contornar esse tipo de questão.
Mesmo que nós três venhamos de áreas distintas, todos acreditamos que Julia é mais eficiente que outros tipos de linguagens para nossas pesquisas. 
Discorremos sobre esse ponto de vista em @sec:why_julia.
Contudo, comparada a outras linguagens de programação, Julia é uma das mais recentes.
Isso significa que o ecossistema em torno da liguagem é, por vezes, de difícil navegação.
É difícil descobrir por onde começar e como todos os diferentes pacotes se encaixam.
Por isso decidimos escrever este livro!
Desejamos tornar mais acessível para pesquisadores, em especial para nossos colegas, essa linguagem incrível.

Como pontuado anteriormente, cada linguagem de programação tem seus pontos fortes e fracos.
Para nós, a ciência de dados é, definitivamente, um ponto forte de Julia.
Ao mesmo tempo, nós três usamos ferramentas de ciência de dados no nosso dia a dia.
E provavelmente você também quer trabalhar com ciência de dados!
Por isso, nosso livro é focado em ciência de dados.

Na próxima etapa dessa seção daremos uma ênfase maior nos **"dados" parte essencial da ciência de dados** e como a habilidade em manipulação de dados é, e continuará sendo, a **maior demanda** do mercado e da academia.
Argumentamos que **incorporar a ciência de dados às práticas de engenharia de software** reduzirá o atrito na atualização e no compartilhamento de códigos entre colaboradores. 
Grande parte da análise de dados vem de um esforço colaborativo, por isso as práticas com softwares são de grande ajuda.

### Dados estão em todos os lugares {#sec:data_everywhere}

**Dados são abundantes** e serão ainda mais em um futuro próximo.
Um relatório do final do ano de 2012, concluiu que, entre 2005 e 2020, a quantidade de dados armazenados digitalmente **cresceu de um fator de 300, em 130 exabytes^[1 exabyte (EB) = 1,000,000 terabyte (TB).] para impressionantes 40,000 exabytes** [@gantz2012digital].
Em 2020, na média, cada pessoa criou **1.7 MB dados por segundo** [@domo2018data].
Um relatório recente previu que quase **dois terços (65%) doas PIBs nacionais estarão digitalizados até 2022** [@fitzgerald2020idc].

Todas as profissões serão impactadas pelo aumento e pela disponibilidade cada vez maior de dados [@chen2014big; @khan2014big].
Dados são usados para comunicar e construir conhecimento, assim como na tomada de decisões. 
É por isso que habilidades com dados é tão importante.
Estar confortável ao lidar com dados, fará de você um pesquisador e/ou profissional valioso. 
Em outras palavras, você adquirirá **literacia em dados**.

## O que é Ciência de Dados? {#sec:why_data_science}

Ciência de Dados não se trata apenas de aprendizado de máquina e estatística, também não é somente sobre predição.
Também não é uma disciplina totalmente contida nos campos STEM (Ciências, Tecnologia, Engenharia e Matemática) [@Meng2019Data].
Entretanto, podemos afirmar com certeza que Ciência de Dados é sempre sobre **dados**.
Nossos objetivos com este livro são dois:

* Focar na espinha dorsal da Ciência de dados: **dados**.
* E o uso da linguagem de programação **Julia** para o processamento de dados.

Explicamos porque Julia é uma linguagem extremamente eficaz para a Ciência de Dados em @sec:why_julia.
Por enquanto, vamos focar nos dados.

### Literacia em dados {#sec:data_literacy}

De acoro com a [Wikipedia](https://en.wikipedia.org/wiki/Data_literacy), a definição formal para **literacia em dados é "a habilidade de ler, entender, criar e comunicar dados enquanto informação."**.
Também gostamos da concepção informal de que, ao adquirir literacia em dados, você não se sentirá sufocado pelos dados, mas sim, saberpa utilizá-los na tomada correta de decisões.
Literacia em dados é uma habilidade extremamente competitiva.
Neste livro iremos abordar dois importantes aspectos da literacia em dados:

1. **Manipulação de dados** com `DataFrames.jl` (@sec:dataframes).
Neste capítulo, você aprenderá a:
    1. Ler dados em CSV e Excel com Julia.
    2. Processar dados em Julia, ou seja, aprender a responder questões com dados.
    3. Filtrar e agrupar dados.
    4. Lidar com dados faltantes.
    5. Agrupar várias fontes de dados.
    6. Agrupar e resumir dados.
    7. Exportar dados em Julia para arquivos CSV e Excel.
2. **Visualização de dados** com `Makie.jl` (@sec:DataVisualizationMakie).
Neste capítulo você entenderá como:
    1. Plotar dados `Makie.jl` com diferentes backends.
    2. Salvar visualizações nos mais diferentes formatos, como PNG ou PDF.
    3. Usar diferentes funções de plotagem para criar diversas formas de visualização dos dados.
    4. Customizar visualizações com atributos.
    5. Usar e criar novos temas de plotagem.
    6. Adicionar elementos $\LaTeX$ aos plots.
    7. Manilupar cores e paletas.
    8. Criar layouts de figuras complexas.

## Engenharia de software {#sec:engineering}

Diferente de boa parte da literatura sobre Ciência de Dados, esse livro dá uma ênfase maior para a **estruturação do código**.
A razão para isso é que notamos que muitos cientistas de dados simplesmente inserem seu código em um arquivo enorme e rodam as instruções sequencialmente.
Uma analogia possível seria forçar as pessoas a lerem um livro sempre do início até o final, sem poder consultar capítulos anteriores ou pular para seções mais interessantes.
Isso funciona para projetos menores, mas enquanto maior e mais complexo for o projeto, mais problemas aparecerão.
Por exemplo, um livro bem escrito é dividido em diferentes capítulos e seções que fazem referência a diversas partes do próprio livro.
O software equivalente a isso **divide o código em funções**.
Cada função tem nome e algum conteúdo.
Ao usar corretamente as funções, você pode determinar que o computador, em qualquer ponto do código, pule de um lugar para outro e continue a partir daí.
Isso permite que você reutilize o código com mais facilidade entre projetos, atualize o código, compartilhe o código, colabore e tenha uma visão mais geral do processo.
Portanto, com as funções, você pode **otimizar o tempo**.

Assim, ao ler este livro, você acabará se acostumando a ler e usar funções.
Outro benefício em ser hábil na engenharia de software, é compreender com mais facilidade o código-fonte dos pacotes que utiliza, algo essencial qunado se depura códigos ou quando buscamos entender exatamente como os pacotes que utilizamos funcionam.
Por fim, você pode ter certeza de que não inventamos essa ênfase nas funções.
Na indústria, é comum estimular desenvolvedores a usarem **"funções ao invés de comentários"**.
Isso significa que, em vez de escrever um comentário para humanos e algum código para o computador, os desenvolvedores escrevem uma função que é lida por humanos e computadores.

Além disso, nos esforçamos muito para seguir um guia de estilo consistente.
Os guias de estilo de programação fornecem diretrizes para a escrita de códigos,por exemplo, sobre onde deve haver espaço em branco e quais nomes devem ser em caixa alta ou não.
Seguir um guia de estilo rígido pode parecer pedante e algumas vezes é.
No entanto, enquanto mais consistente o código for, mais fácil serão sua leitura e compreensão.
Pra ler nosso código, você não precisa entender nosso guia de estilo.
Você perceberá enquanto lê.
Se quiser conhecer os detalhes de nosso guia de estilo, acesse @sec:notation.

## Agradecimentos

Muitas pessoas colaboraram direta ou indiretamente para a criação deste livro.

Jose Storopoli agradece sua famíla, em especial sua esposa pelo suporte e amor durante a escrita e revisão da obra.
Ele também agradece aos seus colegas, em especial a [Fernando Serra](https://orcid.org/0000-0002-8178-7313), [Wonder Alexandre Luz Alves](https://orcid.org/0000-0003-0430-950X) e [André Librantz](https://orcid.org/0000-0001-8599-9009), por seu suporte.

Rik Huijzer agrade em primeiro lugar seus supervisores de PhD na Universidade de Groningen, [Peter de Jonge](https://www.rug.nl/staff/peter.de.jonge/), [Ruud den Hartigh](https://www.rug.nl/staff/j.r.den.hartigh/) e [Frank Blaauw](https://frankblaauw.nl/).
Em segundo lugar, agradece aos pais e a sua namorada por toda a compreensão durante feriados, finais de semana e noites dedicadas a este livro. 

Lazaro Alonso agradece sua esposa e suas filhas por todo suporte durante o projeto.
