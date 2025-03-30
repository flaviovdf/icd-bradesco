---
layout: page
title: Merge
nav_order: 09
---
[<img src="https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/colab_favicon_small.png" style="float: right;">](https://colab.research.google.com/github/flaviovdf/icd-bradesco/blob/master/_lessons/09-Mesclando.ipynb)

# Tópico 11 – Merge ou Mesclando
{: .no_toc .mb-2 }

Vamos aprender como juntar duas tabelas diferentes de dados.
{: .fs-6 .fw-300 }

{: .no_toc .text-delta }
Resultados Esperados

1. Uso do merge!

![](https://static.wikia.nocookie.net/dragonball/images/6/60/FusionDanceFinaleGotenTrunksBuuSaga.png)


```python
#In: 
import numpy as np
import pandas as pd
import pandas as pd
```

## Mesclando Dados


```python
#In: 
telefones = pd.DataFrame().assign(
    Modelo=['iPhone 13', 'iPhone 13 Pro Max', 'Samsung Galaxy Z Flip', 'Pixel 5a'],
    Preco=[799, 1099, 999, 449],
    Tela=[6.1, 6.7, 6.7, 6.3]
)

unidades = pd.DataFrame().assign(
    Celular=['iPhone 13 Pro Max', 'iPhone 13', 'Pixel 5a', 'iPhone 13'],
    Unidades=[50, 40, 10, 100],
    Shopping=['Del Rey', 'Savassi', 'Diamond', 'Cidade']
)
```


```python
#In: 
# Preços
telefones
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
      <th>Modelo</th>
      <th>Preco</th>
      <th>Tela</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>iPhone 13</td>
      <td>799</td>
      <td>6.1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>iPhone 13 Pro Max</td>
      <td>1099</td>
      <td>6.7</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Samsung Galaxy Z Flip</td>
      <td>999</td>
      <td>6.7</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Pixel 5a</td>
      <td>449</td>
      <td>6.3</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
# Unidades por shopping
unidades
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
      <th>Celular</th>
      <th>Unidades</th>
      <th>Shopping</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>iPhone 13 Pro Max</td>
      <td>50</td>
      <td>Del Rey</td>
    </tr>
    <tr>
      <th>1</th>
      <td>iPhone 13</td>
      <td>40</td>
      <td>Savassi</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Pixel 5a</td>
      <td>10</td>
      <td>Diamond</td>
    </tr>
    <tr>
      <th>3</th>
      <td>iPhone 13</td>
      <td>100</td>
      <td>Cidade</td>
    </tr>
  </tbody>
</table>
</div>



**Pergunta:** Se eu vender todos os telefones do meu estoque, quanto terei em receita?

### Se eu vender todos os telefones do meu estoque, quanto terei de receita?


```python
#In: 
telefones.merge(unidades, left_on='Modelo', right_on='Celular')
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
      <th>Modelo</th>
      <th>Preco</th>
      <th>Tela</th>
      <th>Celular</th>
      <th>Unidades</th>
      <th>Shopping</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>iPhone 13</td>
      <td>799</td>
      <td>6.1</td>
      <td>iPhone 13</td>
      <td>40</td>
      <td>Savassi</td>
    </tr>
    <tr>
      <th>1</th>
      <td>iPhone 13</td>
      <td>799</td>
      <td>6.1</td>
      <td>iPhone 13</td>
      <td>100</td>
      <td>Cidade</td>
    </tr>
    <tr>
      <th>2</th>
      <td>iPhone 13 Pro Max</td>
      <td>1099</td>
      <td>6.7</td>
      <td>iPhone 13 Pro Max</td>
      <td>50</td>
      <td>Del Rey</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Pixel 5a</td>
      <td>449</td>
      <td>6.3</td>
      <td>Pixel 5a</td>
      <td>10</td>
      <td>Diamond</td>
    </tr>
  </tbody>
</table>
</div>



### O que acabou de acontecer!? 🤯


```python
#In: 
from IPython.display import display, IFrame

def merging_animation():
    src="https://docs.google.com/presentation/d/e/2PACX-1vSk2FfJ4K_An_CQwcN_Yu5unpJckOZjVQDFqZ78ZTTMmowUsCQKKVnum0_m6TaiGquQ44E3FiS9g2Y4/embed?start=false&loop=false&delayms=60000"
    width=825
    height=500
    display(IFrame(src, width, height))
merging_animation()
```



<iframe
    width="825"
    height="500"
    src="https://docs.google.com/presentation/d/e/2PACX-1vSk2FfJ4K_An_CQwcN_Yu5unpJckOZjVQDFqZ78ZTTMmowUsCQKKVnum0_m6TaiGquQ44E3FiS9g2Y4/embed?start=false&loop=false&delayms=60000"
    frameborder="0"
    allowfullscreen

></iframe>



### `.merge`

- Escolha um DataFrame "esquerdo" e "direito".
- Escolha uma coluna de cada uma para "mesclar".
```python
#In: 
left_df.merge(
    right_df, 
    left_on=left_column_name,
    right_on=right_column_name
)
```
- `left_on` e `right_on` devem ser nomes de colunas (não precisam ser iguais).
- O DataFrame resultante contém uma única linha para cada correspondência entre as duas colunas.
- As linhas em qualquer DataFrame sem correspondência desaparecem!

### Se eu vender todos os telefones do meu estoque, quanto terei de receita?

- Mostrar no pandas tutor!


```python
#In: 
merge = telefones.merge(
    unidades,
    left_on='Modelo',
    right_on='Celular'
)
```


```python
#In: 
(merge.get('Preco') * merge.get('Unidades')).sum()
```




    171300



### A ordem importa? 🤔


```python
#In: 
unidades.merge(telefones, left_on='Celular', right_on='Modelo')
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
      <th>Celular</th>
      <th>Unidades</th>
      <th>Shopping</th>
      <th>Modelo</th>
      <th>Preco</th>
      <th>Tela</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>iPhone 13 Pro Max</td>
      <td>50</td>
      <td>Del Rey</td>
      <td>iPhone 13 Pro Max</td>
      <td>1099</td>
      <td>6.7</td>
    </tr>
    <tr>
      <th>1</th>
      <td>iPhone 13</td>
      <td>40</td>
      <td>Savassi</td>
      <td>iPhone 13</td>
      <td>799</td>
      <td>6.1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Pixel 5a</td>
      <td>10</td>
      <td>Diamond</td>
      <td>Pixel 5a</td>
      <td>449</td>
      <td>6.3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>iPhone 13</td>
      <td>100</td>
      <td>Cidade</td>
      <td>iPhone 13</td>
      <td>799</td>
      <td>6.1</td>
    </tr>
  </tbody>
</table>
</div>



**Resposta:** A ordem das linhas e colunas será diferente, mas o conteúdo será o mesmo.

### E se quisermos "mesclar" um índice?

Em vez de usar `left_on` ou `right_on`, use `left_index=True` ou `right_index=True`.


```python
#In: 
telefones
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
      <th>Modelo</th>
      <th>Preco</th>
      <th>Tela</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>iPhone 13</td>
      <td>799</td>
      <td>6.1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>iPhone 13 Pro Max</td>
      <td>1099</td>
      <td>6.7</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Samsung Galaxy Z Flip</td>
      <td>999</td>
      <td>6.7</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Pixel 5a</td>
      <td>449</td>
      <td>6.3</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
unidades_com_index = unidades.set_index('Celular')
unidades_com_index
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
      <th>Unidades</th>
      <th>Shopping</th>
    </tr>
    <tr>
      <th>Celular</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>iPhone 13 Pro Max</th>
      <td>50</td>
      <td>Del Rey</td>
    </tr>
    <tr>
      <th>iPhone 13</th>
      <td>40</td>
      <td>Savassi</td>
    </tr>
    <tr>
      <th>Pixel 5a</th>
      <td>10</td>
      <td>Diamond</td>
    </tr>
    <tr>
      <th>iPhone 13</th>
      <td>100</td>
      <td>Cidade</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
telefones.merge(
    unidades_com_index,
    left_on='Modelo',
    right_index=True
)
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
      <th>Modelo</th>
      <th>Preco</th>
      <th>Tela</th>
      <th>Unidades</th>
      <th>Shopping</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>iPhone 13</td>
      <td>799</td>
      <td>6.1</td>
      <td>40</td>
      <td>Savassi</td>
    </tr>
    <tr>
      <th>0</th>
      <td>iPhone 13</td>
      <td>799</td>
      <td>6.1</td>
      <td>100</td>
      <td>Cidade</td>
    </tr>
    <tr>
      <th>1</th>
      <td>iPhone 13 Pro Max</td>
      <td>1099</td>
      <td>6.7</td>
      <td>50</td>
      <td>Del Rey</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Pixel 5a</td>
      <td>449</td>
      <td>6.3</td>
      <td>10</td>
      <td>Diamond</td>
    </tr>
  </tbody>
</table>
</div>



### Configuração de atividade


```python
#In: 
nice_weather_cities = pd.DataFrame().assign(
    city=['La Jolla', 'San Diego', 'Austin', 'Los Angeles'],
    state=['California', 'California', 'Texas', 'California'],
    today_high_temp=['79', '83', '87', '87']
    
)

schools = pd.DataFrame().assign(
    name=['UCSD', 'University of Chicago', 'University of San Diego','Johns Hopkins University', 'UT Austin', 'SDSU', 'UCLA'], 
    city=['La Jolla', 'Chicago', 'San Diego', 'Baltimore', 'Austin', 'San Diego', 'Los Angeles'],
    state=['California', 'Illinois', 'California', 'Maryland', 'Texas', 'California', 'California'],
    graduation_rate=[0.87, 0.94, 0.78, 0.92, 0.81, 0.83, 0.91 ]
)
```

### Verificação de conceito ✅

**Sem escrever código**, quantas linhas existem em `nice_weather_cities.merge(schools, on='city')`?

- A. 4
- B. 5
- C. 6
- D. 7
- E. 8


```python
#In: 
nice_weather_cities
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
      <th>city</th>
      <th>state</th>
      <th>today_high_temp</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>La Jolla</td>
      <td>California</td>
      <td>79</td>
    </tr>
    <tr>
      <th>1</th>
      <td>San Diego</td>
      <td>California</td>
      <td>83</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Austin</td>
      <td>Texas</td>
      <td>87</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Los Angeles</td>
      <td>California</td>
      <td>87</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
schools
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
      <th>name</th>
      <th>city</th>
      <th>state</th>
      <th>graduation_rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>UCSD</td>
      <td>La Jolla</td>
      <td>California</td>
      <td>0.87</td>
    </tr>
    <tr>
      <th>1</th>
      <td>University of Chicago</td>
      <td>Chicago</td>
      <td>Illinois</td>
      <td>0.94</td>
    </tr>
    <tr>
      <th>2</th>
      <td>University of San Diego</td>
      <td>San Diego</td>
      <td>California</td>
      <td>0.78</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Johns Hopkins University</td>
      <td>Baltimore</td>
      <td>Maryland</td>
      <td>0.92</td>
    </tr>
    <tr>
      <th>4</th>
      <td>UT Austin</td>
      <td>Austin</td>
      <td>Texas</td>
      <td>0.81</td>
    </tr>
    <tr>
      <th>5</th>
      <td>SDSU</td>
      <td>San Diego</td>
      <td>California</td>
      <td>0.83</td>
    </tr>
    <tr>
      <th>6</th>
      <td>UCLA</td>
      <td>Los Angeles</td>
      <td>California</td>
      <td>0.91</td>
    </tr>
  </tbody>
</table>
</div>



### Atividade de acompanhamento

**Sem escrever código**, quantas linhas existem em `nice_weather_cities.merge(schools, on='state')`?


```python
#In: 
nice_weather_cities.merge(schools, on='state')
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
      <th>city_x</th>
      <th>state</th>
      <th>today_high_temp</th>
      <th>name</th>
      <th>city_y</th>
      <th>graduation_rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>La Jolla</td>
      <td>California</td>
      <td>79</td>
      <td>UCSD</td>
      <td>La Jolla</td>
      <td>0.87</td>
    </tr>
    <tr>
      <th>1</th>
      <td>La Jolla</td>
      <td>California</td>
      <td>79</td>
      <td>University of San Diego</td>
      <td>San Diego</td>
      <td>0.78</td>
    </tr>
    <tr>
      <th>2</th>
      <td>La Jolla</td>
      <td>California</td>
      <td>79</td>
      <td>SDSU</td>
      <td>San Diego</td>
      <td>0.83</td>
    </tr>
    <tr>
      <th>3</th>
      <td>La Jolla</td>
      <td>California</td>
      <td>79</td>
      <td>UCLA</td>
      <td>Los Angeles</td>
      <td>0.91</td>
    </tr>
    <tr>
      <th>4</th>
      <td>San Diego</td>
      <td>California</td>
      <td>83</td>
      <td>UCSD</td>
      <td>La Jolla</td>
      <td>0.87</td>
    </tr>
    <tr>
      <th>5</th>
      <td>San Diego</td>
      <td>California</td>
      <td>83</td>
      <td>University of San Diego</td>
      <td>San Diego</td>
      <td>0.78</td>
    </tr>
    <tr>
      <th>6</th>
      <td>San Diego</td>
      <td>California</td>
      <td>83</td>
      <td>SDSU</td>
      <td>San Diego</td>
      <td>0.83</td>
    </tr>
    <tr>
      <th>7</th>
      <td>San Diego</td>
      <td>California</td>
      <td>83</td>
      <td>UCLA</td>
      <td>Los Angeles</td>
      <td>0.91</td>
    </tr>
    <tr>
      <th>8</th>
      <td>Austin</td>
      <td>Texas</td>
      <td>87</td>
      <td>UT Austin</td>
      <td>Austin</td>
      <td>0.81</td>
    </tr>
    <tr>
      <th>9</th>
      <td>Los Angeles</td>
      <td>California</td>
      <td>87</td>
      <td>UCSD</td>
      <td>La Jolla</td>
      <td>0.87</td>
    </tr>
    <tr>
      <th>10</th>
      <td>Los Angeles</td>
      <td>California</td>
      <td>87</td>
      <td>University of San Diego</td>
      <td>San Diego</td>
      <td>0.78</td>
    </tr>
    <tr>
      <th>11</th>
      <td>Los Angeles</td>
      <td>California</td>
      <td>87</td>
      <td>SDSU</td>
      <td>San Diego</td>
      <td>0.83</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Los Angeles</td>
      <td>California</td>
      <td>87</td>
      <td>UCLA</td>
      <td>Los Angeles</td>
      <td>0.91</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
nice_weather_cities.merge(schools, on='state').shape[0]
```




    13



## Resumo, da próxima vez

### Resumo

- Para criar grupos dentro de um grupo, passe uma lista para `.groupby`.
- O resultado possui uma linha para cada combinação única de elementos nas colunas especificadas.
- Para combinar informações de vários DataFrames, use `.merge`.
- Ao usar `.merge`, Python procura uma correspondência entre uma coluna especificada em cada DataFrame e combina as linhas com uma correspondência.
- Se não houver correspondências, a linha desaparece!
