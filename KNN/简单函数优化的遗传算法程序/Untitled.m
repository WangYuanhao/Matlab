%generate 50 populations randomly
populationNum = 50;
chomoLength = 1024;
population = round(rand(populationNum,chomoLength));
errorRate = zeros(populationNum,1);
%computing errorRate for every population
%step1:feature selction
for i = 1:50
    trainingFeature = trainingMatrix(:,population(i,:)==1);
    testFeature = testMatrix(:,population(i,:)==1);
    errorRate(i) = objFunc([testFeature,testMatrix(:,end)], ...
            [trainingFeature,trainingMatrix(:,end)]);
end

