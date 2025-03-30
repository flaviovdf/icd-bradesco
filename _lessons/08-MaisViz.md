---
layout: page
title: Um pouco Mais de Visualização de Dados
nav_order: 8
---
[<img src="https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/colab_favicon_small.png" style="float: right;">](https://colab.research.google.com/github/flaviovdf/icd-bradesco/blob/master/_lessons/08-MaisViz.ipynb)

# Tópico 8 – Um pouco Mais de Visualização de Dados 📈
{: .no_toc .mb-2 }

Aprender um pouco sobre transformação de dados e alguns exemplos a mais.
{: .fs-6 .fw-300 }

{: .no_toc .text-delta }
Resultados Esperados

1. Aprender como transformar dados
1. Aprender qual a melhor forma de ter dados sobre postos



```python
#In: 
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
plt.style.use('ggplot')
```

### Agenda

- Distribuições.
- Histogramas de densidade.
- Parcelas sobrepostas.

### Revisão: tipos de visualizações

O tipo de visualização que criamos depende dos tipos de variáveis ​​que estamos visualizando.

- **Gráfico de dispersão**: numérico versus numérico.
- Exemplo: peso x altura.
- **Gráfico de linhas**: numérico sequencial (tempo) vs.
- Exemplo: altura vs. tempo.
- **Gráfico de barras**: categórico vs. numérico.
- Exemplo: alturas de diferentes membros da família.
- **Histograma**: distribuição numérica.

**Observação:** Podemos trocar as palavras "plot", "chart" e "graph"; todos eles significam a mesma coisa.

### Algumas visualizações ruins

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/08-MaisViz/images/bananas.png)

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/08-MaisViz/images/average_height.png)

![](https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/08-MaisViz/images/weather.png)

## Distribuições

### Qual é a distribuição de uma variável?

- A distribuição de uma variável consiste em todos os valores da variável que ocorrem nos dados, juntamente com suas frequências.
- As distribuições ajudam você a entender:
    - Com que frequência uma variável assume um determinado valor?_
- Ambas as variáveis ​​categóricas e numéricas têm distribuições.

### Variáveis ​​categóricas

A distribuição de uma variável categórica pode ser exibida como uma tabela ou gráfico de barras, entre outras formas! Por exemplo, vejamos qual o tipo de ensino médio dos alunos de FCD.


```python
#In: 
tipo_medio = pd.DataFrame().assign(
    TipoEscola=['Privado', 'Público (Estadual)', 'Público (Municipal)', 'Público (Federal)'], 
    NumDiscentes=[15, 8, 3, 7]
)
tipo_medio
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
      <th>TipoEscola</th>
      <th>NumDiscentes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Privado</td>
      <td>15</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Público (Estadual)</td>
      <td>8</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Público (Municipal)</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Público (Federal)</td>
      <td>7</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
tipo_medio.plot(kind='barh', x='TipoEscola', y='NumDiscentes');
```


    
![png](08-MaisViz_files/08-MaisViz_11_0.png)
    



```python
#In: 
tipo_medio.plot(kind='bar', x='TipoEscola', y='NumDiscentes');
```


    
![png](08-MaisViz_files/08-MaisViz_12_0.png)
    


### Variáveis ​​numéricas

A distribuição de uma variável numérica nem sempre pode ser representada com precisão por um gráfico de barras. Por exemplo, vejamos o número de streams de cada uma das 200 músicas mais populares no Spotify nos EUA. 🎵


