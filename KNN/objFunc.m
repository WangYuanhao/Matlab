function [errorRate] = objFunc(testMatrix,trainingMatrix)

%  trainingMatrix = txtsToMatrix('trainingDigits');
%  testMatrix = txtsToMatrix('testDigits');
%  save trainingMatrix.mat
%  save testMatrix.mat
% load('testMatrix.mat');
% load('trainingMatrix.mat');
testRecords = size(testMatrix,1);
%outputLabel = zeros(testRecords,1);
%kChosen = 2:1:20;
k =3;
%errorRate = zeros(length(kChosen),1);
%matlabpool local 2
%tic;
%for j = 1:length(kChosen)
count = 0;
   for i = 1:testRecords
        outputLabel = knnClassifier(k,testMatrix(i,1:end-1),trainingMatrix);
        if outputLabel ~= testMatrix(i,end)
           count = count + 1;
%         formatSpec = 'The %d th input is classified as %d .\nThe actual label of %d th input is %d .\n';
%         fprintf(formatSpec,i,outputLabel,i,testMatrix(i,end));
%         fprintf('\n########################################################\n');
        end

    %     disp(outputLabel);
    %     disp(testMatrix(i,end));
  end
%fprintf('Error rate: %f.\n',count/double(testRecords));
    errorRate = count/double(testRecords);
%end
%toc
%matlabpool close
%plot(kChosen,errorRate,'bo','MarkerFaceColor','b');

        