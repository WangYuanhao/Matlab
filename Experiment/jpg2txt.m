clc;clear;
fPath = fullfile('D:','dataset','2','*.jpg');

imageFiles = dir(fPath);
imageRecords = length(imageFiles);
for i = 1 : imageRecords
  
%     imageFiles(i).name-----refers to filename
%     imageRGB refers to RGB image
    imageRGB = imread(imageFiles(i).name);
%     extract R channel for image
    imageR = imageRGB(:,:,1);
%     auto compute threshold for binarization
    thresh = graythresh(imageR);
%     binarization
    imageMatrix = im2bw(imageR,thresh);
%     write imageMatrix into txt
    fileName = strcat(num2str(i),'_2.txt');
%     cd D:\dataset\txtfile
    dlmwrite(fileName,imageMatrix,'delimiter',' ','newline','pc')
%     cd D:\dataset\2\
    
    
end
    


