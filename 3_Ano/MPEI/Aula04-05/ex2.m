%% 2 a)
% Espaço de amostragem: 100 -> S = {nota 1,..., nota 100} 
% P(“retirar uma nota da caixa”) = 1/100 (probabilidade de tirar uma nota é
% igual pra todas)

%% 2 b)
% Espaço de amostragem: S = {nota 5, nota 50, nota 100}
% PX(x) = P("Sair nota com valor x")

% PX(5) = P("Sair nota com valor 5") = 90/100;
% PX(50) = P("Sair nota com valor 50") = 9/100;
% PX(100) = P("Sair nota com valor 100") = 1/100;

%% 2 c)



x = [5,50,100];
b = [90/100, 9/100, 1/100];

y = [cumsum(b)]

stairs([0 x 120],[0 y 1]);
ylim([0 1.1]);
xlabel('x');
ylabel('Fx(x)');
grid on;
