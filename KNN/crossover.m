function [nextGeneration] = crossover(parents,crossProb)
    individualLen = size(parents,2);
    nextGeneration = zeros(size(parents,1),individualLen);
    if rand() < crossProb
        crossPosition = round(rand()*(individualLen-2)) + 1;
        nextGeneration(1,:) = [parents(1,1:crossPosition) parents(2,crossPosition+1:end)];
        nextGeneration(2,:) = [parents(2,1:crossPosition) parents(1,crossPosition+1:end)];
    else
        nextGeneration(1,:) = parents(1,:);
        nextGeneration(2,:) = parents(2,:);
     end
end