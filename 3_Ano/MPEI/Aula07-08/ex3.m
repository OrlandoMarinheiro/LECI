X = [1 0 1 1;
     0 1 0 0;
     0 1 0 1;
     1 0 1 1;
     1 1 0 1;
     0 1 0 0];

classes = categorical({'Interessa', 'Não Interessa', 'Interessa', 'Interessa', 'Interessa', 'Não Interessa'});

XI = X(classes== 'Interessa',:);
XNI = X(classes == 'Não Interessa',:);
probI = sum(classes == 'Interessa')/length(classes);
probNI = sum(classes == 'Não Interessa')/length(classes);
pI = sum(XI)/ sum(sum(XI));
pNI = sum(XNI)/sum(sum(XNI));

% Exercicio 3 a) ----------------------

filme = [1 0 1 1];
resI = probI*prod(pI(filme==1));
resNI = probNI*prod(pNI(filme==1));

if resI>resNI
    fprintf('\nExercicio 3 a) Interessa -> p(interessa) = %f > p(não interessa) = %f\n', resI, resNI);
else
    fprintf('\nExercicio 3 a) Não Interessa -> p(interessa) = %f < p(não interessa) = %f\n', resI, resNI);
end

% Exercicio 3 b) ----------------------

filme = [0 1 0 0];
resI = probI*prod(pI(filme==1));
resNI = probNI*prod(pNI(filme==1));

if resI>resNI
    fprintf('\nExercicio 3 b) Interessa -> p(interessa) = %f > p(não interessa) = %f\n', resI, resNI);
else
    fprintf('\nExercicio 3 b) Não Interessa -> p(interessa) = %f < p(não interessa) = %f\n', resI, resNI);
end

% Exercicio 3 c) ----------------------

filme = [1 1 0 0];
resI = probI*prod(pI(filme==1));
resNI = probNI*prod(pNI(filme==1));

if resI>resNI
    fprintf('\nExercicio 3 c) Interessa -> p(interessa) = %f > p(não interessa) = %f\n', resI, resNI);
else
    fprintf('\nExercicio 3 c) Não Interessa -> p(interessa) = %f < p(não interessa) = %f\n', resI, resNI);
end
