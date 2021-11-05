# Prefácio {#sec:preface}

Existem várias linguagens de programação e cada uma delas tem seus pontos fortes e fracos.
Algumas linguagens são mais rápidas, mas bastante verbosas.
Outras linguagens são fáceis de codificar, mas são lentas. Isso é conhecido como o problema das *duas linguagens* e Julia busca eliminar esse problema.
Mesmo que nós três somos de áreas distintas, todos acreditamos que Julia é mais efetiva para nossas pesquisas que as outras linguagens que usamos antes.
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

Na próxima etapa dessa seção daremos uma ênfase maior **na importância dos "dados" em ciência de dados** e mostraremos porque a habilidade em manipulação de dados é, e continuará sendo, a **maior demanda** do mercado e da academia.
Argumentamos que **incorporar as práticas da engenharia de software à ciência de dados** reduzirá o atrito na atualização e no compartilhamento de códigos entre colaboradores.
Grande parte da análise de dados vem de um esforço colaborativo, por isso as práticas de desenvolvimento de software são de grande ajuda.

### Dados estão em todos os lugares {#sec:data_everywhere}

**Dados são abundantes** e serão ainda mais em um futuro próximo.
Um relatório do final do ano de 2012, concluiu que, entre 2005 e 2020, a quantidade de dados armazenados digitalmente **cresceria em um fator de 300, partindo de 130 exabytes^[1 exabyte (EB) = 1,000,000 terabyte (TB).] para impressionantes 40,000 exabytes** [@gantz2012digital].
Isso equivale a 40 trilhões de gigabytes: para colocarmos em perspectiva, são mais de **5.2 terabytes para cada ser humano que vive neste planeta!**
Em 2020, em média, cada pessoa criou **1.7 MB de dados por segundo** [@domo2018data].
Um relatório recente previu que quase **dois terços (65%) dos PIBs nacionais estarão digitalizados até 2022** [@fitzgerald2020idc].

Todas as profissões serão impactadas pelo aumento e disponibilidade cada vez maior de dados [@chen2014big; @khan2014big] e pela crescente importância que os dados têm tomado.
Dados são usados para comunicar e construir conhecimento, assim como na tomada de decisões.
É por isso que habilidade com dados é tão importante.
Estar confortável ao lidar com dados fará de você um pesquisador e/ou profissional valioso.
Em outras palavras, você se tornará  **alfabetizado em dados**.

## O que é Ciência de Dados? {#sec:why_data_science}

Ciência de dados não se trata apenas de aprendizado de máquina e estatística, também não é somente sobre predição.
Também não é uma disciplina totalmente contida nos campos STEM (Ciências, Tecnologia, Engenharia e Matemática) [@Meng2019Data].
Entretanto, podemos afirmar com certeza que ciência de dados é sempre sobre **dados**.
Nossos objetivos com este livro são dois:

* Focar na espinha dorsal da ciência de dados: **dados**.
* E o uso da linguagem de programação **Julia** para o processamento de dados.

Explicamos porque Julia é uma linguagem extremamente eficaz para a ciência de dados em @sec:why_julia.
Por enquanto, vamos focar nos dados.

### Alfabetização de dados {#sec:data_literacy}

