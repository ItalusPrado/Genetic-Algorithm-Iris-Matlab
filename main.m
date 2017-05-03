clc;
clear all;
close all;

% Tamanho do treino
sizeTrain = 120;
sizePopulation = 30;
sizeElitism = 4;
sizeReproduction = 20;
sizeMutation = 6;
mutationChance = 0.1;

% Separando e organizando dados já normalizados
% Entrada = Tamanho do treino
% Saida = ParametrosTreino,ClassificacaoTreino,ParametrosTeste,ClassificacaoTeste
[trainValues,trainTypes,testValues,testTypes] = organizeData(sizeTrain);

% Criando população | A população antiga pode ser vazia
% Entrada = Número de parâmetros, tamanho da população, população vazia
% Saida = Nova população de valores reais
population = createPopulation(size(trainValues,2), 50, []);

for i = 1:20
    % Calculando fitness de cada individuo
    % Entrada = População, ParametrosTreino, ClassificacaoTreino
    % Saída = Vetor de fitness com index dos individuos em ordem de melhor para pior
    [fitness,relativeFitness,intervalFitness] = findFitness(population, trainValues, trainTypes);
    
    % Escolhendo N individuos por elitismo
    % Entrada = Numero de individuos que serão escolhidos, fitness em ordem de
    % melhor para pior, população atual
    % Saída = Vetor com os primeiros N individuos da nova população
    newPopulation = elitism(sizeElitism, fitness, population);
    
    % Escolhendo N individuos por reprodução
    % Entrada = Numero de individuos que serão criados, fitness de intervalo,
    % população antiga
    % Saída = Retorna 2 novos individuos para nova população
    for j = 1:sizeReproduction/2
        reproductionChilds = reproduction(sizeReproduction, intervalFitness, population);
        newPopulation = [newPopulation reproductionChilds];
    end
    
    
    % Escolhendo N individuos para mutação com chance de 10% de ser
    % escolhido e 10% de chance de gene mudar
    % Entrada = Chance de mutação, população
    % Saida = População com possíveis mutações
    for j = 1 : sizeMutation
        mutationChild = mutation(mutationChance,intervalFitness, population);
        newPopulation = [newPopulation mutationChild];
    end
    
    population = newPopulation;
end

best = population(:,1);
hits = 0;

% Testando o melhor individuo no vetor separado para teste
for j = 1 : length(testValues)
    
    result = testValues(j,:)*best; % Resultado de W'X
    
    % Função de ativação
    if result >= 0
        type = 1;
    else
        type = 0;
    end
    
    % Conferindo se acertou o tipo e somando aos acertos
    if type == testTypes(j)
        hits = hits+1;
    end
end
hits