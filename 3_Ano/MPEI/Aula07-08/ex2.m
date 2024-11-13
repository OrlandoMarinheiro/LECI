% Exercicio 2 a) ----------------------

data = readcell('PL5EX2(in).csv');
Xaux = data(2:end, 2:end-1);
X = cell2mat(Xaux);

Y = categorical(data(2:end, end)');
lista_palavras = data(1, 2:end-1);

% Exercicio 2 b) ----------------------


aux = randperm(size(X,1));
aux2 = round(0.7*size(X,1));

Xtreino = X(aux(1:aux2),:);
Ytreino = Y(aux(1:aux2));

Xteste = X(aux(aux2 + 1:end),:);
Yteste = Y(aux(aux2 + 1:end));


% Exercicio 2 c) ----------------------

% conjunto de treino
num_SPAM_treino = sum(Ytreino == 'SPAM');
num_OK_treino = sum(Ytreino == 'OK');

num_total = length(Ytreino);

prob_SPAM_treino = num_SPAM_treino/num_total;
prob_OK_treino = num_OK_treino/num_total;



fprintf("Exercício 2 c) Probabilidades a priori:\t P(SPAM) = %.4f\t P(OK) = %.4f\n", prob_SPAM_treino, prob_OK_treino);


% Exercicio 2 d) ----------------------
fprintf("\nExercício 2 d)\n");

% matriz para acumular ocorrencias de palavras apenas como SPAM no conjunto
% de treino
matriz_SPAM_treino = zeros(num_SPAM_treino, length(lista_palavras));

% matriz para acumular ocorrencias de palavras apenas como OK no conjunto
% de treino
matriz_OK_treino = zeros(num_OK_treino, length(lista_palavras));


indice_SPAM = 1;
indice_OK = 1;

for i = 1 : length(Ytreino)

    if Ytreino(i) == "OK"
        matriz_OK_treino(indice_OK, :) = Xtreino(i, :);
        indice_OK = indice_OK + 1;
    else
        matriz_SPAM_treino(indice_SPAM, :) = Xtreino(i, :);
        indice_SPAM = indice_SPAM + 1;
    end
end


num_ocor_palavra_SPAM_treino = sum(matriz_SPAM_treino, 1);
num_ocor_palavra_OK_treino = sum(matriz_OK_treino, 1);


for i = 1 : length(lista_palavras)
    prob_palavra_SPAM_treino = (num_ocor_palavra_SPAM_treino(i) + 1) / (num_SPAM_treino + length(lista_palavras));

    prob_palavra_OK_treino = (num_ocor_palavra_OK_treino(i) + 1) / (num_OK_treino + length(lista_palavras));

    fprintf('\nP("%s"| SPAM): %.4f \t\t P("%s"| OK): %.4f', lista_palavras{i}, prob_palavra_SPAM_treino, lista_palavras{i}, prob_palavra_OK_treino);
    
end


% Exercicio 2 e) ----------------------
fprintf("\n\nExercício 2 e) Conjunto de teste:");


% conjunto de teste

num_SPAM_teste = sum(Yteste == 'SPAM');
num_OK_teste = sum(Yteste == 'OK');

num_total = length(Yteste);

prob_SPAM_teste = num_SPAM_teste/num_total;
prob_OK_teste = num_OK_teste/num_total;


% matriz para acumular ocorrencias de palavras apenas como SPAM no conjunto
% de teste 
matriz_SPAM_teste = zeros(num_SPAM_teste, length(lista_palavras));

% matriz para acumular ocorrencias de palavras apenas como OK no conjunto
% de teste 
matriz_OK_teste = zeros(num_OK_teste, length(lista_palavras));


indice_SPAM = 1;
indice_OK = 1;

for i = 1 : length(Yteste)

    if Yteste(i) == "OK"
        matriz_OK_teste(indice_OK, :) = Xteste(i, :);
        indice_OK = indice_OK + 1;
    else
        matriz_SPAM_teste(indice_SPAM, :) = Xteste(i, :);
        indice_SPAM = indice_SPAM + 1;
    end
end


num_ocor_palavra_SPAM_teste = sum(matriz_SPAM_teste, 1);
num_ocor_palavra_OK_teste = sum(matriz_OK_teste, 1);


% iniciar dois arrays para verificar qual é a categoria mais provavel
score_SPAM_teste = zeros(1, length(lista_palavras));
score_OK_teste = zeros(1, length(lista_palavras));

