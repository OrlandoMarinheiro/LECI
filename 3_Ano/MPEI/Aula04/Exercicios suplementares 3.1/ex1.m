% 1 a) ---------------

% evento “A - uma caixa de brinquedos tem pelo menos 1 brinquedo com defeito”
N = 1e5;
n = 8; % numero de brinquedos
p1 = 0.002; % probabilidade de defeito na componente 1
p2 = 0.005; % probabilidade de defeito na componente 2
pM = 0.01; % probabilidade de defeito no processo de montagem

c1 = rand(n,N) < p1;
c2 = rand(n,N) < p2;
cM = rand(n,N) < pM;

brinquedo_com_defeito = c1 | c2 | cM; % defeitos na componente 1, 2 ou na montagem
caixa_com_defeito = sum(brinquedo_com_defeito) >= 1; % defeito em pelo menos um dos brinquedos da caixa
probA = sum(caixa_com_defeito)/N; % calculo da probabilidade
fprintf("1 a) Probabilidade do evento A: %f\n", probA);




