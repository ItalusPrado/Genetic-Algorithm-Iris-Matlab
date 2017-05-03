function [trainValues,trainTypes,testValues,testTypes] = organizeData(sizeTrain)

data = load('iris.txt'); % Carregando iris
bias = repmat(-1,length(data),1); % Iniciando Bias
data = [bias data];

randomIndex = randperm(length(data)); % Index aleatórios
data = data(randomIndex(1:length(data)),:); % Embaralhando data

trainValues = data(1:sizeTrain,1:5); % Vetor de valores do treino
trainValues(:,2:5) = (trainValues(:,2:5) - repmat(min(trainValues(:,2:5)),120,1))./repmat((max(trainValues(:,2:5))-min(trainValues(:,2:5))),120,1); % Normalizando

testValues = data(sizeTrain+1:length(data),1:5); % Vetor de valores do teste
testValues(:,2:5) = (testValues(:,2:5) - repmat(min(testValues(:,2:5)),30,1))./repmat((max(testValues(:,2:5))-min(testValues(:,2:5))),30,1); % Normalizando
trainTypes = data(1:sizeTrain,6); % Vetor de tipos do treino
testTypes = data(sizeTrain+1:length(data),6); % Vetor de tipos do teste

end