for i = 1 : length(lista_palavras)
    
    score_SPAM_teste(i) = (num_ocor_palavra_SPAM_teste(i) + 1) / (num_SPAM_teste + length(lista_palavras));

    score_OK_teste(i) = (num_ocor_palavra_OK_teste(i) + 1) / (num_OK_teste + length(lista_palavras));
end

score_final_OK = prob_OK_teste * prod(score_OK_teste);
score_final_SPAM = prob_SPAM_teste * prod(score_SPAM_teste);

fprintf("\n");
fprintf('\nP("SPAM"|email): %e', score_final_SPAM);
fprintf('\nP("OK"|email): %e', score_final_OK);

if score_final_SPAM > score_final_OK
    fprintf('\nClasse mais provável: "SPAM"');
else
    fprintf('\nClasse mais provável: "OK"');
end



% Exercicio 2 f) ----------------------


VP = 0; 
FP = 0; 
VN = 0; 
FN = 0;

% conjunto de teste
for i = 1 : length(Yteste)
    
    if score_final_OK > score_final_SPAM
        score = "OK";
    else
        score = "SPAM";
    end

    classe = Yteste(i);

    if score == "SPAM" && classe == "SPAM"
        VP = VP + 1;

    elseif score == "SPAM" && classe == "OK"
        FP = FP + 1;

    elseif score == "OK" && classe == "OK"
        VN = VN + 1;

    elseif score == "OK" && classe == "SPAM"
        FN = FN + 1;
    end
end

precisao = VP / (VP + FP);
recall = VP / (VP + FN);
f1 = 2 * (precisao * recall) / (precisao + recall);

fprintf("\n\nExercício 2 f)  Precisão: %f \t Recall: %f \t F1: %f", precisao, recall, f1);


% Exercicio 2 g) ----------------------

num_experiencias = 10;
array_precisao = zeros(1, num_experiencias);
array_recall = zeros(1, num_experiencias);

for i = 1 : num_experiencias
    VP = 0; 
    FP = 0; 
    VN = 0; 
    FN = 0;
    
    for j = 1 : length(Yteste)
        
        if score_final_OK > score_final_SPAM
            score = "OK";
        else
            score = "SPAM";
        end
    
        classe = Yteste(j);
    
        if score == "SPAM" && classe == "SPAM"
            VP = VP + 1;
    
        elseif score == "SPAM" && classe == "OK"
            FP = FP + 1;
    
        elseif score == "OK" && classe == "OK"
            VN = VN + 1;
    
        elseif score == "OK" && classe == "SPAM"
            FN = FN + 1;
        end
    end
    
array_precisao(i) = VP / (VP + FP);
array_recall(i) = VP / (VP + FN);

end

media_precisao = sum(array_precisao) / num_experiencias;
media_recall = sum(array_recall) / num_experiencias;

fprintf("\n\nExercício 2 g) Conjunto de teste: Media precisão: %.4f \t Media recall: %.4f", media_precisao, media_recall);


% Exercicio 2 h) ----------------------

aux = randperm(size(X,1));
aux2 = round(0.5*size(X,1));

Xtreino = X(aux(1:aux2),:);
Ytreino = Y(aux(1:aux2));

num_experiencias = 10;
array_precisao = zeros(1, num_experiencias);
array_recall = zeros(1, num_experiencias);

for i = 1 : num_experiencias
    VP = 0; 
    FP = 0; 
    VN = 0; 
    FN = 0;
    
    for j = 1 : length(Ytreino)
        
        if score_final_OK > score_final_SPAM
            score = "OK";
        else
            score = "SPAM";
        end
    
        classe = Ytreino(j);
    
        if score == "SPAM" && classe == "SPAM"
            VP = VP + 1;
    
        elseif score == "SPAM" && classe == "OK"
            FP = FP + 1;
    
        elseif score == "OK" && classe == "OK"
            VN = VN + 1;
    
        elseif score == "OK" && classe == "SPAM"
            FN = FN + 1;
        end
    end
    
array_precisao(i) = VP / (VP + FP);
array_recall(i) = VP / (VP + FN);

end

media_precisao = sum(array_precisao) / num_experiencias;
media_recall = sum(array_recall) / num_experiencias;

fprintf("\n\nExercício 2 h) Conjunto de treino: Media precisão: %.4f \t Media recall: %.4f", media_precisao, media_recall);