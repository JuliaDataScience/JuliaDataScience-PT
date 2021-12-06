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

So, `CSV.jl` adds quotation marks `"` around the comma-containing values.
Another common way to solve this problem is to write the data to a **t**ab-**s**eparated **v**alues (TSV) file format.
This assumes that the data doesn't contain tabs, which holds in most cases.

Also, note that TSV files can also be read using a simple text editor, and these files use the ".tsv" extension.

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

Text file formats like CSV and TSV files can also be found that use other delimiters, such as semicolons ";", spaces "\ ", or even something as unusual as "π".

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

By convention, it's still best to give files with special delimiters, such as ";", the ".csv" extension.

Loading CSV files using `CSV.jl` is done in a similar way.
You can use `CSV.read` and specify in what kind of format you want the output.
We specify a `DataFrame`.

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
CSV.read(path, DataFrame)
end # hide
"""; process=without_caption_label)
```

Conveniently, `CSV.jl` will automatically infer column types for us:

```jl
sco("""
JDS.inside_tempdir() do # hide
path = write_grades_csv()
df = CSV.read(path, DataFrame)
end # hide
"""; process=string, post=output_block)
```

It works even for far more complex data:

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

These CSV basics should cover most use cases.
For more information, see the [`CSV.jl` documentation](https://csv.juliadata.org/stable) and especially the [`CSV.File` constructor docstring](https://csv.juliadata.org/stable/#CSV.File).

### Excel {#sec:excel}

There are multiple Julia packages to read Excel files.
In this book, we will only look at [`XLSX.jl`](https://github.com/felipenoris/XLSX.jl), because it is the most actively maintained package in the Julia ecosystem that deals with Excel data.
As a second benefit, `XLSX.jl` is written in pure Julia, which makes it easy for us to inspect and understand what's going on under the hood.

Load `XLSX.jl` via

```
using XLSX:
    eachtablerow,
    readxlsx,
    writetable
```

To write files, we define a little helper function for data and column names:

```jl
@sc write_xlsx("", DataFrame())
```

Now, we can easily write the grades to an Excel file:

```jl
@sc write_grades_xlsx()
```

When reading it back, we will see that `XLSX.jl` puts the data in a `XLSXFile` type and we can access the desired `sheet` much like a `Dict`:

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

Notice that we cover just the basics of `XLSX.jl` but more powerful usage and customizations are available.
For more information and options, see the [`XLSX.jl` documentation](https://felipenoris.github.io/XLSX.jl/stable/).
