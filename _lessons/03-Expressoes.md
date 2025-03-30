---
layout: page
title: Expressões
nav_order: 3
---
[<img src="https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/colab_favicon_small.png" style="float: right;">](https://colab.research.google.com/github/flaviovdf/icd-bradesco/blob/master/_lessons/03-Expressoes.ipynb)

# Tópico 3 - Expressões
{: .no_toc .mb-2 }

Primeiros passos em Python.
{: .fs-6 .fw-300 }

{: .no_toc .text-delta }
Resultados Esperados

1. Saber o que é um notebook e um arquivo `.py`
1. Saber realizar matemática simples em python
1. Entender as ferramentas base da ciência de dados



```python
#In: 
# Ignore este código, porém execute o mesmo

from IPython.display import IFrame
def show_nested_eval():
    src = 'https://docs.google.com/presentation/d/e/2PACX-1vQpW0NzwT3LjZsIIDAgtSMRM1cl41Gp_Lf8k9GT-gm5sGAIynw4rsgiEFbIybClD6QtxarKaVKLbR9U/embed?start=false&loop=false&delayms=60000" frameborder="0" width="960" height="569" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"'
    width = 960
    height = 569
    return IFrame(src, width, height)
```

### Agenda

- O que é código? O que são notebooks Jupyter?
- Expressões.
- Variáveis.
- Expressões de chamada.
- Tipos de dados.

Muita programação – acompanhe no notebook clicando no link do Collab acima!

## O que é código? O que são notebooks Jupyter? 💻

### O que é código?

- As instruções para computadores são escritas em **linguagens de programação** e são chamadas de **código**.
- “Programas de computador” nada mais são do que **receitas**: escrevemos programas que dizem ao computador exatamente o que fazer, e ele faz exatamente isso – nada mais e nada menos.

### Por que Python?

<center>
<img src='https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/03-Expressoes/images/languages.jpg' width=400>
</center>

- Popular.
- Variedade de usos.
- Desenvolvimento web.
- Ciência de dados e aprendizado de máquina.
- Não é realmente usado para desenvolvimento de aplicativos.
- Fácil de mergulhar!

### Notebooks Jupyter 📓

- Frequentemente, mas não nesta classe, o código é escrito em um editor de texto e depois executado em uma interface de linha de comando.

<center>
<img src='https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/03-Expressoes/images/terminal.png' width=800>
</center>

- **Jupyter Notebooks** nos permite escrever e executar código em um único documento. Eles também nos permitem incorporar texto e código. **Usaremos Jupyter Notebooks durante todo o trimestre**.

## Expressões

### Python como calculadora

- Uma **expressão** é uma combinação de valores, operadores e funções que **avalia** algum **valor**.

- Por enquanto, vamos pensar no Python como uma calculadora – ele pega expressões e as avalia.

- Inseriremos nossas expressões em **células de código**. Para executar uma célula de código:
- **Pressione `shift` + `enter` (ou `shift` + `return`) no teclado (de preferência)**, ou
- Pressione o botão "▶ Executar" na barra de ferramentas.


```python
#In: 
17
```




    17




```python
#In: 
-1 + 3.14
```




    2.14




```python
#In: 
2 ** 3
```




    8




```python
#In: 
(17 - 14) / 2
```




    1.5




```python
#In: 
# Only one value is displayed. Why?
3 * 4
5
```




    5



### Operaçoes aritimeticas

| Operação | Operador | Exemplo | Valor |
| --- | --- | --- | --- |
| Adição | `+` | `2 + 3` | `5` |
| Subtração | `-` | `2 - 3` | `-1` |
| Multiplicação | `*` | `2 * 3` | `6` |
| Divisão | `/` | `7/3` | `2.66667` |
| Restante | `%` | `7% 3` | `1` |
| Exponenciação | `**` | `2 ** 0,5` | `1.41421` |

### Python usa a ordem típica de operações – PEMDAS (BEDMAS? 🛏️)


```python
#In: 
3 * 2 ** 2
```




    12




```python
#In: 
(3 * 2) ** 2
```




    36



### Atividade

Na célula abaixo, substitua as reticências por uma expressão equivalente a

$$(19 + 6 \cdot 3) - 15 \cdot \left(\sqrt{100} \cdot \frac{1}{30}\right) \cdot \frac{3}{5} + \frac{4 ^2}{2^3} + \left( 6 - \frac{2}{3} \right) \cdot 12 $$

Tente usar parênteses somente quando necessário.


```python
#In: 
...
```




    Ellipsis



## Variáveis

### Motivação

Abaixo, calculamos o número de segundos em um ano.


```python
#In: 
60 * 60 * 24 * 365
```




    31536000



Se quisermos utilizar o valor acima mais tarde no nosso bloco de notas para determinar, digamos, o número de segundos em 12 anos, teremos de copiar e colar a expressão. **Isso é inconveniente e propenso a introduzir erros.**


```python
#In: 
60 * 60 * 24 * 365 * 12
```




    378432000



Seria ótimo se pudéssemos **armazenar** o valor inicial e consultá-lo mais tarde!

### Variáveis ​​e instruções de atribuição

- Uma **variável** é um local para armazenar um valor para que possa ser consultado posteriormente em nosso código. Para definir uma variável, usamos uma **instrução de atribuição**.

$$ \overbrace{\texttt{minhavariável}}^{\text{nome}} = \overbrace{\texttt{2 + 3}}^{\text{qualquer expressão}} $$

- Uma instrução de atribuição altera o significado do **nome** à esquerda do símbolo `=`.

- A expressão do lado direito do símbolo `=` é avaliada antes de ser atribuída ao nome do lado esquerdo.
* por exemplo. `myvariable` está vinculado a `5` (valor) e não a `2 + 3` (expressão).

Observe que antes de usá-lo em uma instrução de atribuição, `more_than_1` não tem significado.


```python
#In: 
# Descomente e execute
# more_than_1
```

Depois de usá-lo em uma instrução de atribuição, podemos perguntar ao Python seu valor.


```python
#In: 
# Note that an assignment statement doesn't output anything!
more_than_1 = 15 - 5
```


```python
#In: 
more_than_1
```




    10



Sempre que usamos `more_than_1` em uma expressão, `10` é substituído por `10`.


```python
#In: 
more_than_1 * 2
```




    20



Observe que a expressão acima **não alterou** o valor de `more_than_1`, porque **não reatribuímos `more_than_1`**!


```python
#In: 
more_than_1
```




    10



### Nomeando variáveis

- Geralmente, dê nomes úteis às suas variáveis ​​para que você saiba a que elas se referem.
- Os nomes das variáveis ​​podem conter caracteres maiúsculos e minúsculos, dígitos de 0 a 9 e sublinhados.
- Eles não podem começar com um número.
- Eles diferenciam maiúsculas de minúsculas!

As instruções de atribuição a seguir são **válidas**, mas usam nomes de variáveis ​​**ruins** 😕.


```python
#In: 
six = 15
```


```python
#In: 
i_45love_chocolate_9999 = 60 * 60 * 24 * 365
```

As instruções de atribuição a seguir são **válidas** e usam nomes de variáveis ​​**bons** ✅.


```python
#In: 
seconds_per_hour = 60 * 60
hours_per_year = 24 * 365
seconds_per_year = seconds_per_hour * hours_per_year
```

As seguintes "declarações de atribuição" são **inválidas ❌**.


```python
#In: 
# Descomente e execute
# 6 = 15
```


```python
#In: 
# Descomente e execute
# 3 = 2 + 1
```

### Declarações de atribuição não são equações matemáticas!

- Ao contrário da matemática, onde $x = 3$ significa a mesma coisa que $3 = x$, as instruções de atribuição **não** são "simétricas".
- Uma instrução de atribuição atribui (ou "liga") o nome à esquerda de `=` ao valor à direita de `=`, nada mais.


```python
#In: 
x = 3
x
```




    3




```python
#In: 
# Descomente e execute
# 4 = x
```

### O valor de uma variável é definido no momento da atribuição


```python
#In: 
uc = 2
sd = 3 + uc
```

As declarações de atribuição não são **promessas** – o valor de uma variável pode mudar!


```python
#In: 
uc = 7
```

Observe que mesmo depois de alterar `uc`, não alteramos `sd`, então ainda é o mesmo de antes.


```python
#In: 
sd
```




    5



### Uma analogia útil

<center>
<img src='https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/03-Expressoes/images/box.png' width=600>
</center>

- Uma metáfora comum é que as variáveis ​​são como caixas ou contêineres ([source](https://www.tomasbeuzen.com/python-programming-for-data-science/chapters/chapter1-basics.html)).
- Outra analogia: uma declaração de atribuição é como colocar um adesivo em um valor.

### Verificação de conceito ✅

Suponha que você executou as três linhas de código a seguir:

```py
side_length = 5
area = side_length ** 2
side_length = side_length + 2
```

Quais são os valores de `side_length` e `area` após a execução?

A. `comprimento_lateral = 5`, `área = 25`

B. `comprimento_lateral = 5`, `área = 49`

C. `comprimento_lateral = 7`, `área = 25`

D. `comprimento_lateral = 7`, `área = 49`

E. Nenhuma das opções acima

## Expressões de chamada 📞

### Funções algébricas

- Em matemática, as funções recebem alguma entrada e retornam alguma saída.

$$f(x, y) = 2x^2 + 3xy - 1$$

- Podemos determinar a saída de uma função mesmo se passarmos coisas complicadas.

$$f\left(\frac{1+2}{3+4}, (-1)^{15}\right)$$

### Expressões de chamada

* **Expressões de chamada** em Python invocam funções – elas dizem a uma função para "executar sua receita".
* As funções em Python funcionam da mesma forma que as funções em matemática.
* As entradas para funções são chamadas de **argumentos**.


```python
#In: 
abs(-12)
```




    12



### Algumas funções podem receber um número variável de argumentos


```python
#In: 
max(3, -4)
```




    3




```python
#In: 
max(2, -3, -6, 10, -4)
```




    10




```python
#In: 
# Only two arguments!
max(4 + 5, 5 - 4)
```




    9



### Use ```?``` depois de uma função para ver a documentação de uma função
Ou use a função `help`, por ex. `ajuda(máx.)`.


```python
#In: 
max?
```

### Exemplo: `round`


```python
#In: 
my_number = 1.22
round(my_number)
```




    1




```python
#In: 
round?
```


```python
#In: 
round(1.22222, 3)
```




    1.222



### Avaliação aninhada

Podemos **aninhar** muitas chamadas de função para avaliar expressões sofisticadas.


```python
#In: 
min(abs(max(-1, -2, -3, min(4, -2))), max(5, 100))
```




    1



...como isso funcionou?


```python
#In: 
show_nested_eval()
```





<iframe
    width="960"
    height="569"
    src="https://docs.google.com/presentation/d/e/2PACX-1vQpW0NzwT3LjZsIIDAgtSMRM1cl41Gp_Lf8k9GT-gm5sGAIynw4rsgiEFbIybClD6QtxarKaVKLbR9U/embed?start=false&loop=false&delayms=60000" frameborder="0" width="960" height="569" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true""
    frameborder="0"
    allowfullscreen

></iframe>




### Importar instruções
- Python não tem tudo que precisamos integrado.
- Para obter funcionalidades adicionais, importamos **módulos** por meio de **instruções de importação**.
- **Módulos** podem ser considerados coleções de funções e valores Python.
- Chame essas funções usando a sintaxe `module.function()`, chamada "notação de ponto".

### Exemplo: `import math`

`sqrt`, `log`, `pow`, etc.


```python
#In: 
import math
```


```python
#In: 
math.sqrt(9)
```




    3.0




```python
#In: 
math.pow(3, 2)
```




    9.0




```python
#In: 
# What base is log?
math.log?
```

Ele também possui constantes integradas!


```python
#In: 
math.pi
```




    3.141592653589793



### Verificação de conceito ✅

Suponha que você executou as seguintes instruções:

```py
x = 3
y = -2
```

Qual desses exemplos resulta em um erro?

A. `abs(x, y)`

B. `math.pow(x, abs(y))`

C. `round(x, max (abs (y ** 2)))`

D. `math.pow(x, math.pow(y, x))`

E. Mais de um dos itens acima


```python
#In: 

```

## Tipos de dados

### Qual é a diferença? 🧐


```python
#In: 
4 / 2
```




    2.0




```python
#In: 
5 - 3
```




    2



Para nós, `2.0` e `2` são o mesmo número, $2$. Mas para Python, isso parece ser diferente!

### Tipos de dados
- Todo valor em Python tem um **tipo**.
- Use a função `type` para verificar o tipo de um valor.
- É importante entender como diferentes tipos funcionam com diferentes operações, pois os resultados podem nem sempre ser os que esperamos.

### Dois tipos de dados numéricos: ```int``` e ```float```
- ```int``` : Um número inteiro de qualquer tamanho.
- ```float```: Um número com ponto decimal.

### ```int```
- Se você usar essas operações entre `int`s (`+`, `-`, `*`, `**`), o resultado será outro `int`.
- `int`s têm precisão arbitrária em Python, o que significa que seus cálculos serão sempre exatos.


```python
#In: 
3 + 5
```




    8




```python
#In: 
type(3 + 5)
```




    int




```python
#In: 
2 ** 300
```




    2037035976334486086268445688409378161051468393665936250636140449354381299763336706183397376




```python
#In: 
2 ** 3000
```




    1230231922161117176931558813276752514640713895736833715766118029160058800614672948775360067838593459582429649254051804908512884180898236823585082482065348331234959350355845017413023320111360666922624728239756880416434478315693675013413090757208690376793296658810662941824493488451726505303712916005346747908623702673480919353936813105736620402352744776903840477883651100322409301983488363802930540482487909763484098253940728685132044408863734754271212592471778643949486688511721051561970432780747454823776808464180697103083861812184348565522740195796682622205511845512080552010310050255801589349645928001133745474220715013683413907542779063759833876101354235184245096670042160720629411581502371248008430447184842098610320580417992206662247328722122088513643683907670360209162653670641130936997002170500675501374723998766005827579300723253474890612250135171889174899079911291512399773872178519018229989376



### ```float```
* Um `float` é especificado usando um ponto **decimal**.
* Um `float` pode ser impresso usando notação científica.


```python
#In: 
2.0 + 3.2
```




    5.2




```python
#In: 
type(2.0 + 3.2)
```




    float




```python
#In: 
2.0 ** 300
```




    2.037035976334486e+90



### As armadilhas do ```float```
* `float`s têm tamanho limitado (mas o limite é enorme).
* `float`s têm precisão limitada de 15-16 casas decimais.
* Depois da aritmética, as últimas casas decimais podem estar erradas de maneiras inesperadas (precisão limitada!).


```python
#In: 
1 + 0.2
```




    1.2




```python
#In: 
1 + 0.1 + 0.1
```




    1.2000000000000002




```python
#In: 
# Descomente e execute
# 2.0 ** 3000
```

### Coerção de tipo entre ```int``` e ```float```
- Por padrão, Python muda um `int` para um `float` em uma expressão mista envolvendo ambos os tipos.
- Observe que a divisão de dois `int`s retorna automaticamente um valor `float`.
- Um valor pode ser explicitamente **coagido** (ou seja, convertido) usando as funções ```int``` e ```float```.


```python
#In: 
2.0 + 3
```




    5.0




```python
#In: 
2 / 1
```




    2.0




```python
#In: 
# Want an integer back
int(2 / 1)
```




    2




```python
#In: 
# int chops off the decimal point, effectively rounding DOWN
int(3.9)
```




    3



### À parte: modelo de memória Jupyter

<center><img src='https://raw.githubusercontent.com/flaviovdf/fcd/master/assets/03-Expressoes/images/elephant.png' width=20%></center>

Nosso caderno **ainda** lembra todas as variáveis ​​que definimos anteriormente na aula.


```python
#In: 
more_than_1
```




    10



- No entanto, se você voltar ao seu notebook depois de algumas horas, ele normalmente “esquecerá” todas as variáveis ​​que conhecia.
- Quando isso acontecer, você precisará executar novamente as células do seu notebook.

## Resumo, da próxima vez

### Resumo

- Expressões são avaliadas como valores. Python exibirá o valor da última expressão em uma célula por padrão.
- Python conhece todos os operadores matemáticos padrão e segue PEMDAS.
- As instruções de atribuição nos permitem vincular valores a variáveis.
- Podemos chamar funções em Python da mesma forma que chamamos funções em matemática.
- Python conhece algumas funções por padrão, e as instruções de importação nos permitem trazer funcionalidades adicionais dos módulos.
- Todos os valores em Python possuem um tipo de dados.
- `int`s e `float`s são números.
- `int`s são inteiros, enquanto `float`s contêm pontos decimais.

### Próxima vez

- Aprenderemos sobre strings, um tipo de dados em Python projetado para armazenar texto.
- Também aprenderemos como armazenar sequências, ou muitas informações, em uma única variável.

**Observação:** Apresentaremos alguns códigos em laboratórios e trabalhos de casa também. Nem tudo estará em palestra. **Você aprenderá fazendo!**
