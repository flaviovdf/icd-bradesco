---
layout: page
title: Visualização de Dados
nav_order: 7
---
[<img src="https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/colab_favicon_small.png" style="float: right;">](https://colab.research.google.com/github/flaviovdf/icd-bradesco/blob/master/_lessons/07-Viz.ipynb)

# Tópico 7 – DataViz: Visualizando Dados 📈
{: .no_toc .mb-2 }

Um pouco de como representar dados de forma visual!
{: .fs-6 .fw-300 }

{: .no_toc .text-delta }
Resultados Esperados

1. Junto com a aula passada, ferramentas simples para exploração de dados
1. Aprender a base de pandas para realizar um plot simples
1. Aprender conceitos básicos de visualização dados


```python
#In: 
import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
plt.style.use('ggplot')

from IPython.display import HTML, display, IFrame
```

### Além: atalhos de teclado

Existem vários atalhos de teclado integrados aos Jupyter Notebooks projetados para ajudar você a economizar tempo. Para vê-los, clique no botão do teclado na barra de ferramentas acima ou pressione a tecla H do teclado (desde que você não esteja editando ativamente uma célula).

Atalhos particularmente úteis:

| Ação | Atalho de teclado |
| --- | --- |
| Executar célula + pular para a próxima célula | MUDANÇA + ENTER |
| Salve o caderno | CTRL/CMD + S |
| Criar nova célula acima/abaixo | A/B |
| Excluir célula | DD |

### Agenda

- Por que visualizar?
- Terminologia.
- Gráficos de dispersão.
- Gráficos de linha.
- Gráficos de barra.

## Por que visualizar?

### Marcha de Napoleão

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/images/minard.jpg)

### Por que visualizar?

- Os computadores são melhores que os humanos para processar números, mas os humanos são melhores para identificar padrões visuais.

- As visualizações permitem-nos compreender rapidamente muitos dados – tornam mais fácil identificar tendências e comunicar os nossos resultados a outras pessoas.

- Existem vários tipos de visualizações; nesta aula, veremos gráficos de dispersão, gráficos de linhas, gráficos de barras e histogramas, mas existem muitos outros.
- A escolha certa depende do tipo de dados.

## Terminologia

### Indivíduos e variáveis

<center><img src='https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/images/ind-var.png' largura=90%/></center>

- <span style="color:#6d9eeb"><b>Indivíduo (linha):</b></span> Pessoa/lugar/coisa para a qual os dados são registrados. Também chamada de **observação**.

- <span style="color:#ff9900"><b>Variável (coluna):</b></span> Algo que é registrado para cada indivíduo. Também chamado de **recurso**.

### Tipos de variáveis

Existem dois tipos principais de variáveis:

- **Numérico**: Faz sentido fazer aritmética com os valores.
- **Categórico**: Os valores se enquadram em categorias, que podem ou não ter alguma _ordem_ para eles.

### Exemplos de variáveis ​​numéricas

- Salários dos jogadores da NBA 🏀.
- Individual: um jogador da NBA.
- Variável: seu salário.

- Ganhos brutos do filme 💰.
- Individual: um filme.
- Variável: seu rendimento bruto.

- Doses de reforço administradas por dia 💉.
- Individual: data.
- Variável: número de doses de reforço administradas naquela data.

### Exemplos de variáveis ​​​​categóricas

- Gêneros de filmes 🎬.
- Individual: um filme.
- Variável: seu gênero.

- CEPs 🏠.
- Pessoa física: residente nos EUA.
- Variável: CEP.
- Apesar de parecerem números, os CEPs são categóricos (a aritmética não faz sentido).

- Nível de experiência anterior em programação para alunos do DSC 10 🧑‍🎓.
- Individual: aluno do DSC 10.
- Variável: seu nível de experiência anterior em programação, por ex. nenhum, baixo, médio ou alto.
- Existe uma _ordem_ para essas categorias!

### Verificação de conceito ✅

Qual destas **não** é uma variável numérica?

A. Economia de combustível em milhas por galão.

B. Número de trimestres na UCSD.

C. Faculdade na UCSD (sexto, sétimo, etc).

D. Número da conta bancária.

E. Mais de uma destas não são variáveis ​​numéricas.

### Tipos de visualizações

O tipo de visualização que criamos depende dos tipos de variáveis ​​que estamos visualizando.

- **Gráfico de dispersão**: numérico versus numérico.
- **Gráfico de linhas**: numérico sequencial (tempo) vs.
- **Gráfico de barras**: categórico vs. numérico.
- **Histograma**: numérico.
- Cobriremos na próxima vez.

**Observação:** Podemos trocar as palavras "plot", "chart" e "graph"; todos eles significam a mesma coisa.

## Gráficos de dispersão

### Conjunto de dados dos 50 atores de maior bilheteria

|Coluna |Conteúdo|
|----------|------------|
`'Ator'`|Nome do ator
`'Total Bruto'`| Receita total bruta de bilheteria interna, em milhões de dólares, de todos os filmes do ator
`'Número de filmes'`| O número de filmes em que o ator esteve
`'Média por Filme'`| Total bruto dividido pelo número de filmes
`'Filme #1'`| O filme de maior bilheteria em que o ator já esteve
`'Bruto'`| Receita bruta de bilheteria interna, em milhões de dólares, do filme número 1 do ator


