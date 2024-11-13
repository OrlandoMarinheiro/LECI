% Exercicio 1 a) ----------------------

frases = {'just plain boring'
            'entirely predictable and lacks energy'
            'no surprises and very few laughs'
            'very powerful'
            'the most fun film of the summer'
};

% função
todas = strjoin(frases, ' ');  % buscar todas as palavras e junta-las
palavras = regexp(todas, '\s+', 'split'); % separar palavra por \s+ (1 ou mais caracteres em branco)
palavrasUnicas = unique(lower(palavras));  % ordenar por ordem alfabetica

% -------------------------------------

% Exercicio 1 b) ----------------------
fprintf("Exercício 1 b)\n")

contagem = zeros(length(frases), length(palavrasUnicas));

for i = 1 : length(frases)
    frase = regexp(frases{i}, '\s+', 'split');   % separar cada frase dentro de frases em palavras

    for j = 1 : length(palavrasUnicas)
        palavra = palavrasUnicas{j};

        contagem(i, j) = sum(strcmp(palavra, frase));
    end
end

disp(contagem);

% Exercicio 1 c) ----------------------

categorias = categorical({'-';'-';'-';'+';'+'});

% -------------------------------------


% Exercicio 1 d) ----------------------
fprintf("Exercício 1 d)\n")

num_neg = sum(categorias == '-'); % numero de categorias -
num_pos = sum(categorias == '+'); % numero de categorias +
num_total = num_pos + num_neg;

Prob_negativo = num_neg / num_total;
Prob_positivo = num_pos / num_total;

fprintf("P(-): %f\t", Prob_negativo);
fprintf("P(+): %f", Prob_positivo);


num_palvras_neg = sum(sum(contagem(1:3, :))); % numero de palavras de categoria -
num_palavras_pos = sum(sum(contagem(4:5, :))); % numero de palavras de categoria +
num_total_palavras = length(palavrasUnicas);


palavras = {'predictable', 'no', 'fun'};
indices = zeros(1, length(palavras));

% iniciar dois arrays para verificar qual é a categoria mais provavel
score_neg = zeros(1, length(palavras));
score_pos = zeros(1, length(palavras));

% descobrir indice da palavra em questão
for i = 1 : length(palavras)
    indices(i) =  find(strcmp(palavras{i}, palavrasUnicas));
end


for i = 1 : length(indices)
    % numero de vezes que a palavra em questão aparece em -
    num_ocor_neg = sum(contagem(1:3, :));
    num_ocor_neg = num_ocor_neg(indices(i));

    % numero de vezes que a palavra em questão aparece em +
    num_ocor_pos = sum(contagem(4:5, :));
    num_ocor_pos = num_ocor_pos(indices(i));

    
    prob_predictable_neg = (num_ocor_neg + 1) / (num_palvras_neg + num_total_palavras);
    prob_predictable_pos = (num_ocor_pos + 1) / (num_palavras_pos + num_total_palavras);

    fprintf('\nP("%s"|-): %.4f\tP("%s"|+): %.4f', palavras{i}, prob_predictable_neg, palavras{i}, prob_predictable_pos);
    
    
    % adicionar ao array
    score_neg(i) = prob_predictable_neg;
    score_pos(i) = prob_predictable_pos;

  
end

% calcular a categoria mais provavel (VER PAG 25 SLIDE Naive Bayes)
score_final_pos = prod(score_pos) * Prob_positivo;
score_final_neg = prod(score_neg) * Prob_negativo;

fprintf("\n");
fprintf('\nP("predictable with no fun"|-): %e', score_final_neg);
fprintf('\nP("predictable with no fun"|+): %e', score_final_pos);

if score_final_neg > score_final_pos
    fprintf('\nCategoria mais provável: "-"');
else
    fprintf('\nCategoria mais provável: "+"');
end

