clear;clc;
addpath(genpath(pwd))
filePath = 'D:\Matlab\dataset\';
folderNames = dir(filePath);
folderRecords = length(folderNames);
for i = 3:folderRecords
%     folderNameI:subfolder of dataset
    folderNameI = folderNames(i).name;
%     filePathI:path of ith subfolder of dataset
    filePathI = strcat(filePath,folderNameI);
%     create new folder to store txt   
    newfolder = strcat('D:\Matlab\txtfile\',folderNameI);
    mkdir(newfolder)
%     fileNames:all files under subfolder i 
    fileNames = dir(filePathI);
    fileRecords = length(fileNames);
%    change current directory to new folder
    cd(newfolder)
%     create txt files under new folder
    for j = 3:fileRecords
         
         imageName = strcat(filePathI,'\',fileNames(j).name);
         imageMatrix = jpg2mat(imageName);
%     write imageMatrix into txt
         fileName = strcat(num2str(j),'_',folderNameI,'.txt');

         dlmwrite(fileName,imageMatrix,'delimiter',' ','newline','pc')
     end
         
end
cd('D:\Matlab\')
    