```python
#In: 
actors = pd.read_csv('https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/data/actors.csv').set_index('Actor')
actors
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
      <th>Total Gross</th>
      <th>Number of Movies</th>
      <th>Average per Movie</th>
      <th>#1 Movie</th>
      <th>Gross</th>
    </tr>
    <tr>
      <th>Actor</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Harrison Ford</th>
      <td>4871.7</td>
      <td>41</td>
      <td>118.8</td>
      <td>Star Wars: The Force Awakens</td>
      <td>936.7</td>
    </tr>
    <tr>
      <th>Samuel L. Jackson</th>
      <td>4772.8</td>
      <td>69</td>
      <td>69.2</td>
      <td>The Avengers</td>
      <td>623.4</td>
    </tr>
    <tr>
      <th>Morgan Freeman</th>
      <td>4468.3</td>
      <td>61</td>
      <td>73.3</td>
      <td>The Dark Knight</td>
      <td>534.9</td>
    </tr>
    <tr>
      <th>Tom Hanks</th>
      <td>4340.8</td>
      <td>44</td>
      <td>98.7</td>
      <td>Toy Story 3</td>
      <td>415.0</td>
    </tr>
    <tr>
      <th>Robert Downey, Jr.</th>
      <td>3947.3</td>
      <td>53</td>
      <td>74.5</td>
      <td>The Avengers</td>
      <td>623.4</td>
    </tr>
    <tr>
      <th>Eddie Murphy</th>
      <td>3810.4</td>
      <td>38</td>
      <td>100.3</td>
      <td>Shrek 2</td>
      <td>441.2</td>
    </tr>
    <tr>
      <th>Tom Cruise</th>
      <td>3587.2</td>
      <td>36</td>
      <td>99.6</td>
      <td>War of the Worlds</td>
      <td>234.3</td>
    </tr>
    <tr>
      <th>Johnny Depp</th>
      <td>3368.6</td>
      <td>45</td>
      <td>74.9</td>
      <td>Dead Man's Chest</td>
      <td>423.3</td>
    </tr>
    <tr>
      <th>Michael Caine</th>
      <td>3351.5</td>
      <td>58</td>
      <td>57.8</td>
      <td>The Dark Knight</td>
      <td>534.9</td>
    </tr>
    <tr>
      <th>Scarlett Johansson</th>
      <td>3341.2</td>
      <td>37</td>
      <td>90.3</td>
      <td>The Avengers</td>
      <td>623.4</td>
    </tr>
    <tr>
      <th>Gary Oldman</th>
      <td>3294.0</td>
      <td>38</td>
      <td>86.7</td>
      <td>The Dark Knight</td>
      <td>534.9</td>
    </tr>
    <tr>
      <th>Robin Williams</th>
      <td>3279.3</td>
      <td>49</td>
      <td>66.9</td>
      <td>Night at the Museum</td>
      <td>250.9</td>
    </tr>
    <tr>
      <th>Bruce Willis</th>
      <td>3189.4</td>
      <td>60</td>
      <td>53.2</td>
      <td>Sixth Sense</td>
      <td>293.5</td>
    </tr>
    <tr>
      <th>Stellan Skarsgard</th>
      <td>3175.0</td>
      <td>43</td>
      <td>73.8</td>
      <td>The Avengers</td>
      <td>623.4</td>
    </tr>
    <tr>
      <th>Anthony Daniels</th>
      <td>3162.9</td>
      <td>7</td>
      <td>451.8</td>
      <td>Star Wars: The Force Awakens</td>
      <td>936.7</td>
    </tr>
    <tr>
      <th>Ian McKellen</th>
      <td>3150.4</td>
      <td>31</td>
      <td>101.6</td>
      <td>Return of the King</td>
      <td>377.8</td>
    </tr>
    <tr>
      <th>Will Smith</th>
      <td>3149.1</td>
      <td>24</td>
      <td>131.2</td>
      <td>Independence Day</td>
      <td>306.2</td>
    </tr>
    <tr>
      <th>Stanley Tucci</th>
      <td>3123.9</td>
      <td>50</td>
      <td>62.5</td>
      <td>Catching Fire</td>
      <td>424.7</td>
    </tr>
    <tr>
      <th>Matt Damon</th>
      <td>3107.3</td>
      <td>39</td>
      <td>79.7</td>
      <td>The Martian</td>
      <td>228.4</td>
    </tr>
    <tr>
      <th>Robert DeNiro</th>
      <td>3081.3</td>
      <td>79</td>
      <td>39.0</td>
      <td>Meet the Fockers</td>
      <td>279.3</td>
    </tr>
    <tr>
      <th>Cameron Diaz</th>
      <td>3031.7</td>
      <td>34</td>
      <td>89.2</td>
      <td>Shrek 2</td>
      <td>441.2</td>
    </tr>
    <tr>
      <th>Liam Neeson</th>
      <td>2942.7</td>
      <td>63</td>
      <td>46.7</td>
      <td>The Phantom Menace</td>
      <td>474.5</td>
    </tr>
    <tr>
      <th>Andy Serkis</th>
      <td>2890.6</td>
      <td>23</td>
      <td>125.7</td>
      <td>Star Wars: The Force Awakens</td>
      <td>936.7</td>
    </tr>
    <tr>
      <th>Don Cheadle</th>
      <td>2885.4</td>
      <td>34</td>
      <td>84.9</td>
      <td>Avengers: Age of Ultron</td>
      <td>459.0</td>
    </tr>
    <tr>
      <th>Ben Stiller</th>
      <td>2827.0</td>
      <td>37</td>
      <td>76.4</td>
      <td>Meet the Fockers</td>
      <td>279.3</td>
    </tr>
    <tr>
      <th>Helena Bonham Carter</th>
      <td>2822.0</td>
      <td>36</td>
      <td>78.4</td>
      <td>Harry Potter / Deathly Hallows (P2)</td>
      <td>381.0</td>
    </tr>
    <tr>
      <th>Orlando Bloom</th>
      <td>2815.8</td>
      <td>17</td>
      <td>165.6</td>
      <td>Dead Man's Chest</td>
      <td>423.3</td>
    </tr>
    <tr>
      <th>Woody Harrelson</th>
      <td>2815.8</td>
      <td>50</td>
      <td>56.3</td>
      <td>Catching Fire</td>
      <td>424.7</td>
    </tr>
    <tr>
      <th>Cate Blanchett</th>
      <td>2802.6</td>
      <td>39</td>
      <td>71.9</td>
      <td>Return of the King</td>
      <td>377.8</td>
    </tr>
    <tr>
      <th>Julia Roberts</th>
      <td>2735.3</td>
      <td>42</td>
      <td>65.1</td>
      <td>Ocean's Eleven</td>
      <td>183.4</td>
    </tr>
    <tr>
      <th>Elizabeth Banks</th>
      <td>2726.3</td>
      <td>35</td>
      <td>77.9</td>
      <td>Catching Fire</td>
      <td>424.7</td>
    </tr>
    <tr>
      <th>Ralph Fiennes</th>
      <td>2715.3</td>
      <td>36</td>
      <td>75.4</td>
      <td>Harry Potter / Deathly Hallows (P2)</td>
      <td>381.0</td>
    </tr>
    <tr>
      <th>Emma Watson</th>
      <td>2681.9</td>
      <td>17</td>
      <td>157.8</td>
      <td>Harry Potter / Deathly Hallows (P2)</td>
      <td>381.0</td>
    </tr>
    <tr>
      <th>Tommy Lee Jones</th>
      <td>2681.3</td>
      <td>46</td>
      <td>58.3</td>
      <td>Men in Black</td>
      <td>250.7</td>
    </tr>
    <tr>
      <th>Brad Pitt</th>
      <td>2680.9</td>
      <td>40</td>
      <td>67.0</td>
      <td>World War Z</td>
      <td>202.4</td>
    </tr>
    <tr>
      <th>Adam Sandler</th>
      <td>2661.0</td>
      <td>32</td>
      <td>83.2</td>
      <td>Hotel Transylvania 2</td>
      <td>169.7</td>
    </tr>
    <tr>
      <th>Daniel Radcliffe</th>
      <td>2634.4</td>
      <td>17</td>
      <td>155.0</td>
      <td>Harry Potter / Deathly Hallows (P2)</td>
      <td>381.0</td>
    </tr>
    <tr>
      <th>Jonah Hill</th>
      <td>2605.1</td>
      <td>29</td>
      <td>89.8</td>
      <td>The LEGO Movie</td>
      <td>257.8</td>
    </tr>
    <tr>
      <th>Owen Wilson</th>
      <td>2602.3</td>
      <td>39</td>
      <td>66.7</td>
      <td>Night at the Museum</td>
      <td>250.9</td>
    </tr>
    <tr>
      <th>Idris Elba</th>
      <td>2580.6</td>
      <td>26</td>
      <td>99.3</td>
      <td>Avengers: Age of Ultron</td>
      <td>459.0</td>
    </tr>
    <tr>
      <th>Bradley Cooper</th>
      <td>2557.7</td>
      <td>25</td>
      <td>102.3</td>
      <td>American Sniper</td>
      <td>350.1</td>
    </tr>
    <tr>
      <th>Mark Wahlberg</th>
      <td>2549.8</td>
      <td>36</td>
      <td>70.8</td>
      <td>Transformers 4</td>
      <td>245.4</td>
    </tr>
    <tr>
      <th>Jim Carrey</th>
      <td>2545.2</td>
      <td>27</td>
      <td>94.3</td>
      <td>The Grinch</td>
      <td>260.0</td>
    </tr>
    <tr>
      <th>Dustin Hoffman</th>
      <td>2522.1</td>
      <td>43</td>
      <td>58.7</td>
      <td>Meet the Fockers</td>
      <td>279.3</td>
    </tr>
    <tr>
      <th>Leonardo DiCaprio</th>
      <td>2518.3</td>
      <td>25</td>
      <td>100.7</td>
      <td>Titanic</td>
      <td>658.7</td>
    </tr>
    <tr>
      <th>Jeremy Renner</th>
      <td>2500.3</td>
      <td>21</td>
      <td>119.1</td>
      <td>The Avengers</td>
      <td>623.4</td>
    </tr>
    <tr>
      <th>Philip Seymour Hoffman</th>
      <td>2463.7</td>
      <td>40</td>
      <td>61.6</td>
      <td>Catching Fire</td>
      <td>424.7</td>
    </tr>
    <tr>
      <th>Sandra Bullock</th>
      <td>2462.6</td>
      <td>35</td>
      <td>70.4</td>
      <td>Minions</td>
      <td>336.0</td>
    </tr>
    <tr>
      <th>Chris Evans</th>
      <td>2457.8</td>
      <td>23</td>
      <td>106.9</td>
      <td>The Avengers</td>
      <td>623.4</td>
    </tr>
    <tr>
      <th>Anne Hathaway</th>
      <td>2416.5</td>
      <td>25</td>
      <td>96.7</td>
      <td>The Dark Knight Rises</td>
      <td>448.1</td>
    </tr>
  </tbody>
</table>
</div>



### Gráficos de dispersão

Qual é a relação entre `'Número de Filmes'` e `'Total Bruto'`?


```python
#In: 
actors.plot(kind='scatter', x='Number of Movies', y='Total Gross');
```


    
![png](07-Viz_files/07-Viz_31_0.png)
    


### Gráficos de dispersão

- Os gráficos de dispersão visualizam a relação entre duas variáveis ​​numéricas.
- Para criar um a partir de um DataFrame `df`, use
```
df.plot(
    kind='scatter', 
    x=x_column_for_horizontal, 
    y=y_column_for_vertical
)
```
- O gráfico de dispersão resultante tem um ponto por linha de `df`.
- Se você colocar um ponto e vírgula após uma chamada para `.plot`, isso ocultará a saída de texto estranha exibida.

### Gráficos de dispersão

Qual é a relação entre `'Número de Filmes'` e `'Média por Filme'`?


```python
#In: 
actors.plot(kind='scatter', x='Number of Movies', y='Average per Movie');
```


    
![png](07-Viz_files/07-Viz_34_0.png)
    


Observe que no gráfico acima, há uma associação _negativa_ e um valor discrepante.

### Quem esteve em 60 ou mais filmes?


```python
#In: 
actors[actors.get('Number of Movies') >= 60]
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
      <th>Total Gross</th>
      <th>Number of Movies</th>
      <th>Average per Movie</th>
      <th>#1 Movie</th>
      <th>Gross</th>
    </tr>
    <tr>
      <th>Actor</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Samuel L. Jackson</th>
      <td>4772.8</td>
      <td>69</td>
      <td>69.2</td>
      <td>The Avengers</td>
      <td>623.4</td>
    </tr>
    <tr>
      <th>Morgan Freeman</th>
      <td>4468.3</td>
      <td>61</td>
      <td>73.3</td>
      <td>The Dark Knight</td>
      <td>534.9</td>
    </tr>
    <tr>
      <th>Bruce Willis</th>
      <td>3189.4</td>
      <td>60</td>
      <td>53.2</td>
      <td>Sixth Sense</td>
      <td>293.5</td>
    </tr>
    <tr>
      <th>Robert DeNiro</th>
      <td>3081.3</td>
      <td>79</td>
      <td>39.0</td>
      <td>Meet the Fockers</td>
      <td>279.3</td>
    </tr>
    <tr>
      <th>Liam Neeson</th>
      <td>2942.7</td>
      <td>63</td>
      <td>46.7</td>
      <td>The Phantom Menace</td>
      <td>474.5</td>
    </tr>
  </tbody>
