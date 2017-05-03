function [fitness,relativeFitness,intervalFitness] = findFitness(population, parameters, types)

fitnessArray = [];

for i = 1 : length(population)
    
    hits = 0; % Iniciando numero de acertos = 0
    individual = population(:,i); % Escolhendo individuo para aplicar o fitness
    
    for j = 1 : length(parameters)
        
        result = parameters(j,:)*individual; % Resultado de W'X
        
        % Função de ativação
        if result >= 0
            type = 1;
        else
            type = 0;
        end
        
        % Conferindo se acertou o tipo e somando aos acertos
        if type == types(j)
            hits = hits+1;
        end
        
    end
    
    % Salvando informações do individuo e quantos ele acertou
    fitnessArray(i,:) = [hits, i];
end

fitness = flipud(sortrows(fitnessArray)); % Ordenando os melhores individuos

totalFitness = sum(fitness(:,1)); % Coletando o somatório dos fitness

% Informando valor relativo do fitness
relativeFitness = fitness(:,1)./repmat(totalFitness,length(fitness),1);

% Criando valor de intervalo dos fitness relativos (Usado para a roleta)
for i = length(fitness) : -1 : 1
    intervalFitness(i,:) = [sum(relativeFitness(1:i)) fitness(i,2)];
end
fitness(1)

end