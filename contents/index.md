# Bem-vindo(a) {-}

```{=html}
<style>
.language-switcher {
    font-size: 22px;
    text-align: right;
    margin-right: 0.2em;
    margin-bottom: 2em;
}

.language-switcher button {
    font-size: 20px;
}
</style>

<div class="language-switcher">
<a href="https://juliadatascience.io"><button>🇺🇸</button></a>
<a href="/pt"><button>🇧🇷</button></a>
</div>
```

```{=comment}
This file is only included on the website.
```

Bem-vindo(a)! Este é um livro _open source_ e de acesso livre e gratuito de como fazer **Ciência de Dados com [Julia](https://julialang.org)**.
Nosso público-alvo são pesquisadores de todos os campos de ciências aplicadas, assim como praticantes e profissionais do mercado.
Você pode navegar pelas páginas do ebook usando as teclas direcionais (esquerda/direita) do seu teclado.

Este livro também está disponível como um arquivo [**PDF**](/juliadatascience.pdf){target="_blank"}.

O código-fonte está disponível no [GitHub](https://github.com/JuliaDataScience/JuliaDataScience-PT){target="_blank"}.

Este livro também está disponível na [Amazon.com](https://www.amazon.com/dp/B09QP69D1T/).

Se você quer ser notificado sobre atualizações, por favor considere se **inscrever na newsletter**:

```{=html}
<form style="margin: 0 auto;" action="https://api.staticforms.xyz/submit" method="post">
    <input type="hidden" name="accessKey" value="2b78f325-fb4e-44e1-ad2f-4dc714ac402f">
    <input type="email" name="email">
    <input type="hidden" name="redirectTo" value="https://juliadatascience.io/thanks">
    <input type="submit" value="Submit" />
</form>
```

### Como Citar esse Livro {-}

Para citar esse conteúdo por favor use:

```plaintext
Storopoli, Huijzer and Alonso (2021). Julia Data Science. https://juliadatascience.io. ISBN: 9798489859165.
```

Or in BibTeX format:

```plaintext
@book{storopolihuijzeralonso2021juliadatascience,
  title = {Julia Data Science},
  author = {Jose Storopoli and Rik Huijzer and Lazaro Alonso},
  url = {https://juliadatascience.io},
  year = {2021},
  isbn = {9798489859165}
}
```

### Capa do Livro {-}

```jl
let
    fig = front_cover()
    # Use lazy loading to keep homepage speed high.
    link_attributes = """loading="lazy" width=80%"""
    # When changing this name, also change the link in README.md.
    # This doesn't work for some reason; I need to fix it.
    filename = "frontcover"
    Options(fig; filename, label=filename)
end
```
