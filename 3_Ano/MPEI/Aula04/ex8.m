% 8 ---------------
% probabilidade de existir no max 1 erro num livro de 100 pags
n = 100; % numero de paginas
lambda_1 = 0.02; % taxa média de erros por página
lambda_2 = lambda_1 * n; % taxa média de erros em 100 paginas

% probabilidade de existir no maximo 1 erro, ou seja, 0 ou 1 erros
pk = 0;
for k = 0:1 % numero de eventos que queremos observar
    pk = pk + (lambda_2^k * exp(-lambda_2)) / factorial(k);
end

fprintf("8) Probabilidade de existir no máximo 1 erro num livro de 100 paginas: %e\n", pk);