</table>
</div>



### Quem é o estranho?

Quem quer que sejam, fizeram poucos filmes de alta bilheteria.


```python
#In: 
actors[actors.get('Number of Movies') < 10]
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
      <th>Total Gross</th>
      <th>Number of Movies</th>
      <th>Average per Movie</th>
      <th>#1 Movie</th>
      <th>Gross</th>
    </tr>
    <tr>
      <th>Actor</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Anthony Daniels</th>
      <td>3162.9</td>
      <td>7</td>
      <td>451.8</td>
      <td>Star Wars: The Force Awakens</td>
      <td>936.7</td>
    </tr>
  </tbody>
</table>
</div>



### Anthony Daniels

<center><img src='https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/images/c3po.png' width=200></center>

## Gráficos de linha 📉

### Conjunto de dados agregando filmes por ano

|Coluna| Conteúdo|
|------|-----------|
`'Ano'`| Ano
`'Total Bruto em Bilhões'`| Total bruto de bilheteria doméstica, em bilhões de dólares, de todos os filmes lançados
`'Número de filmes'`| Número de filmes lançados
`'Filme #1'`| Filme de maior bilheteria


```python
#In: 
movies_by_year = pd.read_csv('https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/data/movies_by_year.csv').set_index('Year')
movies_by_year
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
      <th>Total Gross in Billions</th>
      <th>Number of Movies</th>
      <th>#1 Movie</th>
    </tr>
    <tr>
      <th>Year</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2022</th>
      <td>5.64</td>
      <td>380</td>
      <td>Top Gun: Maverick</td>
    </tr>
    <tr>
      <th>2021</th>
      <td>4.48</td>
      <td>439</td>
      <td>Spider-Man: No Way Home</td>
    </tr>
    <tr>
      <th>2020</th>
      <td>2.11</td>
      <td>456</td>
      <td>Bad Boys for Life</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>11.36</td>
      <td>910</td>
      <td>Avengers: Endgame</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>11.89</td>
      <td>993</td>
      <td>Black Panther</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>11.08</td>
      <td>854</td>
      <td>Star Wars: Episode VIII - The Last Jedi</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>11.38</td>
      <td>855</td>
      <td>Finding Dory</td>
    </tr>
    <tr>
      <th>2015</th>
      <td>11.15</td>
      <td>845</td>
      <td>Jurassic World</td>
    </tr>
    <tr>
      <th>2014</th>
      <td>10.37</td>
      <td>849</td>
      <td>Guardians of the Galaxy</td>
    </tr>
    <tr>
      <th>2013</th>
      <td>10.96</td>
      <td>826</td>
      <td>Iron Man 3</td>
    </tr>
    <tr>
      <th>2012</th>
      <td>10.84</td>
      <td>807</td>
      <td>The Avengers</td>
    </tr>
    <tr>
      <th>2011</th>
      <td>10.16</td>
      <td>731</td>
      <td>Harry Potter and the Deathly Hallows: Part 2</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>10.59</td>
      <td>651</td>
      <td>Avatar</td>
    </tr>
    <tr>
      <th>2009</th>
      <td>10.62</td>
      <td>646</td>
      <td>Transformers: Revenge of the Fallen</td>
    </tr>
    <tr>
      <th>2008</th>
      <td>9.65</td>
      <td>725</td>
      <td>The Dark Knight</td>
    </tr>
    <tr>
      <th>2007</th>
      <td>9.68</td>
      <td>775</td>
      <td>Spider-Man 3</td>
    </tr>
    <tr>
      <th>2006</th>
      <td>9.20</td>
      <td>746</td>
      <td>Pirates of the Caribbean: Dead Man's Chest</td>
    </tr>
    <tr>
      <th>2005</th>
      <td>8.83</td>
      <td>676</td>
      <td>Star Wars: Episode III - Revenge of the Sith</td>
    </tr>
    <tr>
      <th>2004</th>
      <td>9.35</td>
      <td>700</td>
      <td>Shrek 2</td>
    </tr>
    <tr>
      <th>2003</th>
      <td>9.23</td>
      <td>667</td>
      <td>Finding Nemo</td>
    </tr>
    <tr>
      <th>2002</th>
      <td>9.16</td>
      <td>570</td>
      <td>Spider-Man</td>
    </tr>
    <tr>
      <th>2001</th>
      <td>7.96</td>
      <td>412</td>
      <td>Harry Potter and the Sorcerer's Stone</td>
    </tr>
    <tr>
      <th>2000</th>
      <td>7.48</td>
      <td>439</td>
      <td>How the Grinch Stole Christmas</td>
    </tr>
    <tr>
      <th>1999</th>
      <td>7.34</td>
      <td>448</td>
      <td>Star Wars: Episode I - The Phantom Menace</td>
    </tr>
    <tr>
      <th>1998</th>
      <td>6.70</td>
      <td>334</td>
      <td>Titanic</td>
    </tr>
    <tr>
      <th>1997</th>
      <td>6.08</td>
      <td>310</td>
      <td>Men in Black</td>
    </tr>
    <tr>
      <th>1996</th>
      <td>5.60</td>
      <td>306</td>
      <td>Independence Day</td>
    </tr>
    <tr>
      <th>1995</th>
      <td>5.11</td>
      <td>291</td>
      <td>Batman Forever</td>
    </tr>
    <tr>
      <th>1994</th>
      <td>5.06</td>
      <td>259</td>
      <td>The Lion King</td>
    </tr>
    <tr>
      <th>1993</th>
      <td>4.82</td>
      <td>267</td>
      <td>Jurassic Park</td>
    </tr>
    <tr>
      <th>1992</th>
      <td>4.52</td>
      <td>247</td>
      <td>Batman Returns</td>
    </tr>
    <tr>
      <th>1991</th>
      <td>4.34</td>
      <td>253</td>
      <td>Terminator 2: Judgment Day</td>
    </tr>
    <tr>
      <th>1990</th>
      <td>4.33</td>
      <td>236</td>
      <td>Ghost</td>
    </tr>
    <tr>
      <th>1989</th>
      <td>4.08</td>
      <td>235</td>
      <td>Batman</td>
    </tr>
    <tr>
      <th>1988</th>
      <td>3.54</td>
      <td>239</td>
      <td>Who Framed Roger Rabbit</td>
    </tr>
    <tr>
      <th>1987</th>
      <td>3.34</td>
      <td>226</td>
      <td>Beverly Hills Cop II</td>
    </tr>
    <tr>
      <th>1986</th>
      <td>3.07</td>
      <td>201</td>
      <td>Top Gun</td>
    </tr>
    <tr>
      <th>1985</th>
      <td>3.02</td>
      <td>191</td>
      <td>Back to the Future</td>
    </tr>
    <tr>
      <th>1984</th>
      <td>3.07</td>
      <td>169</td>
      <td>Ghostbusters</td>
    </tr>
    <tr>
      <th>1983</th>
      <td>2.74</td>
      <td>149</td>
      <td>Star Wars: Episode VI - Return of the Jedi</td>
    </tr>
    <tr>
      <th>1982</th>
      <td>3.00</td>
      <td>132</td>
      <td>E.T. the Extra-Terrestrial</td>
    </tr>
    <tr>
      <th>1981</th>
      <td>0.90</td>
      <td>56</td>
      <td>Superman II</td>
    </tr>
    <tr>
      <th>1980</th>
      <td>1.64</td>
      <td>68</td>
      <td>Star Wars: Episode V - The Empire Strikes Back</td>
    </tr>
    <tr>
      <th>1979</th>
      <td>1.23</td>
      <td>40</td>
      <td>Superman</td>
    </tr>
    <tr>
      <th>1978</th>
      <td>0.83</td>
      <td>13</td>
      <td>Grease</td>
    </tr>
    <tr>
      <th>1977</th>
      <td>0.44</td>
      <td>9</td>
      <td>Star Wars: Episode IV - A New Hope</td>
    </tr>
  </tbody>
