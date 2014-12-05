function [outputLabel]=knnClassifier(k,testSample,trainSample)
    % The testSample doesn't have label.
    format long
    trainingRecords = size(trainSample(:,1:end-1));
    %compute distances between testSample and all points in trainSample
    testSampleMatrix = repmat(testSample,trainingRecords(1),1);
    diffMat = testSampleMatrix - trainSample(:,1:end-1);
    squareDiffMat = diffMat.^2;
    %sum toward column direction
    distances = sqrt(sum(squareDiffMat,2));
    
    [~,indexOfPoints] = sort(distances);
    
    labels = trainSample(indexOfPoints(1:k),end);
   
         
    %mode:most frequency value in labels;
    outputLabel = mode(labels);
    
    
    
end