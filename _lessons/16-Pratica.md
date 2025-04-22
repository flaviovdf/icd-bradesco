---
layout: page
title: Prática SKlearn
nav_order: 16
---

[<img src="https://github.com/icd-ufmg/icd-ufmg.github.io/blob/master/_lessons/colab_favicon_small.png?raw=1" style="float: right;">](https://colab.research.google.com/github/flaviovdf/icd-bradesco/blob/master/_lessons/16-Pratica.ipynb)

# Aprendizado na Prática

{: .no_toc .mb-2 }

Fazendo uso a regressão e classicação knn e logística!
{: .fs-6 .fw-300 }

{: .no_toc .text-delta }
Resultados Esperados

1. Saber executar o KNN do SKlearn
1. Praticar o pipeline completo de ICD


```python
#In: 
# -*- coding: utf8

from scipy import stats as ss

import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

plt.style.use('ggplot')
```


```python
#In: 
%%capture 
! wget https://github.com/icd-ufmg/material/raw/master/aulas/23-MLPratica/fashion/train-images-idx3-ubyte.gz -P fashion
! wget https://github.com/icd-ufmg/material/raw/master/aulas/23-MLPratica/fashion/t10k-images-idx3-ubyte.gz -P fashion
! wget https://github.com/icd-ufmg/material/raw/master/aulas/23-MLPratica/fashion/train-labels-idx1-ubyte.gz -P fashion
! wget https://github.com/icd-ufmg/material/raw/master/aulas/23-MLPratica/fashion/t10k-labels-idx1-ubyte.gz -P fashion
```


```python
#In: 
def load_mnist(path, kind='train'):
    import os
    import gzip
    import numpy as np

    """Load MNIST data from `path`"""
    labels_path = os.path.join(path,
                               '%s-labels-idx1-ubyte.gz'
                               % kind)
    images_path = os.path.join(path,
                               '%s-images-idx3-ubyte.gz'
                               % kind)

    with gzip.open(labels_path, 'rb') as lbpath:
        labels = np.frombuffer(lbpath.read(), dtype=np.uint8,
                               offset=8)

    with gzip.open(images_path, 'rb') as imgpath:
        images = np.frombuffer(imgpath.read(), dtype=np.uint8,
                               offset=16).reshape(len(labels), 784)

    return images, labels
```

## Classificação

Nesta aula vamos explorar aprendizado de máquina na prática. Em particular, vamos iniciar por algoritmos de classificação na base Fashion MNIST. Depois disso vamos explorar regressão.

Acima, temos alguns códigos auxiliares para carregar a base. Nesta, cada ponto é um vetor de 784 posições. Ao redimensionar os mesmos com:

```python
#In: 
x.reshape((28, 28))
```

Temos uma imagem de alguma peça de vestimento. Código para carregar os dados abaixo. Vamos usar apenas 500 instâncias para treino e teste. Lento usar muito mais do que isso no meu computador.


```python
#In: 
X_train, y_train = load_mnist('fashion', kind='train')
X_test, y_test = load_mnist('fashion', kind='t10k')
```


```python
#In: 
X_train = X_train[:500]
y_train = y_train[:500]

X_test = X_test[:500]
y_test = y_test[:500]
```


```python
#In: 
np.unique(y_test, return_counts=True)
```




    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8),
     array([53, 40, 63, 46, 55, 52, 49, 52, 43, 47]))



Observe como cada instância é um vetor. Cada valor é um tom de cinza. 0 == branco; 256 == preto.


```python
#In: 
X_train[10]
```




    array([  0,   0,   0,   0,   1,   0,   0,   0,   0,  41, 162, 167,  84,
            30,  38,  94, 177, 176,  26,   0,   0,   0,   1,   0,   0,   0,
             0,   0,   0,   0,   0,   1,   0,   0,  41, 147, 228, 242, 228,
           236, 251, 251, 251, 255, 242, 230, 247, 221, 125,   0,   0,   0,
             0,   0,   0,   0,   0,   0,   0,   0,   0,  91, 216, 228, 222,
           219, 219, 218, 222, 200, 224, 230, 221, 222, 222, 227, 237, 183,
             0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   4, 202, 208,
           212, 217, 219, 222, 222, 219, 219, 220, 218, 222, 224, 224, 221,
           210, 227, 163,   0,   0,   0,   0,   0,   0,   0,   0,   0, 102,
           225, 210, 216, 218, 222, 221, 219, 225, 225, 221, 222, 224, 222,
           224, 224, 215, 215, 218,  28,   0,   0,   0,   0,   0,   0,   0,
             0, 189, 222, 220, 213, 219, 220, 218, 221, 220, 219, 222, 226,
           222, 220, 221, 216, 215, 218, 229, 148,   0,   0,   0,   0,   0,
             0,   0,  11, 240, 210, 227, 213, 214, 220, 217, 220, 224, 220,
           221, 217, 206, 209, 208, 212, 220, 224, 218, 234,   0,   0,   0,
             0,   0,   0,   0, 118, 214, 208, 224, 216, 211, 226, 212, 219,
           213, 193, 192, 179, 194, 213, 216, 216, 217, 227, 216, 221,  91,
             0,   0,   0,   0,   0,   0, 170, 221, 205, 225, 219, 217, 232,
           232, 226, 182, 182, 211, 226, 220, 212, 217, 216, 216, 225, 213,
           226, 184,   0,   0,   0,   0,   0,   0,   0, 181, 229, 219, 220,
           213, 227, 226, 222, 214, 222, 220, 216, 215, 213, 214, 216, 215,
           220, 233, 211,   0,   0,   0,   0,   0,   0,   0,   0,   0, 164,
           242, 222, 210, 214, 211, 215, 215, 216, 217, 215, 215, 215, 215,
           213, 222, 238, 184,   0,   0,   0,   0,   0,   0,   0,   0,   2,
             0,   0,  60, 222, 217, 214, 214, 215, 219, 202, 217, 210, 203,
           216, 212, 221, 200,  60,   0,   0,   0,   0,   0,   0,   0,   0,
             0,   0,   0,   0,   0, 193, 222, 208, 216, 215, 216, 218, 220,
           219, 215, 216, 204, 222, 148,   0,   0,   0,   0,   0,   0,   0,
             0,   0,   0,   0,   0,   0,   0, 194, 222, 206, 216, 216, 217,
           218, 217, 218, 216, 218, 208, 219, 179,   0,   0,   0,   0,   0,
             0,   0,   0,   0,   0,   0,   1,   0,   0, 192, 224, 213, 217,
           217, 218, 217, 217, 217, 215, 216, 209, 215, 176,   0,   0,   0,
             0,   0,   0,   0,   0,   0,   0,   0,   1,   0,   0, 194, 221,
           214, 217, 216, 216, 217, 217, 217, 216, 214, 210, 214, 177,   0,
             0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   0,   0,
           193, 220, 214, 218, 217, 216, 217, 217, 216, 216, 215, 212, 214,
           183,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,
             0,   0, 197, 220, 214, 219, 218, 218, 218, 218, 217, 217, 219,
           214, 217, 189,   0,   0,   1,   0,   0,   0,   0,   0,   0,   0,
             0,   0,   0,   0, 201, 222, 214, 219, 218, 219, 219, 218, 218,
           217, 219, 216, 220, 196,   0,   0,   1,   0,   0,   0,   0,   0,
             0,   0,   0,   0,   0,   0, 209, 222, 216, 220, 219, 219, 220,
           220, 218, 217, 219, 216, 222, 203,   0,   0,   1,   0,   0,   0,
             0,   0,   0,   0,   0,   0,   0,   0, 209, 221, 216, 220, 219,
           219, 221, 221, 219, 219, 221, 217, 222, 210,   0,   0,   1,   0,
             0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 208, 222, 218,
           221, 220, 220, 221, 222, 220, 220, 222, 219, 222, 216,   0,   0,
             1,   0,   0,   0,   0,   0,   0,   0,   0,   1,   0,   0, 210,
           226, 220, 221, 220, 221, 222, 222, 220, 220, 224, 221, 224, 221,
             0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   0,
             0, 217, 227, 219, 222, 224, 219, 219, 221, 222, 220, 221, 222,
           225, 220,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
             1,   0,   0, 183, 228, 221, 225, 221, 215, 217, 221, 222, 221,
           222, 224, 224, 193,   0,   0,   1,   0,   0,   0,   0,   0,   0,
             0,   0,   1,   0,   0, 179, 225, 218, 221, 219, 213, 213, 217,
           220, 219, 218, 221, 222, 197,   0,   0,   2,   0,   0,   0,   0,
             0,   0,   0,   0,   1,   0,   0, 240, 233, 228, 235, 232, 229,
           228, 229, 231, 231, 231, 228, 229, 212,   0,   0,   1,   0,   0,
             0,   0,   0,   0,   0,   0,   0,   0,   0, 101, 157, 148, 148,
           167, 180, 182, 179, 176, 172, 171, 164, 177, 163,   0,   0,   1,
             0,   0,   0,   0], dtype=uint8)



Ao redimensionar temos uma peça de roupa! Fashion!


```python
#In: 
I = X_train[0].reshape(28, 28)
print(I.shape)
```

    (28, 28)



```python
#In: 
plt.imshow(X_train[100].reshape(28, 28))
plt.xticks(np.arange(28))
plt.yticks(np.arange(28));
```


    
![png](16-Pratica_files/16-Pratica_12_0.png)
    



```python
#In: 
plt.imshow(X_train[1].reshape(28, 28))
plt.xticks(np.arange(28))
plt.yticks(np.arange(28));
```


    
![png](16-Pratica_files/16-Pratica_13_0.png)
    



```python
#In: 
M = np.array([[1, 2], [2, 3]])
M.flatten()
```




    array([1, 2, 2, 3])



Temos 10 classes. 


```python
#In: 
len(set(y_train))
```




    10




```python
#In: 
text_labels = ['t-shirt', 'trouser', 'pullover', 'dress', 'coat', 'sandal', 'shirt', 'sneaker', 'bag', 'ankle boot']
index = np.arange(len(text_labels))
labels = pd.Series(text_labels, index=index)
labels
```




    0       t-shirt
    1       trouser
    2      pullover
    3         dress
    4          coat
    5        sandal
    6         shirt
    7       sneaker
    8           bag
    9    ankle boot
    dtype: object



## Executando o Scikit-Learn

Agora, vamos executar o código do sklearn na nossa base. Lembrando que temos que separar a mesma em Treino, Validação e Teste. Para tal, vamos fazer uso da classe `StratifiedKFold`. A mesma serve para realizar n-fold cross validation. A biblioteca sklearn não cria grupos de validação para você, a mesma só usa o conceito de treino/teste. De qualquer forma, validação nada mais é do que um conjunto a mais de teste. Então, vamos fazer 5-fold no nosso treino, separando em treino/validação. Note que NUNCA avaliamos nada no teste, apenas reportamos os números no fim!!


