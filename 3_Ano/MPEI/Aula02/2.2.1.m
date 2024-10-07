%% a)

n = 2; % numero de vezes lançadas
N = 1e5; % numero de experiencias

lancamentos = randi([1,6],n,N);

% “A – a soma dos dois valores e igual a 9”
countA = sum(lancamentos) == 9;
probA = sum(countA)/N;

% “B – o segundo valor é par”
countB = lancamentos(2,:);
par = rem(countB,2) == 0;
probB = sum(par)/N;

%  “C – pelo menos um dos valores é igual a 5”

igual5 = lancamentos == 5;
somaIgual5 = sum(igual5);
c = somaIgual5 >= 1; 
probC = sum(c)/N;

% “D – nenhum dos valores é igual a 1”

diferente_1 = lancamentos ~= 1;
somaDiferente1 = sum(diferente_1);
d = somaDiferente1 == 2;
probD = sum(d)/N;

fprintf("\nA) %f; B) %f; C) %f; D) %f;",probA,probB,probC,probD);

%% b)
ProbAB = probA * probB
% Para serem independentes é necessário que P(AB) = P(A) x P(B) 
% soma igual a 9 -> {(3,6), (5,4)}
% P(AB) = 2/36 = 1/18
% P(A) = 4/36 = 1/9
% P(B) = 18/36 = 1/2
% P(A) x P(B) = 1/9 x 1/2 = 1/18 Logo são independentes

%% c)

ProbCD = probC * probD
% P(CD) = P(C) x P(D) 
% P(CD) = 9/36 = 1/4
% P(C) = 11/36
% P(D) = 25/36
% P(C) x P(D) = 11/36 x 25/36 = 275/1296 Logo não são independentes