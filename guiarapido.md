---
layout: page
title: Referência
description: Guia Rápido de Referência do Curso.
nav_order: 7
---

# Referência do Curso FCD.

---

## Bibliotecas

- `numpy` cuida de operações com vetores e matrizes
- `babypandas` uma versão simplificada da biblioteca pandas, cuida de tabelas
- `matplotlib` gera gráficos, não fazemos uso de matplotlib avançado

Durante o restante desse guia, `df` é um DataFrame, `ser` é uma Série, `arr` é um array. `babypandas` foi importado como `bpd` e `numpy` como `np`.

## Construindo e Organizando DataFrames

Cada função/método abaixo cria um novo DataFrame. Lembre-se de salvá-lo!

- `bpd.DataFrame()`: Cria um DataFrame vazio.
- `bpd.read_csv(caminho_para_arquivo)`: Cria um DataFrame a partir de um arquivo CSV.
- `df.assign(nome_da_coluna=dados_da_coluna)`: Adiciona/substitui uma coluna.
- `df.drop(columns=nome_da_coluna ou [col_1_nome, ... col_k_nome])`: Remove coluna(s).
- `df.set_index(nome_da_coluna)`: Move uma coluna para o índice.
- `df.reset_index()`: Move o índice para uma coluna.
- `df.sort_values(by=nome_da_coluna, ascending=True)`: Ordena o DataFrame inteiro em ordem ascendente pelos valores em uma coluna. ascending pode ser omitido pois seu valor padrão é True.
- `left.merge(right, left_on=coluna_esquerda, right_on=coluna_direita):` Junta os DataFrames left e right pelas colunas especificadas. Pode usar on em vez de left_on e right_on se os nomes das colunas forem iguais.

## Arrays e NumPy

- `arr[indice]`: O elemento na posição indice no array arr. O primeiro elemento é arr[].
- `np.append(arr, valor)`: Uma cópia de arr com valor adicionado ao final. Isso não muda arr a menos que você armazene o resultado em arr.
- `np.count_nonzero(arr)`: O número de entradas não-zero em arr. True conta como 1, False conta como 0.
- `np.arange(início, parada, passo)`: Um array de números começando com início, aumentando/diminuindo em incrementos de passo e parando antes de (excluindo) parada. Se início ou passo forem omitidos, os valores padrão são 0 e 1, respectivamente.
- `np.percentile(arr, p)`: O percentil p dos números em arr.

## Plotagem

- `df.plot(kind=tipo, x=col_x, y=col_y)`: Desenha um gráfico. tipo pode ser 'scatter', 'line', 'bar', ou 'barh'. Se x for omitido, o índice é usado. Para a maioria dos tipos de gráficos, se y for omitido, todas as colunas são plotadas em eixos compartilhados.

## Acessando Dados

- `df.shape[]`: Número de linhas e colunas.
- `df.get(nome_da_coluna)`: Acesso a uma coluna como Série.

## Operações em DataFrames e Series

- `df[condição]`: Filtra linhas que satisfazem a `condição`.
- `df[[coluna_1, coluna_2, ...]]`: Um DataFrame apenas com as colunas especificadas.
- `df.mean()`, `df.min()`, `df.max()`, `ser.mean()`, `ser.min()`, `ser.max()`: Calcula a média, o mínimo, e o máximo de um DataFrame ou Series, respectivamente.

## Estatísticas e Agregações

- `df.groupby(coluna).aggregate(função ou {coluna: função, ...})`: Agrupa por `coluna`, então calcula agregações especificadas.
- `df.pivot_table(values=valor, index=índice, columns=colunas, aggfunc=função)`: Cria uma tabela pivô.

## Indexação e Seleção

- `df.loc[rótulos_linhas, rótulos_colunas]`: Seleciona com base em rótulos.
- `df.iloc[índices_linhas, índices_colunas]`: Seleciona com base em índices numéricos.

## Operações de Strings em Series

- `ser.str.lower()`, `ser.str.upper()`, `ser.str.len()`: Métodos que operam em cada string de uma Series.

## Trabalhando com Datas e Horários

- `pd.to_datetime(ser)`: Converte uma Series para datetime.
- `df['coluna'].dt.day`, `df['coluna'].dt.month`, `df['coluna'].dt.year`: Extrai o dia, mês, e ano de uma coluna datetime.

## Lendo e Escrevendo Dados

- `df.to_csv(caminho_para_arquivo)`: Escreve o DataFrame para um arquivo CSV.

## Utilidades

- `len(obj)`: Retorna o comprimento de um objeto, como um DataFrame, Series, ou array.
- `np.random.choice(arr, tamanho, replace=False)`: Escolhe aleatoriamente `tamanho` elementos de `arr`. `replace` determina se a seleção é com reposição.

Lembre-se, estas são apenas algumas das funções e métodos disponíveis em pandas e numpy para manipulação de dados e análise estatística. A prática e a exploração de documentações e recursos adicionais podem ajudar a aprofundar seu entendimento.
