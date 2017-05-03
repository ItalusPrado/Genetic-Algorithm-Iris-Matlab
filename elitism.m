function newPopulation = elitism(sizeElitism, fitness, population)

% Escolha da elite
indexElite = fitness(1:sizeElitism,2);
newPopulation = population(:,indexElite);

end