%% a)

prob = 0;
N = 1e3;
pessoas = 1;

while prob < 0.5
    pessoas = pessoas + 1;
    aniversarios = randi([1,365],pessoas,N);
    count = 0;
    for i = 1:N
        if length(unique(aniversarios(:,i))) ~= pessoas
            count = count + 1;
        end
    end
    prob = count/N;
end
fprintf("\nO número de pessoas é %d", pessoas);

%% b)

prob = 0;
N = 1e3;
pessoas = 1;

while prob < 0.9
    pessoas = pessoas + 1;
    aniversarios = randi([1,365],pessoas,N);
    count = 0;
    for i = 1:N
        if length(unique(aniversarios(:,i))) ~= pessoas
            count = count + 1;
        end
    end
    prob = count/N;
end
fprintf("\nO número de pessoas é %d", pessoas);

