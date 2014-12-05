function [newGeneration] = mutation(generation,mutationProb)
    individualLen = size(generation,2);
    newGeneration = zeros(size(generation,1),individualLen);
    for i = 1:size(generation,1)
        if rand() < mutationProb
            mutationPosition = round(rand()*(individualLen-1)) + 1;
            newGeneration(i,mutationPosition) = abs(generation(i,mutationPosition) - 1);
            newGeneration(i,1:mutationPosition-1) = generation(i,1:mutationPosition-1);
            newGeneration(i,mutationPosition+1:end) = generation(i,mutationPosition+1:end);
        else
            newGeneration(i,:) = generation(i,:);
        end
    end
end