```python
#In: 
from sklearn.model_selection import StratifiedKFold
```

Ao gerar o split, teremos 20 conjuntos (muito eu sei).


```python
#In: 
skf = StratifiedKFold(n_splits=20, shuffle=True)
```

Cada passo do laço retorna indices do vetor


```python
#In: 
for treino, validacao in skf.split(X_train, y_train):
    count_train = np.unique(y_train[treino], return_counts=True)
    print(count_train)
```

    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 37, 42, 62, 48, 39, 58, 49, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 37, 42, 62, 48, 39, 58, 49, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 42, 62, 48, 39, 58, 50, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 42, 62, 48, 39, 58, 50, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 42, 62, 49, 38, 58, 50, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 43, 62, 49, 39, 58, 50, 42, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 43, 62, 49, 39, 58, 50, 42, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 43, 62, 49, 39, 58, 50, 42, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([50, 36, 43, 61, 49, 39, 58, 50, 42, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([50, 36, 43, 61, 49, 39, 58, 50, 42, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([50, 36, 43, 61, 49, 39, 58, 49, 43, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([50, 36, 43, 61, 49, 39, 58, 49, 43, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([50, 36, 43, 61, 49, 39, 58, 49, 43, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([50, 36, 43, 62, 48, 39, 58, 49, 43, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([50, 36, 43, 62, 48, 39, 58, 49, 43, 47]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([50, 36, 43, 62, 48, 39, 57, 49, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 43, 62, 48, 39, 58, 49, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 43, 62, 48, 39, 58, 49, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 43, 62, 48, 39, 58, 49, 43, 48]))
    (array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=uint8), array([49, 36, 43, 62, 48, 39, 58, 49, 43, 48]))


Vamos quebrar nos conjuntos e avaliar o KNN. De um mundo de métricas, vamos fazer uso de 4 neste notebook:

1. Precisão
2. Revocação
3. F1
4. Acurácia

![](https://raw.githubusercontent.com/icd-ufmg/material/master/aulas/23-MLPratica/f.png)

Na figura acima, assuma que o termo `busca` indica as previsões do seu classificador (sem tempo para alterar a figura irmão). Sendo `y_p (y-pred)` um conjunto de elementos da previsão e `y_t (y-true)` os rótulos reais. Por clareza, vamos assumir duas classes `1 e 0`. Afinal, o caso multiclasse pode ser reduzido para este. Assim, cada elemento dos vetores `y_p` e `y_t` $\in \{0, 1\}$. Os verdadeiros positivos, __true positive (TP)__, é o conjunto de previsões da classe `1` que foram corretas. Podemos formalizar como:

$$TP = \sum_i \mathbb{1}_{y_t[i] = 1} \mathbb{1}_{y_p[i] = 1}$$

$\mathbb{1}_{y_t[i] = 1}$ retorna 1 quando $y_t[i] = 1$, 0 caso contrário. O mesmo vale para $\mathbb{1}_{y_t[i] = y_p[i]}$ que retorna um quando $y_p[i] = 1$. Usando a mesma notação, os verdadeiros negativos é definido como:

$$TN = \sum_i \mathbb{1}_{y_t[i] = 0} \mathbb{1}_{y_t[i] = 0}$$

Os falsos positivos e negativos capturam os erros da previsão. Note que nos dois a previsão é o oposto do real:

$$FP = \sum_i \mathbb{1}_{y_t[i] = 0} \mathbb{1}_{y_p[i] = 1}$$

$$FN = \sum_i \mathbb{1}_{y_t[i] = 1} \mathbb{1}_{y_p[i] = 0}$$

Assim, a acurácia do classificador é definida como a fração total de acertos:

$$Acuracia = \frac{TP + TN}{TP + TN + FP + FN}$$

A precisão é definida como a fração dos elementos classificados como 1 que foram corretos:

$$Precisão = \frac{TP}{TP + FP}$$

A revocação é a fração de todos os elementos do conjunto 1 que foram acertados. Diferente da precisão, aqui focamos nos elementos reais! Na precisão focamos nas previsões.

$$Revocação = \frac{TP}{TP + FN}$$

Tanto a previsão quanto a revocação importam. Na primeira, precisão, queremos saber o quão bom o classificador é em retornar acertos. Na segunda, o quanto de elementos reais o classificador captura. Observe como um classificador que sempre retorna 1 tem revocação máxima, porém precisão baixa. Um classificador que sempre retorna 0 tem precisão máxima e revocação baixa. Para captura a média harmônica dos dois usamos o F1-score:

$$F1 = MediaHarmonica(Precisao, Revocacao)$$

Dependendo do problema uma métrica pode importar mais do que a outra. Aqui, trabalhamos com classes balanceadas, então a acurácia já é boa suficiente. Vamos avaliar a acurácia nos conjuntos abaixo:


```python
#In: 
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score
```

Observe como o laço abaixo guarda o melhor valor de n para cada fold de validação!


```python
#In: 
fold = 0
melhores = []
for treino, validacao in skf.split(X_train, y_train):
    X_tt = X_train[treino]
    y_tt = y_train[treino]
    X_v = X_train[validacao]
    y_v = y_train[validacao]
    
    best = (0, 0)
    for nn in [2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 100]: # Vamos testar tais valores de n
        model = KNeighborsClassifier(n_neighbors=nn)
        model.fit(X_tt, y_tt) # treina no conjunto de treino
        y_pv = model.predict(X_v) # previsões no conjunto de validação
        
        # Resultado com melhor acurácia!
        accuracy = accuracy_score(y_v, y_pv)
        if accuracy > best[0]:
            best = (accuracy, nn)
    
    melhores.append(best[1])
    fold += 1
    print('Fold-{}, melhor nn = {}, acc = {}'.format(fold, best[1], best[0]))
```

    Fold-1, melhor nn = 2, acc = 0.8
    Fold-2, melhor nn = 40, acc = 0.8


    Fold-3, melhor nn = 2, acc = 0.72
    Fold-4, melhor nn = 9, acc = 0.68


    Fold-5, melhor nn = 2, acc = 0.8
    Fold-6, melhor nn = 6, acc = 0.76


    Fold-7, melhor nn = 10, acc = 0.8
    Fold-8, melhor nn = 10, acc = 0.76


    Fold-9, melhor nn = 4, acc = 0.76
    Fold-10, melhor nn = 5, acc = 0.8


    Fold-11, melhor nn = 5, acc = 0.84
    Fold-12, melhor nn = 3, acc = 0.76


    Fold-13, melhor nn = 3, acc = 0.8
    Fold-14, melhor nn = 5, acc = 0.8


    Fold-15, melhor nn = 40, acc = 0.8
    Fold-16, melhor nn = 5, acc = 0.84


    Fold-17, melhor nn = 5, acc = 0.68
    Fold-18, melhor nn = 2, acc = 0.6


    Fold-19, melhor nn = 2, acc = 0.68
    Fold-20, melhor nn = 6, acc = 0.84


Vamos ver quantas vezes cada escolha de número de vizinhos, nn, ganhou na validação.


```python
#In: 
unique, counts = np.unique(melhores, return_counts=True)
plt.bar(unique, counts)
plt.title('Número de vezes que n ganhou na validação')
plt.xlabel('NN')
plt.ylabel('Count na validação')
```




    Text(0, 0.5, 'Count na validação')




    
![png](16-Pratica_files/16-Pratica_29_1.png)
    


Agora, podemos finalmente avaliar o modelo no conjunto de teste! Vamos escolher n como a médiana dos folds.


```python
#In: 
print(np.median(melhores))
```

    5.0


Vamos verificar as outras métricas e todas as classes.


```python
#In: 
from sklearn.metrics import classification_report

model = KNeighborsClassifier(n_neighbors=5)
model.fit(X_train, y_train)

print(classification_report(y_test, model.predict(X_test)))
```

                  precision    recall  f1-score   support
    
               0       0.71      0.77      0.74        53
               1       0.95      0.97      0.96        40
               2       0.53      0.62      0.57        63
               3       0.86      0.93      0.90        46
               4       0.63      0.60      0.62        55
               5       0.94      0.60      0.73        52
               6       0.53      0.43      0.47        49
               7       0.71      0.87      0.78        52
               8       0.94      0.79      0.86        43
               9       0.83      0.96      0.89        47
    
        accuracy                           0.74       500
       macro avg       0.76      0.75      0.75       500
    weighted avg       0.75      0.74      0.74       500
    


Parece que erramos muito a classe 4, coat. Casacos se parecem com camisas, vestidos etc. Podemos investigar isto usando a matriz de confusão.


```python
#In: 
from sklearn.metrics import confusion_matrix
plt.imshow(confusion_matrix(y_test, model.predict(X_test)))
plt.xticks(labels.index - 0.5, '\n\n'+ labels, rotation=90)
plt.yticks(labels.index - 0.5, '\n\n'+ labels);
```


    
![png](16-Pratica_files/16-Pratica_35_0.png)
    


## Logística

Vamos repetir tudo para a regressão logística. Felizmente, o sklearn tem uma versão da logística que já faz treino/validação internamente. Para alguns modelos, existem atalhos para fazer isto. Caso queira entender, leia:

https://robjhyndman.com/hyndsight/crossvalidation/


```python
#In: 
from sklearn.linear_model import LogisticRegressionCV
```


```python
#In: 
# O LogisticCV tenta várias regularizações.
model = LogisticRegressionCV(Cs=100,
                             penalty='l2',   #ridge
                             cv=5,           #5 folds internos
                             fit_intercept=False,
                             solver='liblinear',
                             multi_class='ovr')
model.fit(X_train, y_train)
```

    /home/flaviovdf/virtualenvs/teaching/lib/python3.12/site-packages/sklearn/linear_model/_logistic.py:1914: FutureWarning: 'multi_class' was deprecated in version 1.5 and will be removed in 1.7. Use OneVsRestClassifier(LogisticRegressionCV(..)) instead. Leave it to its default value to avoid this warning.
      warnings.warn(





<style>#sk-container-id-1 {
  /* Definition of color scheme common for light and dark mode */
  --sklearn-color-text: black;
  --sklearn-color-line: gray;
  /* Definition of color scheme for unfitted estimators */
  --sklearn-color-unfitted-level-0: #fff5e6;
  --sklearn-color-unfitted-level-1: #f6e4d2;
  --sklearn-color-unfitted-level-2: #ffe0b3;
  --sklearn-color-unfitted-level-3: chocolate;
  /* Definition of color scheme for fitted estimators */
  --sklearn-color-fitted-level-0: #f0f8ff;
  --sklearn-color-fitted-level-1: #d4ebff;
  --sklearn-color-fitted-level-2: #b3dbfd;
  --sklearn-color-fitted-level-3: cornflowerblue;

  /* Specific color for light theme */
  --sklearn-color-text-on-default-background: var(--sg-text-color, var(--theme-code-foreground, var(--jp-content-font-color1, black)));
  --sklearn-color-background: var(--sg-background-color, var(--theme-background, var(--jp-layout-color0, white)));
  --sklearn-color-border-box: var(--sg-text-color, var(--theme-code-foreground, var(--jp-content-font-color1, black)));
  --sklearn-color-icon: #696969;

  @media (prefers-color-scheme: dark) {
    /* Redefinition of color scheme for dark theme */
    --sklearn-color-text-on-default-background: var(--sg-text-color, var(--theme-code-foreground, var(--jp-content-font-color1, white)));
    --sklearn-color-background: var(--sg-background-color, var(--theme-background, var(--jp-layout-color0, #111)));
    --sklearn-color-border-box: var(--sg-text-color, var(--theme-code-foreground, var(--jp-content-font-color1, white)));
    --sklearn-color-icon: #878787;
  }
}

#sk-container-id-1 {
  color: var(--sklearn-color-text);
}

#sk-container-id-1 pre {
  padding: 0;
}

#sk-container-id-1 input.sk-hidden--visually {
  border: 0;
  clip: rect(1px 1px 1px 1px);
  clip: rect(1px, 1px, 1px, 1px);
  height: 1px;
  margin: -1px;
  overflow: hidden;
  padding: 0;
  position: absolute;
  width: 1px;
}

#sk-container-id-1 div.sk-dashed-wrapped {
  border: 1px dashed var(--sklearn-color-line);
  margin: 0 0.4em 0.5em 0.4em;
  box-sizing: border-box;
  padding-bottom: 0.4em;
  background-color: var(--sklearn-color-background);
}

#sk-container-id-1 div.sk-container {
  /* jupyter's `normalize.less` sets `[hidden] { display: none; }`
     but bootstrap.min.css set `[hidden] { display: none !important; }`
     so we also need the `!important` here to be able to override the
     default hidden behavior on the sphinx rendered scikit-learn.org.
     See: https://github.com/scikit-learn/scikit-learn/issues/21755 */
  display: inline-block !important;
  position: relative;
}

#sk-container-id-1 div.sk-text-repr-fallback {
  display: none;
}

div.sk-parallel-item,
div.sk-serial,
div.sk-item {
  /* draw centered vertical line to link estimators */
  background-image: linear-gradient(var(--sklearn-color-text-on-default-background), var(--sklearn-color-text-on-default-background));
  background-size: 2px 100%;
  background-repeat: no-repeat;
  background-position: center center;
}

/* Parallel-specific style estimator block */

#sk-container-id-1 div.sk-parallel-item::after {
  content: "";
  width: 100%;
  border-bottom: 2px solid var(--sklearn-color-text-on-default-background);
  flex-grow: 1;
}

#sk-container-id-1 div.sk-parallel {
  display: flex;
  align-items: stretch;
  justify-content: center;
  background-color: var(--sklearn-color-background);
  position: relative;
}

#sk-container-id-1 div.sk-parallel-item {
  display: flex;
  flex-direction: column;
}

#sk-container-id-1 div.sk-parallel-item:first-child::after {
  align-self: flex-end;
  width: 50%;
}

#sk-container-id-1 div.sk-parallel-item:last-child::after {
  align-self: flex-start;
  width: 50%;
}

#sk-container-id-1 div.sk-parallel-item:only-child::after {
  width: 0;
}

/* Serial-specific style estimator block */

#sk-container-id-1 div.sk-serial {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: var(--sklearn-color-background);
  padding-right: 1em;
  padding-left: 1em;
}


/* Toggleable style: style used for estimator/Pipeline/ColumnTransformer box that is
clickable and can be expanded/collapsed.
- Pipeline and ColumnTransformer use this feature and define the default style
- Estimators will overwrite some part of the style using the `sk-estimator` class
*/

/* Pipeline and ColumnTransformer style (default) */

#sk-container-id-1 div.sk-toggleable {
  /* Default theme specific background. It is overwritten whether we have a
  specific estimator or a Pipeline/ColumnTransformer */
  background-color: var(--sklearn-color-background);
}

/* Toggleable label */
#sk-container-id-1 label.sk-toggleable__label {
  cursor: pointer;
  display: block;
  width: 100%;
  margin-bottom: 0;
  padding: 0.5em;
  box-sizing: border-box;
  text-align: center;
}

