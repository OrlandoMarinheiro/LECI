fprintf("Probabilidade de sair 7 chips defeituosos em 8000 fabricados:\n");
% 6 a) -----------------------

% por cada 1000 chips há 1 defeituoso
n = 8000; % numero de chips
k = 7; % numero de chips defeituosos
p = 1/1000; % probabilidade de sair chip defeituoso
pBinomial = binopdf(k, n, p); % probabilidade utilizando distribuição binomial

fprintf("6 a) Probabilidade utilizando a distribuição binomial: %f\n", pBinomial);

% 6 b) -----------------------

% Lei de Poisson, probabilidade de ocorrer exatamente k eventos.
% pk = (λ^k * e^-λ)/k!
% λ é o número médio (ou taxa média) de eventos em um intervalo fixo.
% k -> número de eventos que queremos observar (número de sucessos).

lambda = n * p;
pk = (lambda^k * exp(-lambda)) / factorial(k);
fprintf("6 b) Probabilidade utilizando a Lei de Poison: %f\n", pk);
