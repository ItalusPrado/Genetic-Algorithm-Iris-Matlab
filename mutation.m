function individual = mutation(mutationChance,intervalFitness, population)

value = rand;

searching = true;
i = 1;

while searching
    if intervalFitness(i,1) >= value
        indChoosen = intervalFitness(i,2);
        searching = false;
    else
        i = i+1;
    end
end

individual = population(:,indChoosen);

chooseToChange = rand;

if chooseToChange <= mutationChance
    for j = 1 : size(population,1)
        
        willChange = rand;
        if willChange <= mutationChance
            individual(j,1) = rand;
            break;
        end
        
    end
end


end

% for i = 1 : length(population)
%
%     indivChoosen = rand;
%
%     if indivChoosen <= mutationChance
%         for j = 1 : size(population,1)
%
%             willChange = rand;
%             if willChange <= mutationChance
%                 population(j,i) = rand;
%                 break;
%             end
%
%         end
%     end
%
% end