```python
#In: 
charts = pd.read_csv('https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/07-DataViz/data/regional-us-daily-2023-01-21.csv')
charts = (charts.set_index('rank')
          .assign(million_streams = np.round(charts.get('streams')/1000000, 2))
          .get(['track_name', 'artist_names', 'streams', 'million_streams'])
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
      <th>million_streams</th>
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
      <td>2.48</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Kill Bill</td>
      <td>SZA</td>
      <td>2479445</td>
      <td>1.34</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Creepin' (with The Weeknd &amp; 21 Savage)</td>
      <td>Metro Boomin, The Weeknd, 21 Savage</td>
      <td>1337320</td>
      <td>1.24</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Superhero (Heroes &amp; Villains) [with Future &amp; C...</td>
      <td>Metro Boomin, Future, Chris Brown</td>
      <td>1235285</td>
      <td>1.11</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Rich Flex</td>
      <td>Drake, 21 Savage</td>
      <td>1109704</td>
      <td>1.05</td>
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
      <td>0.27</td>
    </tr>
    <tr>
      <th>197</th>
      <td>LET GO</td>
      <td>Central Cee</td>
      <td>267401</td>
      <td>0.27</td>
    </tr>
    <tr>
      <th>198</th>
      <td>Major Distribution</td>
      <td>Drake, 21 Savage</td>
      <td>266986</td>
      <td>0.27</td>
    </tr>
    <tr>
      <th>199</th>
      <td>Sun to Me</td>
      <td>Zach Bryan</td>
      <td>266968</td>
      <td>0.27</td>
    </tr>
    <tr>
      <th>200</th>
      <td>The Real Slim Shady</td>
      <td>Eminem</td>
      <td>266698</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>200 rows × 4 columns</p>
</div>



Para ver a distribuição do número de streams, precisamos agrupar pela coluna `'million_streams'`.


```python
#In: 
stream_counts = charts.groupby('million_streams').count()
stream_counts = stream_counts.assign(Count=stream_counts.get('track_name')).drop(columns=['track_name', 'artist_names', 'streams'])
stream_counts
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
      <th>Count</th>
    </tr>
    <tr>
      <th>million_streams</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0.27</th>
      <td>17</td>
    </tr>
    <tr>
      <th>0.28</th>
      <td>20</td>
    </tr>
    <tr>
      <th>0.29</th>
      <td>19</td>
    </tr>
    <tr>
      <th>0.30</th>
      <td>8</td>
    </tr>
    <tr>
      <th>0.31</th>
      <td>14</td>
    </tr>
    <tr>
      <th>0.32</th>
      <td>7</td>
    </tr>
    <tr>
      <th>0.33</th>
      <td>14</td>
    </tr>
    <tr>
      <th>0.34</th>
      <td>7</td>
    </tr>
    <tr>
      <th>0.35</th>
      <td>10</td>
    </tr>
    <tr>
      <th>0.36</th>
      <td>8</td>
    </tr>
    <tr>
      <th>0.37</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.38</th>
      <td>7</td>
    </tr>
    <tr>
      <th>0.39</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.40</th>
      <td>5</td>
    </tr>
    <tr>
      <th>0.41</th>
      <td>3</td>
    </tr>
    <tr>
      <th>0.42</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.43</th>
      <td>4</td>
    </tr>
    <tr>
      <th>0.44</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.45</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.46</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.47</th>
      <td>4</td>
    </tr>
    <tr>
      <th>0.48</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.49</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.50</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.52</th>
      <td>5</td>
    </tr>
    <tr>
      <th>0.53</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.54</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.55</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.56</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.57</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.58</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.61</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.64</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.66</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.67</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.69</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.74</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.75</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.76</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.79</th>
      <td>5</td>
    </tr>
    <tr>
      <th>0.83</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.86</th>
      <td>2</td>
    </tr>
    <tr>
      <th>0.87</th>
      <td>1</td>
    </tr>
    <tr>
      <th>0.94</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1.00</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1.05</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1.11</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1.24</th>
      <td>1</td>
    </tr>
    <tr>
      <th>1.34</th>
      <td>1</td>
    </tr>
    <tr>
      <th>2.48</th>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
stream_counts.plot(kind='bar', y='Count', figsize=(15,5));
```


    
![png](08-MaisViz_files/08-MaisViz_17_0.png)
    


- Isso obscurece o fato de que as duas músicas principais são atípicas, com **muito mais streams** do que as outras músicas.

- O eixo horizontal deve ser numérico (como uma reta numérica), não categórico. Deve haver mais espaço entre certas barras do que outras.

## Histogramas

### Histogramas mostram a distribuição de variáveis ​​numéricas *sem normalizar*

Em vez de um gráfico de barras, visualizaremos a distribuição de uma variável numérica com um **histograma**. Vamos ver como é um histograma de densidade para `'million_streams'`. O que você percebe nessa visualização?


```python
#In: 
# Ignore the code for right now.
charts.plot(
    kind='hist',
    y='million_streams',
    bins=np.arange(0, 4, 0.5),
    ec='w'  # borda branca
);
```


    
![png](08-MaisViz_files/08-MaisViz_21_0.png)
    


### Primeira ideia chave por trás dos histogramas: binning 🗑️

- Binning é o ato de contar o número de valores numéricos que se enquadram nos intervalos definidos por dois pontos finais. Esses intervalos são chamados de “caixas”.
- Um valor cai em uma caixa se for **maior ou igual ao ponto final esquerdo** e **menor que o ponto final direito**.
- [a, b): a está incluído, b não.
- A largura de uma caixa é sua extremidade direita menos sua extremidade esquerda.



```python
#In: 
from IPython.display import display, IFrame

def binning_animation():
    src="https://docs.google.com/presentation/d/e/2PACX-1vTnRGwEnKP2V-Z82DlxW1b1nMb2F0zWyrXIzFSpQx_8Wd3MFaf56y2_u3JrLwZ5SjWmfapL5BJLfsDG/embed?start=false&loop=false&delayms=60000"
    width=900
    height=307
    display(IFrame(src, width, height))
