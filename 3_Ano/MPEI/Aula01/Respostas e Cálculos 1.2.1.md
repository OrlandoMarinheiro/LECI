# Respostas e Cálculos 1.2.1

## R1 - Sequências de Bits
Quantas sequências diferentes de 10 bits há? E de n bits?

- **10 bits**: \( 2^{10} = 1024 \)
- **n bits**: \( 2^n \)

## R2 - Sequências de Símbolos
Quantas sequências diferentes de 10 símbolos do alfabeto (A, C, G, T) há? E de n símbolos do mesmo alfabeto?

- **10 símbolos**: \( 4^{10} \)
- **n símbolos**: \( 4^n \)

## R3 - Teste com Perguntas Verdadeiro ou Falso
Um teste tem n perguntas com respostas possíveis Verdadeiro ou Falso. 

### Número de maneiras diferentes de responder:
\[ R = 2^n \]

### Probabilidade de acertar todas as respostas escolhendo à sorte:
Apenas uma sequência correta de respostas existe. Com \( 2^n \) maneiras diferentes de responder, a probabilidade de acertar todas as respostas será:
\[ R = \frac{1}{2^n} \]

## R4 - Chaves Distintas
Quantas chaves distintas pode ter o Totoloto antigo (5 números em 49)?

\[ R = C(49,5) \]

E o Euromilhões (5 números em 50 e duas estrelas em 11)?

\[ R = C(50,5) \times C(11,2) \]

## R5 - Baralho com 20 Cartas
Considere um baralho com 20 cartas, sendo 10 vermelhas e 10 pretas, ambas numeradas de 1 a 10.

### (a) Disposição das 20 cartas
De quantas maneiras diferentes se podem dispor as 20 cartas numa fila?
\[ R = 20! \]

### (b) Probabilidade de sequência alternada
Calcule a probabilidade de se obter uma sequência constituída alternadamente por cartas pretas e vermelhas:
\[ R = \frac{20 \times 10! \times 10!}{20!} = 0,0000108 \]

## R6 - Lançamento de Dois Dados
### (a) Espaço de Amostragem
Indique o espaço de amostragem da soma:
- Soma mínima: \( 1 + 1 = 2 \)
- Soma máxima: \( 6 + 6 = 12 \)

\[ S = \{2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12\} \]

### (b) Probabilidade de Soma 9
Soma 9: \( 4 + 5 \) ou \( 5 + 4 \) e \( 6 + 3 \) ou \( 3 + 6 \).

\[ P = \frac{4}{36} = \frac{1}{9} \]

## R7 - Probabilidade de Encontrar Peças Defeituosas
Um conjunto de 50 peças contém 8 peças defeituosas. Selecionam-se aleatoriamente 10 peças. Qual a probabilidade de encontrar 3 defeituosas?

Utilizando a fórmula da probabilidade hipergeométrica:
\[ P(X = 3) = \frac{\binom{8}{3} \cdot \binom{42}{7}}{\binom{50}{10}} \]

### Cálculo
1. \( \binom{8}{3} = 56 \)
2. \( \binom{42}{7} = 105048576 \)
3. \( \binom{50}{10} = 10272278170 \)

Assim, 
\[ P(X = 3) = \frac{56 \times 105048576}{10272278170} \approx 0.5716 \]

## R8 - Passwords Diferentes
Quantas passwords diferentes se podem obter nas seguintes situações:

### (a) Comprimento 5 com Dígitos
Cada posição contém um dígito entre 0 e 9:
\[ R = 10 \times 9 \times 8 \times 7 \times 6 \]

### (b) Comprimento 5 com Letras Minúsculas
Cada posição contém uma letra minúscula sem acentos:
\[ R = 26 \times 25 \times 24 \times 23 \times 22 \]

### (c) Probabilidade de Acertar Passwords
Qual a probabilidade de acertar em cada um dos dois casos anteriores escolhendo uma password aleatoriamente?

- **(a)**: 
\[ R = \frac{10 \times 9 \times 8 \times 7 \times 6}{10^5} \]

- **(b)**: 
\[ R = \frac{26 \times 25 \times 24 \times 23 \times 22}{26^5} \]

### (d) Alteração com 3 Tentativas
Qual a alteração ao valor destas probabilidades se fizermos 3 tentativas completamente independentes?

- **(a)**:
\[ P(\text{Não acertar}) = 1 - \frac{10 \times 9 \times 8 \times 7 \times 6}{10^5} \]
\[ P(\text{Não acertar 3 vezes}) = \left(1 - \frac{10 \times 9 \times 8 \times 7 \times 6}{10^5}\right)^3 \]

- **(b)**:
\[ P(\text{Não acertar}) = 1 - \frac{26 \times 25 \times 24 \times 23 \times 22}{26^5} \]
\[ P(\text{Não acertar 3 vezes}) = \left(1 - \frac{26 \times 25 \times 24 \times 23 \times 22}{26^5}\right)^3 \]
