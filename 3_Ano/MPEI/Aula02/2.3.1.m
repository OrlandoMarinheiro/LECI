%% a)
% P(Carlos|Erro) = P(CE) / P(E) = 0.5 * 0.001 / 0.001 = 0.5
N = 1e5;
num_programas = 100;

programas = randi([1,num_programas],num_programas,N);

prob = programas <= 50;
probCarlos = sum(sum(prob)) * 0.001 / N

%% b)

N = 1e5;
num_programas = 100;
programas = randi([1,num_programas],num_programas,N);

% André
prob = programas <= 20;
probAndre = sum(sum(prob)) * 0.01 / N;

% Bruno
prob = programas <= 30;
probBruno = sum(sum(prob)) * 0.05 / N;

% Carlos
prob = programas <= 50;
probCarlos = sum(sum(prob)) * 0.001 / N;

fprintf("\nAndré: %f; Bruno: %f; Carlos: %f", probAndre, probBruno, probCarlos);
