# Prefácio {#sec:preface}

Existem várias linguagens de programação e cada uma delas tem seus pontos fortes e fracos.
Algumas linguagens são mais rápidas, mas bastante verbosas.
Outras linguagens são fáceis de codificar, mas são lentas. Isso é conhecido como o problema de *duas linguagens* problem e Julia busca contornar esse tipo de problema.
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
The software equivalent of this is **splitting code into functions**.
Each function has a name and some contents.
By using functions, you can tell the computer at any point in your code to jump to some other place and continue from there.
This allows you to more easily re-use code between projects, update code, share code, collaborate, and see the big picture.
Hence, with functions, you can **save time**.

So, while reading this book, you will eventually get used to reading and using functions.
Another benefit of having good software engineering skills is that it will allow you to more easily read the source code of the packages that you're using, which could be greatly beneficial when you are debugging your code or wondering how exactly the package that you're using works.
Finally, you can rest assured that we did not invent this emphasis on functions ourselves.
In industry, it is common practice to encourage developers to use **"functions instead of comments"**.
This means that, instead of writing a comment for humans and some code for the computer, the developers write a function which is read by both humans and computers.

Also, we've put much effort into sticking to a consistent style guide.
Programming style guides provide guidelines for writing code; for example, about where there should be whitespace and what names should be capitalized or not.
Sticking to a strict style guide might sound pedantic and it sometimes is.
However, the more consistent the code is, the easier it is to read and understand the code.
To read our code, you don't need to know our style guide.
You'll figure it out when reading.
If you do want to see the details of our style guide, check out @sec:notation.

## Acknowledgements

Many people have contributed directly and indirectly to this book.

Jose Storopoli would like to thank his family, especially his wife for the support and love during the writing and reviewing process.
He would also like to thank his colleagues, especially [Fernando Serra](https://orcid.org/0000-0002-8178-7313), [Wonder Alexandre Luz Alves](https://orcid.org/0000-0003-0430-950X) and [André Librantz](https://orcid.org/0000-0001-8599-9009), for their encouragement.

Rik Huijzer would first like to thank his PhD supervisors at the University of Groningen, [Peter de Jonge](https://www.rug.nl/staff/peter.de.jonge/), [Ruud den Hartigh](https://www.rug.nl/staff/j.r.den.hartigh/) and [Frank Blaauw](https://frankblaauw.nl/) for their support.
Second, he would like to thank his parents and girlfriend for being hugely supportive during the holiday and all the weekends and evenings that were involved in this book.

Lazaro Alonso would like to thank his wife and daughters for their encouragement to get involved in this project.
