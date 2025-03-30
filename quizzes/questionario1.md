---
layout: page
title: Questionário 1
parent: Quizzes
nav_order: 1
---

# Questionário 1

## Problema 1

Após uma visita ao zoológico, Anthony escreveu o seguinte
bloco de código.

```python
zebra = 5
leao = 4
vaca = 1
zebra = zebra * 2
leao = abs(vaca - leao)
zebra = zebra + leao ** 2
vaca = (zebra + leao) / 2 * leao
```

Após a execução do bloco de código acima, qual é o valor de
`vaca`?

#### Solução

<details><summary>Resposta</summary>
33.0
</details>

## Problema 2

Considere as quatro instruções de atribuição a seguir.

```python
bass = "5"
tuna = 2
sword = ["4.0", 5, 12.5, -10, "2023"]
gold = [4, "6", "CSE", "doc"]
```

### Problema 2.1

Qual é o valor da expressão bass * tuna?

##### Solução

<details><summary>Resposta</summary>
"55"
</details>

## Problema 2.2

Qual das seguintes expressões resulta em um erro?

- ( ) `int(sword[0])`
- ( ) `float(sword[1])`
- ( ) `int(sword[2])`
- ( ) `int(sword[3])`
- ( ) `float(sword[4])`

##### Solução

<details><summary>Resposta</summary>
`int(sword[0])`
</details>

## Problema 2.3

Qual das seguintes expressões é avaliada como "DSC10"?

- ( ) `gold[3].replace("o", "s").title() + str(gold[0] + gold[1])`
- ( ) `gold[3].replace("o", "s").upper() + str(gold[0] + int(gold[1]))`
- ( ) `gold[3].replace("o", "s").upper() + str(gold[1] + int(gold[0]))`
- ( ) `gold[3].replace("o", "s").title() + str(gold[0] + int(gold[1]))`

##### Solução

<details><summary>Resposta</summary>
`gold[3].replace("o", "s").upper() + str(gold[0] + int(gold[1]))`
</details>

## Problema 3

Considere a seguinte declaração de atribuição.

```python
puffin = np.array([5, 9, 13, 17, 21])
```

### Problema 3.1

Forneça argumentos para chamar `np.arange` para que o array
penguin seja idêntico ao array puffin.

```python
penguin = np.arange(____)
```

##### Solução

<details><summary>Resposta</summary>
Precisamos fornecer `np.arange` três
argumentos: 5, qualquer número no intervalo (21,25] e 4.
Por exemplo, `penguin = np.arange(5, 25, 4)` funcionaria.
</details>

## Problema 3.2

Preencha os espaços em branco para que o array parrot
também seja idêntico ao array puffin. Dica: comece
escolhendo y para que parrot tenha comprimento 5.

```python
parrot = __(x)__ * np.arange(0, __(y)__, 2) + __(z)__
```

##### Solução

<details><summary>Resposta</summary>
- `x`: `2`
- `y`: qualquer número em $(8, 10]$
- `z`: `5`
</details>

## Problema 4

Suponha que students seja um DataFrame de todos os alunos
que fizeram o DSC 10 no último trimestre, students tem uma
linha por aluno, onde:

- O índice contém os PIDs dos alunos como strings começando com "A".
- A coluna "Overall" contém as notas percentuais gerais dos alunos como números flutuantes.
- A coluna "Animal" contém os animais favoritos dos alunos como cordas.

### Problema 4.1

Qual é o tipo do valor retornado na expressão
students.get("Overall") ?  Se esta expressão apresentar
algum erro, selecione “Erro”.

- ( ) float
- ( ) string
- ( ) array
- ( ) Series
- ( ) Erro

##### Solução.

<details><summary>Resposta</summary>
Series
</details>

### Problema 4.2

Qual é o tipo retornado da expressão students.get("PID")?
Se esta expressão apresentar algum erro, selecione “Erro”.

- ( ) float
- ( ) string
- ( ) array
- ( ) Series
- ( ) Erro

##### Solução

<details><summary>Resposta</summary>
Erro
</details>

### Problema 4.3

Supondo que students está ordenado por "Overall" em ordem
descrescente, preencha os espaços em branco para que
animal_one e animal_two sejam ambos avaliados como
"giraffe".

```pythob
animal_one = students.get(__(x)__).loc[__(y)__]
animal_two = students.get(__(x)__).iloc[__(z)__]
```

##### Solução.

<details><summary>Resposta</summary>
- `x`: `"Animal"`
- `y`: `"A12345678"`
- `z`: `5`
</details>

### Problema 4.4

Se students  não estivesse ordenado por  "Overall" em ordem
decrescente, quais das suas respostas precisariam ser
alteradas?

- ( ) Nenhuma das duas precisaria mudar
- ( ) `y` e `z`
- ( ) Apenas `y`
- ( ) Apenas `z`

##### Solução

<details><summary>Resposta</summary>
Apenas `z`
</details>
