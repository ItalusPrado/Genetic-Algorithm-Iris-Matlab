function newPopulation = reproduction(sizeReproduction, intervalFitness, population)

% Roleta
indexOk = false;

while indexOk == false
    values = [rand rand];
    best = [0 0];
    for individual = 1 : 2
        searching = true;
        i = 1;
        while searching
            if intervalFitness(i,1) >= values(individual)
                indChoosen(individual) = intervalFitness(i,2);
                best(individual) = i;
                searching = false;
            else
                i = i+1;
            end
        end
    end
    if indChoosen(1) ~= indChoosen(2)
        indexOk = true;
    end
end

% CrossOver aritmético entre os 2 individuos
blend = rand;
individualA = population(:,indChoosen(1));
individualB = population(:,indChoosen(2));
% result1 = (blend*individualA)+((1-blend)*individualB);
% result2 = ((1-blend)*individualA)+(blend*individualB);

if best(1) < best(2)
    result1 = individualA + blend * (individualA - individualB);
    result2 = individualA;
else
    result1 = individualB + blend * (individualB - individualA);
    result2 = individualB;
end

newPopulation = [result1 result2];

end