% 3 a) -----------------------
fprintf("3 a)\n");

N= 1e5; % numero de experiencias
p = 0.5; % probabilidade de coroa
n = 4; % numero de lançamentos por experiencia
px = zeros(1,5); % armazenar os valores de px para cada X
for X = 0:4
    lancamentos = rand(n,N) > p;
    sucessos= sum(lancamentos) == X;
    px(X + 1)= sum(sucessos)/N;
end

fprintf("P(x): %f\n", px);
fprintf("\n");
stem([0:4],px);
xlabel('x'); 
ylabel('px(x)');
title('Funcao massa de probabilidade');


% 3 b) -----------------------
fprintf("3 b)\n");

% Valor esperado
% E(X) = (X0 * p(X0) + X1 * p(X1) + ... + Xi * p(Xi))
E = 0;
for X = 1:5
    E = E + ((X - 1) * px(X));
end

fprintf("E(x): %f\n", E);

% Variência
% Var(X) = E[X^2] - E^2[X]

E_var = 0;
for X = 1:5
    E_var = E_var + ((X - 1)^2 * px(X));
end
var = E_var - E^2;
fprintf("Var(x): %f\n", var);

% desvio padrão

desvio = sqrt(var);
fprintf("Desvio Padrão: %f\n", desvio);
fprintf("\n");


% 3 c) -----------------------

% Como existe um numero fixo de experiencias (4), a probabilidade de
% sucesso é a mesma nelas todas e existem apenas dois resultados possiveis
% (cara ou coroa), estamos perante uma distribuição binomial.
% Assim temos que: px(k) = nCk * p^k * (1-p)^(n-k)
% Sendo: 
% k -> numero de sucessos (coroas)
% n -> numero de lancamentos
% p -> probabilidade de sucesso (coroas, 0.5)


% 3 d) -----------------------
fprintf("3 d)\n");

p = 0.5; % probabilidade de coroa
n = 4; % numero de lançamentos por experiencia
pxTeorico = zeros(1,5); % armazenar os valores de px para cada X
for k = 0:4
    % px(k) = nCk * p^k * (1-p)^(n-k)
    pxTeorico(k + 1) = (factorial(n)/(factorial(k) * factorial(n - k))) * p^k * (1-p)^(n-k);
end

for i = 1:5
    fprintf(" Valor teorico Px(X): %f | Valor da simulação Px(X): %f\n", pxTeorico(i), px(i));
end
fprintf("\n");

subplot(1,2,1);
stem([0:4],px);
xlabel('x'); 
ylabel('px(x)');
title('Função massa de probabilidade');
grid on;

subplot(1,2,2);
stem([0:4],pxTeorico, 'r');
xlabel('x'); 
ylabel('px(x)');
title('Valores teóricos da Função');
grid on;

% 3 e) -----------------------
fprintf("3 e)\n");

% Valor esperado teórico
% E(X) = (X0 * p(X0) + X1 * p(X1) + ... + Xi * p(Xi))
Et = 0;
for X = 1:5
    Et = Et + ((X - 1) * pxTeorico(X));
end

fprintf("Valor teorico de E(x): %f | Valor da simulação de E(x): %f\n", Et, E);

% Variência teórica
% Var(X) = E[X^2] - E^2[X]

E_varT = 0;
for X = 1:5
    E_varT = E_varT + ((X - 1)^2 * pxTeorico(X));
end
varT = E_varT - Et^2;

fprintf("Valor teorico de Var(x): %f | Valor da simulação de Var(x): %f\n", varT, var);

% 3 f) -----------------------
% i)
% k=0 -> 1
% k=1 -> 2
% k=2 -> 3
% k=3 -> 4
% k=4 -> 5
fprintf("3 f)\n");
fprintf("i)\n");
p_2 = sum(pxTeorico(3:5)); % obter pelo menos 2 coroas

fprintf("P(Pelo menos 2 coroas): %f\n",p_2);

% ii) -----------------------
fprintf("ii)\n");

p_1 = sum(pxTeorico(1:2)); % obter até 1 coroa
fprintf("P(Até 1 coroa): %f\n",p_1);

% iii) -----------------------
fprintf("iii)\n");

p_1_3 = sum(pxTeorico(2:4)); % obter entre 1 e 3 coroas
fprintf("P(entre 1 e 3 coroas): %f\n",p_1_3);