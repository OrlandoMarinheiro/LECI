% 2 a) --------------------------

% P(x=a, y=b) = P(x=a) * P(y=b)

% Definindo a matriz de distribuição conjunta
PXY = [1/8 1/8 1/24; 
       1/8 1/4 1/8; 
      1/24 1/8 1/24];

soma_colunas = sum(PXY,1)  % soma colunas probY, correspondente a Y

soma_linhas = sum(PXY,2) % soma linhas probX, correspondente a X


for x = 1:3
    for y = 1:3
        PX_Y = soma_linhas(x) * soma_colunas(y);
        
        if PXY(x,y) ~= PX_Y
            independente = false;
            break
        end

    end
    if independente == false
        break   
    end
end


if independente == true
    fprintf("Ex 2) As variaveis X e Y são independentes!");
else
    fprintf("Ex 2) As variaveis X e Y não são independentes!");
end