#sk-container-id-1 label.sk-toggleable__label-arrow:before {
  /* Arrow on the left of the label */
  content: "▸";
  float: left;
  margin-right: 0.25em;
  color: var(--sklearn-color-icon);
}

#sk-container-id-1 label.sk-toggleable__label-arrow:hover:before {
  color: var(--sklearn-color-text);
}

/* Toggleable content - dropdown */

#sk-container-id-1 div.sk-toggleable__content {
  max-height: 0;
  max-width: 0;
  overflow: hidden;
  text-align: left;
  /* unfitted */
  background-color: var(--sklearn-color-unfitted-level-0);
}

#sk-container-id-1 div.sk-toggleable__content.fitted {
  /* fitted */
  background-color: var(--sklearn-color-fitted-level-0);
}

#sk-container-id-1 div.sk-toggleable__content pre {
  margin: 0.2em;
  border-radius: 0.25em;
  color: var(--sklearn-color-text);
  /* unfitted */
  background-color: var(--sklearn-color-unfitted-level-0);
}

#sk-container-id-1 div.sk-toggleable__content.fitted pre {
  /* unfitted */
  background-color: var(--sklearn-color-fitted-level-0);
}

#sk-container-id-1 input.sk-toggleable__control:checked~div.sk-toggleable__content {
  /* Expand drop-down */
  max-height: 200px;
  max-width: 100%;
  overflow: auto;
}

#sk-container-id-1 input.sk-toggleable__control:checked~label.sk-toggleable__label-arrow:before {
  content: "▾";
}

/* Pipeline/ColumnTransformer-specific style */

#sk-container-id-1 div.sk-label input.sk-toggleable__control:checked~label.sk-toggleable__label {
  color: var(--sklearn-color-text);
  background-color: var(--sklearn-color-unfitted-level-2);
}

#sk-container-id-1 div.sk-label.fitted input.sk-toggleable__control:checked~label.sk-toggleable__label {
  background-color: var(--sklearn-color-fitted-level-2);
}

/* Estimator-specific style */

/* Colorize estimator box */
#sk-container-id-1 div.sk-estimator input.sk-toggleable__control:checked~label.sk-toggleable__label {
  /* unfitted */
  background-color: var(--sklearn-color-unfitted-level-2);
}

#sk-container-id-1 div.sk-estimator.fitted input.sk-toggleable__control:checked~label.sk-toggleable__label {
  /* fitted */
  background-color: var(--sklearn-color-fitted-level-2);
}

#sk-container-id-1 div.sk-label label.sk-toggleable__label,
#sk-container-id-1 div.sk-label label {
  /* The background is the default theme color */
  color: var(--sklearn-color-text-on-default-background);
}

/* On hover, darken the color of the background */
#sk-container-id-1 div.sk-label:hover label.sk-toggleable__label {
  color: var(--sklearn-color-text);
  background-color: var(--sklearn-color-unfitted-level-2);
}

/* Label box, darken color on hover, fitted */
#sk-container-id-1 div.sk-label.fitted:hover label.sk-toggleable__label.fitted {
  color: var(--sklearn-color-text);
  background-color: var(--sklearn-color-fitted-level-2);
}

/* Estimator label */

#sk-container-id-1 div.sk-label label {
  font-family: monospace;
  font-weight: bold;
  display: inline-block;
  line-height: 1.2em;
}

#sk-container-id-1 div.sk-label-container {
  text-align: center;
}

/* Estimator-specific */
#sk-container-id-1 div.sk-estimator {
  font-family: monospace;
  border: 1px dotted var(--sklearn-color-border-box);
  border-radius: 0.25em;
  box-sizing: border-box;
  margin-bottom: 0.5em;
  /* unfitted */
  background-color: var(--sklearn-color-unfitted-level-0);
}

#sk-container-id-1 div.sk-estimator.fitted {
  /* fitted */
  background-color: var(--sklearn-color-fitted-level-0);
}

/* on hover */
#sk-container-id-1 div.sk-estimator:hover {
  /* unfitted */
  background-color: var(--sklearn-color-unfitted-level-2);
}

#sk-container-id-1 div.sk-estimator.fitted:hover {
  /* fitted */
  background-color: var(--sklearn-color-fitted-level-2);
}

/* Specification for estimator info (e.g. "i" and "?") */

/* Common style for "i" and "?" */

.sk-estimator-doc-link,
a:link.sk-estimator-doc-link,
a:visited.sk-estimator-doc-link {
  float: right;
  font-size: smaller;
  line-height: 1em;
  font-family: monospace;
  background-color: var(--sklearn-color-background);
  border-radius: 1em;
  height: 1em;
  width: 1em;
  text-decoration: none !important;
  margin-left: 1ex;
  /* unfitted */
  border: var(--sklearn-color-unfitted-level-1) 1pt solid;
  color: var(--sklearn-color-unfitted-level-1);
}

.sk-estimator-doc-link.fitted,
a:link.sk-estimator-doc-link.fitted,
a:visited.sk-estimator-doc-link.fitted {
  /* fitted */
  border: var(--sklearn-color-fitted-level-1) 1pt solid;
  color: var(--sklearn-color-fitted-level-1);
}

/* On hover */
div.sk-estimator:hover .sk-estimator-doc-link:hover,
.sk-estimator-doc-link:hover,
div.sk-label-container:hover .sk-estimator-doc-link:hover,
.sk-estimator-doc-link:hover {
  /* unfitted */
  background-color: var(--sklearn-color-unfitted-level-3);
  color: var(--sklearn-color-background);
  text-decoration: none;
}

div.sk-estimator.fitted:hover .sk-estimator-doc-link.fitted:hover,
.sk-estimator-doc-link.fitted:hover,
div.sk-label-container:hover .sk-estimator-doc-link.fitted:hover,
.sk-estimator-doc-link.fitted:hover {
  /* fitted */
  background-color: var(--sklearn-color-fitted-level-3);
  color: var(--sklearn-color-background);
  text-decoration: none;
}

/* Span, style for the box shown on hovering the info icon */
.sk-estimator-doc-link span {
  display: none;
  z-index: 9999;
  position: relative;
  font-weight: normal;
  right: .2ex;
  padding: .5ex;
  margin: .5ex;
  width: min-content;
  min-width: 20ex;
  max-width: 50ex;
  color: var(--sklearn-color-text);
  box-shadow: 2pt 2pt 4pt #999;
  /* unfitted */
  background: var(--sklearn-color-unfitted-level-0);
  border: .5pt solid var(--sklearn-color-unfitted-level-3);
}

