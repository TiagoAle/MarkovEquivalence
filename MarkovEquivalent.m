function resultado = MarkovEquivalent(arrayQ1,arrayQ2)

% -------- Parte I - Verificação do esqueleto do grafo ---------
arrayQ1t= arrayQ1';
arrayQ2t = arrayQ2';

markov1 = arrayQ1t | arrayQ1;
markov2 = arrayQ2t | arrayQ2;

firstTest = isequal(markov1,markov2);

%---------- Parte II - Verificação se possuem mesma imoralidade ---------

imoralities1 = [];
imoralities2 = [];
values = sum(arrayQ1,1);
positions = [];
b = 1;

for i = 1:size(arrayQ1,2)
    if values(i) > 1
        a = 1;
        for j = 1:size(arrayQ1,1)
            if arrayQ1(j,i) == 1
                positions(a,b) = j;
                a = a+1;
            end
        end
        b = b+1;
    end
end

n = 1
for i = 1:size(positions,2)
    for j = 1:size(positions,1)-1
        pos1 = positions(j,i);
        for k = j+1:size(positions,1)
            pos2 = positions(k,i);
            if pos2 == 0
                break
            end
            if arrayQ1(pos1,pos2) == 0 && arrayQ1(pos2,pos1) == 0
                imoralities1(n,:) = [pos1 pos2];
                n = n+1;
            end
        end
    end
end

values = sum(arrayQ2,1);
positions = [];
b = 1;

for i = 1:size(arrayQ2,2)
    if values(i) > 1
        a = 1;
        for j = 1:size(arrayQ2,1)
            if arrayQ2(j,i) == 1
                positions(a,b) = j;
                a = a+1;
            end
        end
        b = b+1;
    end
end

n = 1
for i = 1:size(positions,2)
    for j = 1:size(positions,1)-1
        pos1 = positions(j,i);
        for k = j+1:size(positions,1)
            pos2 = positions(k,i);
            if pos2 == 0
                break
            end
            if arrayQ2(pos1,pos2) == 0 && arrayQ2(pos2,pos1) == 0
                imoralities2(n,:) = [pos1 pos2];
                n = n+1;
            end
        end
    end
end

if imoralities1 == imoralities2
    resultado = 1;
else
    resultado = 0;
end