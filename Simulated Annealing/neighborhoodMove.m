function [neighborhood] = neighborhoodMove(x_)
%change two elements every movement
    
    xLength = length(x_);
    % randperm generates random integers sequece without repeat
    changePosition = randperm(xLength,2);
    temp = x_(changePosition(1));
    x_(changePosition(1)) = x_(changePosition(2));
    x_(changePosition(2)) = temp;
    neighborhood = x_;
end