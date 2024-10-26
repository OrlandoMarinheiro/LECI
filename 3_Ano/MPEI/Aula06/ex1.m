
% 1 a) -------------------------
fprintf("Exercicio 1 a)\n")


% Definindo a matriz de distribuição conjunta
PXY = [0.3 0.2 0; 
       0.1 0.15 0.05; 
         0 0.1 0.1];

soma_colunas = sum(PXY,1);  % soma colunas probY

soma_linhas = sum(PXY,2); % soma linhas probX

fprintf("FMP marginal de X:\t");
for i = 1:3
    fprintf("f(%d) = %.2f\t", i, soma_linhas(i));
end

fprintf("\nFMP marginal de Y:\t");
for i = 1:3
    fprintf("f(%d) = %.2f\t", i, soma_colunas(i));
end

% representação massa probabilidade grafico stem
x = [0:2];

subplot(1,2,1);
stem(x, soma_linhas);
xlabel("X")
ylabel("Px")
grid on;


subplot(1,2,2);
stem(x, soma_colunas);
xlabel("Y")
ylabel("Py")
grid on;

sgtitle("Funções massa de probabilidade marginais de X e Y");


% 1 b) -------------------------
fprintf("\nExercicio 1 b)")


media_x = 0;
var_x = 0;
for x = 0:2
    media_x = media_x + x * soma_linhas(x + 1);
    var_x = var_x + x^2 * soma_linhas(x + 1);
end
var_x = var_x - media_x^2;

media_y = 0;
var_y = 0;
for y = 0:2
    media_y = media_y + y * soma_colunas(y + 1);
    var_y = var_y + y^2 * soma_colunas(y + 1);
end
var_y = var_y - media_y^2;

fprintf("\nVariável X:  media = %f, variância = %f", media_x, var_x);

fprintf("\nVariável Y:  media = %f, variância = %f", media_y, var_y);


% 1 c) -------------------------
fprintf("\nExercicio 1 c)")

media_XY = 0;
for x = 1:3
    
    for y = 1:3
        
        media_XY = media_XY + PXY(x,y) * (x - 1) * (y - 1);
    end
end

correlacao_XY = media_XY;
covariancia_XY = media_XY - (media_x * media_y);
coeficiente_correlacao_XY = covariancia_XY / (sqrt(var_y) * sqrt(var_x));


fprintf("\nCorrelação XY:  %f", correlacao_XY);
fprintf("\nCovariância XY:  %f", covariancia_XY);
fprintf("\nCoeficiente de Correlação entre X e Y:  %f", coeficiente_correlacao_XY);


