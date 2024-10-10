
%% 1 a)

%  x = {1,2,3,4,5,6}
% p(x) = 1/6
x = 1:6
p = ones(1,6)/6

stem(x,p);
xlabel('x'); 
ylabel('px(x)');
title('Funcao massa de probabilidade');

%% 1 b)

%  x = {1,2,3,4,5,6}
% p(x) = 1/6
x = 0:7
p = ones(1,6)/6
y = [0 cumsum(p) 1]

stairs(x,y);
xlabel('x'); 
ylabel('px(x)');
title('Funcao massa de probabilidade');