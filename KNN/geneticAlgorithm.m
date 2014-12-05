%populationSize
populationSize = 50;
%individual length:each image is 32*32 pixels.
individualLen = 1024;
%population
population = round(rand(populationSize,individualLen));
%iteration
iters = 200;
% probability of crossover
crossProb = 0.8;
%probability of mutation
mutationProb = 0.1;
%next population
nextPopulation = zeros(populationSize,individualLen);
% record average error rate
averageErrorRate = zeros(iters,1);
%record best error rate
bestErrorRate = zeros(iters,1);
%record best individual
bestIndividual = zeros(iters,individualLen);
load trainingMatrix.mat;
load testMatrix.mat;
tic
for i = 1:iters
   
    errorRate = zeros(populationSize,1);
    
    for j = 1:populationSize
        trainingFeature = trainingMatrix(:,population(j,:)==1);
        testFeature = testMatrix(:,population(j,:)==1);
        errorRate(j) = objFunc([testFeature,testMatrix(:,end)], ...
                [trainingFeature,trainingMatrix(:,end)]);
    end
    averageErrorRate(i) = mean(errorRate);
    [bestErrorRate(i),index] = max(errorRate);
    bestIndividual(i,:) = population(index,:); 
    
    for k = 1:2:populationSize
        select = selecT(errorRate);
        children = crossover([population(select(1),:);population(select(2),:)],crossProb);
        nextPopulation(k:k+1,:) = mutation(children,mutationProb);
    end
    population = nextPopulation;

end
toc