</table>
</div>



### Gráficos de linha

Como o número de filmes mudou ao longo do tempo? 🤔


```python
#In: 
movies_by_year.plot(kind='line', y='Number of Movies');
```


    
![png](07-Viz_files/07-Viz_46_0.png)
    


### Gráficos de linha

- Os gráficos de linhas mostram tendências em variáveis ​​numéricas ao longo do tempo.
- Para criar um a partir de um DataFrame `df`, use
```
df.plot(
    kind='line', 
    x=x_column_for_horizontal, 
    y=y_column_for_vertical
)
```

### Dica de plotagem

- **Dica**: se você quiser que o eixo x seja o índice, omita o argumento `x=`!
- Não funciona para gráficos de dispersão, mas funciona para a maioria dos outros tipos de gráficos.


```python
#In: 
movies_by_year.plot(kind='line', y='Number of Movies');
```


    
![png](07-Viz_files/07-Viz_49_0.png)
    


### Desde o ano 2000

Podemos criar um gráfico de linhas de apenas 2.000 em diante consultando `movies_by_year` antes de chamar `.plot`.


```python
#In: 
movies_by_year[movies_by_year.index >= 2000].plot(kind='line', y='Number of Movies');
```


    
![png](07-Viz_files/07-Viz_51_0.png)
    


