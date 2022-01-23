## GLMakie.jl {#sec:glmakie}

`CairoMakie.jl` fornece todas as nossas necessidades de imagens 2D estáticas.
Mas às vezes queremos interatividade, principalmente quando estamos lidando com imagens 3D.
A visualização de dados em 3D também é uma prática comum para obter insights de seus dados.
É aqui que `GLMakie.jl` pode ser útil, já que usa [OpenGL](http://www.opengl.org/) como um _backend_ que adiciona interatividade e capacidade de resposta a _plots_.
Como antes, um _plot_ simples inclui, é claro, linhas e pontos.
Então, vamos começar com eles e como já sabemos como os layouts funcionam, vamos colocar isso em prática.

### Dispersão e Linhas

Para os gráficos de dispersão temos duas opções, a primeira é `scatter(x, y, z)` e a segunda é `meshscatter(x, y, z)`.
Na primeira, os marcadores não são escalonados nas direções dos eixos, mas na segunda, porque são geometrias reais no espaço 3D.
Veja o próximo exemplo:

```
using GLMakie
GLMakie.activate!()
```

```jl
@sco JDS.scatters_in_3D()
```
Observe também que uma geometria diferente pode ser passada como marcadores, ou seja, um quadrado/ângulo e podemos atribuir-lhes uma `colormap` também.
No painel central, pode-se obter esferas perfeitas fazendo `aspect = :data` como no painel direito.

E fazendo `lines` ou `scatterlines` é também bem simples:

```jl
@sco JDS.lines_in_3D()
```

Plotando uma `surface` também é fácil de ser fazer assim como um `wireframe` e linhas `contour` em 3D.

### `surface`s, `wireframe`, `contour`, `contourf` e `contour3d`

Para mostrar estes casos, utilizaremos a seguinte função `peaks`:

```jl
@sc JDS.peaks()
```

A saída para as diferentes funções de plotagem é:

```jl
@sco JDS.plot_peaks_function()
```

Mas, também pode ser plotado com um `heatmap(x, y, z)`, `contour(x, y, z)` ou `contourf(x, y, z)`:

```jl
@sco JDS.heatmap_contour_and_contourf()
```

Adicionalmente, ao mudarmos `Axis` para um `Axis3`, estes _plots_ estarão automaticamente no plano x-y:

```jl
@sco JDS.heatmap_contour_and_contourf_in_a_3d_plane()
```

Algo que também é bem facil de fazer é misturar todas essas fun;óes de plotagens em um único _plot_:

```
using TestImages
```

```jl
@sco JDS.mixing_surface_contour3d_contour_and_contourf()
```

Não é ruim, certo?
É claro que qualquer `heatmap`s, `contour`s, `contourf`s ou `image` pode ser plotado em qualquer _plot_.

### `arrows` e `streamplots`

`arrows` e `streamplot` são _plots_ que podem ser úteis quando queremos saber as direções que uma determinada variável seguirá.
Veja uma demonstração abaixo^[Estamos usando o módulo `LinearAlgebra` da biblioteca padrão de Julia.]:

```
using LinearAlgebra
```

```jl
@sco JDS.arrows_and_streamplot_in_3d()
```

Outros exemplos interessantes são `mesh(obj)`, `volume(x, y, z, vals)`, e `contour(x, y, z, vals)`.

### _Mesh_ e Volumes

Visualizações de _mesh_ são úteis quando você quer plotar geometrias, como uma `Sphere` ou um Retângulo, ex: `FRect3D`.
Outra abordagem para visualizar pontos no espaço 3D é chamando as funções `volume` e `contour`, que implementam [_ray tracing_](https://en.wikipedia.org/wiki/Ray_tracing_(graphics)) para simular uma grande variedade de efeitos ópticos.
Veja os próximos exemplos:

```
using GeometryBasics
```

```jl
@sco JDS.mesh_volume_contour()
```

Note que aqui estamos traçando duas _mesh_ no mesmo eixo, uma esfera transparente e um cubo.
Até agora, cobrimos a maioria dos casos de uso 3D.
Outro exemplo é `?linesegments`.

Tomando como referência o exemplo anterior, pode-se fazer o seguinte _plot_ personalizado com esferas e retângulos:

```
using GeometryBasics, Colors
```

Para as esferas, vamos fazer um _grid_ retangular.
Além disso, usaremos uma cor diferente para cada uma delas.
Adicionalmente, podemos misturar esferas e um plano retangular.
Em seguida, definimos todos os dados necessários.

```jl
sc("""
seed!(123)
spheresGrid = [Point3f(i,j,k) for i in 1:2:10 for j in 1:2:10 for k in 1:2:10]
colorSphere = [RGBA(i * 0.1, j * 0.1, k * 0.1, 0.75) for i in 1:2:10 for j in 1:2:10 for k in 1:2:10]
spheresPlane = [Point3f(i,j,k) for i in 1:2.5:20 for j in 1:2.5:10 for k in 1:2.5:4]
cmap = get(colorschemes[:plasma], LinRange(0, 1, 50))
colorsPlane = cmap[rand(1:50,50)]
rectMesh = FRect3D(Vec3f(-1, -1, 2.1), Vec3f(22, 11, 0.5))
recmesh = GeometryBasics.mesh(rectMesh)
colors = [RGBA(rand(4)...) for v in recmesh.position]
""")
```

Então, o _plot_ é feito simplesmente com:

```jl
@sco JDS.grid_spheres_and_rectangle_as_plate()
```

Aqui, o retângulo é semi-transparente devido ao canal alfa adicionado à cor RGB.
A função de retângulo é bastante versátil, por exemplo, _box_ 3D é fácil implementar que por sua vez pode ser usada para traçar um histograma 3D.
Veja nosso próximo exemplo, onde estamos usando novamente nossa função `peaks` e algumas definições adicionais:

```jl
sc("""
x, y, z = peaks(; n=15)
δx = (x[2] - x[1]) / 2
δy = (y[2] - y[1]) / 2
cbarPal = :Spectral_11
ztmp = (z .- minimum(z)) ./ (maximum(z .- minimum(z)))
cmap = get(colorschemes[cbarPal], ztmp)
cmap2 = reshape(cmap, size(z))
ztmp2 = abs.(z) ./ maximum(abs.(z)) .+ 0.15
""")
```

aqui $\delta x, \delta y$ são usados para especificar o tamanho das _box_.
`cmap2` será a cor de cada _box_ e `ztmp2` será usado como o parâmetro de transparência.
Veja o resultado na próxima figura.

```jl
@sco JDS.histogram_or_bars_in_3d()
```

Note que você pode também usar `lines` ou `wireframe` sobre um objeto _mesh_.

### Linhas Preenchidas e `band`

Para o nosso último exemplo vamos mostrar como fazer uma curva preenchida em 3d com `band` e alguns `linesegments`:

```jl
@sco JDS.filled_line_and_linesegments_in_3D()
```

Finalmente, nossa jornada fazendo _plots_ 3D chegou ao fim.
Você pode combinar tudo o que expostos aqui para criar imagens 3D incríveis!
