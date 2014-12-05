% function [vector] = txt2Vector(filenames)
function [trainingMatrix] = txtsToMatrix(folderName)
    fileNames = dir(folderName);
    fileRecords = length(fileNames);
    %labels = zeros(fileReocrd-2,1);
    % we already knew that every image is 32*32 pixels
    trainingMatrix = zeros(fileRecords-2,32*32+1);
    for k = 3:fileRecords
        filePath = ['./',folderName,'/',fileNames(k).name];
        label = str2num(fileNames(k).name(1));
        fid = fopen(filePath);
        strCell = textscan(fid,'%s');
        fclose(fid);

        strMatrix = char(strCell{1});
        tempMatrix = zeros(size(strMatrix,1));
        for i = 1:size(strMatrix,1)
            kRow = strMatrix(i,:);
            tempMatrix(i,:) = str2num(kRow(:))';
        end
        trainingMatrix(k-2,:) = [reshape(tempMatrix',1,[]),label];
    end

end

