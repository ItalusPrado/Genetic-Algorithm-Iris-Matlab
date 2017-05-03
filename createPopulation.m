function population = createPopulation(sizeParameters, sizePopulation, oldPopulation)

% Criando população com valores aleatorios caso não tenha população anterior
if isempty(oldPopulation)
    population = rand(sizeParameters,sizePopulation);
end

end