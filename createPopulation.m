function population = createPopulation(sizeParameters, sizePopulation, oldPopulation)

% Criando popula��o com valores aleatorios caso n�o tenha popula��o anterior
if isempty(oldPopulation)
    population = rand(sizeParameters,sizePopulation);
end

end