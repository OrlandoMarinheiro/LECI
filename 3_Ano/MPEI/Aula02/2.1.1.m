
%% a)
N = 10000; % numero de experiencias
p = 0.5; % probabilidade de ser rapaz ou rapariga
k = 1; % ter pelo menos um filho rapaz
n = 2; % numero de filhos de cada familia

familia = rand(n,N) > p;
sucessos= sum(familia) >= k;
probSimulacao= sum(sucessos)/N


%% b)
% Casos Possiveis -> HH, HM, MH, MM = 4
% Casos Favoraveis -> HH, HM, MH = 3
CP = 4;
CF = 3;
P = CF/CP

%% c)

N = 10000; % numero de experiencias
p = 0.5; % probabilidade de ser rapaz ou rapariga
k = 1; % ter pelo menos um filho rapaz
n = 2; % numero de filhos de cada familia

familia = rand(n,N) > p;
sucessos= sum(familia) >= k;
probSimulacao= sum(sucessos)/N

%% d)

N = 10000; % numero de experiencias
p = 0.5; % probabilidade de ser rapaz ou rapariga
k = 1; % ter pelo menos um filho rapaz
n = 2; % numero de filhos de cada familia

familia = rand(n,N) > p;
sucessos= sum(familia) == k;
probSimulacao= sum(sucessos)/N

%% e)

N = 10000; % numero de experiencias
p = 0.5; % probabilidade de ser rapaz ou rapariga
n = 5; % numero de filhos de cada familia

familia = rand(n,N) > p;
CP = sum(familia) >= 1;
CF = sum(familia) == 2;
probSimulacao= CF/CP

%% f)

N = 10000; % numero de experiencias
p = 0.5; % probabilidade de ser rapaz ou rapariga
n = 5; % numero de filhos de cada familia

familia = rand(n,N) > p;
CP = sum(familia) >= 1;
CF = sum(familia) >= 2;
probSimulacao= CF/CP



