%% a)

n = 20;
m = 100;
N = 1e5;

experiencias = randi(m,n,N);

contador = 0;
for i = 1:N
    aux = experiencias(:,i); % aux contém todas as linhas e "i" colunas da matriz experiencias
    if length(unique(aux)) == n
        contador = contador + 1;
    end
end
probA = contador / N
%% b)

n = 20;
m = 100;
N = 1e5;

experiencias = randi(m,n,N);

contador = 0;
for i = 1:N
    aux = experiencias(:,i); % aux contém todas as linhas e "i" colunas da matriz experiencias
    if length(unique(aux)) < n
        contador = contador + 1;
    end
end
probA = contador / N

%% c)

N = 1e5;
m_values = [1000, 100000];

for index = 1:length(m_values)
    m = m_values(index);
    % vetor para armazenar valores das probabilidades
    probB = zeros(1,10);
    for n = 10:10:100
        experiencias = randi(m,n,N);
        contador = 0;
        for i = 1:N
            aux = experiencias(:,i); % aux contém todas as linhas e "i" colunas da matriz experiencias
            if length(unique(aux)) < n
                contador = contador + 1;
            end
        end
        probB(n/10) = contador / N;
    end
    
    subplot(1,2,index);
    plot(10:10:100,probB,'-o');
    title(['m = ', num2str(m)]);
    xlabel('Número de dardos (n)');
    ylabel('Probabilidade');
    grid on;
    sgtitle('Probabilidade de Pelo Menos 1 Alvo Atingido 2 ou Mais Vezes');
end

%% d)

N = 1e5;
n = 100;
m_values = [200,500,1000,2000,5000,10000,20000,50000,100000];

% vetor para armazenar valores das probabilidades
probB = zeros(1, length(m_values));

for index = 1:length(m_values)
    m = m_values(index);

    experiencias = randi(m,n,N);
    contador = 0;
    for i = 1:N
        aux = experiencias(:,i); % aux contém todas as linhas e "i" colunas da matriz experiencias
        if length(unique(aux)) < n
            contador = contador + 1;
        end
    end
    probB(index) = contador / N;
end

plot(m_values, probB, '-o');
xlabel('Número de alvos (m)');
ylabel('Probabilidade');
grid on;




