function imageMatrix = jpg2mat(filename)
%     imageFiles(i).name-----refers to filename
%     imageRGB refers to RGB image
    imageRGB = imread(filename);
%     extract R channel for image
    imageR = imageRGB(:,:,1);
%     auto compute threshold for binarization
    thresh = graythresh(imageR);
%     binarization
    imageMatrix = im2bw(imageR,thresh);
end
    


