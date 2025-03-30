---
layout: page
title: Pandas
nav_order: 5
---
[<img src="https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/colab_favicon_small.png" style="float: right;">](https://colab.research.google.com/github/flaviovdf/icd-bradesco/blob/master/_lessons/05-Pandas.ipynb)

# Tópico 5 – DataFrames: Acessando DataFrames e Séries
{: .no_toc .mb-2 }

DataFrames representam tabelas. Vamos finalmente explorar alguns dados!
{: .fs-6 .fw-300 }

{: .no_toc .text-delta }
Resultados Esperados

1. Entender o `DataFrame` de pandas/babypandas
1. Saber acessar linhas e colunas
1. Entender consultas básicas

Os dados de hoje estão [aqui](https://raw.githubusercontent.com/flaviovdf/fcd/main/assets/06-GroupBy/data/afonso_pena.csv)

### Agenda

Hoje, usaremos um conjunto de dados real e muitas perguntas motivadoras para ilustrar as principais técnicas de manipulação de DataFrame.

#### Observação:

Alguns links importantes daqui para frente:

-[Comandos e Conceitos Úteis](https://flaviovdf.io/fcd/guiarapido/).

-[`babypandas` notes](https://notes.dsc10.com).

-[`babypandas` documentation](https://babypandas.readthedocs.io/en/latest/index.html).

## Tabelas de Dados

### `pandas`

- DataFrames (tabelas) são fornecidos por um pacote chamado `pandas`.
- `pandas` é **a** ferramenta para fazer ciência de dados em Python.

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/05-BabyPandas/images/pandas.png)

### Mas a biblioteca `pandas` padrão não é tão fofa...

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/05-BabyPandas/images/angrypanda.jpg)

### Digite `babypandas`!

- Assim, vamos limitar um pouco as funções de pandas que utilizamos
- Você não precisa aprender pandas avançado nesse curso!

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/05-BabyPandas/images/babypanda.jpg)

### DataFrames em `pandas` 🐼

- As tabelas em ``pandas` são chamadas de "DataFrames".
- Para usar DataFrames, precisaremos importar `babypandas`. (Precisaremos de `numpy` também.)


```python
#In: 
import pandas as pd
import numpy as np
```

### Sobre os dados: Feira da Afonso Pena 👷

- Normalmente trabalharemos com dados armazenados no formato CSV. CSV significa “valores separados por vírgula”.
- O arquivo [afonso_pena.csv](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/05-BabyPandas/images/) contém informações sobre as barracas da feira. Tais dados foram coletados da Prefeitura de Belo Horizonte [Dados Abertos PBH](https://dados.pbh.gov.br/dataset/dicionario-de-dados-feira-afonso-pena-barraca).

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/05-BabyPandas/images/afonsopena.webp)

### Lendo dados de um arquivo 📖

Podemos ler em um CSV usando `pd.read_csv(...)`. Forneça o caminho para um arquivo relativo ao seu notebook (se o arquivo estiver na mesma pasta do seu notebook, esse é apenas o nome do arquivo).


```python
#In: 
# para rodar no colab use 'https://raw.githubusercontent.com/flaviovdf/fcd/main/assets/06-GroupBy/data/afonso_pena.csv'
# i.e., afonso_pena = pd.read_csv('https://raw.githubusercontent.com/flaviovdf/fcd/main/assets/06-GroupBy/data/afonso_pena.csv')
afonso_pena = pd.read_csv('afonso_pena.csv')
```

### Estrutura de um DataFrame

- DataFrames possuem *colunas* e *linhas*.
- Pense em cada coluna como um array. As colunas contêm dados do mesmo `tipo`.
- Cada coluna possui um rótulo, por ex. `'NOME_SETOR'` e `'NOME_FEIRANTE'`.
- O rótulo de uma coluna é o seu nome.
- Os rótulos das colunas são armazenados como strings.
- Cada linha também possui um rótulo.
- Juntos, os rótulos das linhas são chamados de _índice_. O índice **não** é uma coluna!



```python
#In: 
afonso_pena
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>83</td>
      <td>F.F2.V016</td>
      <td>BARRACA CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>JANA FONSECA VIEIRA</td>
      <td>Criança</td>
      <td>BOLSA DE BEBÊ, MALA DE MATERNIDADE, NECESSÁIRE...</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1</th>
      <td>84</td>
      <td>G.F3.V052</td>
      <td>BARRACA CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>KARINA RODRIGUES BRANDORFI</td>
      <td>Bijouterias</td>
      <td>BRINCO, ANEL, PULSEIRA, COLAR, ARCO</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>2</th>
      <td>85</td>
      <td>E.F4.V003</td>
      <td>BARRACA CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>BARBARA ISABELLE CARVALHO DE PAULA</td>
      <td>Vestuário Infantil</td>
      <td>VESTIDO, CONJUNTO, MACACÃO</td>
      <td>3.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>3</th>
      <td>86</td>
      <td>E.F2.V004</td>
      <td>BARRACA CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>GISELE PAGANO NEVES SALAZAR</td>
      <td>Vestuário Infantil</td>
      <td>MACACÃO, BLUSA, SAPATINHO</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>4</th>
      <td>87</td>
      <td>D.F2.V016</td>
      <td>BARRACA CÉLIA APARECIDA DE SOUZA</td>
      <td>CÉLIA APARECIDA DE SOUZA</td>
      <td>EDSON PIRES DE SOUZA</td>
      <td>Vestuário</td>
      <td>BLUSA, BERMUDA, ROUPA DE GINÁSTICA, SAIA, VEST...</td>
      <td>7.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1245</th>
      <td>1350</td>
      <td>G.F4.V014</td>
      <td>BARRACA HELCIO LICIO SILVA</td>
      <td>HELCIO LICIO SILVA</td>
      <td>GRAZIELA CRISTINA RAMALHO SILVA</td>
      <td>Bijouterias</td>
      <td>ANEL, COLAR, BROCHE, BRINCO, PULSEIRA, ALIANÇA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1246</th>
      <td>1351</td>
      <td>J.F1.V004</td>
      <td>BARRACA DIEGO DOS SANTOS DIAS</td>
      <td>DIEGO DOS SANTOS DIAS</td>
      <td>CELSO DE SOUZA LINHARES</td>
      <td>Calçados</td>
      <td>RASTEIRINHA, SAPATO, SANDÁLIA</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1247</th>
      <td>1352</td>
      <td>D.F4.V050</td>
      <td>BARRACA JAIR CORREA</td>
      <td>JAIR CORREA</td>
      <td>Keli Aparecida Batista Correa</td>
      <td>Vestuário</td>
      <td>VESTIDO DE MALHA, BATA DE TECIDO, CONJUNTO, SA...</td>
      <td>5.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1248</th>
      <td>1353</td>
      <td>G.F2.V010</td>
      <td>BARRACA SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>ANA PAULA FAUSTINA DE SOUZA</td>
      <td>Bijouterias</td>
      <td>COLAR, GARGANTILHA, ARCO, ANEL, PASSADOR DE CA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1249</th>
      <td>1354</td>
      <td>G.F1.V061</td>
      <td>BARRACA REGINA GARCIA FERREIRA</td>
      <td>REGINA GARCIA FERREIRA</td>
      <td>Rejane Garcia Ferreira Clemente</td>
      <td>Bijouterias</td>
      <td>COLAR DE METAL, PRESILHA, PASSADOR DE CABELO, ...</td>
      <td>4.0</td>
      <td>11.827592</td>
    </tr>
  </tbody>
</table>
<p>1250 rows × 9 columns</p>
</div>



### Configurando um novo índice

- Podemos definir um índice melhor usando `.set_index(column_name)`.
- Os rótulos das linhas devem ser identificadores exclusivos.
- Os rótulos das linhas são nomes de linhas; idealmente, cada linha tem um nome descritivo diferente.
- ⚠️ Como a maioria dos métodos DataFrame, `.set_index` retorna um novo DataFrame; não modifica o DataFrame original.


```python
#In: 
afonso_pena.set_index('ID_FEIRA_AFONSO_PENA_BARRACA')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
    </tr>
    <tr>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>83</th>
      <td>F.F2.V016</td>
      <td>BARRACA CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>JANA FONSECA VIEIRA</td>
      <td>Criança</td>
      <td>BOLSA DE BEBÊ, MALA DE MATERNIDADE, NECESSÁIRE...</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>84</th>
      <td>G.F3.V052</td>
      <td>BARRACA CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>KARINA RODRIGUES BRANDORFI</td>
      <td>Bijouterias</td>
      <td>BRINCO, ANEL, PULSEIRA, COLAR, ARCO</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>85</th>
      <td>E.F4.V003</td>
      <td>BARRACA CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>BARBARA ISABELLE CARVALHO DE PAULA</td>
      <td>Vestuário Infantil</td>
      <td>VESTIDO, CONJUNTO, MACACÃO</td>
      <td>3.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>86</th>
      <td>E.F2.V004</td>
      <td>BARRACA CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>GISELE PAGANO NEVES SALAZAR</td>
      <td>Vestuário Infantil</td>
      <td>MACACÃO, BLUSA, SAPATINHO</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>87</th>
      <td>D.F2.V016</td>
      <td>BARRACA CÉLIA APARECIDA DE SOUZA</td>
      <td>CÉLIA APARECIDA DE SOUZA</td>
      <td>EDSON PIRES DE SOUZA</td>
      <td>Vestuário</td>
      <td>BLUSA, BERMUDA, ROUPA DE GINÁSTICA, SAIA, VEST...</td>
      <td>7.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1350</th>
      <td>G.F4.V014</td>
      <td>BARRACA HELCIO LICIO SILVA</td>
      <td>HELCIO LICIO SILVA</td>
      <td>GRAZIELA CRISTINA RAMALHO SILVA</td>
      <td>Bijouterias</td>
      <td>ANEL, COLAR, BROCHE, BRINCO, PULSEIRA, ALIANÇA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1351</th>
      <td>J.F1.V004</td>
      <td>BARRACA DIEGO DOS SANTOS DIAS</td>
      <td>DIEGO DOS SANTOS DIAS</td>
      <td>CELSO DE SOUZA LINHARES</td>
      <td>Calçados</td>
      <td>RASTEIRINHA, SAPATO, SANDÁLIA</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1352</th>
      <td>D.F4.V050</td>
      <td>BARRACA JAIR CORREA</td>
      <td>JAIR CORREA</td>
      <td>Keli Aparecida Batista Correa</td>
      <td>Vestuário</td>
      <td>VESTIDO DE MALHA, BATA DE TECIDO, CONJUNTO, SA...</td>
      <td>5.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1353</th>
      <td>G.F2.V010</td>
      <td>BARRACA SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>ANA PAULA FAUSTINA DE SOUZA</td>
      <td>Bijouterias</td>
      <td>COLAR, GARGANTILHA, ARCO, ANEL, PASSADOR DE CA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1354</th>
      <td>G.F1.V061</td>
      <td>BARRACA REGINA GARCIA FERREIRA</td>
      <td>REGINA GARCIA FERREIRA</td>
      <td>Rejane Garcia Ferreira Clemente</td>
      <td>Bijouterias</td>
      <td>COLAR DE METAL, PRESILHA, PASSADOR DE CABELO, ...</td>
      <td>4.0</td>
      <td>11.827592</td>
    </tr>
  </tbody>
</table>
<p>1250 rows × 8 columns</p>
</div>




```python
#In: 
afonso_pena
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>83</td>
      <td>F.F2.V016</td>
      <td>BARRACA CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>JANA FONSECA VIEIRA</td>
      <td>Criança</td>
      <td>BOLSA DE BEBÊ, MALA DE MATERNIDADE, NECESSÁIRE...</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1</th>
      <td>84</td>
      <td>G.F3.V052</td>
      <td>BARRACA CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>KARINA RODRIGUES BRANDORFI</td>
      <td>Bijouterias</td>
      <td>BRINCO, ANEL, PULSEIRA, COLAR, ARCO</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>2</th>
      <td>85</td>
      <td>E.F4.V003</td>
      <td>BARRACA CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>BARBARA ISABELLE CARVALHO DE PAULA</td>
      <td>Vestuário Infantil</td>
      <td>VESTIDO, CONJUNTO, MACACÃO</td>
      <td>3.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>3</th>
      <td>86</td>
      <td>E.F2.V004</td>
      <td>BARRACA CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>GISELE PAGANO NEVES SALAZAR</td>
      <td>Vestuário Infantil</td>
      <td>MACACÃO, BLUSA, SAPATINHO</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>4</th>
      <td>87</td>
      <td>D.F2.V016</td>
      <td>BARRACA CÉLIA APARECIDA DE SOUZA</td>
      <td>CÉLIA APARECIDA DE SOUZA</td>
      <td>EDSON PIRES DE SOUZA</td>
      <td>Vestuário</td>
      <td>BLUSA, BERMUDA, ROUPA DE GINÁSTICA, SAIA, VEST...</td>
      <td>7.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1245</th>
      <td>1350</td>
      <td>G.F4.V014</td>
      <td>BARRACA HELCIO LICIO SILVA</td>
      <td>HELCIO LICIO SILVA</td>
      <td>GRAZIELA CRISTINA RAMALHO SILVA</td>
      <td>Bijouterias</td>
      <td>ANEL, COLAR, BROCHE, BRINCO, PULSEIRA, ALIANÇA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1246</th>
      <td>1351</td>
      <td>J.F1.V004</td>
      <td>BARRACA DIEGO DOS SANTOS DIAS</td>
      <td>DIEGO DOS SANTOS DIAS</td>
      <td>CELSO DE SOUZA LINHARES</td>
      <td>Calçados</td>
      <td>RASTEIRINHA, SAPATO, SANDÁLIA</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1247</th>
      <td>1352</td>
      <td>D.F4.V050</td>
      <td>BARRACA JAIR CORREA</td>
      <td>JAIR CORREA</td>
      <td>Keli Aparecida Batista Correa</td>
      <td>Vestuário</td>
      <td>VESTIDO DE MALHA, BATA DE TECIDO, CONJUNTO, SA...</td>
      <td>5.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1248</th>
      <td>1353</td>
      <td>G.F2.V010</td>
      <td>BARRACA SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>ANA PAULA FAUSTINA DE SOUZA</td>
      <td>Bijouterias</td>
      <td>COLAR, GARGANTILHA, ARCO, ANEL, PASSADOR DE CA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1249</th>
      <td>1354</td>
      <td>G.F1.V061</td>
      <td>BARRACA REGINA GARCIA FERREIRA</td>
      <td>REGINA GARCIA FERREIRA</td>
      <td>Rejane Garcia Ferreira Clemente</td>
      <td>Bijouterias</td>
      <td>COLAR DE METAL, PRESILHA, PASSADOR DE CABELO, ...</td>
      <td>4.0</td>
      <td>11.827592</td>
    </tr>
  </tbody>
</table>
<p>1250 rows × 9 columns</p>
</div>




```python
#In: 
afonso_pena = afonso_pena.set_index('ID_FEIRA_AFONSO_PENA_BARRACA')
afonso_pena
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
    </tr>
    <tr>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>83</th>
      <td>F.F2.V016</td>
      <td>BARRACA CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>JANA FONSECA VIEIRA</td>
      <td>Criança</td>
      <td>BOLSA DE BEBÊ, MALA DE MATERNIDADE, NECESSÁIRE...</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>84</th>
      <td>G.F3.V052</td>
      <td>BARRACA CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>KARINA RODRIGUES BRANDORFI</td>
      <td>Bijouterias</td>
      <td>BRINCO, ANEL, PULSEIRA, COLAR, ARCO</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>85</th>
      <td>E.F4.V003</td>
      <td>BARRACA CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>BARBARA ISABELLE CARVALHO DE PAULA</td>
      <td>Vestuário Infantil</td>
      <td>VESTIDO, CONJUNTO, MACACÃO</td>
      <td>3.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>86</th>
      <td>E.F2.V004</td>
      <td>BARRACA CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>GISELE PAGANO NEVES SALAZAR</td>
      <td>Vestuário Infantil</td>
      <td>MACACÃO, BLUSA, SAPATINHO</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>87</th>
      <td>D.F2.V016</td>
      <td>BARRACA CÉLIA APARECIDA DE SOUZA</td>
      <td>CÉLIA APARECIDA DE SOUZA</td>
      <td>EDSON PIRES DE SOUZA</td>
      <td>Vestuário</td>
      <td>BLUSA, BERMUDA, ROUPA DE GINÁSTICA, SAIA, VEST...</td>
      <td>7.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1350</th>
      <td>G.F4.V014</td>
      <td>BARRACA HELCIO LICIO SILVA</td>
      <td>HELCIO LICIO SILVA</td>
      <td>GRAZIELA CRISTINA RAMALHO SILVA</td>
      <td>Bijouterias</td>
      <td>ANEL, COLAR, BROCHE, BRINCO, PULSEIRA, ALIANÇA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1351</th>
      <td>J.F1.V004</td>
      <td>BARRACA DIEGO DOS SANTOS DIAS</td>
      <td>DIEGO DOS SANTOS DIAS</td>
      <td>CELSO DE SOUZA LINHARES</td>
      <td>Calçados</td>
      <td>RASTEIRINHA, SAPATO, SANDÁLIA</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1352</th>
      <td>D.F4.V050</td>
      <td>BARRACA JAIR CORREA</td>
      <td>JAIR CORREA</td>
      <td>Keli Aparecida Batista Correa</td>
      <td>Vestuário</td>
      <td>VESTIDO DE MALHA, BATA DE TECIDO, CONJUNTO, SA...</td>
      <td>5.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1353</th>
      <td>G.F2.V010</td>
      <td>BARRACA SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>ANA PAULA FAUSTINA DE SOUZA</td>
      <td>Bijouterias</td>
      <td>COLAR, GARGANTILHA, ARCO, ANEL, PASSADOR DE CA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1354</th>
      <td>G.F1.V061</td>
      <td>BARRACA REGINA GARCIA FERREIRA</td>
      <td>REGINA GARCIA FERREIRA</td>
      <td>Rejane Garcia Ferreira Clemente</td>
      <td>Bijouterias</td>
      <td>COLAR DE METAL, PRESILHA, PASSADOR DE CABELO, ...</td>
      <td>4.0</td>
      <td>11.827592</td>
    </tr>
  </tbody>
</table>
<p>1250 rows × 8 columns</p>
</div>



### Forma de um DataFrame

- `.shape` retorna o número de linhas e colunas em um determinado DataFrame.
- Acesse cada um com `[]`:
- `.shape[0]` para linhas.
- `.shape[1]` para colunas.


```python
#In: 
# There were 9 columns before, but one of them became the index, and the index is not a column!
afonso_pena.shape
```




    (1250, 8)




```python
#In: 
# Number of rows
afonso_pena.shape[0]
```




    1250




```python
#In: 
# Number of columns
afonso_pena.shape[1]
```




    8



## Exemplo 1: Total, Media e Mediana de Produtos

**Conceitos principais:** Acessar colunas, entender operações em colunas numéricas.

### Encontrando o total de solicitações

- **Pergunta:** Como sumarizar uma coluna?
- Obtenha a coluna
- Agregue o valor

#### Etapa 1 – Obtendo uma coluna

- Podemos obter uma coluna de um DataFrame usando `.get(column_name)`.
- ⚠️ Os nomes das colunas diferenciam maiúsculas de minúsculas!
- Os nomes das colunas são strings, então precisamos usar aspas.
- O resultado parece um DataFrame de 1 coluna, mas na verdade é uma *Série*.


```python
#In: 
afonso_pena
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
    </tr>
    <tr>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>83</th>
      <td>F.F2.V016</td>
      <td>BARRACA CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>JANA FONSECA VIEIRA</td>
      <td>Criança</td>
      <td>BOLSA DE BEBÊ, MALA DE MATERNIDADE, NECESSÁIRE...</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>84</th>
      <td>G.F3.V052</td>
      <td>BARRACA CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>KARINA RODRIGUES BRANDORFI</td>
      <td>Bijouterias</td>
      <td>BRINCO, ANEL, PULSEIRA, COLAR, ARCO</td>
      <td>5.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>85</th>
      <td>E.F4.V003</td>
      <td>BARRACA CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>BARBARA ISABELLE CARVALHO DE PAULA</td>
      <td>Vestuário Infantil</td>
      <td>VESTIDO, CONJUNTO, MACACÃO</td>
      <td>3.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>86</th>
      <td>E.F2.V004</td>
      <td>BARRACA CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>GISELE PAGANO NEVES SALAZAR</td>
      <td>Vestuário Infantil</td>
      <td>MACACÃO, BLUSA, SAPATINHO</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>87</th>
      <td>D.F2.V016</td>
      <td>BARRACA CÉLIA APARECIDA DE SOUZA</td>
      <td>CÉLIA APARECIDA DE SOUZA</td>
      <td>EDSON PIRES DE SOUZA</td>
      <td>Vestuário</td>
      <td>BLUSA, BERMUDA, ROUPA DE GINÁSTICA, SAIA, VEST...</td>
      <td>7.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1350</th>
      <td>G.F4.V014</td>
      <td>BARRACA HELCIO LICIO SILVA</td>
      <td>HELCIO LICIO SILVA</td>
      <td>GRAZIELA CRISTINA RAMALHO SILVA</td>
      <td>Bijouterias</td>
      <td>ANEL, COLAR, BROCHE, BRINCO, PULSEIRA, ALIANÇA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1351</th>
      <td>J.F1.V004</td>
      <td>BARRACA DIEGO DOS SANTOS DIAS</td>
      <td>DIEGO DOS SANTOS DIAS</td>
      <td>CELSO DE SOUZA LINHARES</td>
      <td>Calçados</td>
      <td>RASTEIRINHA, SAPATO, SANDÁLIA</td>
      <td>3.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1352</th>
      <td>D.F4.V050</td>
      <td>BARRACA JAIR CORREA</td>
      <td>JAIR CORREA</td>
      <td>Keli Aparecida Batista Correa</td>
      <td>Vestuário</td>
      <td>VESTIDO DE MALHA, BATA DE TECIDO, CONJUNTO, SA...</td>
      <td>5.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1353</th>
      <td>G.F2.V010</td>
      <td>BARRACA SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>ANA PAULA FAUSTINA DE SOUZA</td>
      <td>Bijouterias</td>
      <td>COLAR, GARGANTILHA, ARCO, ANEL, PASSADOR DE CA...</td>
      <td>7.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>1354</th>
      <td>G.F1.V061</td>
      <td>BARRACA REGINA GARCIA FERREIRA</td>
      <td>REGINA GARCIA FERREIRA</td>
      <td>Rejane Garcia Ferreira Clemente</td>
      <td>Bijouterias</td>
      <td>COLAR DE METAL, PRESILHA, PASSADOR DE CABELO, ...</td>
      <td>4.0</td>
      <td>11.827592</td>
    </tr>
  </tbody>
</table>
<p>1250 rows × 8 columns</p>
</div>




```python
#In: 
afonso_pena.get('NUMERO_PRODUTOS_CADASTRADOS')
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83      5.0
    84      5.0
    85      3.0
    86      3.0
    87      7.0
           ... 
    1350    7.0
    1351    3.0
    1352    5.0
    1353    7.0
    1354    4.0
    Name: NUMERO_PRODUTOS_CADASTRADOS, Length: 1250, dtype: float64



### Digressão: Série

- Uma *Série* é como um array, mas com um índice.
- Em particular, as séries suportam aritmética.


```python
#In: 
afonso_pena.get('NUMERO_PRODUTOS_CADASTRADOS')
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83      5.0
    84      5.0
    85      3.0
    86      3.0
    87      7.0
           ... 
    1350    7.0
    1351    3.0
    1352    5.0
    1353    7.0
    1354    4.0
    Name: NUMERO_PRODUTOS_CADASTRADOS, Length: 1250, dtype: float64



#### Etapa 2 – Calculando o total

- Assim como acontece com os arrays, podemos realizar operações aritméticas nas séries


```python
#In: 
afonso_pena.get('NUMERO_PRODUTOS_CADASTRADOS').sum()
```




    7457.0




```python
#In: 
afonso_pena.get('NUMERO_PRODUTOS_CADASTRADOS').max()
```




    21.0




```python
#In: 
afonso_pena.get('NUMERO_PRODUTOS_CADASTRADOS').mean()
```




    5.9656



## Exemplo 2: Quais feirantes vendem mais produtos?

**Conceitos principais**: Classificação. Acessando usando posições inteiras.

#### Etapa 1 – Classificando o DataFrame

- Use o método `.sort_values(by=column_name)` para classificar.
- O `by=` pode ser omitido, mas ajuda na legibilidade.
- Como a maioria dos métodos DataFrame, retorna um novo DataFrame.


```python
#In: 
afonso_pena.sort_values(by='NUMERO_PRODUTOS_CADASTRADOS')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
    </tr>
    <tr>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>261</th>
      <td>X.F2.V003</td>
      <td>BARRACA JOÃO GERALDO MARTINS DE SOUZA</td>
      <td>JOÃO GERALDO MARTINS DE SOUZA</td>
      <td>CHARLES DAVIDSON ROSA MARTINS</td>
      <td>Alimentação</td>
      <td>CHURRASCO</td>
      <td>1.0</td>
      <td>33.569063</td>
    </tr>
    <tr>
      <th>273</th>
      <td>P.F1.V012</td>
      <td>BARRACA JOSÉ ALBERTO LUCIANO</td>
      <td>JOSÉ ALBERTO LUCIANO</td>
      <td>EDSON APARECIDO SANCHES</td>
      <td>Artes e Pintura</td>
      <td>PINTURA A ÓLEO</td>
      <td>1.0</td>
      <td>23.790191</td>
    </tr>
    <tr>
      <th>150</th>
      <td>E.F3.V022</td>
      <td>BARRACA ELIANA LOPES RIBEIRO</td>
      <td>ELIANA LOPES RIBEIRO</td>
      <td>CRISTINA LOPES RIBEIRO</td>
      <td>Vestuário Infantil</td>
      <td>ROUPA INFANTIL BORDADA</td>
      <td>1.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>1018</th>
      <td>P.F2.V003</td>
      <td>BARRACA ELIANE LEAO PIANETTI</td>
      <td>ELIANE LEAO PIANETTI</td>
      <td>LUIZ AUGUSTO PIANETTI FONSECA</td>
      <td>Artes e Pintura</td>
      <td>PINTURA A ÓLEO</td>
      <td>1.0</td>
      <td>23.790191</td>
    </tr>
    <tr>
      <th>1019</th>
      <td>P.F1.V007</td>
      <td>BARRACA EVANDRO TADEU DE OLIVEIRA</td>
      <td>EVANDRO TADEU DE OLIVEIRA</td>
      <td>JONH WAINE DE ALMEIDA SANTOS</td>
      <td>Artes e Pintura</td>
      <td>PINTURA ACRÍLICA</td>
      <td>1.0</td>
      <td>23.790191</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1406</th>
      <td>Z.F1.V007</td>
      <td>BARRACA FRANCINERE AMARAL CARDOSO RIBEIRO DE S...</td>
      <td>FRANCINERE AMARAL CARDOSO RIBEIRO DE SOUZA</td>
      <td>RAYKARD AGUIAR DE JESUS</td>
      <td>Alimentação</td>
      <td>CERVEJA, REFRIGERANTE, SUCO INDUSTRIALIZADO, E...</td>
      <td>20.0</td>
      <td>33.611058</td>
    </tr>
    <tr>
      <th>336</th>
      <td>B.F1.V001</td>
      <td>BARRACA LUCY DOS SANTOS SEBASTIAO</td>
      <td>LUCY DOS SANTOS SEBASTIAO</td>
      <td>LAURO MARTINS DOS SANTOS</td>
      <td>Decoração e Utilidades</td>
      <td>CERÂMICA VITRIFICADA, MOLDURA, VELA, CASTIÇAL,...</td>
      <td>20.0</td>
      <td>21.193242</td>
    </tr>
    <tr>
      <th>653</th>
      <td>F.F1.V015</td>
      <td>BARRACA SILVIA REGINA NOGUEIRA RIBEIRO</td>
      <td>SILVIA REGINA NOGUEIRA RIBEIRO</td>
      <td>LIGIA MARIA NOGUEIRA RIBEIRO</td>
      <td>Criança</td>
      <td>VESTIDO, BLUSA, CONJUNTO VIROL, CALÇA, COLETE,...</td>
      <td>20.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>491</th>
      <td>F.F2.V011</td>
      <td>BARRACA MARILEA IMACULADA MUNIZ COSTA</td>
      <td>MARILEA IMACULADA MUNIZ COSTA</td>
      <td>KELLINGTON NONATO MUNIZ COSTA</td>
      <td>Criança</td>
      <td>KIT BERÇO, CORTINADO, BONECA DE PELÚCIA, SAIA ...</td>
      <td>21.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>109</th>
      <td>Y.F1.V012</td>
      <td>BARRACA DAYSE PINTO NORBERTO</td>
      <td>DAYSE PINTO NORBERTO</td>
      <td>DJALMA ANTÔNIO DE FREITAS</td>
      <td>Alimentação</td>
      <td>CERVEJA, TORRESMO, CHIPS, AZEITONA, REFRIGERAN...</td>
      <td>21.0</td>
      <td>33.611057</td>
    </tr>
  </tbody>
</table>
<p>1250 rows × 8 columns</p>
</div>



Isso classifica, mas em ordem crescente (de pequeno para grande). Queremos o contrário!

#### Etapa 2 – Classificando o DataFrame em ordem *decrescente*

- Use `.sort_values(by=column_name, ascending=False)` para classificar em ordem *decrescente*.
- `ascendente` é um argumento opcional. Se omitido, será definido como `True` por padrão.
- Este é um exemplo de *argumento de palavra-chave* ou *argumento nomeado*.
- Se quisermos especificar a ordem de classificação, devemos usar a palavra-chave `ascendente=`.


```python
#In: 
ordenado = afonso_pena.sort_values(by='NUMERO_PRODUTOS_CADASTRADOS', ascending=False)
ordenado
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
    </tr>
    <tr>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>491</th>
      <td>F.F2.V011</td>
      <td>BARRACA MARILEA IMACULADA MUNIZ COSTA</td>
      <td>MARILEA IMACULADA MUNIZ COSTA</td>
      <td>KELLINGTON NONATO MUNIZ COSTA</td>
      <td>Criança</td>
      <td>KIT BERÇO, CORTINADO, BONECA DE PELÚCIA, SAIA ...</td>
      <td>21.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>109</th>
      <td>Y.F1.V012</td>
      <td>BARRACA DAYSE PINTO NORBERTO</td>
      <td>DAYSE PINTO NORBERTO</td>
      <td>DJALMA ANTÔNIO DE FREITAS</td>
      <td>Alimentação</td>
      <td>CERVEJA, TORRESMO, CHIPS, AZEITONA, REFRIGERAN...</td>
      <td>21.0</td>
      <td>33.611057</td>
    </tr>
    <tr>
      <th>653</th>
      <td>F.F1.V015</td>
      <td>BARRACA SILVIA REGINA NOGUEIRA RIBEIRO</td>
      <td>SILVIA REGINA NOGUEIRA RIBEIRO</td>
      <td>LIGIA MARIA NOGUEIRA RIBEIRO</td>
      <td>Criança</td>
      <td>VESTIDO, BLUSA, CONJUNTO VIROL, CALÇA, COLETE,...</td>
      <td>20.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>336</th>
      <td>B.F1.V001</td>
      <td>BARRACA LUCY DOS SANTOS SEBASTIAO</td>
      <td>LUCY DOS SANTOS SEBASTIAO</td>
      <td>LAURO MARTINS DOS SANTOS</td>
      <td>Decoração e Utilidades</td>
      <td>CERÂMICA VITRIFICADA, MOLDURA, VELA, CASTIÇAL,...</td>
      <td>20.0</td>
      <td>21.193242</td>
    </tr>
    <tr>
      <th>1406</th>
      <td>Z.F1.V007</td>
      <td>BARRACA FRANCINERE AMARAL CARDOSO RIBEIRO DE S...</td>
      <td>FRANCINERE AMARAL CARDOSO RIBEIRO DE SOUZA</td>
      <td>RAYKARD AGUIAR DE JESUS</td>
      <td>Alimentação</td>
      <td>CERVEJA, REFRIGERANTE, SUCO INDUSTRIALIZADO, E...</td>
      <td>20.0</td>
      <td>33.611058</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1357</th>
      <td>I.F3.V006</td>
      <td>BARRACA GISLAINE ASSUNÇÃO MACHADO</td>
      <td>GISLAINE ASSUNÇÃO MACHADO</td>
      <td>LUCIANA BARBOSA CALDEIRA</td>
      <td>Cintos, Bolsas e Acessórios</td>
      <td>BOLSA</td>
      <td>1.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>647</th>
      <td>P.F1.V023</td>
      <td>BARRACA SÉRGIO BARBOSA DE JESUS</td>
      <td>SÉRGIO BARBOSA DE JESUS</td>
      <td>MARIA ADEMILDE DURAES DOS SANTOS</td>
      <td>Artes e Pintura</td>
      <td>PINTURA A ÓLEO</td>
      <td>1.0</td>
      <td>23.790191</td>
    </tr>
    <tr>
      <th>811</th>
      <td>D.F3.V005</td>
      <td>BARRACA JANE LACERDA FARIA</td>
      <td>JANE LACERDA FARIA</td>
      <td>WASHIMGTON GERALDO SILVA</td>
      <td>Vestuário</td>
      <td>BLUSA</td>
      <td>1.0</td>
      <td>11.838911</td>
    </tr>
    <tr>
      <th>812</th>
      <td>B.F3.V007</td>
      <td>BARRACA JENNER BATISTA</td>
      <td>JENNER BATISTA</td>
      <td>LUCIA CARLOS BATISTA</td>
      <td>Decoração e Utilidades</td>
      <td>EMBALAGEM DE PRESENTE</td>
      <td>1.0</td>
      <td>11.827592</td>
    </tr>
    <tr>
      <th>807</th>
      <td>C.F3.V010</td>
      <td>BARRACA MARIA GERALDA SANTANA SILVA</td>
      <td>MARIA GERALDA SANTANA SILVA</td>
      <td>POLIANA FERREIRA DA SILVA</td>
      <td>Cama, Mesa, Banho e Tapeçaria</td>
      <td>TAPETE</td>
      <td>1.0</td>
      <td>11.838911</td>
    </tr>
  </tbody>
</table>
<p>1250 rows × 8 columns</p>
</div>



## Exemplo 3: Criando novas Colunas

**Conceitos Principais** Entender operações em colunas assim como em vetores

### Etapa 1 - Operações aritméticas em colunas

* Crie uma variável para o número de produtos cadastrados
* Crie uma outra variável para a área


```python
#In: 
produtos = afonso_pena.get('NUMERO_PRODUTOS_CADASTRADOS')
area = afonso_pena.get('AREA')
```

* Assim como em `numpy` (aula passada), podemos realizar operações aritméticas em colunas pandas.


```python
#In: 
produtos / area
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83      0.422336
    84      0.422336
    85      0.253402
    86      0.253644
    87      0.591836
              ...   
    1350    0.591271
    1351    0.253644
    1352    0.422740
    1353    0.591271
    1354    0.338192
    Length: 1250, dtype: float64



* Observe como a resposta tem a divisão dos produtos pela área, ou seja, a densidade de cada barraca
* Além do mais, observe como temos também o índice de cada barraca

### Etapa 2: Criando uma nova coluna

* Agora, vamos criar a coluna densidade na nossa base de dados
* Use `.assign(name_of_column=data_in_series)` para atribuir uma série (ou array, ou lista) a um DataFrame.
* ⚠️ Não coloque aspas em `name_of_column`.
* Cria um novo DataFrame!


```python
#In: 
afonso_pena.assign(DENSIDADE = produtos / area)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
      <th>DENSIDADE</th>
    </tr>
    <tr>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>83</th>
      <td>F.F2.V016</td>
      <td>BARRACA CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>JANA FONSECA VIEIRA</td>
      <td>Criança</td>
      <td>BOLSA DE BEBÊ, MALA DE MATERNIDADE, NECESSÁIRE...</td>
      <td>5.0</td>
      <td>11.838911</td>
      <td>0.422336</td>
    </tr>
    <tr>
      <th>84</th>
      <td>G.F3.V052</td>
      <td>BARRACA CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>CARMEN FERNANDA ROCHA DE ALCANTARA</td>
      <td>KARINA RODRIGUES BRANDORFI</td>
      <td>Bijouterias</td>
      <td>BRINCO, ANEL, PULSEIRA, COLAR, ARCO</td>
      <td>5.0</td>
      <td>11.838911</td>
      <td>0.422336</td>
    </tr>
    <tr>
      <th>85</th>
      <td>E.F4.V003</td>
      <td>BARRACA CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>CARMEN LÚCIA CARVALHO DE ALMEIDA</td>
      <td>BARBARA ISABELLE CARVALHO DE PAULA</td>
      <td>Vestuário Infantil</td>
      <td>VESTIDO, CONJUNTO, MACACÃO</td>
      <td>3.0</td>
      <td>11.838911</td>
      <td>0.253402</td>
    </tr>
    <tr>
      <th>86</th>
      <td>E.F2.V004</td>
      <td>BARRACA CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>CECÍLIA PAGANO NEVES SALAZAR</td>
      <td>GISELE PAGANO NEVES SALAZAR</td>
      <td>Vestuário Infantil</td>
      <td>MACACÃO, BLUSA, SAPATINHO</td>
      <td>3.0</td>
      <td>11.827592</td>
      <td>0.253644</td>
    </tr>
    <tr>
      <th>87</th>
      <td>D.F2.V016</td>
      <td>BARRACA CÉLIA APARECIDA DE SOUZA</td>
      <td>CÉLIA APARECIDA DE SOUZA</td>
      <td>EDSON PIRES DE SOUZA</td>
      <td>Vestuário</td>
      <td>BLUSA, BERMUDA, ROUPA DE GINÁSTICA, SAIA, VEST...</td>
      <td>7.0</td>
      <td>11.827592</td>
      <td>0.591836</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1350</th>
      <td>G.F4.V014</td>
      <td>BARRACA HELCIO LICIO SILVA</td>
      <td>HELCIO LICIO SILVA</td>
      <td>GRAZIELA CRISTINA RAMALHO SILVA</td>
      <td>Bijouterias</td>
      <td>ANEL, COLAR, BROCHE, BRINCO, PULSEIRA, ALIANÇA...</td>
      <td>7.0</td>
      <td>11.838911</td>
      <td>0.591271</td>
    </tr>
    <tr>
      <th>1351</th>
      <td>J.F1.V004</td>
      <td>BARRACA DIEGO DOS SANTOS DIAS</td>
      <td>DIEGO DOS SANTOS DIAS</td>
      <td>CELSO DE SOUZA LINHARES</td>
      <td>Calçados</td>
      <td>RASTEIRINHA, SAPATO, SANDÁLIA</td>
      <td>3.0</td>
      <td>11.827592</td>
      <td>0.253644</td>
    </tr>
    <tr>
      <th>1352</th>
      <td>D.F4.V050</td>
      <td>BARRACA JAIR CORREA</td>
      <td>JAIR CORREA</td>
      <td>Keli Aparecida Batista Correa</td>
      <td>Vestuário</td>
      <td>VESTIDO DE MALHA, BATA DE TECIDO, CONJUNTO, SA...</td>
      <td>5.0</td>
      <td>11.827592</td>
      <td>0.422740</td>
    </tr>
    <tr>
      <th>1353</th>
      <td>G.F2.V010</td>
      <td>BARRACA SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>SIDNEY FERNANDO KNEIPP SOARES</td>
      <td>ANA PAULA FAUSTINA DE SOUZA</td>
      <td>Bijouterias</td>
      <td>COLAR, GARGANTILHA, ARCO, ANEL, PASSADOR DE CA...</td>
      <td>7.0</td>
      <td>11.838911</td>
      <td>0.591271</td>
    </tr>
    <tr>
      <th>1354</th>
      <td>G.F1.V061</td>
      <td>BARRACA REGINA GARCIA FERREIRA</td>
      <td>REGINA GARCIA FERREIRA</td>
      <td>Rejane Garcia Ferreira Clemente</td>
      <td>Bijouterias</td>
      <td>COLAR DE METAL, PRESILHA, PASSADOR DE CABELO, ...</td>
      <td>4.0</td>
      <td>11.827592</td>
      <td>0.338192</td>
    </tr>
  </tbody>
</table>
<p>1250 rows × 9 columns</p>
</div>



* O código acima cria não altera os dados originais
* Ainda temos as mesmas colunas de antes


```python
#In: 
afonso_pena.columns
```




    Index(['CODIGO_VAGA', 'NOME_FANTASIA', 'NOME_FEIRANTE', 'NOME_PREPOSTO',
           'NOME_SETOR', 'PRODUTOS', 'NUMERO_PRODUTOS_CADASTRADOS', 'AREA'],
          dtype='object')



* Porém, podemos criar uma variável


```python
#In: 
afonso_pena = afonso_pena.assign(DENSIDADE = produtos / area)
afonso_pena.get('DENSIDADE')
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83      0.422336
    84      0.422336
    85      0.253402
    86      0.253644
    87      0.591836
              ...   
    1350    0.591271
    1351    0.253644
    1352    0.422740
    1353    0.591271
    1354    0.338192
    Name: DENSIDADE, Length: 1250, dtype: float64



## Exemplo 3: Agora você responda.
- Qual a densidade máxima?
- Qual a densidade mínima?
- Qual a densidade média?


```python
#In: 
# Suas respostas aqui!
```

## Exemplo 4: A densidade média das barracas de produtos de crianças 👶🧸?

- Podemos responde a pergunda acima se tivéssemos um DataFrame composto apenas por tais barracas.
- Como conseguimos esse DataFrame?


```python
#In: 
# Aqui temos os setores
afonso_pena.get('NOME_SETOR')
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83                 Criança
    84             Bijouterias
    85      Vestuário Infantil
    86      Vestuário Infantil
    87               Vestuário
                   ...        
    1350           Bijouterias
    1351              Calçados
    1352             Vestuário
    1353           Bijouterias
    1354           Bijouterias
    Name: NOME_SETOR, Length: 1250, dtype: object




```python
#In: 
# Quais deles são de crianças
afonso_pena.get('NOME_SETOR') == 'Criança'
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83       True
    84      False
    85      False
    86      False
    87      False
            ...  
    1350    False
    1351    False
    1352    False
    1353    False
    1354    False
    Name: NOME_SETOR, Length: 1250, dtype: bool



Use `==` para verificar a igualdade. Não `=`, pois é para atribuição de um valor a uma variável.


```python
#In: 
'Criança' == 'Criança'
```




    True




```python
#In: 
'Criança' == 'Adulto'
```




    False



Podemos *transmitir* a verificação de igualdade para cada elemento de uma Série. A comparação acontece elemento a elemento.


```python
#In: 
afonso_pena.get('NOME_SETOR') == 'Criança'
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83       True
    84      False
    85      False
    86      False
    87      False
            ...  
    1350    False
    1351    False
    1352    False
    1353    False
    1354    False
    Name: NOME_SETOR, Length: 1250, dtype: bool



### À parte: Booleanos

- Quando comparamos dois valores, o resultado é `True` ou `False`.
- Observe que essas palavras não estão entre aspas.
- `bool` é um tipo de dados em Python, assim como `int`, `float` e `str`.
- Significa "Boolean", em homenagem a George Boole, um dos primeiros matemáticos.
- Existem apenas dois valores booleanos possíveis: `True` ou `False`.
- Sim ou não.
- Ligado ou desligado.
- 1 ou 0.

### Operadores de comparação

Existem vários tipos de comparações que podemos fazer.

|símbolo|significado|
|--------|--------|
|`==` |igual a |
|`!=` |diferente de |
|`<`|menos que|
|`<=`|menor ou igual a|
|`>`|maior que|
|`>=`|maior ou igual a|

Podemos então usar o operador apropriado para ver tudo que é diferente de 'Criança'
Observe que a resposta é o oposto de antes!


```python
#In: 
afonso_pena.get('NOME_SETOR') != 'Criança'
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83      False
    84       True
    85       True
    86       True
    87       True
            ...  
    1350     True
    1351     True
    1352     True
    1353     True
    1354     True
    Name: NOME_SETOR, Length: 1250, dtype: bool



### O que é uma consulta? 🤔

- Uma "consulta" é um código que extrai linhas de um DataFrame para as quais determinadas condições são verdadeiras.
- Freqüentemente usamos consultas para _filtrar_ DataFrames para que contenham apenas as linhas que satisfaçam as condições declaradas em nossas perguntas.

### Como consultamos um DataFrame?

Para selecionar apenas determinadas linhas de `solicitações`:

1. Faça uma sequência (lista/matriz/série) de `True`s (manter) e `False`s (lançar), geralmente fazendo uma comparação.
2. Em seguida, passe-o para `dados[booleanos]`.


```python
#In: 
afonso_pena[afonso_pena.get('NOME_SETOR') == 'Criança']
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CODIGO_VAGA</th>
      <th>NOME_FANTASIA</th>
      <th>NOME_FEIRANTE</th>
      <th>NOME_PREPOSTO</th>
      <th>NOME_SETOR</th>
      <th>PRODUTOS</th>
      <th>NUMERO_PRODUTOS_CADASTRADOS</th>
      <th>AREA</th>
      <th>DENSIDADE</th>
    </tr>
    <tr>
      <th>ID_FEIRA_AFONSO_PENA_BARRACA</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>83</th>
      <td>F.F2.V016</td>
      <td>BARRACA CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>CARMEN EMMANUEL DOS SANTOS SILVA</td>
      <td>JANA FONSECA VIEIRA</td>
      <td>Criança</td>
      <td>BOLSA DE BEBÊ, MALA DE MATERNIDADE, NECESSÁIRE...</td>
      <td>5.0</td>
      <td>11.838911</td>
      <td>0.422336</td>
    </tr>
    <tr>
      <th>97</th>
      <td>F.F3.V022</td>
      <td>BARRACA CLÁUDIA REGINA RACHID NETTO</td>
      <td>CLÁUDIA REGINA RACHID NETTO</td>
      <td>HERMOGENES GONÇALVES NETTO</td>
      <td>Criança</td>
      <td>SACOLA, MOISÉS, FRASQUEIRA, MALA, NECESSÁIRE</td>
      <td>5.0</td>
      <td>11.838911</td>
      <td>0.422336</td>
    </tr>
    <tr>
      <th>99</th>
      <td>F.F2.V002</td>
      <td>BARRACA CLESIA LUCI TORRES DE OLIVEIRA</td>
      <td>CLESIA LUCI TORRES DE OLIVEIRA</td>
      <td>ANA CAROLINE SILVA MATOZINHOS</td>
      <td>Criança</td>
      <td>BONECO, MÓBILE, BICHO DE PANO</td>
      <td>3.0</td>
      <td>11.838911</td>
      <td>0.253402</td>
    </tr>
    <tr>
      <th>108</th>
      <td>F.F1.V031</td>
      <td>BARRACA DAISY ANDRADE</td>
      <td>DAISY ANDRADE</td>
      <td>MARCIO MARTINS</td>
      <td>Criança</td>
      <td>PAGÃO, CABIDE</td>
      <td>2.0</td>
      <td>11.827592</td>
      <td>0.169096</td>
    </tr>
    <tr>
      <th>114</th>
      <td>F.F2.V013</td>
      <td>BARRACA DIRLENE VILELA ROMÃO</td>
      <td>DIRLENE VILELA ROMÃO</td>
      <td>MICHELLE VILELA COSTA</td>
      <td>Criança</td>
      <td>EDREDON, MANTA, CAPA DE CARRINHO, CORTINADO DE...</td>
      <td>7.0</td>
      <td>11.827592</td>
      <td>0.591836</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1411</th>
      <td>F.F3.V013</td>
      <td>BARRACA ROSANA DANIEL DE FIGUEIREDO</td>
      <td>ROSANA DANIEL DE FIGUEIREDO</td>
      <td>MARIA DO ROSARIO SILVA SALGADO</td>
      <td>Criança</td>
      <td>KIT BERÇO, MANTA, PROTETOR DE BERÇO, CAPA DE C...</td>
      <td>10.0</td>
      <td>11.827592</td>
      <td>0.845481</td>
    </tr>
    <tr>
      <th>1467</th>
      <td>F.F1.V005</td>
      <td>BARRACA LYDNEIA MELISSA TEIXEIRA</td>
      <td>LYDNEIA MELISSA TEIXEIRA</td>
      <td>LYDSSEI MELISSA TEIXEIRA FERREIRA</td>
      <td>Criança</td>
      <td>KIT BERÇO, SAIA PARA BERÇO, NINHO, LENÇOL, ALM...</td>
      <td>8.0</td>
      <td>11.827592</td>
      <td>0.676384</td>
    </tr>
    <tr>
      <th>1468</th>
      <td>F.F4.V014</td>
      <td>BARRACA PAULA GUERRA IGLESIAS RODRIGUES</td>
      <td>PAULA GUERRA IGLESIAS RODRIGUES</td>
      <td>GREG PETERSON LOPES PERUZZO</td>
      <td>Criança</td>
      <td>BONECA DE PANO, BONECA DE FELTRO, BONECO, DEDO...</td>
      <td>5.0</td>
      <td>11.838911</td>
      <td>0.422336</td>
    </tr>
    <tr>
      <th>1426</th>
      <td>F.F3.V010</td>
      <td>BARRACA ALESSANDRA DE ABREU REIS</td>
      <td>ALESSANDRA DE ABREU REIS</td>
      <td>GLAUCIA HELENA DE ABREU TAVARES</td>
      <td>Criança</td>
      <td>ACESSÓRIOS PARA CACHORRO, ALMOFADA, CAMA DE TE...</td>
      <td>14.0</td>
      <td>11.838911</td>
      <td>1.182541</td>
    </tr>
    <tr>
      <th>1337</th>
      <td>F.F2.V004</td>
      <td>BARRACA MATHEUS PESSALI TIAGO BARBOSA</td>
      <td>MATHEUS PESSALI TIAGO BARBOSA</td>
      <td>MIRNA COSTA GONÇALVES</td>
      <td>Criança</td>
      <td>QUADRO, TOALHA FRALDA, TOALHA, BRINQUEDO PEDAG...</td>
      <td>6.0</td>
      <td>11.838911</td>
      <td>0.506803</td>
    </tr>
  </tbody>
</table>
<p>103 rows × 9 columns</p>
</div>



### Voltando para a pergunta: A densidade média das barracas de produtos de crianças 👶🧸?
- Filtre um novo DataFrame apenas de crianças
- Pegue a coluna desejada
- Tire a média


```python
#In: 
criancas = afonso_pena[afonso_pena.get('NOME_SETOR') == 'Criança']
criancas.get('DENSIDADE')
```




    ID_FEIRA_AFONSO_PENA_BARRACA
    83      0.422336
    97      0.422336
    99      0.253402
    108     0.169096
    114     0.591836
              ...   
    1411    0.845481
    1467    0.676384
    1468    0.422336
    1426    1.182541
    1337    0.506803
    Name: DENSIDADE, Length: 103, dtype: float64




```python
#In: 
criancas.get('DENSIDADE').mean()
```




    0.6106923564685903



### E se forem comidas? 🍓 🍒 🍎 🍉 🍑 🍊 🥭 🍍 🍌 🍋 🍈 🍏 🍐 🥝 🍇 🥥 🍅 🌶 🍄 🥕 🍠 🧅 🌽 🥦 🥒🥬 🥑 🍆 🧄 🥔 🌰🥜


```python
#In: 
comidas = afonso_pena[afonso_pena.get('NOME_SETOR') == 'Alimentação']
comidas.get('DENSIDADE').mean()
```




    0.218202423788409



### Como explicar o resultado acima?
- Será que a coluna área ajuda?


```python
#In: 
comidas.get('AREA').mean()
```




    33.593432833729956




```python
#In: 
criancas.get('AREA').mean()
```




    12.378615690707454



Parece que as barracas de comida tem muita espaço. Isso é esperado, elas precisam cozinhar.

## Resumo

### Resumo

- Aprendemos alguns métodos e técnicas do DataFrame.
- Não sinta necessidade de memorizá-los todos imediatamente.
- Com o tempo, essas técnicas se tornarão cada vez mais familiares.
- **Pratique!** Elabore suas próprias perguntas usando este conjunto de dados e tente respondê-las.

### Próxima vez

- Responderemos a perguntas mais complicadas, que nos levarão a um novo método principal do DataFrame, `.groupby`, para organizar linhas de um DataFrame com o mesmo valor em uma coluna específica.
- Por exemplo, podemos querer organizar os dados por bairro, recolhendo todos os diferentes pedidos de serviço para cada bairro.


```python
#In: 

```
