% The M-file is used to integrate all images into a single mat file.
% We've already known there are 303 images.
% All images are binarized.
clc;clear
imageRecords = 303;
directories = dir;
dirRecords = length(directories)-3;
% The last column of verificationCodes stands for labels.
% Every directory is named by image's label
verificationCodes = zeros(imageRecords,401);
count = 1;
for i = 1:dirRecords
    filePath = strcat('./',directories(i+2).name,'/*.jpg');
    files = dir(filePath);
    fileRecords = length(files);
    for k = 1:fileRecords
        imageMatrix = jpg2mat(strcat('./', ... 
            '/',directories(i+2).name,'/',files(k).name)); 
        verificationCodes(count,1:end-1) = reshape(imageMatrix,1,400);
        verificationCodes(count,end) = str2double(directories(i+2).name);
        count = count + 1;
    end
end
verificationCodes = uint8(verificationCodes);
save('verificationCodeDatabase.mat','verificationCodes');