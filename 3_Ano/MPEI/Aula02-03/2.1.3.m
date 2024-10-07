%% a)
T = 1000;
num_keys = 10;
N = 1e5;


count = 0;
for i = 1:N
    % criar um array com 1 linha e 10 colunas e preencher com valores entre
    % 0 e T-1
    hash = randi([0,T-1],1,num_keys);
    % Caso os valores do array se repetirem pelo menos 2 vezes (pelo menos 
    % 2 iguais) temos uma colisão
    if length(unique(hash)) ~= num_keys
        count = count + 1;
    end
end

probA = count/N

%% b)

T = 1000;
num_keys = 1:10;
N = 1e5;

probA = zeros(1,length(num_keys));
for key = num_keys
    count = 0;
    for i = 1:N
        hash = randi([0,T-1],1,key);
        if length(unique(hash)) ~= key
            count = count + 1;
        end
    end
    probA(key) = count/N;
end

plot(num_keys,probA,'-o');
xlabel('Número de keys');
ylabel('Probabilidade');
title('Probabilidade de haver pelo menos uma colisão')
grid on

%% c)

num_keys = 50;
N = 1e5;

probA = zeros(1,10);
for T = 100:100:1000
    count = 0;
    for i = 1:N
        hash = randi(T,1,num_keys);
        if length(unique(hash)) == num_keys
            count = count + 1;
        end
    end
    probA(T/100) = count/N;
end

plot(100:100:1000,probA,'-o');
xlabel('Tamanho do array (T)');
ylabel('Probabilidade');
title('Probabilidade de não haver colisão em função do tamanho T')
grid on

