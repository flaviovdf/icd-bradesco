---
layout: page
title: Questionário 2
parent: Quizzes
nav_order: 2
---

# Questionário 2

O DataFrame items descreve vários itens disponíveis para coletar ou comprar usando sinos, moeda usada no jogo Animal Crossing: New Horizons .
Para cada item temos:

- "Item" (str): O nome do objeto.
- "Cost" (int): O custo do item em sinos. Itens que custam 0 sinos não podem ser comprados e devem ser coletados por outros meios (como artesanato).
- "Location" (str): A loja ou ação através da qual o item pode ser obtido.

As primeiras 6 linhas desse dataFrame estão mostradas na imagem a seguir.

![](https://practice.dsc10.com/assets/images/fa23-quizzes/items.png)

## Problema 1

Preencha os espaços em branco para que tanto count_1 quanto count_2, avaliem para "items" um "Cost" de 0.

```python
count_1 = items.groupby(__(a)__).__(b)__().get("Item").loc[__(c)__]
count_2 = items[__(d)__].shape[0]
```

#### Solução

<details><summary>Resposta</summary>
- a: "Cost"
- b: count
- c: 0
- d: items.get("Cost") == 0
</details>

## Problema 2

O DataFrame "keepers" possui 5 linhas, cada uma representando um lojista diferente no universo Animal Crossing: New Horizons.O DataFrame keepers é mostrado abaixo em sua totalidade.
![](https://practice.dsc10.com/assets/images/fa23-quizzes/keepers1.png)

Quantas linhas existem no seguinte DataFrame? Dê sua resposta como um número inteiro.

```python
keepers.merge(items.take(np.arange(6)),
              left_on="Store",
              right_on="Location")
```

#### Solução

<details><summary>Resposta</summary>
10
</details>

## Problema 3

Qual tipo de gráfico devemos usar para visualizar a distribuição da coluna "Location" do DataFrame "items"?

- ( ) Gráfico de dispersão
- ( ) Gráfico de linha
- ( ) Gráfico de barra
- ( ) Histograma

#### Solução

<details><summary>Resposta</summary>
Gráfico de barras
</details>

## Problema 4

A Nintendo coletou dados sobre as alturas de uma amostra de jogadores de Animal Crossing: New Horizons. Um histograma dessa amostra alturas na amostra é apresentado abaixo.

![](https://practice.dsc10.com/assets/images/fa23-quizzes/histogram.png)

Qual porcentagem de jogadores na amostra da Nintendo tem pelo menos 62,5 polegadas de altura? Dê sua resposta como um número inteiro arredondado para o múltiplo de 5 mais próximo.

##### Solução.

<details><summary>Resposta</summary>
80%
</details>

## Problema 5

Considere a função "tom_nook", definida abaixo. Lembre-se de que se x é um número inteiro, então se x % 2 == 0, x é par, caso contrário, x é ímpar.

```python
def tom_nook(crossing):
    bells = 0
    for nook in np.arange(crossing):
        if nook % 2 == 0:
            bells = bells + 1
        else:
            bells = bells - 2
    return bells
```

Qual valor é avaliado em tom_nook(8)?

- ( ) -6
- ( ) -4
- ( ) -2
- ( ) 0
- ( ) 2
- ( ) 4
- ( ) 6

##### Solução.

<details><summary>Resposta</summary>
-4
</details>
