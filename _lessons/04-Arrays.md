---
layout: page
title: Strings e Arrays
nav_order: 4
---
[<img src="https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/colab_favicon_small.png" style="float: right;">](https://colab.research.google.com/github/flaviovdf/icd-bradesco/blob/master/_lessons/04-Arrays.ipynb)

# Tópico 4 - Strings e Arrays
{: .no_toc .mb-2 }

Vetores (Arrays) representam um conjunto básico de dados. Vamos aprender como usar os mesmos.
{: .fs-6 .fw-300 }

{: .no_toc .text-delta }
Resultados Esperados

1. Entender tipos em Python, em particular a String
1. Saber o que é a biblioteca [numpy](https://numpy.org/)
1. Conhecimento básico de manipulação de arrays

### Recursos 🤝

- Estamos cobrindo **muito** conteúdo muito rapidamente. Se você está sobrecarregado, saiba que estamos aqui para apoiá-lo!
- Os monitores foram definidos. Olhem a mensagem no moodle.
- Procurem o professor depois da aula!

### Agenda

- Strings
- Listas.
- Matrizes.
- Intervalos.

## Strings ou Texto

### Strings

- Uma string é um trecho de texto de qualquer comprimento.
- Em Python, as strings são colocadas entre aspas simples ou duplas.


```python
#In: 
'woof'
```




    'woof'




```python
#In: 
type('woof')
```




    str




```python
#In: 
"woof"
```




    'woof'




```python
#In: 
# A string, not an int!
"1998"
```




    '1998'



### Aritmética de strings

Ao usar o símbolo `+` entre duas strings, a operação é chamada de "concatenação".


```python
#In: 
s1 = 'baby'
s2 = '🐼'
```


```python
#In: 
s1 + s2
```




    'baby🐼'




```python
#In: 
s1 + ' ' + s2
```




    'baby 🐼'




```python
#In: 
s2 * 3
```




    '🐼🐼🐼'



### Métodos de string
* Strings estão associadas a certas funções chamadas **métodos de string**.
* Acesse métodos de string com um `.` após a string ("notação de ponto").
* Por exemplo, para usar o método `upper` na string `s`, escrevemos `s.upper()`.
* Exemplos incluem `upper`, `title` e `replace`.


```python
#In: 
my_cool_string = 'data science is super cool!'
```


```python
#In: 
my_cool_string.title()
```




    'Data Science Is Super Cool!'




```python
#In: 
my_cool_string.upper()
```




    'DATA SCIENCE IS SUPER COOL!'




```python
#In: 
my_cool_string.replace('super cool', '💯' * 3)
```




    'data science is 💯💯💯!'




```python
#In: 
# len is not a method, since it doesn't use dot notation
len(my_cool_string)
```




    27



### Caracteres especiais em strings

Aspas simples e aspas duplas geralmente são intercambiáveis, exceto quando a própria string contém aspas simples ou duplas.


```python
#In: 
# a linha abaixo gera um erro, descomente e teste
# 'my string's full of apostrophes!'
```


```python
#In: 
"my string's full of apostrophes!"
```




    "my string's full of apostrophes!"




```python
#In: 
# escape the apostrophe with a backslash!
'my string\'s "full" of apostrophes!'
```




    'my string\'s "full" of apostrophes!'




```python
#In: 
print('my string\'s "full" of apostrophes!')
```

    my string's "full" of apostrophes!


### Além: `print`
- Por padrão, os notebooks Jupyter exibem o valor "bruto" da expressão da última linha de uma célula.
- A função `print` exibe o valor em texto legível quando é avaliado.


```python
#In: 
12 # 12 won't be displayed, since Python only shows the value of the last expression
23
```




    23




```python
#In: 
# Note, there is no Out[number] to the left! That only appears when displaying a non-printed value.
# But both 12 and 23 are displayed.
print(12)
print(23)
```

    12
    23



```python
#In: 
# '\n' inserts a new line
my_newline_str = 'here is a string with two lines.\nhere is the second line'  
my_newline_str
```




    'here is a string with two lines.\nhere is the second line'




```python
#In: 
# The quotes disappeared and the newline is rendered!
print(my_newline_str)  
```

    here is a string with two lines.
    here is the second line


### Conversão de tipo de e para strings
* Qualquer valor pode ser convertido em uma string usando ```str```.
* Algumas strings podem ser convertidas para ```int``` e ```float```.


```python
#In: 
str(3)
```




    '3'




```python
#In: 
float('3')
```




    3.0




```python
#In: 
int('4')
```




    4




```python
#In: 
int('baby panda')
```


    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    Cell In[25], line 1
    ----> 1 int('baby panda')


    ValueError: invalid literal for int() with base 10: 'baby panda'


### Verificação de conceito ✅

Suponha que você executou as seguintes instruções:

```py
x = 3
y = '4'
z = '5.6'
```

Escolha a expressão que será avaliada **sem** erro.

R. `x + y`

B. `x + int(y + z)`

C.`str(x) + int(y)`

D. `str (x) + z`

E. Todos eles têm erros

## Listas

### Motivação

Como armazenaríamos as temperaturas de cada um dos primeiros 6 dias do mês de setembro?

Nossa melhor solução agora é criar uma variável separada para cada dia.


```python
#In: 
temperature_on_sept_01 = 84
temperature_on_sept_02 = 78
temperature_on_sept_03 = 81
temperature_on_sept_04 = 75
temperature_on_sept_05 = 79
temperature_on_sept_06 = 75
```

Isso _tecnicamente_ nos permite fazer coisas como calcular a temperatura média durante os primeiros 6 dias:

```
avg_temperature = 1/6 * (
    temperature_on_sept_01
    + temperature_on_sept_02
    + temperature_on_sept_03
    + ...)
```

Imagine os dados de um mês inteiro ou os dados de um ano inteiro. Parece que precisamos de uma solução melhor.


### Listas em Python

Em Python, uma lista é usada para armazenar vários valores em um único valor/variável. Para criar uma nova lista do zero, usamos `[`colchetes`]`.



```python
#In: 
temperature_list = [84, 78, 81, 75, 79, 75]
```


```python
#In: 
len(temperature_list)
```




    6



Observe que os elementos de uma lista não precisam ser únicos!

### As listas facilitam o trabalho com sequências!

Para encontrar a temperatura média, basta dividir a **soma das temperaturas** pelo **número de temperaturas registradas**:


```python
#In: 
temperature_list
```




    [84, 78, 81, 75, 79, 75]




```python
#In: 
sum(temperature_list) / len(temperature_list)
```




    78.66666666666667



### Tipos

O `tipo` de uma lista é... `lista`.


```python
#In: 
temperature_list
```




    [84, 78, 81, 75, 79, 75]




```python
#In: 
type(temperature_list)
```




    list



Dentro de uma lista, você pode armazenar elementos de diferentes tipos.


```python
#In: 
mixed_list = [-2, 2.5, 'ucsd', [1, 3]]
mixed_list
```




    [-2, 2.5, 'ucsd', [1, 3]]



### Há um problema...

- As listas são **muito lentas**.
- Isso não é grande coisa quando não há muitas entradas, mas é um grande problema quando há milhões ou bilhões de entradas.

## Matrizes

### NumPy

<center>
<img src='https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/04-Arrays/numpy.png' width=400>
</center>

- NumPy (pronuncia-se "num pie") é uma biblioteca (módulo) Python que fornece suporte para **arrays** e operações neles.

- A biblioteca `babypandas`, sobre a qual você aprenderá no próximo tópico, anda de mãos dadas com o NumPy.
- NumPy é muito usado no mundo real.

- Para usar `numpy`, precisamos importá-lo. Geralmente é importado como `np` (mas não precisa ser!)


```python
#In: 
import numpy as np
```

### Matrizes

Pense nos arrays NumPy (apenas "arrays" de agora em diante) como listas sofisticadas e mais rápidas.

<center><img src="https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/04-Arrays/squid.png" width=30%></center>

Para criar um array, passamos uma lista como entrada para a função `np.array`.


```python
#In: 
np.array([4, 9, 1, 2])
```




    array([4, 9, 1, 2])



<center>
<img src='https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/04-Arrays/brackets.png' width=50%>
</center>


```python
#In: 
temperature_array = np.array([84, 78, 81, 75, 79, 75])
temperature_array
```




    array([84, 78, 81, 75, 79, 75])




```python
#In: 
temperature_list
```




    [84, 78, 81, 75, 79, 75]




```python
#In: 
# No square brackets, because temperature_list is already a list!
np.array(temperature_list)
```




    array([84, 78, 81, 75, 79, 75])



### Posições

Quando as pessoas ficam em fila, cada pessoa tem uma posição.

<center><img src="https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/04-Arrays/position.png" width=50%></center>

Da mesma forma, cada elemento de um array (e lista) possui uma posição.

### Acessando elementos por posição

- Python, como a maioria das linguagens de programação, é "indexado em 0".
- Isso significa que a posição do primeiro elemento em uma matriz é 0, não 1.
- Um motivo: a posição de um elemento representa o número de elementos à sua frente.
- Para acessar o elemento do array `arr_name` na posição `pos`, usamos a sintaxe `arr_name[pos]`.


```python
#In: 
temperature_array
```




    array([84, 78, 81, 75, 79, 75])




```python
#In: 
temperature_array[0]
```




    84




```python
#In: 
temperature_array[1]
```




    78




```python
#In: 
temperature_array[3]
```




    75




```python
#In: 
# Access last element
temperature_array[5]
```




    75




```python
#In: 
temperature_array[6]
```


    ---------------------------------------------------------------------------

    IndexError                                Traceback (most recent call last)

    Cell In[44], line 1
    ----> 1 temperature_array[6]


    IndexError: index 6 is out of bounds for axis 0 with size 6



```python
#In: 
# If a position is negative, count from the end!
temperature_array[-1]
```




    75



### Tipos

Anteriormente nesta palestra, vimos que as listas podem armazenar elementos de vários tipos.


```python
#In: 
nums_and_strings_lst = ['uc', 'sd', 1961, 3.14]
nums_and_strings_lst
```




    ['uc', 'sd', 1961, 3.14]



**Isso não é verdade para arrays – todos os elementos de um array devem ser do mesmo tipo.**


```python
#In: 
# All elements are converted to strings!
np.array(nums_and_strings_lst)
```




    array(['uc', 'sd', '1961', '3.14'], dtype='<U32')



### Aritmética de números de array

As matrizes facilitam a execução da mesma operação em todos os elementos. Este comportamento é formalmente conhecido como "transmissão".


```python
#In: 
temperature_array
```




    array([84, 78, 81, 75, 79, 75])




```python
#In: 
# Increase all temperatures by 3 degrees
temperature_array + 3
```




    array([87, 81, 84, 78, 82, 78])




```python
#In: 
# Halve all temperatures
temperature_array / 2
```




    array([42. , 39. , 40.5, 37.5, 39.5, 37.5])




```python
#In: 
# Convert all temperatures to Celsius
(5 / 9) * (temperature_array - 32)
```




    array([28.88888889, 25.55555556, 27.22222222, 23.88888889, 26.11111111,
           23.88888889])



**Nota:** Em nenhuma das células acima modificamos `temperature_array`! Cada uma dessas expressões criou um novo array.


```python
#In: 
temperature_array
```




    array([84, 78, 81, 75, 79, 75])



Para realmente alterar `temperature_array`, precisamos reatribuí-lo a um novo array.


```python
#In: 
temperature_array = (5 / 9) * (temperature_array - 32)
```


```python
#In: 
# Now in Celsius!
temperature_array
```




    array([28.88888889, 25.55555556, 27.22222222, 23.88888889, 26.11111111,
           23.88888889])



### Aritmética elemento a elemento

- Podemos aplicar operações aritméticas a múltiplos arrays, desde que tenham o mesmo comprimento.
- O resultado é calculado **por elemento**, o que significa que a operação aritmética é aplicada a um par de elementos de cada array por vez.
- Por exemplo, `a + b` é um array cujo primeiro elemento é a soma do primeiro elemento de `a` e do primeiro elemento de `b`.


```python
#In: 
a = np.array([1, 2, 3])
b = np.array([-4, 5, 9])
```


```python
#In: 
a + b
```




    array([-3,  7, 12])




```python
#In: 
a / b
```




    array([-0.25      ,  0.4       ,  0.33333333])




```python
#In: 
a ** 2 + b ** 2
```




    array([17, 29, 90])



### Exemplo: visualizações do TikTok 🎬

Baby Panda fez uma série de cinco vídeos no TikTok chamada "Um dia na vida de um mascote da ciência de dados". O número de visualizações que eles receberam nesses vídeos é armazenado na matriz `views` abaixo.


```python
#In: 
views = np.array([158, 352, 195, 1423916, 46])
```

Algumas perguntas:

Qual foi a contagem média de visualizações?


```python
#In: 
views
```




    array([    158,     352,     195, 1423916,      46])




```python
#In: 
sum(views) / len(views)
```




    284933.4




```python
#In: 
# The mean method exists for arrays (but not for lists)
views.mean()
```




    284933.4



Quantas visualizações seus vídeos mais e menos populares receberam?


```python
#In: 
views
```




    array([    158,     352,     195, 1423916,      46])




```python
#In: 
views.max()
```




    1423916




```python
#In: 
views.min()
```




    46



Quantas visualizações **acima da média** cada um dos vídeos recebeu? Quantas visualizações acima da média o vídeo mais visto recebeu?


```python
#In: 
views
```




    array([    158,     352,     195, 1423916,      46])




```python
#In: 
views - views.mean()
```




    array([-284775.4, -284581.4, -284738.4, 1138982.6, -284887.4])




```python
#In: 
(views - views.mean()).max()
```




    1138982.6



Foi [estimated](https://www.ngpf.org/blog/question-of-the-day/question-of-the-day-how-much-can-a-creator-on-tiktok-make-if-their-video-receives-1-million-views/) que o TikTok paga aos seus criadores \\$0,03 por 1000 visualizações. Se isso for verdade, quantos dólares o Bebê Panda ganhou com seu vídeo mais visto? 💸


```python
#In: 
views
```




    array([    158,     352,     195, 1423916,      46])




```python
#In: 
views.max() * 0.03 / 1000
```




    42.717479999999995



## Gamas

### Motivação

Muitas vezes precisamos criar arrays como este:


```python
#In: 
days_in_september = np.array([
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 
    13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 
    23, 24, 25, 26, 27, 28, 29, 30
])
```

Precisa haver uma maneira mais fácil de fazer isso!

### Intervalos
* Um **intervalo** é uma matriz de números espaçados uniformemente. Criamos intervalos usando `np.arange`.
* A maneira mais geral de criar um intervalo é `np.arange(start, end, step)`. Isso retorna uma matriz tal que:
- O primeiro número é `start`. **Por padrão, `iniciar` é 0.**
- Todos os números subsequentes são espaçados por `step`, até (mas excluindo) `end`. **Por padrão, `step` é 1.**


```python
#In: 
# Start at 0, end before 8, step by 1
# This will be our most common use-case!
np.arange(8)
```




    array([0, 1, 2, 3, 4, 5, 6, 7])




```python
#In: 
# Start at 5, end before 10, step by 1
np.arange(5, 10)
```




    array([5, 6, 7, 8, 9])




```python
#In: 
# Start at 3, end before 32, step by 5
np.arange(3, 32, 5)
```




    array([ 3,  8, 13, 18, 23, 28])




```python
#In: 
# Steps can be fractional!
np.arange(-3, 2, 0.5)
```




    array([-3. , -2.5, -2. , -1.5, -1. , -0.5,  0. ,  0.5,  1. ,  1.5])




```python
#In: 
# If step is negative, we count backwards.
np.arange(1, -10, -3)
```




    array([ 1, -2, -5, -8])



### Atividade

🎉 Parabéns! 🎉 Você ganhou na loteria 💰. Veja como funciona o seu pagamento: no primeiro dia de setembro, você receberá 0,01. A cada dia seguinte, seu salário dobra, então no segundo dia você recebe 0,02, no terceiro dia você recebe 0,04, no quarto dia você recebe 0,08 e assim por diante.

Setembro tem 30 dias.

Escreva uma **expressão de uma linha** que use os números `2` e `30`, junto com a função `np.arange` e o método `.sum()`, que calcula o valor total **em dólares** você será pago em setembro.


```python
#In: 
...
```




    Ellipsis



## Resumo, da próxima vez

### Resumo

- Strings são usadas para armazenar texto. Coloque-os entre aspas simples ou duplas.
- Listas e arrays são usados ​​para armazenar **sequências**.
- Matrizes são mais rápidas e convenientes para operações numéricas.
- Você pode executar facilmente operações numéricas em todos os elementos de um array e realizar operações em vários arrays.
- Os intervalos são matrizes de números igualmente espaçados.
- Lembre-se de consultar os recursos desde o início da palestra!

### Próxima vez

Aprenderemos como usar Python para trabalhar com dados tabulares do mundo real.