binning_animation()
```



<iframe
    width="900"
    height="307"
    src="https://docs.google.com/presentation/d/e/2PACX-1vTnRGwEnKP2V-Z82DlxW1b1nMb2F0zWyrXIzFSpQx_8Wd3MFaf56y2_u3JrLwZ5SjWmfapL5BJLfsDG/embed?start=false&loop=false&delayms=60000"
    frameborder="0"
    allowfullscreen

></iframe>



### Personalizando as caixas

- Por padrão, o Python agrupará seus dados em 10 compartimentos de tamanhos iguais.
- Você pode especificar outro número de compartimentos de tamanhos iguais definindo o argumento opcional `bins` igual a algum outro valor inteiro.
- Você também pode especificar o início e os pontos finais do compartimento personalizado definindo `bins` iguais a uma sequência de pontos finais do compartimento.
- Pode ser um array `list` ou `numpy`.


```python
#In: 
charts.plot(
    kind='hist',
    y='million_streams',
    bins=20,
    ec='w'
);
```


    
![png](08-MaisViz_files/08-MaisViz_25_0.png)
    



```python
#In: 
charts.plot(
    kind='hist', y='million_streams', density=True,
    bins=[0, 1, 2, 3, 4, 5],
    ec='w'
);
```


    
![png](08-MaisViz_files/08-MaisViz_26_0.png)
    


Nos dois histogramas acima, o que é diferente e o que é igual?

### Observações
- A forma geral de todos os dois histogramas é a mesma, independentemente dos compartimentos. Esta forma é chamada de *inclinada à direita*.
- Mais compartimentos fornecem uma imagem mais precisa e granular da distribuição da variável `'million_streams'`.
- Os valores do eixo $y$ parecem mudar muito quando mudamos os compartimentos. Agarre-se a esse pensamento; veremos o porquê em breve.

### Histogramas de densidade mostram a distribuição de variáveis ​​numéricas

Podemos também criar histogramas *normalizados* ou histogramas de densidade.

### Ideia chave por trás dos histogramas de densidade: a área total é 1

- Em um histograma de densidade, o eixo $y$ pode ser difícil de interpretar, mas foi projetado para dar ao histograma uma propriedade muito boa: $$\textbf{As barras de um histograma de densidade }$$
$$\textbf{têm uma área total combinada de 1.}$$
- Isso significa que a área de uma barra é igual à proporção de todos os pontos de dados que caem nessa caixa.
- Proporções e percentagens representam a mesma coisa.
- Uma proporção é um decimal entre 0 e 1, uma porcentagem está entre 0\% e 100\%.
- A proporção 0,34 significa 34\%.


### Cálculo de exemplo


```python
#In: 
charts.plot(
    kind='hist',
    y='million_streams',
    density=True,
    bins=[0, 0.5, 1, 1.5, 2.5, 4],
    ec='w'
);
```


    
![png](08-MaisViz_files/08-MaisViz_32_0.png)
    


Com base neste histograma, que proporção das 200 músicas mais populares teve menos de meio milhão de streams?

### Exemplo de cálculo

- A altura da barra [0, 0.5) parece ser apenas 1,6.
- A largura da caixa é 0,5 - 0 = 0,5.

- Portanto, usando a fórmula da área de um retângulo,

$$\begin{align}\text{Area} &= \text{Altura} \times \text{Largura} \\ &= 1,6 \times 0,5 \\ e= 0,8
\end{align}$$

- Como as áreas representam proporções, isso significa que a proporção das 200 músicas mais populares com menos de 0,5 milhão de streams foi de aproximadamente 0,8 (ou 80\%).

### Verifique a matemática


```python
#In: 
first_bin = charts[charts.get('million_streams') < 0.5].shape[0]
first_bin
```




    159




```python
#In: 
first_bin/200
```




    0.795



Isso corresponde ao resultado que obtivemos. (Não exatamente, já que fizemos uma estimativa para a altura.)

### Como calcular alturas em um histograma de densidade

Como a barra de um histograma é um retângulo, sua área é dada por

$$\text{Área} = \text{Altura} \times \text{Largura}$$

Que significa

$$\text{Altura} = \frac{\text{Área}}{\text{Largura}} = \frac{\text{Proporção (ou Porcentagem)}}{\text{Largura}}$$

Isso implica que as unidades de altura são "proporção por (unidade $x$-eixo)". O eixo $y$ representa uma espécie de *densidade*, e é por isso que o chamamos de histograma de densidade.




```python
#In: 
charts.plot(kind='hist', y='million_streams', density=True,
            bins=[0, 0.5, 1, 1.5, 2.5, 4],
            ec='w');
