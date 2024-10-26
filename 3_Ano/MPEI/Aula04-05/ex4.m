% 4 a) -----------------------
% i)
fprintf("4 a)\n");
fprintf("i)\n");

N= 1e5; % numero de experiencias
p = 0.3; % probabilidade de peça defeituosa
n = 5; % numero de peças por experiencia
px = zeros(1,5); % armazenar os valores de px para cada X
for X = 0:5
    lancamentos = rand(n,N) < p;
    defeitos= sum(lancamentos) == X;
    px(X + 1)= sum(defeitos)/N;
end

subplot(2,2,1);
stem([0:5],px);
xlabel('x'); 
ylabel('px(x)');
title('4 a) i) Funcao massa de probabilidade de X');

for i = 0:5
    fprintf("X: %d | P(x): %f\n", i, px(i + 1));
end
fprintf("\n");

% ii) -----------------------

y = cumsum(px);
x = 0:5;

subplot(2,2,2);
stairs(x,y);
ylim([0 1.1]);
xlabel('x'); 
ylabel('px(x)');
title('4 a) ii) Funcao distribuição acumulada');
grid on

% iii) -----------------------
fprintf("iii)\n");
% k=0 -> 1
% k=1 -> 2
% k=2 -> 3
% k=3 -> 4
% k=4 -> 5
p_2 = sum(px(1:3));
fprintf("P(No máximo 2 peças defeituosas): %f\n",p_2);

% 4 b) -----------------------
% i)
fprintf("4 b)\n");

p = 0.3; % probabilidade de peça defeituosa
n = 5; % numero de peças por experiencia
pxTeorico = zeros(1,5); % armazenar os valores de px para cada X
for k = 0:5
    pxTeorico(k + 1) = (factorial(n)/(factorial(k) * factorial(n - k))) * p^k * (1-p)^(n-k);
end

y = cumsum(pxTeorico);
x = 0:5;

subplot(2,1,2);
stairs(x,y);
ylim([0 1.1]);
xlabel('x'); 
ylabel('px(x)');
title('4 b) i) Funcao distribuição acumulada ');
grid on

% ii) -----------------------
fprintf("ii)\n");

p_2T = sum(pxTeorico(1:3));
fprintf("P(No máximo 2 peças defeituosas teoricamente): %f\n",p_2T);