.sk-estimator-doc-link.fitted span {
  /* fitted */
  background: var(--sklearn-color-fitted-level-0);
  border: var(--sklearn-color-fitted-level-3);
}

.sk-estimator-doc-link:hover span {
  display: block;
}

/* "?"-specific style due to the `<a>` HTML tag */

#sk-container-id-1 a.estimator_doc_link {
  float: right;
  font-size: 1rem;
  line-height: 1em;
  font-family: monospace;
  background-color: var(--sklearn-color-background);
  border-radius: 1rem;
  height: 1rem;
  width: 1rem;
  text-decoration: none;
  /* unfitted */
  color: var(--sklearn-color-unfitted-level-1);
  border: var(--sklearn-color-unfitted-level-1) 1pt solid;
}

#sk-container-id-1 a.estimator_doc_link.fitted {
  /* fitted */
  border: var(--sklearn-color-fitted-level-1) 1pt solid;
  color: var(--sklearn-color-fitted-level-1);
}

/* On hover */
#sk-container-id-1 a.estimator_doc_link:hover {
  /* unfitted */
  background-color: var(--sklearn-color-unfitted-level-3);
  color: var(--sklearn-color-background);
  text-decoration: none;
}

#sk-container-id-1 a.estimator_doc_link.fitted:hover {
  /* fitted */
  background-color: var(--sklearn-color-fitted-level-3);
}
</style><div id="sk-container-id-1" class="sk-top-container"><div class="sk-text-repr-fallback"><pre>LogisticRegressionCV(Cs=100, cv=5, fit_intercept=False, multi_class=&#x27;ovr&#x27;,
                     solver=&#x27;liblinear&#x27;)</pre><b>In a Jupyter environment, please rerun this cell to show the HTML representation or trust the notebook. <br />On GitHub, the HTML representation is unable to render, please try loading this page with nbviewer.org.</b></div><div class="sk-container" hidden><div class="sk-item"><div class="sk-estimator fitted sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-1" type="checkbox" checked><label for="sk-estimator-id-1" class="sk-toggleable__label fitted sk-toggleable__label-arrow fitted">&nbsp;&nbsp;LogisticRegressionCV<a class="sk-estimator-doc-link fitted" rel="noreferrer" target="_blank" href="https://scikit-learn.org/1.5/modules/generated/sklearn.linear_model.LogisticRegressionCV.html">?<span>Documentation for LogisticRegressionCV</span></a><span class="sk-estimator-doc-link fitted">i<span>Fitted</span></span></label><div class="sk-toggleable__content fitted"><pre>LogisticRegressionCV(Cs=100, cv=5, fit_intercept=False, multi_class=&#x27;ovr&#x27;,
                     solver=&#x27;liblinear&#x27;)</pre></div> </div></div></div></div>




```python
#In: 
model.C_
```




    array([1.e-04, 1.e-04, 1.e-04, 1.e-04, 1.e-04, 1.e-04, 1.e-04, 1.e-04,
           1.e-04, 1.e-04])




```python
#In: 
print(classification_report(y_test, model.predict(X_test)))
```

                  precision    recall  f1-score   support
    
               0       0.83      0.64      0.72        53
               1       1.00      0.97      0.99        40
               2       0.69      0.54      0.61        63
               3       0.75      0.91      0.82        46
               4       0.59      0.75      0.66        55
               5       1.00      0.69      0.82        52
               6       0.52      0.65      0.58        49
               7       0.85      0.87      0.86        52
               8       0.89      0.79      0.84        43
               9       0.82      0.98      0.89        47
    
        accuracy                           0.77       500
       macro avg       0.79      0.78      0.78       500
    weighted avg       0.79      0.77      0.77       500
    



```python
#In: 
plt.imshow(confusion_matrix(y_test, model.predict(X_test)))
plt.xticks(labels.index - 0.5, '\n\n'+ labels, rotation=90)
plt.yticks(labels.index - 0.5, '\n\n'+ labels);
```


    
![png](16-Pratica_files/16-Pratica_41_0.png)
    


## Regressão

Agora vamos avaliar modelos de regressão em dados tabulares. Primeiro, vamos carregar os dados. Obsevre que cada atributo é diferente. Data, numéricos categóricos, etc...


```python
#In: 
df = pd.read_csv('walmart.csv', on_bad_lines='skip')
df = df.iloc[:, :-1]
df.head()
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
      <th>Store</th>
      <th>Date</th>
      <th>Weekly_Sales_Store</th>
      <th>IsHoliday</th>
      <th>Temperature</th>
      <th>Fuel_Price</th>
      <th>MarkDown1</th>
      <th>MarkDown2</th>
      <th>MarkDown3</th>
      <th>MarkDown4</th>
      <th>MarkDown5</th>
      <th>CPI</th>
      <th>Unemployment</th>
      <th>Type</th>
      <th>Size</th>
      <th>Total Markdown</th>
      <th>Total Sales</th>
      <th>SalesPerSqFt</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>5/2/2010</td>
      <td>1643690.90</td>
      <td>False</td>
      <td>42.31</td>
      <td>2.572</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>211.096358</td>
      <td>8.106</td>
      <td>A</td>
      <td>151315</td>
      <td>0.0</td>
      <td>1643690.90</td>
      <td>10.862710</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>12/2/2010</td>
      <td>1641957.44</td>
      <td>True</td>
      <td>38.51</td>
      <td>2.548</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>211.242170</td>
      <td>8.106</td>
      <td>A</td>
      <td>151315</td>
      <td>0.0</td>
      <td>1641957.44</td>
      <td>10.851254</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1</td>
      <td>19/2/2010</td>
      <td>1611968.17</td>
      <td>False</td>
      <td>39.93</td>
      <td>2.514</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>211.289143</td>
      <td>8.106</td>
      <td>A</td>
      <td>151315</td>
      <td>0.0</td>
      <td>1611968.17</td>
      <td>10.653063</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>26/2/2010</td>
      <td>1409727.59</td>
      <td>False</td>
      <td>46.63</td>
      <td>2.561</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>211.319643</td>
      <td>8.106</td>
      <td>A</td>
      <td>151315</td>
      <td>0.0</td>
      <td>1409727.59</td>
      <td>9.316509</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1</td>
      <td>5/3/2010</td>
      <td>1554806.68</td>
      <td>False</td>
      <td>46.50</td>
      <td>2.625</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>211.350143</td>
      <td>8.106</td>
      <td>A</td>
      <td>151315</td>
      <td>0.0</td>
      <td>1554806.68</td>
      <td>10.275298</td>
    </tr>
  </tbody>
</table>
</div>



Vamos criar o treino e teste


```python
#In: 
from sklearn.model_selection import train_test_split
```


```python
#In: 
train_df, test_df = train_test_split(df, test_size=0.2)
```


```python
#In: 
df.shape
```




    (6435, 18)




```python
#In: 
train_df.shape
```




    (5148, 18)




```python
#In: 
test_df.shape
```




    (1287, 18)



Segundo, temos que converter os atributos categóricos em colunas novas. Para isto, fazemos uso de one hot encoding. Cada categoria vira uma coluna de 1/0. Algoritmos como KNN e Logistic não sabem fazer uso de categorias por padrão. Mesmo se as categorias representarem números, faça uso de one hot. Sempre se pergunte: faz sentido computar uma distância nessa coluna? Se não, one-hot (ou outra abordagem).


```python
#In: 
train_df = train_df.drop(['MarkDown1', 'MarkDown2', 'MarkDown3', 'MarkDown4', 'MarkDown5'], axis='columns')
test_df = test_df.drop(['MarkDown1', 'MarkDown2', 'MarkDown3', 'MarkDown4', 'MarkDown5'], axis='columns')
```


```python
#In: 
train_df.head()
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
      <th>Store</th>
      <th>Date</th>
      <th>Weekly_Sales_Store</th>
      <th>IsHoliday</th>
      <th>Temperature</th>
      <th>Fuel_Price</th>
      <th>CPI</th>
      <th>Unemployment</th>
      <th>Type</th>
      <th>Size</th>
      <th>Total Markdown</th>
      <th>Total Sales</th>
      <th>SalesPerSqFt</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>674</th>
      <td>5</td>
      <td>20/1/2012</td>
      <td>287523.98</td>
      <td>False</td>
      <td>54.65</td>
      <td>3.268</td>
      <td>220.569410</td>
      <td>5.943</td>
      <td>B</td>
      <td>34875</td>
      <td>4270.87</td>
      <td>291794.85</td>
      <td>8.366877</td>
    </tr>
    <tr>
      <th>814</th>
      <td>6</td>
      <td>30/12/2011</td>
      <td>1598080.52</td>
      <td>True</td>
      <td>46.80</td>
      <td>3.129</td>
      <td>221.128263</td>
      <td>6.551</td>
      <td>A</td>
      <td>202505</td>
      <td>92849.95</td>
      <td>1690930.47</td>
      <td>8.350068</td>
    </tr>
    <tr>
      <th>777</th>
      <td>6</td>
      <td>15/4/2011</td>
      <td>1448797.02</td>
      <td>False</td>
      <td>73.17</td>
      <td>3.743</td>
      <td>216.844663</td>
      <td>6.855</td>
      <td>A</td>
      <td>202505</td>
      <td>0.00</td>
      <td>1448797.02</td>
      <td>7.154377</td>
    </tr>
    <tr>
      <th>5353</th>
      <td>38</td>
      <td>15/4/2011</td>
      <td>362758.94</td>
      <td>False</td>
      <td>57.63</td>
      <td>3.868</td>
      <td>128.910733</td>
      <td>13.736</td>
      <td>C</td>
      <td>39690</td>
      <td>0.00</td>
      <td>362758.94</td>
      <td>9.139807</td>
    </tr>
    <tr>
      <th>5100</th>
      <td>36</td>
      <td>2/12/2011</td>
      <td>293350.51</td>
      <td>False</td>
      <td>53.57</td>
      <td>3.164</td>
      <td>217.422921</td>
      <td>7.716</td>
      <td>A</td>
      <td>39910</td>
      <td>634.31</td>
      <td>293984.82</td>
      <td>7.366194</td>
    </tr>
  </tbody>
</table>
</div>




```python
#In: 
train_df.dtypes
```




    Store                   int64
    Date                   object
    Weekly_Sales_Store    float64
    IsHoliday                bool
    Temperature           float64
    Fuel_Price            float64
    CPI                   float64
    Unemployment          float64
    Type                   object
    Size                    int64
    Total Markdown        float64
    Total Sales           float64
    SalesPerSqFt          float64
    dtype: object



Vamos inicialmente converter a data. Note que a mesma existe em uma escala completamente diferente do resto. O split abaixo quebra o texto da data.


```python
#In: 
train_df['Date'].str.split('/')
```




    674      [20, 1, 2012]
    814     [30, 12, 2011]
    777      [15, 4, 2011]
    5353     [15, 4, 2011]
    5100     [2, 12, 2011]
                 ...      
    3638     [22, 4, 2011]
    4665    [21, 10, 2011]
    1058     [11, 3, 2011]
    799      [16, 9, 2011]
    1214     [10, 6, 2011]
    Name: Date, Length: 5148, dtype: object



Agora pegamos o mês


```python
#In: 
for split in train_df['Date'].str.split('/'):
    print(split[1])
    break
```

    1



```python
#In: 
train_df['Month'] = [split[1] for split in train_df['Date'].str.split('/')]
test_df['Month'] = [split[1] for split in test_df['Date'].str.split('/')]
```


```python
#In: 
test_df.head()
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
      <th>Store</th>
      <th>Date</th>
      <th>Weekly_Sales_Store</th>
      <th>IsHoliday</th>
      <th>Temperature</th>
      <th>Fuel_Price</th>
      <th>CPI</th>
      <th>Unemployment</th>
      <th>Type</th>
      <th>Size</th>
      <th>Total Markdown</th>
      <th>Total Sales</th>
      <th>SalesPerSqFt</th>
      <th>Month</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>5640</th>
      <td>40</td>
      <td>22/4/2011</td>
      <td>965056.40</td>
      <td>False</td>
      <td>39.32</td>
      <td>3.919</td>
      <td>134.357100</td>
      <td>4.781</td>
      <td>A</td>
      <td>155083</td>
      <td>0.00</td>
      <td>965056.40</td>
      <td>6.222838</td>
      <td>4</td>
    </tr>
    <tr>
      <th>287</th>
      <td>3</td>
      <td>12/2/2010</td>
      <td>420728.96</td>
      <td>True</td>
      <td>47.93</td>
      <td>2.548</td>
      <td>214.574792</td>
      <td>7.368</td>
      <td>B</td>
      <td>37392</td>
      <td>0.00</td>
      <td>420728.96</td>
      <td>11.251844</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1933</th>
      <td>14</td>
      <td>8/7/2011</td>
      <td>2063401.06</td>
      <td>False</td>
      <td>77.49</td>
      <td>3.711</td>
      <td>186.032016</td>
      <td>8.625</td>
      <td>A</td>
      <td>200898</td>
      <td>0.00</td>
      <td>2063401.06</td>
      <td>10.270889</td>
      <td>7</td>
    </tr>
    <tr>
      <th>2416</th>
      <td>17</td>
      <td>20/7/2012</td>
      <td>944698.70</td>
      <td>False</td>
      <td>70.59</td>
      <td>3.556</td>
      <td>130.701290</td>
      <td>5.936</td>
      <td>B</td>
      <td>93188</td>
      <td>4819.18</td>
      <td>949517.88</td>
      <td>10.189272</td>
      <td>7</td>
    </tr>
    <tr>
      <th>828</th>
      <td>6</td>
      <td>6/4/2012</td>
      <td>1840131.19</td>
      <td>False</td>
      <td>71.60</td>
      <td>3.891</td>
      <td>223.041930</td>
      <td>5.964</td>
      <td>A</td>
      <td>202505</td>
      <td>17583.38</td>
      <td>1857714.57</td>
      <td>9.173673</td>
      <td>4</td>
    </tr>
  </tbody>
</table>
</div>



Removendo a data


```python
#In: 
train_df = train_df.drop(['Date'], axis='columns')
test_df = test_df.drop(['Date'], axis='columns')
train_df.shape
```




    (5148, 13)



One hot encoding do resto categórico


```python
#In: 
cols_usar = ['Temperature', 'Fuel_Price', 'CPI', 'Unemployment', 'Size',
             'Weekly_Sales_Store',
             'Store', 'Month', 'Type', 'IsHoliday']
cols_cat = ['Store', 'Month', 'Type', 'IsHoliday']
train_df = pd.get_dummies(train_df[cols_usar],
                          columns=cols_cat)
test_df = pd.get_dummies(test_df[cols_usar],
                         columns=cols_cat)
```

Vamos focar em poucos pontos para o notebook executar e só olhar para o teste no fim de tudo!


```python
#In: 
train_df = train_df.sample(1000)
test_df = test_df.sample(1000)
```

*Normalizando dados*: Como trabalhar com esse mundo de valores distintos? Solução!? Normalizar!


```python
#In: 
y_train_df = train_df['Weekly_Sales_Store']
X_train_df = train_df.drop('Weekly_Sales_Store', axis='columns')
```


```python
#In: 
X_train_df
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
      <th>Temperature</th>
      <th>Fuel_Price</th>
      <th>CPI</th>
      <th>Unemployment</th>
      <th>Size</th>
      <th>Store_1</th>
      <th>Store_2</th>
      <th>Store_3</th>
      <th>Store_4</th>
      <th>Store_5</th>
      <th>...</th>
      <th>Month_5</th>
      <th>Month_6</th>
      <th>Month_7</th>
      <th>Month_8</th>
      <th>Month_9</th>
      <th>Type_A</th>
      <th>Type_B</th>
      <th>Type_C</th>
      <th>IsHoliday_False</th>
      <th>IsHoliday_True</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3344</th>
      <td>26.09</td>
      <td>3.452</td>
      <td>133.492143</td>
      <td>8.252</td>
      <td>203819</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3660</th>
      <td>50.72</td>
      <td>3.758</td>
      <td>136.367000</td>
      <td>7.767</td>
      <td>152513</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5621</th>
      <td>21.64</td>
      <td>3.132</td>
      <td>132.676400</td>
      <td>5.287</td>
      <td>155083</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
    </tr>
    <tr>
      <th>6268</th>
      <td>65.17</td>
      <td>3.808</td>
      <td>131.098323</td>
      <td>5.621</td>
      <td>39910</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>True</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1756</th>
      <td>42.55</td>
      <td>2.831</td>
      <td>126.546161</td>
      <td>7.795</td>
      <td>219622</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
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
      <td>...</td>
      <td>...</td>
      <td>...</td>
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
      <th>6124</th>
      <td>67.59</td>
      <td>3.688</td>
      <td>213.162352</td>
      <td>9.575</td>
      <td>41062</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>True</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5578</th>
      <td>20.84</td>
      <td>2.771</td>
      <td>131.586613</td>
      <td>5.892</td>
      <td>155083</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
    </tr>
    <tr>
      <th>638</th>
      <td>77.38</td>
      <td>3.899</td>
      <td>216.534361</td>
      <td>6.489</td>
      <td>34875</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>...</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4013</th>
      <td>57.06</td>
      <td>2.849</td>
      <td>131.940807</td>
      <td>10.160</td>
      <td>93638</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5195</th>
      <td>52.88</td>
      <td>2.943</td>
      <td>210.182398</td>
      <td>8.476</td>
      <td>39910</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
<p>1000 rows × 67 columns</p>
</div>




```python
#In: 
from sklearn.preprocessing import StandardScaler
```

**IMPORTANTE SÓ NORMALIZE O TREINO!!! DEPOIS USE A MÉDIA E DESVIO DO TREINO PARA NORMALIZAR O TESTE!!**

**O TESTE É UM FUTURO! NÃO EXISTE, VOCÊ NÃO SABE NADA DO MESMO**


```python
#In: 
scaler_x = StandardScaler()
scaler_y = StandardScaler()

X_train = scaler_x.fit_transform(X_train_df.values)
y_train = scaler_y.fit_transform(y_train_df.values[:, np.newaxis])
```


```python
#In: 
X_train
```




    array([[-1.87152755,  0.2070454 , -0.93995305, ..., -0.38313051,
             0.29887224, -0.29887224],
           [-0.53069913,  0.88092237, -0.86770187, ..., -0.38313051,
             0.29887224, -0.29887224],
           [-2.11378035, -0.49766255, -0.96045437, ..., -0.38313051,
             0.29887224, -0.29887224],
           ...,
           [ 0.92064012,  1.19143432,  1.14707175, ..., -0.38313051,
             0.29887224, -0.29887224],
           [-0.18555693, -1.12088864, -0.97894138, ..., -0.38313051,
             0.29887224, -0.29887224],
           [-0.41311125, -0.91388068,  0.98743362, ...,  2.61007663,
            -3.34591123,  3.34591123]])




```python
#In: 
y_train
```




    array([[ 3.26152161e-01],
           [-2.22516620e-01],
           [ 1.07891426e-01],
           [-1.26110562e+00],
           [ 1.56773934e+00],
           [ 1.48734316e+00],
           [-1.18349730e+00],
           [ 1.79008233e+00],
           [-6.69577792e-01],
           [ 8.69295197e-01],
           [-7.63381516e-01],
           [-1.11982645e+00],
           [-8.71395571e-01],
           [-1.32336540e+00],
           [ 2.11599466e+00],
           [ 1.52276082e+00],
           [ 1.58538842e+00],
           [-1.30867923e+00],
           [ 8.63966406e-01],
           [-4.36118801e-01],
           [ 1.26158469e+00],
           [ 8.96000082e-01],
           [-8.96032693e-01],
           [ 4.21205745e-01],
           [ 1.70278300e-01],
           [ 8.94511150e-01],
           [-7.94946120e-01],
           [ 1.09096102e+00],
           [ 7.70794148e-01],
           [-1.84646433e-01],
           [-8.37321769e-01],
           [-1.58272729e-01],
           [-3.75656409e-01],
           [-2.22595148e-01],
           [-1.04636060e+00],
           [-9.35955900e-01],
           [-4.09066370e-01],
           [ 5.08479205e-01],
           [-9.26790386e-01],
           [-1.47016707e+00],
           [-1.35330779e+00],
           [ 1.76714343e+00],
           [-1.31418623e+00],
           [-1.29940795e+00],
           [-1.87602314e-01],
           [-1.34795136e+00],
           [-1.99856880e-01],
           [-8.80011530e-01],
           [ 1.37872846e+00],
           [ 1.97067574e+00],
           [ 6.56739546e-01],
           [-9.43903543e-01],
           [-3.10711174e-01],
           [-4.97816080e-01],
           [ 1.44964199e+00],
           [ 3.09556905e-01],
           [ 4.90584644e-01],
           [-1.86745552e-01],
           [-9.17981260e-01],
           [ 1.83262850e+00],
           [-7.86641279e-01],
           [ 1.76682530e+00],
           [-6.22960379e-01],
           [-8.93807186e-01],
           [-1.08857835e+00],
           [ 3.18182165e-01],
           [-3.09166472e-01],
           [ 1.42612635e-01],
           [-1.00934168e+00],
           [ 1.95543452e+00],
           [-2.65850177e-01],
           [-1.36953542e+00],
           [-1.17948716e+00],
           [-9.02680748e-01],
           [-4.86845196e-01],
           [-3.94935006e-01],
           [-3.20461825e-01],
           [-1.07198195e+00],
           [ 5.18567116e-01],
           [-6.51250516e-01],
           [ 2.54306094e-01],
           [ 1.47873450e-01],
           [ 6.07007892e-01],
           [-2.26860869e-01],
           [ 1.22961022e+00],
           [ 6.59745049e-01],
           [-3.66418955e-01],
           [ 1.86785815e-01],
           [ 1.54607187e+00],
           [-2.60554010e-01],
           [ 5.33410199e-01],
           [-4.80467110e-01],
           [ 5.88832511e-01],
           [-1.04611814e-03],
           [ 4.66245780e-01],
           [ 2.26662853e-01],
           [ 2.09374125e+00],
           [ 7.33136558e-01],
           [-3.53595705e-01],
           [-5.77253331e-01],
           [-1.43181798e+00],
           [ 5.22075265e-01],
           [-4.17045490e-01],
           [-1.03999220e-01],
           [-8.18075127e-01],
           [-7.37693179e-01],
           [ 1.54669175e+00],
           [ 1.55250381e-01],
           [-2.72938239e-01],
           [ 4.41329079e+00],
           [-1.29952212e+00],
           [-1.20804236e-01],
           [ 1.98221336e-02],
           [-1.08579445e+00],
           [-1.29252879e+00],
           [ 5.46391387e-01],
           [-7.66611752e-01],
           [-1.27738424e+00],
           [ 9.61670003e-01],
           [ 4.70116747e-01],
           [ 3.81540334e-01],
           [-1.32149836e+00],
           [-4.71579826e-01],
           [-1.45489131e+00],
           [ 1.37300645e+00],
           [-1.11051876e-01],
           [ 2.42972676e+00],
           [ 2.12882371e+00],
           [ 1.68819177e+00],
           [ 4.74001243e-01],
           [ 2.39410680e-02],
           [ 1.25950981e+00],
           [ 1.58427930e+00],
           [ 5.66323802e-01],
           [-1.29121691e+00],
           [-7.74869684e-01],
           [-3.62153639e-01],
           [-9.18065249e-01],
           [ 4.42524344e-01],
           [ 5.96181245e-02],
           [ 7.94885347e-02],
           [ 5.47038565e-01],
           [-1.87602314e-01],
           [-8.71935650e-01],
           [ 9.07034930e-02],
           [-2.65864041e-01],
           [-1.97305406e-01],
           [-1.03295676e+00],
           [-1.07879858e+00],
           [-5.83386232e-01],
           [ 9.04396452e-01],
           [-1.29371014e-01],
           [-1.02205112e+00],
           [-9.35226512e-01],
           [-1.10096010e+00],
           [ 5.86260850e-01],
           [-1.25365276e+00],
           [-5.19208028e-01],
           [ 8.76813525e-01],
           [ 2.21548332e-01],
           [-4.96561604e-01],
           [ 4.16504103e-01],
           [-1.45352478e+00],
           [ 5.02500982e-01],
           [-5.18168544e-01],
           [ 6.46381231e-02],
           [-1.88337762e-01],
           [-2.21362515e-01],
           [-2.99105055e-01],
           [-4.05242629e-01],
           [-1.66390833e-01],
           [ 7.87583593e-01],
           [-4.65831479e-01],
           [ 1.63011422e+00],
           [ 2.94013780e-01],
           [ 4.66079283e-01],
           [ 1.14981302e-01],
           [-1.31038072e+00],
           [-6.44037898e-01],
           [-7.99280804e-01],
           [ 6.60132229e-01],
           [-2.78837601e-01],
           [-1.90975514e-01],
           [-4.11071177e-01],
           [-9.30198975e-01],
           [ 3.25514865e-01],
           [-7.43122446e-01],
           [ 1.76226557e+00],
           [-1.01581554e+00],
           [ 3.25718830e-01],
           [ 8.03529187e-01],
           [-6.01375281e-01],
           [-2.89580122e-01],
           [-8.07409195e-01],
           [-2.75607999e-01],
           [-2.73526248e-01],
           [-3.34230794e-01],
           [-9.14441140e-01],
           [-1.42946252e-01],
           [ 8.98233041e-01],
           [-6.56704075e-01],
           [ 4.17243778e-01],
           [-1.36582551e+00],
           [ 8.49664369e-01],
           [-1.19393634e+00],
           [ 5.93475920e-02],
           [-5.66220318e-01],
           [-1.06237072e+00],
           [-1.23536510e+00],
           [ 4.99178848e-01],
           [ 7.75538471e-01],
           [-5.19436777e-01],
           [-8.87350642e-01],
           [-8.28070928e-01],
           [ 1.10807620e-01],
           [ 2.39886392e+00],
           [ 6.76542279e-01],
           [-3.17148429e-01],
           [-8.21997283e-01],
           [ 5.29650084e-01],
           [-1.02761338e+00],
           [ 1.59143414e+00],
           [-9.89269369e-01],
           [ 1.67229235e-01],
           [-1.22656279e+00],
           [ 9.56580794e-01],
           [-9.87491285e-01],
           [ 4.97264494e-01],
           [-3.61176249e-01],
           [-4.88126235e-01],
           [-1.33781503e+00],
           [-8.81283533e-01],
           [ 1.97003185e+00],
           [-1.56566673e-01],
           [ 7.71243350e-01],
           [ 6.93889981e-01],
           [-7.53668331e-01],
           [-1.17812222e+00],
           [ 1.04722432e+00],
           [ 8.26230499e-01],
           [-1.63132237e-01],
           [-4.15928624e-01],
           [-9.33851109e-01],
           [ 1.57561071e+00],
           [ 1.55162159e+00],
           [-6.35269128e-01],
           [ 1.40495482e+00],
           [ 1.26710561e+00],
           [ 1.41483579e+00],
           [-8.15511252e-01],
           [-7.81678882e-01],
           [-9.07503757e-01],
           [ 9.29327604e-01],
           [ 5.49552977e-01],
           [-6.04402606e-02],
           [-7.22457543e-01],
           [ 1.62938548e+00],
           [ 8.79251346e-01],
           [ 1.43865064e+00],
           [ 1.32590765e+00],
           [-6.89626872e-01],
           [-1.30426064e+00],
           [ 1.85411705e+00],
           [ 9.10253202e-01],
           [-4.10656765e-01],
           [-8.65783794e-01],
           [ 7.86230684e-01],
           [ 1.31215175e+00],
           [ 2.50176403e+00],
           [ 3.45010426e-01],
           [-1.15387134e+00],
           [-1.09885407e+00],
           [-1.29599129e-01],
           [-3.41879985e-01],
           [ 8.43482927e-03],
           [ 1.91532622e-01],
           [ 6.33400815e-01],
           [-1.21429364e+00],
           [ 1.14614588e+00],
           [ 1.51987293e+00],
           [ 8.25927449e-01],
           [ 4.29351628e-01],
           [ 3.22035323e-01],
           [ 1.05628599e+00],
           [-1.24695267e+00],
           [-9.42858651e-01],
           [ 1.47337414e+00],
           [ 1.24251131e+00],
           [-7.79451155e-01],
           [-1.06709414e+00],
           [ 7.10527619e-01],
           [ 3.15823329e-01],
           [ 1.12464278e+00],
           [-8.61733013e-01],
           [-1.04295758e+00],
           [ 9.62415367e-01],
           [ 1.77502169e+00],
           [-7.28011191e-01],
           [ 2.35645135e-01],
           [-8.23653541e-01],
           [-4.19433637e-01],
           [ 4.78552634e+00],
           [ 1.31040249e-01],
           [-3.07547593e-01],
           [ 1.92274498e-01],
           [-5.29186460e-01],
           [-1.21536364e+00],
           [ 1.66180951e+00],
           [-1.03645809e-01],
           [-3.97865920e-03],
           [-5.92098387e-01],
           [-2.43840768e-01],
           [ 6.86047166e-01],
           [ 8.32393505e-01],
           [ 1.74733233e+00],
           [-8.10511387e-01],
           [-9.88703996e-01],
           [-1.07598840e+00],
           [-9.36629589e-01],
           [-9.57718769e-01],
           [-6.95175640e-01],
           [ 6.27374995e-01],
           [ 1.45091913e+00],
           [ 2.57059243e-01],
           [ 1.24455943e-01],
           [-1.02097127e+00],
           [-9.26309001e-01],
           [-3.94243667e-01],
           [-6.60008998e-01],
           [ 4.53086015e-02],
           [ 8.80243097e-02],
           [ 4.61179683e-01],
           [-1.01935757e+00],
           [-1.25820015e+00],
           [ 1.54928226e+00],
           [ 4.40619713e-01],
           [ 6.54120078e-01],
           [-1.40137466e+00],
           [ 5.75227239e-01],
           [-8.17089845e-01],
           [ 1.57855502e+00],
           [-2.79338397e-01],
           [ 2.77150458e-01],
           [ 8.82165255e-02],
           [-4.71495080e-01],
           [-8.93854465e-01],
           [ 1.31756373e-01],
           [ 3.90491755e-01],
           [ 4.17597982e-01],
           [-7.82417499e-01],
           [ 1.53954193e+00],
           [-9.09646015e-01],
           [-7.22773223e-01],
           [ 8.33976237e-01],
           [-1.07664368e+00],
           [ 1.91517523e+00],
           [-1.02867534e+00],
           [ 1.77986832e+00],
           [ 6.48074970e-01],
           [-7.58272825e-01],
           [-1.03650180e+00],
           [ 2.48637236e+00],
           [-2.51373875e-01],
           [-7.41553295e-01],
           [ 1.49828531e+00],
           [ 4.47331482e-01],
           [-1.02232238e+00],
           [-9.63629615e-01],
           [-9.54853975e-01],
           [ 2.43127546e-01],
           [ 5.68154432e-01],
           [ 4.41574809e+00],
           [-7.83673173e-01],
           [-1.30354059e-01],
           [ 2.65850366e-01],
           [-1.08069160e+00],
           [ 2.03850270e+00],
           [ 2.03216926e+00],
           [ 2.62012692e-01],
           [ 1.76853072e+00],
           [-9.21494412e-01],
           [-9.71868400e-01],
           [ 5.13082149e-01],
           [-2.54027305e-01],
           [ 9.23596573e-01],
           [-1.95711452e-01],
           [-7.75468949e-01],
           [-9.59528877e-01],
           [ 1.24707308e+00],
           [ 1.76132138e+00],
           [ 4.46131683e-01],
           [-9.57316528e-01],
           [-9.21106087e-01],
           [-6.80711228e-01],
           [ 1.95922035e-01],
           [-1.43499278e-01],
           [ 3.60960199e-02],
           [-7.79243174e-01],
           [-1.35868626e+00],
           [ 1.81105656e+00],
           [-2.32372822e-01],
           [-2.80818187e-01],
           [-1.73326084e-01],
           [-1.00616146e+00],
           [-1.10362797e+00],
           [ 7.10030028e-01],
           [ 5.08381864e-01],
           [-1.70253450e-01],
           [ 2.46473037e-01],
           [ 2.34166613e-01],
           [-9.00715099e-01],
           [-1.25920426e+00],
           [ 1.26798129e+00],
           [-7.17176242e-01],
           [-3.16280129e-01],
           [ 2.14671845e-01],
           [-5.10786398e-01],
           [ 4.27112821e-01],
           [-3.42624416e-01],
           [ 1.60765578e+00],
           [ 7.54932472e-01],
           [-3.88868742e-01],
           [-1.41257928e+00],
           [ 1.56050474e+00],
           [ 1.25290683e+00],
           [-1.42776292e+00],
           [-4.99202862e-01],
           [-1.12834219e+00],
           [ 2.34062201e+00],
           [ 1.11580180e+00],
           [ 1.04300371e+00],
           [-3.63050036e-01],
           [-5.55759145e-01],
           [-7.77227920e-01],
           [ 6.24542754e-01],
           [ 6.53775439e-01],
           [-1.26590344e+00],
           [-2.07905052e-01],
           [ 1.26893344e+00],
           [-1.18558507e-01],
           [-6.50037401e-01],
           [ 3.03939473e-01],
           [-1.20308971e+00],
           [-6.28696184e-01],
           [-3.25577174e-01],
           [-6.92233252e-01],
           [ 1.02272847e+00],
           [-8.06085510e-01],
           [ 2.88701231e-01],
           [-1.08256839e+00],
           [-1.84427390e-01],
           [ 1.59166085e+00],
           [ 1.45645346e+00],
           [-9.29040889e-01],
           [ 1.01838866e+00],
           [ 2.21641290e-02],
           [-1.03185122e+00],
           [-8.73583682e-01],
           [-6.25688215e-01],
           [ 6.51662263e-01],
           [-6.92926741e-01],
           [ 1.32471862e-01],
           [-2.37631029e-01],
           [-2.95640908e-01],
           [ 1.02373484e+00],
           [ 3.61090529e-01],
           [-1.35868354e-01],
           [-1.30713180e+00],
           [ 1.21188478e+00],
           [-3.42471975e-01],
           [ 1.36471951e+00],
           [ 3.69759809e-01],
           [-1.26140844e+00],
           [-9.29494178e-01],
           [-3.66529631e-01],
           [-3.14785031e-01],
           [-2.91074850e-01],
           [ 1.17455514e+00],
           [-1.47963158e+00],
           [ 1.12996035e+00],
           [-2.57814724e-01],
           [ 5.68146910e-01],
           [-7.00470998e-01],
           [ 1.19601245e-01],
           [ 4.11841110e-01],
           [-8.90544715e-01],
           [-9.84655680e-01],
           [-8.32783402e-01],
           [ 2.46047792e-01],
           [ 6.46403105e-01],
           [-7.25187493e-01],
           [ 8.81492813e-01],
           [-1.42165161e+00],
           [ 8.63486466e-01],
           [ 1.61066835e+00],
           [-4.36608729e-01],
           [-2.49583707e-01],
           [ 1.54972214e+00],
           [ 4.35948141e-01],
           [ 6.21551220e-01],
           [-1.11814231e+00],
           [-2.40181517e-01],
           [ 3.62284145e-01],
           [-3.10996450e-01],
           [ 1.55629750e+00],
           [ 6.25510315e-01],
           [ 5.95657967e-01],
           [-4.57677775e-01],
           [-7.55828468e-01],
           [-1.32567831e+00],
           [-1.32609248e+00],
           [-8.63096451e-02],
           [-7.33572853e-01],
           [ 1.11777154e+00],
           [-1.21677941e+00],
           [-5.84540126e-01],
           [-3.15910212e-01],
           [ 2.41335000e-01],
           [-1.59834253e-01],
           [-1.00174898e-01],
           [ 7.65801770e-01],
           [ 3.05524482e-02],
           [-1.89346296e-01],
           [-1.06964357e+00],
           [-3.60605450e-01],
           [ 5.43386166e-01],
           [-2.91939293e-01],
           [-5.69819449e-01],
           [-1.27667978e+00],
           [-9.85900996e-01],
           [-1.39731482e-01],
           [ 6.34184157e-01],
           [ 8.14990496e-02],
           [-9.96783223e-01],
           [ 4.66899740e-01],
           [ 4.75267732e-01],
           [-7.04362715e-01],
           [-1.09417801e+00],
           [ 1.40336830e+00],
           [-1.11158345e+00],
           [ 5.01335092e-01],
           [ 2.70772619e-01],
           [-4.04755519e-01],
           [ 1.24824179e+00],
           [-1.17501679e+00],
           [ 1.16566096e-01],
           [-1.25723282e+00],
           [-6.40253104e-01],
           [-6.27414669e-01],
           [ 9.65507712e-01],
           [-1.30502170e+00],
           [-2.64457864e-01],
           [-6.08831534e-01],
           [-9.46162747e-01],
           [-9.42820180e-01],
           [-1.35163824e+00],
           [-9.44123749e-01],
           [ 1.02683296e+00],
           [-1.16897503e+00],
           [-8.00684744e-01],
           [-1.35236354e+00],
           [-1.25445288e+00],
           [ 4.53088125e-01],
           [-1.37005771e+00],
           [-8.83288446e-01],
           [ 5.76641078e-01],
           [ 1.25910847e+00],
           [ 5.20253302e-01],
           [-4.96132994e-01],
           [-7.66302149e-01],
           [-1.30904518e+00],
           [ 6.50009458e-01],
           [ 6.41437044e-01],
           [ 1.10535782e+00],
           [ 8.78455620e-01],
           [-1.33927233e+00],
           [-8.58573114e-01],
           [-1.30707756e+00],
           [ 1.39599433e+00],
           [-1.25035201e+00],
           [-9.96896453e-01],
           [ 5.99279804e-01],
           [ 1.76809922e+00],
           [ 2.08209530e+00],
           [-5.97618862e-02],
           [-1.26731333e+00],
           [-7.34130634e-01],
           [-1.91139335e-01],
           [-1.94821239e-01],
           [ 4.59256592e-01],
           [-3.38507120e-01],
           [-2.35273180e-01],
           [ 5.96727379e-01],
           [ 7.49907189e-01],
           [-7.16653656e-01],
           [ 6.86873295e-01],
           [-1.90484653e-01],
           [-6.61460781e-01],
           [-1.68923001e-01],
           [-6.58487950e-02],
           [-3.51452073e-01],
           [ 2.04585405e+00],
           [ 6.70931753e-01],
           [ 1.62883223e+00],
           [-1.08672472e+00],
           [-8.65997342e-01],
           [-1.41912015e+00],
           [-5.90347466e-01],
           [ 4.09396418e-01],
           [ 1.80511508e+00],
           [-1.23494097e+00],
           [ 3.05426556e-01],
           [-7.38061510e-01],
           [ 6.21263989e-01],
           [-8.83262059e-01],
           [-6.73974957e-01],
           [-7.85734010e-02],
           [ 1.42850784e+00],
           [ 7.87550106e-01],
           [ 5.64184556e-01],
           [ 1.35992771e+00],
           [ 7.16641426e-01],
           [ 8.41100622e-01],
           [ 3.17571714e-01],
           [ 9.37478155e-01],
           [ 1.34895262e+00],
           [-9.47858040e-01],
           [ 1.73983706e+00],
           [ 1.58027893e+00],
           [ 1.55266374e+00],
           [-1.32942594e+00],
           [-1.84427390e-01],
           [-1.26966392e+00],
           [ 2.30238433e-01],
           [ 4.74478647e-01],
           [-1.01258369e+00],
           [-1.25019140e+00],
           [-6.63591413e-01],
           [-7.69643906e-01],
           [-1.11051876e-01],
           [ 4.71050910e-01],
           [-9.59572879e-01],
           [ 5.97164268e-01],
           [-4.64169760e-01],
           [ 7.02793577e-01],
           [ 1.23346355e+00],
           [-2.46127734e-01],
           [-1.36378898e+00],
           [-8.29317582e-01],
           [ 6.48342120e-01],
           [-9.79949547e-01],
           [ 2.63069491e-01],
           [ 8.73898123e-01],
           [-1.07935231e+00],
           [-8.08499974e-01],
           [ 3.48520290e-03],
           [-7.27284093e-01],
           [ 4.40695528e-01],
           [-1.36299774e+00],
           [-1.15874461e+00],
           [ 5.04771883e-01],
           [ 3.81549952e-01],
           [ 1.27599481e+00],
           [-6.55177974e-01],
           [ 2.07275938e+00],
           [-5.58585660e-01],
           [-7.02521887e-01],
           [ 1.38903160e+00],
           [ 1.55358855e-01],
           [-1.25458657e+00],
           [ 1.63136061e+00],
           [ 5.71318875e-01],
           [-8.97975531e-01],
           [-6.62169294e-01],
           [ 1.39274912e-01],
           [-2.98556006e-02],
           [ 1.00107561e+00],
           [-9.60026168e-01],
           [-9.82219532e-01],
           [-1.09946546e+00],
           [ 1.93494783e-01],
           [-1.35976878e+00],
           [ 6.74343058e-02],
           [ 8.44906096e-01],
           [ 4.48331102e-01],
           [ 1.25520318e+00],
           [ 2.91899601e-01],
           [-3.66724700e-01],
           [ 5.66217530e-01],
           [-1.01859675e+00],
           [ 4.51348213e-01],
           [ 9.97051813e-01],
           [-9.21868996e-01],
           [-9.57716655e-01],
           [-6.64325433e-01],
           [-8.77957242e-01],
           [-8.45919457e-02],
           [-6.38186415e-01],
           [-1.16723201e+00],
           [-9.98403511e-01],
           [ 4.35570650e-01],
           [-8.70206360e-01],
           [-1.17835821e+00],
           [-1.03987903e+00],
           [-1.00856371e+00],
           [-1.02696665e+00],
           [-9.36592720e-01],
           [ 1.70701657e+00],
           [ 9.99912625e-01],
           [-9.36674067e-01],
           [ 4.81810607e-01],
           [ 1.90781863e+00],
           [ 1.33448185e+00],
           [-2.37642667e-03],
           [-5.74967474e-01],
           [-9.21001771e-01],
           [-1.34751492e+00],
           [-1.35510185e+00],
           [-3.13757015e-01],
           [ 6.99908790e-01],
           [-7.06024029e-01],
           [-7.04078848e-01],
           [-8.55497732e-01],
           [ 2.58084955e-02],
           [ 4.20303128e+00],
           [ 1.85573027e+00],
           [-1.10378758e+00],
           [-1.50145800e-01],
           [ 1.51526886e+00],
           [-5.84067901e-01],
           [ 3.45742386e-01],
           [ 2.10754867e+00],
           [-9.48836276e-01],
           [ 1.48956095e+00],
           [-1.31016119e+00],
           [-1.19305648e+00],
           [-1.07359502e+00],
           [-1.32667640e+00],
           [ 9.14818344e-01],
           [ 1.55680316e+00],
           [ 1.21780506e+00],
           [-1.92729976e-01],
           [-4.14329174e-01],
           [ 1.27451153e+00],
           [ 4.28938748e-01],
           [ 1.78349442e-01],
           [ 6.78748942e-02],
           [-1.34916281e+00],
           [ 7.13681546e-01],
           [ 2.36451025e-01],
           [ 1.66852660e+00],
           [-3.48131260e-01],
           [-1.33421296e+00],
           [ 5.35889821e-01],
           [-1.32427726e+00],
           [ 3.61311669e-01],
           [-1.08984438e+00],
           [ 1.55740813e+00],
           [-7.63198513e-01],
           [ 8.42351120e-02],
           [-1.32292560e+00],
           [-9.86958940e-01],
           [-8.73821256e-01],
           [-4.92761168e-01],
           [-7.58556410e-01],
           [ 1.29015558e-02],
           [ 1.91140501e+00],
           [ 2.21036209e-01],
           [ 4.49363962e-01],
           [ 1.18685246e+00],
           [-1.16286527e+00],
           [-2.07099197e-01],
           [-9.42960854e-01],
           [ 3.18936566e-01],
           [ 4.88744555e-01],
           [-9.60664803e-01],
           [-2.26709151e-01],
           [-1.32288565e-01],
           [ 6.02659099e-01],
           [-1.35687076e+00],
           [-8.15903205e-01],
           [-4.76248192e-01],
           [ 1.46191938e+00],
           [ 3.67001939e-01],
           [-8.78830703e-01],
           [ 7.15621196e-01],
           [-1.29929608e+00],
           [ 2.47579212e-01],
           [-1.31852636e+00],
           [-1.13222940e+00],
           [-5.95788126e-02],
           [ 1.59565836e+00],
           [-1.42867327e+00],
           [ 1.28898611e+00],
           [-2.33000306e-01],
           [-6.80736150e-02],
           [ 3.34832027e-01],
           [-5.66598074e-01],
           [-9.45268077e-01],
           [-6.79985328e-01],
           [-9.48811562e-01],
           [ 4.66849079e-01],
           [-7.79903581e-01],
           [ 2.64013131e-01],
           [-1.39255379e+00],
           [ 8.89175630e-01],
           [-1.27517857e+00],
           [ 1.22578958e+00],
           [-1.38643457e+00],
           [-1.24936279e+00],
           [-1.07918018e+00],
           [ 9.21268546e-01],
           [-8.13151024e-01],
           [ 1.39864605e+00],
           [-1.40349984e+00],
           [ 1.22350500e+00],
           [-9.19477661e-01],
           [-4.74763981e-01],
           [ 2.18529711e+00],
           [-4.52476147e-01],
           [ 5.32814017e-01],
           [-4.20380307e-01],
           [ 4.48511921e-01],
           [-1.12222853e+00],
           [-8.81167590e-01],
           [ 9.06384296e-01],
           [-8.06060884e-01],
           [-1.37342078e+00],
           [-4.26172410e-01],
           [ 1.59543816e+00],
           [-9.65208560e-01],
           [ 1.82036648e+00],
           [-1.25444102e+00],
           [ 2.33585838e+00],
           [-5.50320700e-01],
           [-8.31738211e-01],
           [ 9.60719493e-01],
           [ 8.35701388e-01],
           [-6.55422401e-01],
           [ 5.42026581e-01],
           [-1.70222994e-01],
           [-8.29489540e-01],
           [ 3.06414896e+00],
           [-3.04011700e-01],
           [ 7.25305562e-01],
           [ 3.36368661e-01],
           [ 5.51685863e-01],
           [ 2.03692630e+00],
           [ 8.14276641e-01],
           [ 1.73787876e-01],
           [ 3.72016794e-01],
           [-6.31969084e-01],
           [ 1.43434740e+00],
           [-8.96336447e-01],
           [ 1.81597139e+00],
           [ 7.63668605e-02],
           [ 1.78873267e+00],
           [-9.33038191e-01],
           [ 7.97252440e-01],
           [ 3.85418858e-01],
           [ 1.89836831e+00],
           [ 3.68704965e-01],
           [-1.27962530e-01],
           [ 1.83755725e+00],
           [-2.10429962e-01],
           [-7.96828164e-02],
           [-9.75087499e-02],
           [-4.90874663e-01],
           [-6.41954157e-01],
           [-9.59381773e-01],
           [ 1.78021960e+00],
           [-1.18678502e+00],
           [-2.32447475e-01],
           [ 1.62124823e+00],
           [-7.50199199e-01],
           [-9.04408664e-01],
           [-6.08816033e-01],
           [-4.20297305e-01],
           [ 4.69299531e-01],
           [-4.89106180e-01],
           [ 1.50744124e+00],
           [ 6.24648779e-01],
           [-5.22320982e-01],
           [ 2.65850366e-01],
           [ 2.89270832e-01],
           [ 6.56593940e-01],
           [ 3.33807041e-01],
           [-4.14037451e-01],
           [-7.15369728e-01],
           [-1.00530933e+00],
           [-8.81525758e-01],
           [-8.27050838e-01],
           [ 5.46686932e-01],
           [-1.35567241e+00],
           [ 1.51162874e+00],
           [ 1.07472257e+00],
           [-1.24704616e+00],
           [ 1.06180649e-01],
           [ 1.71674438e+00],
           [-1.30620012e+00],
           [-1.13966149e+00],
           [-6.76909400e-01],
           [-9.33913414e-01],
           [-1.40410452e-02],
           [ 1.49457163e+00],
           [-9.35835290e-01],
           [-4.94362344e-01],
           [-7.93519369e-01],
           [-5.13401921e-01],
           [ 4.61513066e-01],
           [ 1.52008184e+00],
           [-9.28577947e-01],
           [-3.15820463e-01],
           [ 1.96727225e-02],
           [-6.72663162e-01],
           [-7.41569832e-02],
           [-1.36885519e-01],
           [ 1.59165220e+00],
           [-8.04705632e-01],
           [ 5.18371165e-01],
           [ 1.88234849e-01],
           [ 3.83397175e-01],
           [ 1.97172512e-01],
           [ 1.54597666e+00],
           [-6.16857687e-01],
           [ 1.77009901e+00],
           [ 3.44914635e-01],
           [-8.71754479e-01],
           [-1.42804715e-01],
           [ 1.49518712e+00],
           [-1.01172393e+00],
           [ 4.62646489e+00],
           [ 1.60831052e+00],
           [-7.16599754e-01],
           [-3.79767981e-01],
           [-7.43093329e-01],
           [ 1.74609376e+00],
           [ 4.60433544e-01],
           [ 1.39011626e+00],
           [ 3.95452866e-01],
           [ 1.96151789e+00],
           [-1.40465732e-01],
           [-1.54115588e-01],
           [ 5.03929582e-01],
           [-1.03773553e-01],
           [ 1.51192356e+00],
           [-9.38786855e-01],
           [ 3.07398776e-01],
           [-9.37291916e-01],
           [ 4.54920006e-01],
           [ 5.05327621e-01],
           [-1.31501514e+00],
           [ 4.16460506e-01],
           [ 5.78433325e-01],
           [-7.72554446e-01],
           [-6.35917645e-01],
           [ 4.99870363e-01],
           [-3.23944609e-01],
           [-9.19540776e-01],
           [-7.28466628e-01],
           [-1.33317041e+00],
           [ 1.57065792e-01],
           [-1.24113212e+00],
           [ 1.08635399e-01],
           [ 3.78319681e-01],
           [-4.11889785e-01],
           [-1.95618955e-01],
           [ 3.58202748e-01],
           [ 1.00518286e+00],
           [-1.89620369e-01],
           [-8.17464676e-01],
           [ 1.77400295e+00],
           [-9.11098643e-01],
           [-1.57739027e-01],
           [-1.31579980e-01],
           [ 7.30139105e-01],
           [ 1.32604366e+00],
           [-1.20079133e+00],
           [-1.69318636e-01],
           [-1.30629290e+00],
           [ 8.57121115e-01],
           [ 1.12039624e+00],
           [ 9.41802816e-01],
           [-2.44968010e-01],
           [-1.88202196e-01],
           [ 4.67067647e-01],
           [ 1.86185821e+00],
           [-3.43205273e-01],
           [-1.07598861e+00],
           [-1.14037641e+00],
           [ 7.10274226e-01],
           [-4.59630724e-01],
           [-2.13897667e-01],
           [-8.73484491e-01],
           [ 8.69677268e-01],
           [-7.21878729e-01],
           [-1.66687929e-01],
           [-1.33704849e+00],
           [-8.45575016e-01],
           [-1.03864604e+00]])




```python
#In: 
from sklearn.linear_model import LinearRegression # sem regularizar
from sklearn.linear_model import Lasso # com regularização l1
from sklearn.linear_model import Ridge # com regularização l2
from sklearn.neighbors import KNeighborsRegressor

from sklearn.model_selection import GridSearchCV
```

O gridsearch cv faz o laço que fizemos na mão acima (conjuntos de validação)


```python
#In: 
linear = LinearRegression(fit_intercept=False)
lasso = GridSearchCV(Lasso(fit_intercept=False),
                     cv=10,
                     refit=True,
                     param_grid={'alpha': [0.001, 0.01, 0.1, 1, 10, 100]})

ridge = GridSearchCV(Ridge(fit_intercept=False),
                     cv=10,
                     refit=True,
                     param_grid={'alpha': [0.001, 0.01, 0.1, 1, 10, 100]})

knn = GridSearchCV(KNeighborsRegressor(),
                   cv=10,
                   refit=True,
                   param_grid={'n_neighbors': [2, 3, 5, 7, 11, 13],
                               'weights': ['uniform', 'distance']})
```


```python
#In: 
linear = linear.fit(X_train, y_train)
linear.score(X_train, y_train)
```




    0.9337321660650831




```python
#In: 
lasso = lasso.fit(X_train, y_train)
lasso.score(X_train, y_train)
```




    0.9336965588469631




```python
#In: 
ridge = ridge.fit(X_train, y_train)
ridge.score(X_train, y_train)
```




    0.9337603905325227




```python
#In: 
knn = knn.fit(X_train, y_train)
knn.score(X_train, y_train)
```




    0.999999999999988




```python
#In: 
knn.best_params_
```




    {'n_neighbors': 7, 'weights': 'distance'}