plt.ylabel('Densidade')
```




    Text(0, 0.5, 'Densidade')




    
![png](08-MaisViz_files/08-MaisViz_41_1.png)
    


As unidades do eixo $y$ aqui são "proporção por milhão de fluxos", já que o eixo $x$ representa milhões de fluxos.
- Infelizmente, as unidades do eixo $y$ no histograma sempre são exibidas como "Frequência". **Isto está errado!**
- Podemos corrigir com `plt.ylabel(...)`

### Verificação de conceito ✅

Suponha que criamos um histograma de densidade dos tamanhos dos sapatos das pessoas. 👟 Abaixo estão as caixas que escolhemos junto com suas alturas.

| Caixa | Altura da barra |
| --- | --- |
| [3, 7) | 0,05 |
| [7, 10) | 0,1 |
| [10, 12) | 0,15 |
| [12, 16] | $X$ |


Qual deve ser o valor de $X$ para que este seja um histograma válido?

A. 0,02
B. 0,05
C. 0,2
D. 0,5
E. 0.7             


### Gráficos de barras vs. histogramas

Gráfico de barras | Histograma
---|---
Mostra a distribuição de uma variável categórica | Mostra a distribuição de uma variável numérica
1 eixo categórico, 1 eixo numérico | 2 eixos numéricos
As barras têm larguras e espaçamentos arbitrários, mas iguais | O eixo horizontal é numérico e está em escala
Os comprimentos das barras são proporcionais à quantidade numérica de interesse | A altura mede a densidade; as áreas são proporcionais à proporção (porcentagem) de indivíduos

### 🌟 Importante 🌟

Nesta aula, **"histograma" sempre significará um "histograma de densidade".** Usaremos **apenas** histogramas de densidade.

*Nota:* É possível criar o que é chamado de *histograma de frequência* onde o eixo $y$ simplesmente representa uma contagem do número de valores em cada compartimento. Embora sejam mais fáceis de interpretar, os histogramas de frequência não têm a importante propriedade de que a área total é 1, portanto não podem ser conectados à probabilidade da mesma forma que os histogramas de densidade. Isso os torna muito menos úteis para cientistas de dados.

## Gráficos sobrepostos

### Novo conjunto de dados: populações de San Diego e San Jose ao longo do tempo

Os dados para ambas as cidades vêm de [macrotrends.net](https://www.macrotrends.net/cities/23129/san-diego/population).


```python
#In: 
population = pd.read_csv('https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/08-MaisViz/data/sd-sj-2022.csv').set_index('date')
population
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
      <th>Pop SD</th>
      <th>Growth SD</th>
      <th>Pop SJ</th>
      <th>Growth SJ</th>
    </tr>
    <tr>
      <th>date</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1970</th>
      <td>1209000</td>
      <td>3.69</td>
      <td>1009000</td>
      <td>4.34</td>
    </tr>
    <tr>
      <th>1971</th>
      <td>1252000</td>
      <td>3.56</td>
      <td>1027000</td>
      <td>1.78</td>
    </tr>
    <tr>
      <th>1972</th>
      <td>1297000</td>
      <td>3.59</td>
      <td>1046000</td>
      <td>1.85</td>
    </tr>
    <tr>
      <th>1973</th>
      <td>1344000</td>
      <td>3.62</td>
      <td>1064000</td>
      <td>1.72</td>
    </tr>
    <tr>
      <th>1974</th>
      <td>1392000</td>
      <td>3.57</td>
      <td>1084000</td>
      <td>1.88</td>
    </tr>
    <tr>
      <th>1975</th>
      <td>1442000</td>
      <td>3.59</td>
      <td>1103000</td>
      <td>1.75</td>
    </tr>
    <tr>
      <th>1976</th>
      <td>1493000</td>
      <td>3.54</td>
      <td>1123000</td>
      <td>1.81</td>
    </tr>
    <tr>
      <th>1977</th>
      <td>1547000</td>
      <td>3.62</td>
      <td>1143000</td>
      <td>1.78</td>
    </tr>
    <tr>
      <th>1978</th>
      <td>1602000</td>
      <td>3.56</td>
      <td>1163000</td>
      <td>1.75</td>
    </tr>
    <tr>
      <th>1979</th>
      <td>1660000</td>
      <td>3.62</td>
      <td>1184000</td>
      <td>1.81</td>
    </tr>
    <tr>
      <th>1980</th>
      <td>1718000</td>
      <td>3.49</td>
      <td>1204000</td>
      <td>1.69</td>
    </tr>
    <tr>
      <th>1981</th>
      <td>1774000</td>
      <td>3.26</td>
      <td>1221000</td>
      <td>1.41</td>
    </tr>
    <tr>
      <th>1982</th>
      <td>1832000</td>
      <td>3.27</td>
      <td>1237000</td>
      <td>1.31</td>
    </tr>
    <tr>
      <th>1983</th>
      <td>1891000</td>
      <td>3.22</td>
      <td>1254000</td>
      <td>1.37</td>
    </tr>
    <tr>
      <th>1984</th>
      <td>1953000</td>
      <td>3.28</td>
      <td>1271000</td>
      <td>1.36</td>
    </tr>
    <tr>
      <th>1985</th>
      <td>2017000</td>
      <td>3.28</td>
      <td>1288000</td>
      <td>1.34</td>
    </tr>
    <tr>
      <th>1986</th>
      <td>2082000</td>
      <td>3.22</td>
      <td>1305000</td>
      <td>1.32</td>
    </tr>
    <tr>
      <th>1987</th>
      <td>2150000</td>
      <td>3.27</td>
      <td>1323000</td>
      <td>1.38</td>
    </tr>
    <tr>
      <th>1988</th>
      <td>2220000</td>
      <td>3.26</td>
      <td>1341000</td>
      <td>1.36</td>
    </tr>
    <tr>
      <th>1989</th>
      <td>2293000</td>
      <td>3.29</td>
      <td>1359000</td>
      <td>1.34</td>
    </tr>
    <tr>
      <th>1990</th>
      <td>2356000</td>
      <td>2.75</td>
      <td>1376000</td>
      <td>1.25</td>
    </tr>
    <tr>
      <th>1991</th>
      <td>2387000</td>
      <td>1.32</td>
      <td>1392000</td>
      <td>1.16</td>
    </tr>
    <tr>
      <th>1992</th>
      <td>2418000</td>
      <td>1.30</td>
      <td>1408000</td>
      <td>1.15</td>
    </tr>
    <tr>
      <th>1993</th>
      <td>2450000</td>
      <td>1.32</td>
      <td>1424000</td>
      <td>1.14</td>
    </tr>
    <tr>
      <th>1994</th>
      <td>2482000</td>
      <td>1.31</td>
      <td>1441000</td>
      <td>1.19</td>
    </tr>
    <tr>
      <th>1995</th>
      <td>2514000</td>
      <td>1.29</td>
      <td>1457000</td>
      <td>1.11</td>
    </tr>
    <tr>
      <th>1996</th>
      <td>2547000</td>
      <td>1.31</td>
      <td>1474000</td>
      <td>1.17</td>
    </tr>
    <tr>
      <th>1997</th>
      <td>2580000</td>
      <td>1.30</td>
      <td>1491000</td>
      <td>1.15</td>
    </tr>
    <tr>
      <th>1998</th>
      <td>2614000</td>
      <td>1.32</td>
      <td>1508000</td>
      <td>1.14</td>
    </tr>
    <tr>
      <th>1999</th>
      <td>2648000</td>
      <td>1.30</td>
      <td>1525000</td>
      <td>1.13</td>
    </tr>
    <tr>
      <th>2000</th>
      <td>2681000</td>
      <td>1.25</td>
      <td>1541000</td>
      <td>1.05</td>
    </tr>
    <tr>
      <th>2001</th>
      <td>2708000</td>
      <td>1.01</td>
      <td>1554000</td>
      <td>0.84</td>
    </tr>
    <tr>
      <th>2002</th>
      <td>2735000</td>
      <td>1.00</td>
      <td>1566000</td>
      <td>0.77</td>
    </tr>
    <tr>
      <th>2003</th>
      <td>2763000</td>
      <td>1.02</td>
      <td>1578000</td>
      <td>0.77</td>
    </tr>
    <tr>
      <th>2004</th>
      <td>2791000</td>
      <td>1.01</td>
      <td>1591000</td>
      <td>0.82</td>
    </tr>
    <tr>
      <th>2005</th>
      <td>2819000</td>
      <td>1.00</td>
      <td>1603000</td>
      <td>0.75</td>
    </tr>
    <tr>
      <th>2006</th>
      <td>2848000</td>
      <td>1.03</td>
      <td>1616000</td>
      <td>0.81</td>
    </tr>
    <tr>
      <th>2007</th>
      <td>2876000</td>
      <td>0.98</td>
      <td>1629000</td>
      <td>0.80</td>
    </tr>
    <tr>
      <th>2008</th>
      <td>2905000</td>
      <td>1.01</td>
      <td>1642000</td>
      <td>0.80</td>
    </tr>
    <tr>
      <th>2009</th>
      <td>2935000</td>
      <td>1.03</td>
      <td>1655000</td>
      <td>0.79</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>2964000</td>
      <td>0.99</td>
      <td>1668000</td>
      <td>0.79</td>
    </tr>
    <tr>
      <th>2011</th>
      <td>2994000</td>
      <td>1.01</td>
      <td>1681000</td>
      <td>0.78</td>
    </tr>
    <tr>
      <th>2012</th>
      <td>3024000</td>
      <td>1.00</td>
      <td>1694000</td>
      <td>0.77</td>
    </tr>
    <tr>
      <th>2013</th>
      <td>3055000</td>
      <td>1.03</td>
      <td>1708000</td>
      <td>0.83</td>
    </tr>
    <tr>
      <th>2014</th>
      <td>3086000</td>
      <td>1.01</td>
      <td>1721000</td>
      <td>0.76</td>
    </tr>
    <tr>
      <th>2015</th>
      <td>3117000</td>
      <td>1.00</td>
      <td>1735000</td>
      <td>0.81</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>3148000</td>
      <td>0.99</td>
      <td>1749000</td>
      <td>0.81</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>3180000</td>
      <td>1.02</td>
      <td>1762000</td>
      <td>0.74</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>3212000</td>
      <td>1.01</td>
      <td>1776000</td>
      <td>0.79</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>3231000</td>
      <td>0.59</td>
      <td>1783000</td>
      <td>0.39</td>
    </tr>
    <tr>
      <th>2020</th>
      <td>3251000</td>
      <td>0.62</td>
      <td>1791000</td>
      <td>0.45</td>
    </tr>
    <tr>
      <th>2021</th>
      <td>3272000</td>
      <td>0.65</td>
      <td>1799000</td>
      <td>0.45</td>
    </tr>
    <tr>
      <th>2022</th>
      <td>3295000</td>
      <td>0.70</td>
      <td>1809000</td>
      <td>0.56</td>
    </tr>
    <tr>
      <th>2023</th>
      <td>3319000</td>
      <td>0.73</td>
      <td>1821000</td>
      <td>0.66</td>
    </tr>
  </tbody>
