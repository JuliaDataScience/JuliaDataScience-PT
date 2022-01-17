# Visualização de dados com Makie.jl {#sec:DataVisualizationMakie}

> Da palavra japonesa Maki-e, que é uma técnica para polvilhar verniz com pó de ouro e prata.
> Os dados são o ouro e a prata da nossa era, então vamos espalhá-los lindamente pela tela!
>
> _Simon Danisch, criador do `Makie.jl`_

[Makie.jl](http://makie.juliaplots.org/stable/index.html) é um ecossistema de plotagem de alto desempenho, extensível e multiplataforma para a linguagem de programação Julia.
Na nossa opinião, é o pacote de plotagem mais bonito e versátil.

Assim como muitos pacotes de plotagem, o código é dividido em vários pacotes.
`Makie.jl` é o pacote de _frontend_ que define todas as funções de plotagem necessárias para criar objetos de plotagem.
Esses objetos armazenam todas as informações sobre as plotagens, mas ainda precisam ser convertidos em uma imagem.
Para converter esses objetos de plotagem em uma imagem, você precisa de um dos _backends_ Makie.
Por padrão, o `Makie.jl` é reexportado por cada backend, então você só precisa instalar e carregar o _backend_ que deseja usar.

Existem três _backends_ principais que implementam concretamente todos os recursos de renderização abstratos definidos no Makie.
Um para gráficos vetoriais 2D não interativos com qualidade de publicação: `CairoMakie.jl`.
Outro para plotagem 2D e 3D interativa em janelas `GLFW.jl` independentes (que também rodam na GPU), `GLMakie.jl`.
E o terceiro, uma plotagem 2D e 3D interativa baseada em WebGL que roda dentro de navegadores, `WGLMakie.jl`. [Veja a documentação de Makie](http://makie.juliaplots.org/stable/documentation/backends_and_output/).

Neste livro, mostraremos apenas exemplos para `CairoMakie.jl` e `GLMakie.jl`.

Você pode ativar qualquer _backend_ usando o pacote apropriado e chamando sua função `activate!`.
Por exemplo:

```
using GLMakie
GLMakie.activate!()
```

Agora, vamos começar com plots com qualidade de publicação.
Mas, antes de sairmos plotando, é importante saber como salvar nossos gráficos.
A opção mais fácil para `salvar` uma figura `fig` é digitar `save("filename.png", fig)`.
Outros formatos também estão disponíveis para `CairoMakie.jl`, como `svg` e `pdf`.
A resolução da imagem de saída pode ser facilmente ajustada passando argumentos extras.
Por exemplo, para formatos vetoriais, você especifica `pt_per_unit`:

```
save("filename.pdf", fig; pt_per_unit=2)
```

ou

```
save("filename.pdf", fig; pt_per_unit=0.5)
```

Para `png`, você especifica `px_per_unit`.
Veja [Backends & Output](https://makie.juliaplots.org/stable/documentation/backends_and_output/) para mais detalhes.