O que você acha que explica as quedas em torno de 2008 e 2020?

### Como isso afetou o total bruto?


```python
#In: 
movies_by_year[movies_by_year.index >= 2000].plot(kind='line', y='Total Gross in Billions');
```


    
![png](07-Viz_files/07-Viz_54_0.png)
    


### Qual foi o filme de maior bilheteria de 2016? 🐟


```python
#In: 
...
```




    Ellipsis



## Gráficos de barras 📊

### Conjunto de dados das 200 melhores músicas dos EUA no Spotify no sábado (21/01/23)

[Downloaded from here – check it out!](https://spotifycharts.com/regional)


```python
#In: 
charts = (pd.read_csv('https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/data/regional-us-daily-2023-01-21.csv')
          .set_index('rank')
          .get(['track_name', 'artist_names', 'streams', 'uri'])
         )
charts
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
      <th>track_name</th>
      <th>artist_names</th>
      <th>streams</th>
      <th>uri</th>
    </tr>
    <tr>
      <th>rank</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>Flowers</td>
      <td>Miley Cyrus</td>
      <td>3356361</td>
      <td>spotify:track:0yLdNVWF3Srea0uzk55zFn</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Kill Bill</td>
      <td>SZA</td>
      <td>2479445</td>
      <td>spotify:track:1Qrg8KqiBpW07V7PNxwwwL</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Creepin' (with The Weeknd &amp; 21 Savage)</td>
      <td>Metro Boomin, The Weeknd, 21 Savage</td>
      <td>1337320</td>
      <td>spotify:track:2dHHgzDwk4BJdRwy9uXhTO</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Superhero (Heroes &amp; Villains) [with Future &amp; C...</td>
      <td>Metro Boomin, Future, Chris Brown</td>
      <td>1235285</td>
      <td>spotify:track:0vjeOZ3Ft5jvAi9SBFJm1j</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Rich Flex</td>
      <td>Drake, 21 Savage</td>
      <td>1109704</td>
      <td>spotify:track:1bDbXMyjaUIooNwFE9wn0N</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>196</th>
      <td>Burn, Burn, Burn</td>
      <td>Zach Bryan</td>
      <td>267772</td>
      <td>spotify:track:5jfhLCSIFUO4ndzNRh4w4G</td>
    </tr>
    <tr>
      <th>197</th>
      <td>LET GO</td>
      <td>Central Cee</td>
      <td>267401</td>
      <td>spotify:track:3zkyus0njMCL6phZmNNEeN</td>
    </tr>
    <tr>
      <th>198</th>
      <td>Major Distribution</td>
      <td>Drake, 21 Savage</td>
      <td>266986</td>
      <td>spotify:track:46s57QULU02Voy0Kup6UEb</td>
    </tr>
    <tr>
      <th>199</th>
      <td>Sun to Me</td>
      <td>Zach Bryan</td>
      <td>266968</td>
      <td>spotify:track:1SjsVdSXpwm1kTdYEHoPIT</td>
    </tr>
    <tr>
      <th>200</th>
      <td>The Real Slim Shady</td>
      <td>Eminem</td>
      <td>266698</td>
      <td>spotify:track:3yfqSUWxFvZELEM4PmlwIR</td>
    </tr>
  </tbody>
</table>
<p>200 rows × 4 columns</p>
</div>



### Gráficos de barra

Quantos streams as 10 músicas mais populares têm?


```python
#In: 
charts
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
      <th>track_name</th>
      <th>artist_names</th>
      <th>streams</th>
      <th>uri</th>
    </tr>
    <tr>
      <th>rank</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>Flowers</td>
      <td>Miley Cyrus</td>
      <td>3356361</td>
      <td>spotify:track:0yLdNVWF3Srea0uzk55zFn</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Kill Bill</td>
      <td>SZA</td>
      <td>2479445</td>
      <td>spotify:track:1Qrg8KqiBpW07V7PNxwwwL</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Creepin' (with The Weeknd &amp; 21 Savage)</td>
      <td>Metro Boomin, The Weeknd, 21 Savage</td>
      <td>1337320</td>
      <td>spotify:track:2dHHgzDwk4BJdRwy9uXhTO</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Superhero (Heroes &amp; Villains) [with Future &amp; C...</td>
      <td>Metro Boomin, Future, Chris Brown</td>
      <td>1235285</td>
      <td>spotify:track:0vjeOZ3Ft5jvAi9SBFJm1j</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Rich Flex</td>
      <td>Drake, 21 Savage</td>
      <td>1109704</td>
      <td>spotify:track:1bDbXMyjaUIooNwFE9wn0N</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>196</th>
      <td>Burn, Burn, Burn</td>
      <td>Zach Bryan</td>
      <td>267772</td>
      <td>spotify:track:5jfhLCSIFUO4ndzNRh4w4G</td>
    </tr>
    <tr>
      <th>197</th>
      <td>LET GO</td>
      <td>Central Cee</td>
      <td>267401</td>
      <td>spotify:track:3zkyus0njMCL6phZmNNEeN</td>
    </tr>
    <tr>
      <th>198</th>
      <td>Major Distribution</td>
      <td>Drake, 21 Savage</td>
      <td>266986</td>
      <td>spotify:track:46s57QULU02Voy0Kup6UEb</td>
    </tr>
    <tr>
      <th>199</th>
      <td>Sun to Me</td>
      <td>Zach Bryan</td>
      <td>266968</td>
      <td>spotify:track:1SjsVdSXpwm1kTdYEHoPIT</td>
    </tr>
    <tr>
      <th>200</th>
      <td>The Real Slim Shady</td>
      <td>Eminem</td>
      <td>266698</td>
      <td>spotify:track:3yfqSUWxFvZELEM4PmlwIR</td>
    </tr>
  </tbody>
</table>
<p>200 rows × 4 columns</p>
</div>




```python
#In: 
charts.take(np.arange(10))
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
      <th>track_name</th>
      <th>artist_names</th>
      <th>streams</th>
      <th>uri</th>
    </tr>
    <tr>
      <th>rank</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>Flowers</td>
      <td>Miley Cyrus</td>
      <td>3356361</td>
      <td>spotify:track:0yLdNVWF3Srea0uzk55zFn</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Kill Bill</td>
      <td>SZA</td>
      <td>2479445</td>
      <td>spotify:track:1Qrg8KqiBpW07V7PNxwwwL</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Creepin' (with The Weeknd &amp; 21 Savage)</td>
      <td>Metro Boomin, The Weeknd, 21 Savage</td>
      <td>1337320</td>
      <td>spotify:track:2dHHgzDwk4BJdRwy9uXhTO</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Superhero (Heroes &amp; Villains) [with Future &amp; C...</td>
      <td>Metro Boomin, Future, Chris Brown</td>
      <td>1235285</td>
      <td>spotify:track:0vjeOZ3Ft5jvAi9SBFJm1j</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Rich Flex</td>
      <td>Drake, 21 Savage</td>
      <td>1109704</td>
      <td>spotify:track:1bDbXMyjaUIooNwFE9wn0N</td>
    </tr>
    <tr>
      <th>6</th>
      <td>Shakira: Bzrp Music Sessions, Vol. 53</td>
      <td>Bizarrap, Shakira</td>
      <td>1051226</td>
      <td>spotify:track:4nrPB8O7Y7wsOCJdgXkthe</td>
    </tr>
    <tr>
      <th>7</th>
      <td>Just Wanna Rock</td>
      <td>Lil Uzi Vert</td>
      <td>998684</td>
      <td>spotify:track:4FyesJzVpA39hbYvcseO2d</td>
    </tr>
    <tr>
      <th>8</th>
      <td>Anti-Hero</td>
      <td>Taylor Swift</td>
      <td>936166</td>
      <td>spotify:track:0V3wPSX9ygBnCm8psDIegu</td>
    </tr>
    <tr>
      <th>9</th>
      <td>golden hour</td>
      <td>JVKE</td>
      <td>870031</td>
      <td>spotify:track:5odlY52u43F5BjByhxg7wg</td>
    </tr>
    <tr>
      <th>10</th>
      <td>Unholy (feat. Kim Petras)</td>
      <td>Sam Smith, Kim Petras</td>
      <td>859271</td>
      <td>spotify:track:3nqQXoyQOWXiESFLlDF1hG</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
charts.take(np.arange(10)).plot(kind='barh', x='track_name', y='streams');
```


    
![png](07-Viz_files/07-Viz_63_0.png)
    


### Gráficos de barra

- Os gráficos de barras visualizam a relação entre uma variável categórica e uma variável numérica.
- Em um gráfico de barras...
- A espessura e o espaçamento das barras são arbitrários.
- A ordem dos rótulos categóricos não importa.
- Para criar um a partir de um DataFrame `df`, use
```
df.plot(
    kind='barh', 
    x=categorical_column_name, 
    y=numerical_column_name
)
```
- O **"h"** em `'barh'` significa **"horizontal"**.
- É mais fácil ler os rótulos desta forma.
- No gráfico anterior, definimos `y='Streams'` mesmo que os streams sejam medidos pelo comprimento do eixo x.


```python
#In: 
# The bars appear in the opposite order relative to the DataFrame
(charts
 .take(np.arange(10))
 .sort_values(by='streams')
 .plot(kind='barh', x='track_name', y='streams')
);
```


    
![png](07-Viz_files/07-Viz_65_0.png)
    


### Quantas músicas os 15 melhores artistas têm entre os 200 melhores?

Primeiro, vamos criar um DataFrame com uma única coluna que descreve o número de músicas entre as 200 melhores por artista. Isso envolve usar `.groupby` com `.count()`. Como queremos uma linha por artista, agruparemos por `'nomes_artistas'`.


```python
#In: 
charts
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
      <th>track_name</th>
      <th>artist_names</th>
      <th>streams</th>
      <th>uri</th>
    </tr>
    <tr>
      <th>rank</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>Flowers</td>
      <td>Miley Cyrus</td>
      <td>3356361</td>
      <td>spotify:track:0yLdNVWF3Srea0uzk55zFn</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Kill Bill</td>
      <td>SZA</td>
      <td>2479445</td>
      <td>spotify:track:1Qrg8KqiBpW07V7PNxwwwL</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Creepin' (with The Weeknd &amp; 21 Savage)</td>
      <td>Metro Boomin, The Weeknd, 21 Savage</td>
      <td>1337320</td>
      <td>spotify:track:2dHHgzDwk4BJdRwy9uXhTO</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Superhero (Heroes &amp; Villains) [with Future &amp; C...</td>
      <td>Metro Boomin, Future, Chris Brown</td>
      <td>1235285</td>
      <td>spotify:track:0vjeOZ3Ft5jvAi9SBFJm1j</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Rich Flex</td>
      <td>Drake, 21 Savage</td>
      <td>1109704</td>
      <td>spotify:track:1bDbXMyjaUIooNwFE9wn0N</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>196</th>
      <td>Burn, Burn, Burn</td>
      <td>Zach Bryan</td>
      <td>267772</td>
      <td>spotify:track:5jfhLCSIFUO4ndzNRh4w4G</td>
    </tr>
    <tr>
      <th>197</th>
      <td>LET GO</td>
      <td>Central Cee</td>
      <td>267401</td>
      <td>spotify:track:3zkyus0njMCL6phZmNNEeN</td>
    </tr>
    <tr>
      <th>198</th>
      <td>Major Distribution</td>
      <td>Drake, 21 Savage</td>
      <td>266986</td>
      <td>spotify:track:46s57QULU02Voy0Kup6UEb</td>
    </tr>
    <tr>
      <th>199</th>
      <td>Sun to Me</td>
      <td>Zach Bryan</td>
      <td>266968</td>
      <td>spotify:track:1SjsVdSXpwm1kTdYEHoPIT</td>
    </tr>
    <tr>
      <th>200</th>
      <td>The Real Slim Shady</td>
      <td>Eminem</td>
      <td>266698</td>
      <td>spotify:track:3yfqSUWxFvZELEM4PmlwIR</td>
    </tr>
  </tbody>
</table>
<p>200 rows × 4 columns</p>
</div>




```python
#In: 
songs_per_artist = charts.groupby('artist_names').count()
songs_per_artist
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
      <th>track_name</th>
      <th>streams</th>
      <th>uri</th>
    </tr>
    <tr>
      <th>artist_names</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>21 Savage, Metro Boomin</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>80purppp</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>A Boogie Wit da Hoodie</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>Arctic Monkeys</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Arcángel, Bad Bunny</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>XXXTENTACION</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>Yeat</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>Zach Bryan</th>
      <td>4</td>
      <td>4</td>
      <td>4</td>
    </tr>
    <tr>
      <th>d4vd</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Ñengo Flow, Bad Bunny</th>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
<p>145 rows × 3 columns</p>
</div>



Usando `.sort_values` e `.take`, manteremos apenas os 15 melhores artistas. Observe que todas as colunas em `songs_per_artist` contêm as mesmas informações (isso é uma consequência do uso de `.count()`).


```python
#In: 
top_15_artists = (songs_per_artist
                  .sort_values('streams', ascending=False)
                  .take(np.arange(15)))
top_15_artists
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
      <th>track_name</th>
      <th>streams</th>
      <th>uri</th>
    </tr>
    <tr>
      <th>artist_names</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>SZA</th>
      <td>11</td>
      <td>11</td>
      <td>11</td>
    </tr>
    <tr>
      <th>Taylor Swift</th>
      <td>8</td>
      <td>8</td>
      <td>8</td>
    </tr>
    <tr>
      <th>Morgan Wallen</th>
      <td>6</td>
      <td>6</td>
      <td>6</td>
    </tr>
    <tr>
      <th>Drake, 21 Savage</th>
      <td>5</td>
      <td>5</td>
      <td>5</td>
    </tr>
    <tr>
      <th>Zach Bryan</th>
      <td>4</td>
      <td>4</td>
      <td>4</td>
    </tr>
    <tr>
      <th>The Weeknd</th>
      <td>4</td>
      <td>4</td>
      <td>4</td>
    </tr>
    <tr>
      <th>Mac DeMarco</th>
      <td>3</td>
      <td>3</td>
      <td>3</td>
    </tr>
    <tr>
      <th>J. Cole</th>
      <td>3</td>
      <td>3</td>
      <td>3</td>
    </tr>
    <tr>
      <th>Steve Lacy</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Juice WRLD</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Eminem</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Kanye West</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>NewJeans</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Childish Gambino</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>Miley Cyrus</th>
      <td>2</td>
      <td>2</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>



Usando `.assign` e `.drop`, criaremos uma coluna chamada `'count'` que contém as mesmas informações que as outras 3 colunas contêm, e então `.get` apenas essa coluna (ou equivalentemente, eliminaremos o outras 3 colunas).


```python
#In: 
# If we give .get a list, it will return a DataFrame instead of a Series!
top_15_artists = (top_15_artists
                  .assign(count=top_15_artists.get('streams'))
                  .get(['count']))
top_15_artists
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
      <th>count</th>
    </tr>
    <tr>
      <th>artist_names</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>SZA</th>
      <td>11</td>
    </tr>
    <tr>
      <th>Taylor Swift</th>
      <td>8</td>
    </tr>
    <tr>
      <th>Morgan Wallen</th>
      <td>6</td>
    </tr>
    <tr>
      <th>Drake, 21 Savage</th>
      <td>5</td>
    </tr>
    <tr>
      <th>Zach Bryan</th>
      <td>4</td>
    </tr>
    <tr>
      <th>The Weeknd</th>
      <td>4</td>
    </tr>
    <tr>
      <th>Mac DeMarco</th>
      <td>3</td>
    </tr>
    <tr>
      <th>J. Cole</th>
      <td>3</td>
    </tr>
    <tr>
      <th>Steve Lacy</th>
      <td>2</td>
    </tr>
    <tr>
      <th>Juice WRLD</th>
      <td>2</td>
    </tr>
    <tr>
      <th>Eminem</th>
      <td>2</td>
    </tr>
    <tr>
      <th>Kanye West</th>
      <td>2</td>
    </tr>
    <tr>
      <th>NewJeans</th>
      <td>2</td>
    </tr>
    <tr>
      <th>Childish Gambino</th>
      <td>2</td>
    </tr>
    <tr>
      <th>Miley Cyrus</th>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>



Antes de chamar `.plot(kind='barh', y='count')`, classificaremos `top_15_artists` por `'count'` em ordem **crescente**. Isso ocorre porque, estranhamente, o Python inverte a ordem das linhas ao criar barras em gráficos de barras horizontais.


```python
#In: 
top_15_artists.sort_values(by='count').plot(kind='barh', y='count');
```


    
![png](07-Viz_files/07-Viz_75_0.png)
    


### Gráficos de barras verticais

Para criar um gráfico de barras verticais, use `kind='bar'` em vez de `kind='barh'`. No entanto, geralmente são mais difíceis de ler.


```python
#In: 
top_15_artists.plot(kind='bar', y='count');
```


    
![png](07-Viz_files/07-Viz_77_0.png)
    


### À parte: quantas transmissões as músicas do The Weeknd na parada receberam?


```python
#In: 
(charts
 [charts.get('artist_names') == 'The Weeknd']
 .sort_values('streams')
 .plot(kind='barh', x='track_name', y='streams')
);
```


    
![png](07-Viz_files/07-Viz_79_0.png)
    


Parece que estamos perdendo algumas músicas populares...

### Como incluímos músicas em destaque também?

Resposta: Usando `.str.contains`.


```python
#In: 
weeknd = charts[charts.get('artist_names').str.contains('The Weeknd')]
weeknd
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
      <th>track_name</th>
      <th>artist_names</th>
      <th>streams</th>
      <th>uri</th>
    </tr>
    <tr>
      <th>rank</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3</th>
      <td>Creepin' (with The Weeknd &amp; 21 Savage)</td>
      <td>Metro Boomin, The Weeknd, 21 Savage</td>
      <td>1337320</td>
      <td>spotify:track:2dHHgzDwk4BJdRwy9uXhTO</td>
    </tr>
    <tr>
      <th>13</th>
      <td>Die For You</td>
      <td>The Weeknd</td>
      <td>794924</td>
      <td>spotify:track:2LBqCSwhJGcFQeTHMVGwy3</td>
    </tr>
    <tr>
      <th>76</th>
      <td>Stargirl Interlude</td>
      <td>The Weeknd, Lana Del Rey</td>
      <td>372624</td>
      <td>spotify:track:5gDWsRxpJ2lZAffh5p7K0w</td>
    </tr>
    <tr>
      <th>78</th>
      <td>Starboy</td>
      <td>The Weeknd, Daft Punk</td>
      <td>361999</td>
      <td>spotify:track:7MXVkk9YMctZqd1Srtv4MB</td>
    </tr>
    <tr>
      <th>102</th>
      <td>The Hills</td>
      <td>The Weeknd</td>
      <td>334354</td>
      <td>spotify:track:7fBv7CLKzipRk6EC6TWHOB</td>
    </tr>
    <tr>
      <th>110</th>
      <td>I Was Never There</td>
      <td>The Weeknd, Gesaffelstein</td>
      <td>328724</td>
      <td>spotify:track:1cKHdTo9u0ZymJdPGSh6nq</td>
    </tr>
    <tr>
      <th>128</th>
      <td>Blinding Lights</td>
      <td>The Weeknd</td>
      <td>311176</td>
      <td>spotify:track:0VjIjW4GlUZAMYd2vXMi3b</td>
    </tr>
    <tr>
      <th>168</th>
      <td>Call Out My Name</td>
      <td>The Weeknd</td>
      <td>281141</td>
      <td>spotify:track:09mEdoA6zrmBPgTEN5qXmN</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
weeknd.sort_values('streams').plot(kind='barh', x='track_name', y='streams');
```


    
![png](07-Viz_files/07-Viz_83_0.png)
    


## Demonstração divertida 🎵


```python
#In: 
# Run this cell, don't worry about what it does.
def show_spotify(uri):
    code = uri[uri.rfind(':')+1:]
    src = f"https://open.spotify.com/embed/track/{code}"
    width = 400
    height = 75
    display(IFrame(src, width, height))
```

#### Vamos encontrar o URI de uma música que nos interessa.


```python
#In: 
charts
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
      <th>track_name</th>
      <th>artist_names</th>
      <th>streams</th>
      <th>uri</th>
    </tr>
    <tr>
      <th>rank</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>Flowers</td>
      <td>Miley Cyrus</td>
      <td>3356361</td>
      <td>spotify:track:0yLdNVWF3Srea0uzk55zFn</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Kill Bill</td>
      <td>SZA</td>
      <td>2479445</td>
      <td>spotify:track:1Qrg8KqiBpW07V7PNxwwwL</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Creepin' (with The Weeknd &amp; 21 Savage)</td>
      <td>Metro Boomin, The Weeknd, 21 Savage</td>
      <td>1337320</td>
      <td>spotify:track:2dHHgzDwk4BJdRwy9uXhTO</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Superhero (Heroes &amp; Villains) [with Future &amp; C...</td>
      <td>Metro Boomin, Future, Chris Brown</td>
      <td>1235285</td>
      <td>spotify:track:0vjeOZ3Ft5jvAi9SBFJm1j</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Rich Flex</td>
      <td>Drake, 21 Savage</td>
      <td>1109704</td>
      <td>spotify:track:1bDbXMyjaUIooNwFE9wn0N</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>196</th>
      <td>Burn, Burn, Burn</td>
      <td>Zach Bryan</td>
      <td>267772</td>
      <td>spotify:track:5jfhLCSIFUO4ndzNRh4w4G</td>
    </tr>
    <tr>
      <th>197</th>
      <td>LET GO</td>
      <td>Central Cee</td>
      <td>267401</td>
      <td>spotify:track:3zkyus0njMCL6phZmNNEeN</td>
    </tr>
    <tr>
      <th>198</th>
      <td>Major Distribution</td>
      <td>Drake, 21 Savage</td>
      <td>266986</td>
      <td>spotify:track:46s57QULU02Voy0Kup6UEb</td>
    </tr>
    <tr>
      <th>199</th>
      <td>Sun to Me</td>
      <td>Zach Bryan</td>
      <td>266968</td>
      <td>spotify:track:1SjsVdSXpwm1kTdYEHoPIT</td>
    </tr>
    <tr>
      <th>200</th>
      <td>The Real Slim Shady</td>
      <td>Eminem</td>
      <td>266698</td>
      <td>spotify:track:3yfqSUWxFvZELEM4PmlwIR</td>
    </tr>
  </tbody>
</table>
<p>200 rows × 4 columns</p>
</div>




```python
#In: 
favorite_song = 'Bejeweled'
```


```python
#In: 
song_uri = (charts
            [charts.get('track_name') == favorite_song]
            .get('uri')
            .iloc[0])
song_uri
```




    'spotify:track:3qoftcUZaUOncvIYjFSPdE'



Veja o que acontece! 🎶


```python
#In: 
show_spotify(song_uri)
```



<iframe
    width="400"
    height="75"
    src="https://open.spotify.com/embed/track/3qoftcUZaUOncvIYjFSPdE"
    frameborder="0"
    allowfullscreen

></iframe>



Experimente você mesmo!

### Visualizações ruins

- Conforme mencionado anteriormente, as visualizações nos permitem identificar facilmente tendências e comunicar nossos resultados a outras pessoas.
- Algumas visualizações tornam mais difícil ver a tendência nos dados, ao:

- Adicionando "[chart junk](https://eagereyes.org/criticism/chart-junk-considered-useful-after-all)."

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/images/usefuljunk-monster.jpg)

- Usando eixos e tamanhos enganosos.

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/images/average_height.png)

## Resumo

### Resumo

- As visualizações facilitam a extração de padrões de conjuntos de dados.
- Existem dois tipos principais de variáveis: categóricas e numéricas.
- Os tipos de variáveis ​​que estamos visualizando informam nossa escolha de qual tipo de visualização usar.
- Hoje, analisamos gráficos de dispersão, gráficos de linhas e gráficos de barras.
- **Próxima vez:** Histogramas e gráficos sobrepostos.
