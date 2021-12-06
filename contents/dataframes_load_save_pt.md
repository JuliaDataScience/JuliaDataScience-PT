## Carrgar e salvar arquivos {#sec:load_save}

Ter apenas dados dentro dos programas Julia e não ser capaz de carregá-los ou salvá-los seria muito limitante.
Portanto, começamos mencionando como armazenar e carregar arquivos do disco.
Focamos em CSV, see @sec:csv, e Excel, see @sec:excel, formatos de arquivo, uma vez que esses são os formatos de armazenamento de dados mais comuns para dados tabulares.

### CSV {#sec:csv}

Arquivos **C**omma-**s**eparated **v**alues (CSV) são eficazes no armazenamento de tabelas.
Os arquivos CSV têm duas vantagens sobre outros arquivos de armazenamento de dados.
Primeiro, eles fazem exatamente o que o nome indica que fazem, ou seja, armazenam valores, separando-os por vírgulas `,`.
Este acrônimo também é usado como extensão de arquivo.
Portanto, certifique-se de salvar seus arquivos usando a extensão ".csv" tal como "myfile.csv".
Para demonstrar a aparência de um arquivo CSV, podemos instalar o pacote [`CSV.jl`](http://csv.juliadata.org/latest/):

```
julia> ]

pkg> add CSV
```

e carregue-lo via:

```
using CSV
```

Agora podemos usar nossos dados anteriores:

```jl
sco("
grades_2020()
"; process=without_caption_label)
```

e lê-los de um arquivo depois de escrever:

```jl
@sc write_grades_csv()
```

```jl
sco("""
JDS.output_block_inside_tempdir() do # hide
path = write_grades_csv()
read(path, String)
end # hide
""")
```

Aqui, também vemos o segundo benefício do formato de dados CSV: os dados podem ser lidos usando um editor de texto simples.
Isso difere de muitos formatos de dados alternativos que requerem software próprio, por exemplo, Excel.

Isso funciona muito bem, mas somente se nossos dados **contiverem vírgulas `,`** como valores?
Se tivéssemos de escrever ingenuamente os dados com vírgulas, issp tornaria os arquivos muito difíceis de se converter de volta para uma tabela.
Por sorte, `CSV.jl` lida com isso de forma automática.
Considere os seguintes dados com vírgulas `,`:

```jl
@sco grades_with_commas()
```

Se escrevermos isso, teremos:

```jl
sco("""
JDS.output_block_inside_tempdir() do # hide
function write_comma_csv()
    path = "grades-commas.csv"
    CSV.write(path, grades_with_commas())
end
path = write_comma_csv()
read(path, String)
end # hide
""")
```

Logo, `CSV.jl` adiciona aspas `"` em torno dos valores contendo vírgulas.
Outra maneira comum de resolver esse problema é gravar os dados em um formato de arquivo **t**ab-**s**eparated **v**alues (TSV).
Isso pressupõe que os dados não contêm guias, o que é válido na maioria dos casos.

Além disso, observe que os arquivos TSV também podem ser lidos usando um editor de texto simples e esses arquivos usam a extensão ".tsv".

```jl
sco("""
JDS.output_block_inside_tempdir() do # hide
function write_comma_tsv()
    path = "grades-comma.tsv"
    CSV.write(path, grades_with_commas(); delim='\\t')
end
read(write_comma_tsv(), String)
end # hide
""")
```

Também é possível encontrar formatos de arquivo de texto, como arquivos CSV e TSV, que usam outros delimitadores, como ponto-e-vírgula ";", espaços "\ ", ou mesmo algo tão incomum como "π".

```jl
sco("""
JDS.output_block_inside_tempdir() do # hide
function write_space_separated()
    path = "grades-space-separated.csv"
    CSV.write(path, grades_2020(); delim=' ')
end
read(write_space_separated(), String)
end # hide
""")
```

Por convenção, ainda é melhor fornecer arquivos com delimitadores especiais, como ";", a extensão ".csv".

Carregando arquivos CSV usando `CSV.jl` é feito de maneira semelhante.
Você pode usar `CSV.read` e especifique em que tipo de formato você deseja que a saída.
Nós especificamos um `DataFrame`.

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
CSV.read(path, DataFrame)
end # hide
"""; process=without_caption_label)
```

Convenientemente, `CSV.jl` irá inferir automaticamente os tipos de coluna para nós:

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
df = CSV.read(path, DataFrame)
end # hide
"""; process=string, post=output_block)
```

Funciona mesmo com dados muito mais complexos:

```jl
sco("""
JDS.inside_tempdir() do # hide
my_data = \"\"\"
    a,b,c,d,e
    Kim,2018-02-03,3,4.0,2018-02-03T10:00
    \"\"\"
path = "my_data.csv"
write(path, my_data)
df = CSV.read(path, DataFrame)
end # hide
"""; process=string, post=output_block)
```

Essas noções básicas de CSV devem abranger a maioria dos casos de uso.
Para obter mais informações, consulte o [`CSV.jl` documentação](https://csv.juliadata.org/stable) e, especialemnte, o [`CSV.File` construtor docstring](https://csv.juliadata.org/stable/#CSV.File).

### Excel {#sec:excel}

Existem vários pacotes Julia para ler arquivos Excel.
Existem vários pacotes Julia para ler arquivos Excel [`XLSX.jl`](https://github.com/felipenoris/XLSX.jl), porque é o pacote mais ativamente mantido no ecossistema Julia que lida com dados do Excel.
Como um segundo benefício, `XLSX.jl` é escrito em Julia puro, o que torna mais fácil para nós inspecionar e entender o que está acontecendo nos bastidores.

Carregue `XLSX.jl` via

```
using XLSX:
    eachtablerow,
    readxlsx,
    writetable
```

Para escrever arquivos, definimos uma pequena função auxiliar para dados e nomes de colunas:

```jl
@sc write_xlsx("", DataFrame())
```

Agora, podemos escrever facilmente as notas em um arquivo Excel:

```jl
@sc write_grades_xlsx()
```

Ao ler de volta, veremos que `XLSX.jl` coloca os dados em um tipo `XLSXFile` type e podemos acessar a `folha` desejada como um `Dict`:

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_xlsx()
xf = readxlsx(path)
end # hide
""")
```

```jl
s = """
    JDS.inside_tempdir() do # hide
    xf = readxlsx(write_grades_xlsx())
    sheet = xf["Sheet1"]
    eachtablerow(sheet) |> DataFrame
    end # hide
    """
sco(s; process=without_caption_label)
```

Observe que cobrimos apenas o básico de `XLSX.jl` mas um uso mais poderoso e personalizações estão disponíveis.
Para obter mais informações e opções, consulte o [`XLSX.jl` documentação](https://felipenoris.github.io/XLSX.jl/stable/).
