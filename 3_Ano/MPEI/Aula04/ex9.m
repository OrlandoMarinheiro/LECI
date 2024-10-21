% 9 a) ---------------
N = 1e5; % numero de experiencias
desvio = 2;
media = 14;
X = randn(N, 1) * desvio + media; % classificações dos alunos


nota_12_16 = (X > 12 & X < 16); % filtrar notas entre 12 e 16
num_12_16 = sum(nota_12_16); % numero de alunos com nota entre 12 e 16
prob_12_16 = num_12_16/N;

prob_ate12 = normcdf(12,14,2); % calcular a probabilidade acumulada até 12
prob_ate16 = normcdf(16,14,2); % calcular a probabilidade acumulada até 16
correction1 = prob_ate16 - prob_ate12;

fprintf("9 a) Probabilidade do aluno ter uma classificação entre 12 e 16: %f | Usando normcdf(): %f\n", prob_12_16, correction1);

% 9 b) ---------------

nota_10_18 = (X > 10 & X < 18); % filtrar notas entre 10 e 18
num_10_18 = sum(nota_10_18); % numero de alunos com nota entre 10 e 18
prob_10_18 = num_10_18/N;

prob_ate10 = normcdf(10,14,2); % calcular a probabilidade acumulada até 10
prob_ate18 = normcdf(18,14,2); % calcular a probabilidade acumulada até 18
correction2 = prob_ate18 - prob_ate10;

fprintf("9 b) Probabilidade dos alunos terem classificações entre 10 e 18: %f | Usando normcdf(): %f\n", prob_10_18, correction2);

% 9 c) ---------------

nota_maior10 = (X >= 10); % filtrar notas entre 12 e 16
num_maior10 = sum(nota_maior10); % numero de alunos com nota entre 12 e 16
prob_maior10 = num_maior10/N;

prob_ate10 = normcdf(10,14,2); % calcular a probabilidade acumulada até 10
correction3 = 1 - prob_ate10;

fprintf("9 c) Probabilidade do aluno passar (maior ou igual a 10): %f | Usando normcdf(): %f\n", prob_maior10, correction3);