</table>
</div>



### Lembre-se: gráficos de linha


```python
#In: 
population.plot(kind='line', y='Growth SD', 
                title='San Diego population growth rate', legend=False);
```


    
![png](08-MaisViz_files/08-MaisViz_51_0.png)
    



```python
#In: 
population.plot(kind='line', y='Growth SJ', 
                title='San Jose population growth rate', legend=False);
```


    
![png](08-MaisViz_files/08-MaisViz_52_0.png)
    


Observe os argumentos opcionais `title` e `legend`. Alguns outros argumentos opcionais úteis são `figsize`, `xlabel` e `ylabel`. Existem [many optional arguments](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.plot.html).

### Gráficos sobrepostos

Se `y=column_name` for omitido, **todas** colunas serão plotadas!


```python
#In: 
population.plot(kind='line');
```


    
![png](08-MaisViz_files/08-MaisViz_55_0.png)
    


Por que existem apenas três linhas mostradas, mas quatro na legenda? 🤔

### Selecionando várias colunas de uma vez
- Para selecionar várias colunas, use `.get([column_1, ..., column_k])`.
- Passar uma `lista` de rótulos de colunas para `.get` retorna um DataFrame.
- `.get([column_name])` retornará um DataFrame com apenas uma coluna!


```python
#In: 
growths = population.get(['Growth SD', 'Growth SJ'])
growths
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
      <th>Growth SD</th>
      <th>Growth SJ</th>
    </tr>
    <tr>
      <th>date</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1970</th>
      <td>3.69</td>
      <td>4.34</td>
    </tr>
    <tr>
      <th>1971</th>
      <td>3.56</td>
      <td>1.78</td>
    </tr>
    <tr>
      <th>1972</th>
      <td>3.59</td>
      <td>1.85</td>
    </tr>
    <tr>
      <th>1973</th>
      <td>3.62</td>
      <td>1.72</td>
    </tr>
    <tr>
      <th>1974</th>
      <td>3.57</td>
      <td>1.88</td>
    </tr>
    <tr>
      <th>1975</th>
      <td>3.59</td>
      <td>1.75</td>
    </tr>
    <tr>
      <th>1976</th>
      <td>3.54</td>
      <td>1.81</td>
    </tr>
    <tr>
      <th>1977</th>
      <td>3.62</td>
      <td>1.78</td>
    </tr>
    <tr>
      <th>1978</th>
      <td>3.56</td>
      <td>1.75</td>
    </tr>
    <tr>
      <th>1979</th>
      <td>3.62</td>
      <td>1.81</td>
    </tr>
    <tr>
      <th>1980</th>
      <td>3.49</td>
      <td>1.69</td>
    </tr>
    <tr>
      <th>1981</th>
      <td>3.26</td>
      <td>1.41</td>
    </tr>
    <tr>
      <th>1982</th>
      <td>3.27</td>
      <td>1.31</td>
    </tr>
    <tr>
      <th>1983</th>
      <td>3.22</td>
      <td>1.37</td>
    </tr>
    <tr>
      <th>1984</th>
      <td>3.28</td>
      <td>1.36</td>
    </tr>
    <tr>
      <th>1985</th>
      <td>3.28</td>
      <td>1.34</td>
    </tr>
    <tr>
      <th>1986</th>
      <td>3.22</td>
      <td>1.32</td>
    </tr>
    <tr>
      <th>1987</th>
      <td>3.27</td>
      <td>1.38</td>
    </tr>
    <tr>
      <th>1988</th>
      <td>3.26</td>
      <td>1.36</td>
    </tr>
    <tr>
      <th>1989</th>
      <td>3.29</td>
      <td>1.34</td>
    </tr>
    <tr>
      <th>1990</th>
      <td>2.75</td>
      <td>1.25</td>
    </tr>
    <tr>
      <th>1991</th>
      <td>1.32</td>
      <td>1.16</td>
    </tr>
    <tr>
      <th>1992</th>
      <td>1.30</td>
      <td>1.15</td>
    </tr>
    <tr>
      <th>1993</th>
      <td>1.32</td>
      <td>1.14</td>
    </tr>
    <tr>
      <th>1994</th>
      <td>1.31</td>
      <td>1.19</td>
    </tr>
    <tr>
      <th>1995</th>
      <td>1.29</td>
      <td>1.11</td>
    </tr>
    <tr>
      <th>1996</th>
      <td>1.31</td>
      <td>1.17</td>
    </tr>
    <tr>
      <th>1997</th>
      <td>1.30</td>
      <td>1.15</td>
    </tr>
    <tr>
      <th>1998</th>
      <td>1.32</td>
      <td>1.14</td>
    </tr>
    <tr>
      <th>1999</th>
      <td>1.30</td>
      <td>1.13</td>
    </tr>
    <tr>
      <th>2000</th>
      <td>1.25</td>
      <td>1.05</td>
    </tr>
    <tr>
      <th>2001</th>
      <td>1.01</td>
      <td>0.84</td>
    </tr>
    <tr>
      <th>2002</th>
      <td>1.00</td>
      <td>0.77</td>
    </tr>
    <tr>
      <th>2003</th>
      <td>1.02</td>
      <td>0.77</td>
    </tr>
    <tr>
      <th>2004</th>
      <td>1.01</td>
      <td>0.82</td>
    </tr>
    <tr>
      <th>2005</th>
      <td>1.00</td>
      <td>0.75</td>
    </tr>
    <tr>
      <th>2006</th>
      <td>1.03</td>
      <td>0.81</td>
    </tr>
    <tr>
      <th>2007</th>
      <td>0.98</td>
      <td>0.80</td>
    </tr>
    <tr>
      <th>2008</th>
      <td>1.01</td>
      <td>0.80</td>
    </tr>
    <tr>
      <th>2009</th>
      <td>1.03</td>
      <td>0.79</td>
    </tr>
    <tr>
      <th>2010</th>
      <td>0.99</td>
      <td>0.79</td>
    </tr>
    <tr>
      <th>2011</th>
      <td>1.01</td>
      <td>0.78</td>
    </tr>
    <tr>
      <th>2012</th>
      <td>1.00</td>
      <td>0.77</td>
    </tr>
    <tr>
      <th>2013</th>
      <td>1.03</td>
      <td>0.83</td>
    </tr>
    <tr>
      <th>2014</th>
      <td>1.01</td>
      <td>0.76</td>
    </tr>
    <tr>
      <th>2015</th>
      <td>1.00</td>
      <td>0.81</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>0.99</td>
      <td>0.81</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>1.02</td>
      <td>0.74</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>1.01</td>
      <td>0.79</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>0.59</td>
      <td>0.39</td>
    </tr>
    <tr>
      <th>2020</th>
      <td>0.62</td>
      <td>0.45</td>
    </tr>
    <tr>
      <th>2021</th>
      <td>0.65</td>
      <td>0.45</td>
    </tr>
    <tr>
      <th>2022</th>
      <td>0.70</td>
      <td>0.56</td>
    </tr>
    <tr>
      <th>2023</th>
      <td>0.73</td>
      <td>0.66</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
growths.plot(kind='line');
```


    
![png](08-MaisViz_files/08-MaisViz_59_0.png)
    