De acordo com a [Wikipedia](https://pt.wikipedia.org/wiki/Alfabetiza%C3%A7%C3%A3o_de_dados), a definição formal para **alfabetização de dados é "a habilidade de ler, entender, criar e comunicar dados enquanto informação."**.
Também gostamos da concepção informal de que, ao se tornar alfabetizado em dados, você não se sentirá sufocado pelos dados, mas sim, saberá utilizá-los na tomada correta de decisões.
Alfabetização de dados é uma habilidade extremamente competitiva.
Neste livro iremos abordar dois importantes aspectos da alfabetização de dados:

1. **Manipulação de dados** com `DataFrames.jl` (@sec:dataframes).
Neste capítulo, você aprenderá a:
    1. Ler dados em CSV e Excel com Julia.
    2. Processar dados em Julia, ou seja, aprender a responder questões com dados.
    3. Filtrar dados e criar subconjuntos de dados.
    4. Lidar com dados faltantes.
    5. Unir e combinar dados provenientes de várias fontes.
    6. Agrupar e resumir dados.
    7. Exportar dados do Julia para arquivos CSV e Excel.
2. **Visualização de dados** com `Makie.jl` (@sec:DataVisualizationMakie).
Neste capítulo você entenderá como:
    1. Plotar dados utilizando diversos backends do `Makie.jl`.
    2. Salvar visualizações nos mais diferentes formatos, como PNG ou PDF.
    3. Usar diferentes funções de plotagem para criar diversas formas de visualização dos dados.
    4. Customizar visualizações por meio de atributos.
    5. Usar e criar novos temas para suas plotagens.
    6. Adicionar elementos $\LaTeX$ aos plots.
    7. Manipular cores e paletas.
    8. Criar layouts de figuras complexas.

## Engenharia de software {#sec:engineering}

Diferentemente de boa parte da literatura sobre ciência de dados, esse livro dá uma ênfase maior para a **estruturação do código**.
A razão para isso é que notamos que muitos cientistas de dados simplesmente inserem seu código em um arquivo enorme e rodam as instruções sequencialmente.
Uma analogia possível seria forçar as pessoas a lerem um livro sempre do início até o final, sem poder consultar capítulos anteriores ou pular para seções mais interessantes.
Isso funciona para projetos menores, mas quanto maior e mais complexo for o projeto, mais problemas aparecerão.
Por exemplo, um livro bem escrito é dividido em diferentes capítulos e seções que fazem referência a diversas partes do próprio livro.
O equivalente a isso em desenvolvimento de software é **dividir o código em funções**.
Cada função tem nome e algum conteúdo.
Ao usar corretamente as funções você pode determinar que o computador, em qualquer ponto do código, pule de um lugar para outro e continue a partir daí.
Isso permite que você reutilize o código com mais facilidade entre projetos, atualize o código, compartilhe o código, colabore e tenha uma visão mais geral do processo.
Portanto, com as funções, você pode **otimizar o tempo**.

Assim, ao ler este livro, você acabará se acostumando a ler e usar funções.
Outro benefício em ser hábil na engenharia de software é compreender com mais facilidade o código-fonte dos pacotes que utiliza, algo essencial quando se depura códigos ou quando buscamos entender exatamente como os pacotes que utilizamos funcionam.
Por fim, você pode ter certeza de que não inventamos essa ênfase em funções.
Na indústria, é comum estimular desenvolvedores a usarem **"funções ao invés de comentários"**.
Isso significa que, em vez de escrever um comentário para humanos e algum código para o computador, os desenvolvedores escrevem uma função que é lida por humanos e computadores.

Além disso, nos esforçamos muito para seguir um guia de estilo consistente.
Os guias de estilo de programação fornecem diretrizes para a escrita de códigos, por exemplo, sobre onde deve haver espaço em branco e quais nomes devem ser iniciados com letra maiúscula ou não.
Seguir um guia de estilo rígido pode parecer pedante e algumas vezes é.
No entanto, quanto mais consistente o código for, mais fácil será sua leitura e compreensão.
Pra ler nosso código, você não precisa entender nosso guia de estilo.
Você perceberá enquanto lê.
Se quiser conhecer os detalhes de nosso guia de estilo, acesse @sec:notation.

## Agradecimentos

Muitas pessoas colaboraram direta ou indiretamente para a criação deste livro.

Jose Storopoli agradece sua famíla, em especial sua esposa pelo suporte e compreensão durante a escrita e revisão da obra.
Ele também agradece aos seus colegas, em especial a [Fernando Serra](https://orcid.org/0000-0002-8178-7313), [Wonder Alexandre Luz Alves](https://orcid.org/0000-0003-0430-950X) e [André Librantz](https://orcid.org/0000-0001-8599-9009), por seu suporte.

Rik Huijzer agradece em primeiro lugar seus supervisores de PhD na Universidade de Groningen, [Peter de Jonge](https://www.rug.nl/staff/peter.de.jonge/), [Ruud den Hartigh](https://www.rug.nl/staff/j.r.den.hartigh/) e [Frank Blaauw](https://frankblaauw.nl/).
Em segundo lugar, agradece aos pais e a sua namorada por toda a compreensão durante feriados, finais de semana e noites dedicadas a este livro.

Lazaro Alonso agradece sua esposa e suas filhas por todo suporte durante o projeto.
