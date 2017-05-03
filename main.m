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

% Separando e organizando dados j� normalizados
% Entrada = Tamanho do treino
% Saida = ParametrosTreino,ClassificacaoTreino,ParametrosTeste,ClassificacaoTeste
[trainValues,trainTypes,testValues,testTypes] = organizeData(sizeTrain);

% Criando popula��o | A popula��o antiga pode ser vazia
% Entrada = N�mero de par�metros, tamanho da popula��o, popula��o vazia
% Saida = Nova popula��o de valores reais
population = createPopulation(size(trainValues,2), 50, []);

for i = 1:20
    % Calculando fitness de cada individuo
    % Entrada = Popula��o, ParametrosTreino, ClassificacaoTreino
    % Sa�da = Vetor de fitness com index dos individuos em ordem de melhor para pior
    [fitness,relativeFitness,intervalFitness] = findFitness(population, trainValues, trainTypes);
    
    % Escolhendo N individuos por elitismo
    % Entrada = Numero de individuos que ser�o escolhidos, fitness em ordem de
    % melhor para pior, popula��o atual
    % Sa�da = Vetor com os primeiros N individuos da nova popula��o
    newPopulation = elitism(sizeElitism, fitness, population);
    
    % Escolhendo N individuos por reprodu��o
    % Entrada = Numero de individuos que ser�o criados, fitness de intervalo,
    % popula��o antiga
    % Sa�da = Retorna 2 novos individuos para nova popula��o
    for j = 1:sizeReproduction/2
        reproductionChilds = reproduction(sizeReproduction, intervalFitness, population);
        newPopulation = [newPopulation reproductionChilds];
    end
    
    
    % Escolhendo N individuos para muta��o com chance de 10% de ser
    % escolhido e 10% de chance de gene mudar
    % Entrada = Chance de muta��o, popula��o
    % Saida = Popula��o com poss�veis muta��es
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
    
    % Fun��o de ativa��o
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