### Para traçar vários gráficos de uma vez:
* `.get` apenas as colunas que contêm informações relevantes para o seu gráfico.
* Equivalentemente, `.drop` todas as colunas estranhas.
* Especifique a coluna para o eixo $x$ (se não for o índice) em `.plot(x=column_name)`.
* Omita o argumento `y`. Então **todas** as outras colunas serão plotadas em um eixo $y$ compartilhado.

A mesma coisa funciona para `'barh'`, `'bar'` e `'hist'`, mas não para `'scatter'`.

### Novo conjunto de dados: alturas das crianças e de seus pais 👪 📏

- Os dados abaixo foram coletados no final de 1800 por [Francis Galton](https://en.wikipedia.org/wiki/Francis_Galton).
- Ele era eugenista e defensor do racismo científico, por isso coletou esses dados.
- Hoje entendemos que a eugenia é imoral e que não há evidências científicas ou qualquer outra justificativa para o racismo.
- Revisitaremos esse conjunto de dados posteriormente no curso.
- Por enquanto, precisaremos apenas das colunas `'mother'` e `'childHeight'`.


```python
#In: 
mother_child = pd.read_csv('https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/08-MaisViz/data/galton.csv').get(['mother', 'childHeight'])
mother_child
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
      <th>mother</th>
      <th>childHeight</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>67.0</td>
      <td>73.2</td>
    </tr>
    <tr>
      <th>1</th>
      <td>67.0</td>
      <td>69.2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>67.0</td>
      <td>69.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>67.0</td>
      <td>69.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>66.5</td>
      <td>73.5</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>929</th>
      <td>66.0</td>
      <td>64.0</td>
    </tr>
    <tr>
      <th>930</th>
      <td>66.0</td>
      <td>62.0</td>
    </tr>
    <tr>
      <th>931</th>
      <td>66.0</td>
      <td>61.0</td>
    </tr>
    <tr>
      <th>932</th>
      <td>63.0</td>
      <td>66.5</td>
    </tr>
    <tr>
      <th>933</th>
      <td>63.0</td>
      <td>57.0</td>
    </tr>
  </tbody>
</table>
<p>934 rows × 2 columns</p>
</div>



### Plotando histogramas sobrepostos

`alpha` controla o quão transparentes as barras são (`alpha=1` é opaco, `alpha=0` é transparente).


```python
#In: 
height_bins = np.arange(55, 80, 2.5)
mother_child.plot(kind='hist', density=True, ec='w',
                  alpha=0.65, bins=height_bins);
```


    
![png](08-MaisViz_files/08-MaisViz_64_0.png)
    


Por que as crianças parecem muito mais altas que as mães?

### Prática Extra

Tente responder a estas perguntas com base no histograma sobreposto.

1. Qual proporção de crianças tinha entre 70 e 75 polegadas de altura?

2. Qual proporção de mães tinha entre 60 e 63 polegadas de altura?

<h3>Respostas</h3>
<details>
<summary>Clique aqui para mostrar.</summary>

<b>Pergunta 1</b>

A altura da barra $[70, 72.5)$ é em torno de $0,08$, o que significa que $0,08 \cdot 2,5 = 0,2$ de crianças tinham altura nesse intervalo. A altura da barra $[70, 72.5)$ é em torno de $0,02$, o que significa $0,02 \cdot 2,5 = 0,05$ de crianças tinham altura nesse intervalo. Assim, a proporção geral de crianças que tinham entre $70$ e $75$ polegadas de altura era de cerca de $0,20 + 0,05 = 0,25$, ou $25\%$.

Para verificar nossa resposta, podemos executar

<code>heights[(heights.get('childHeight') >= 70) & (heights.get('childHeight') < 75)].shape[0] / heights.shape[0]</code>

<b>Pergunta 2</b>

Não podemos dizer. Poderíamos tentar dividir na proporção de mães em $[60, 62.5)$ e $[60, 62.5)$, mas não sabemos o último. Na ausência de qualquer informação adicional, não podemos inferir sobre a distribuição de valores dentro de um compartimento. Por exemplo, pode ser que todos no intervalo $[60, 62.5)$ realmente caiam no intervalo $[60, 62.5)$ - ou pode ser que ninguém caia!

</details>

## Resumo, da próxima vez

### Resumo

- Histogramas (não gráficos de barras!) são usados ​​para exibir a distribuição de uma variável numérica.
- Sempre usaremos histogramas de densidade.
- Em histogramas de densidade, a área de uma barra representa a proporção (porcentagem) de valores dentro de seu compartimento.
- A área total de todas as barras é 1 (100%).
- Podemos sobrepor vários gráficos de linhas, gráficos de barras e histogramas uns sobre os outros para observar vários relacionamentos ou distribuições.

### Próxima vez

- Escrevendo nossas próprias funções.
- Aplicar funções aos dados num DataFrame.
