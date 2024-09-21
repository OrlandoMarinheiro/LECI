%% Código 1
% Gerar uma matriz com 3 linhas e 10000 colunas de nu´meros aleato´rios
% entre 0.0 e 1.0 (ou seja, cada coluna representa uma experieˆncia):
experiencias = rand(3,10000);
% Gerar uma matriz com 3 linhas e 10000 colunas com o valor 1 se o valor
% da matriz anterior for superior a 0.5 (ou seja, se saiu cara) ou com o
% valor 0 caso contra´rio (ou seja, saiu coroa):
lancamentos = experiencias > 0.5; % 0.5 corresponde a 1 - prob. de caras
% Gerar um vetor linha com 10000 elementos com a soma dos valores de cada
% coluna da matriz anterior (ou seja, o nu´mero de caras de cada experieˆncia):
resultados= sum(lancamentos);
% Gerar um vetor linha com 10000 elementos com o valor 1 quando o valor do
% vetor anterior e´ 2 (ou seja, se a experieˆncia deu 2 caras) ou 0 quando
% é
% diferente de 2:
sucessos= resultados==2;
% Determinar o resultado final dividindo o número de experiências com 2
% caras pelo número total de experiências:
probSimulacao= sum(sucessos)/10000

%% Código 1 - segunda versão
N= 1e5; % numero de experiencias
p = 0.5; % probabilidade de cara
k = 2; % numero de caras
n = 3; % numero de lançamentos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;
probSimulacao= sum(sucessos)/N

%% 2 

N= 1e5; % numero de experiencias
p = 0.5; % probabilidade de cara
k = 6; % numero de caras
n = 15; % numero de lançamentos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;
probSimulacao= sum(sucessos)/N

%% 3

N= 1e5; % numero de experiencias
p = 0.5; % probabilidade de cara
k = 6; % numero de caras
n = 15; % numero de lançamentos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)>=k;
probSimulacao= sum(sucessos)/N

%% 4 

N= 1e5; % numero de experiencias
p = 0.5; % probabilidade de cara
k = 6; % numero de caras
n = 15; % numero de lançamentos
probSimulacao = CalcProbSimul(N,p,k,n)

%% 4 a) e b)

N= 1e5; % numero de experiencias
p = 0.5; % probabilidade de cara

n = 20; % numero de lançamentos

prob1 = zeros(1,n+1)
for k = 1:n+1
    prob1(k) = CalcProbSimul(N,p,k,n)
end

figure(1)
stem(0:n,prob1)
grid on
xlabel('No. de caras')
ylabel('Probabilidade')
title('Probabilidade de k caras em 20 lançamentos')

n = 40; % numero de lançamentos

prob2 = zeros(1,n+1)
for k = 1:n+1
    prob2(k) = CalcProbSimul(N,p,k,n)
end

figure(2)
stem(0:n,prob2)
grid on
xlabel('No. de caras')
ylabel('Probabilidade')
title('Probabilidade de k caras em 40 lançamentos')

n = 100; % numero de lançamentos
prob3 = zeros(1,n+1)
for k = 1:n+1
    prob3(k) = CalcProbSimul(N,p,k,n)
end

figure(3)
stem(0:n,prob3)
grid on
xlabel('No. de caras')
ylabel('Probabilidade')
title('Probabilidade de k caras em 100 lançamentos')

%% 5

p = 0.5;
n = 20;

prob4 = zeros(1,n+1)
for k = 0:n
    prob4(k+1) = nchoosek(n,k)*p^k*(1-p)^(n-k);
end

prob3 = zeros(1,n+1)
for k = 0:n
    prob3(k+1) = CalcProbSimul(N,p,k,n)
end


figure(1)
plot(0:n,prob4, 'Color','r')
hold on
plot(0:n,prob3, 'Color','b')
grid on
xlabel('No. de caras')
ylabel('Probabilidade')
title('Probabilidade de k caras em 20 lançamentos')
legend('Valor estimado', 'Valor analítico')


prob5 = zeros(1,n+1)
for k = 0:n
    prob5(k+1) = nchoosek(n,k)*p^k*(1-p)^(n-k);
end

prob2 = zeros(1,n+1)
for k = 0:n
    prob2(k+1) = CalcProbSimul(N,p,k,n)
end


figure(2)
plot(0:n,prob5, 'Color','r')
hold on
plot(0:n,prob2, 'Color','b')
grid on
xlabel('No. de caras')
ylabel('Probabilidade')
title('Probabilidade de k caras em 40 lançamentos')
legend('Valor estimado', 'Valor analítico')


prob6 = zeros(1,n+1)
for k = 0:n
    prob6(k+1) = nchoosek(n,k)*p^k*(1-p)^(n-k);
end

prob1 = zeros(1,n+1)
for k = 0:n
    prob1(k+1) = CalcProbSimul(N,p,k,n)
end

figure(3)
plot(0:n,prob6, 'Color','r')
hold on
plot(0:n,prob1, 'Color','b')
grid on
xlabel('No. de caras')
ylabel('Probabilidade')
title('Probabilidade de k caras em 100 lançamentos')
legend('Valor estimado', 'Valor analítico')

%% 6 a)

p = 0.3; % probabilidade de sair defeituoso
k = 3; % numero de peças defeituosas
n = 5; % numero de peças da amostra
probSimulacao= nchoosek(n,k)*p^k*(1-p)^(n-k)

%% 6 b)

p = 0.3; % probabilidade de sair defeituoso
k = 2; % numero de peças defeituosas
n = 5; % numero de peças da amostra
probSimulacao= nchoosek(n,k)*p^k*(1-p)^(n-k)

%% 6 c)

p = 0.3; % probabilidade de sair defeituoso
n = 5; % numero de peças da amostra

probSimulacao = zeros(1,n+1)
for k = 0:n
   probSimulacao(k+1) = nchoosek(n,k)*p^k*(1-p)^(n-k)
end

histogram(probSimulacao)
xlabel('Probabilidade de k amostras com defeito')
ylabel('No. de amostras com defeito')

