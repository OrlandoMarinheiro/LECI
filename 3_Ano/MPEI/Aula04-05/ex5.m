% ex5
% Avião despenha se mais de metado dos motores falharem
% É preferível voar num avião que tenha 2 ou 4 motores?

% Calcular a probabilidade de cair um avião com 2 motores:
n = 2; % número de motores
k = 2; % mais de metade dos motores falharem
p = logspace(-3,log10(1/2),100);
p2motores = (factorial(n)/(factorial(k) .* factorial(n - k))) .* p.^k .* (1-p).^(n-k);

fprintf("Probabilidade de despenhar com 2 motores: %f\n", p2motores);

% Calcular a probabilidade de cair um avião com 4 motores: 

n = 4;
p4motores = 0;
for k = 3:4
    p4motores = p4motores + ((factorial(n)/(factorial(k) .* factorial(n - k))) .* p.^k .* (1-p).^(n-k));
end

fprintf("Probabilidade de despenhar com 3 e 4 motores: %f\n", p2motores);


% Comparação dos resultados

figure(1);
hold on;

plot(p,p4motores);
plot(p,p2motores);

legend("4 motores","2 motores");

xlabel('Probabilidade do motor falhar');
ylabel('Probabilidade de avião cair');
title("Exercicio 5");

grid on;
hold off;
