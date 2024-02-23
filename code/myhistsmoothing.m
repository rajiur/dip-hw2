function smoothhist = myhistsmoothing(histarray, histSmoothSize)
    %get size of the histogram
    [c,histsize] = size(histarray);
    
    % ----- histogram smoothing -------
    winMidSize = floor (histSmoothSize / 2);
    smoothhist = zeros(1,histsize);
    % for each point take mean of all points within histSmoothSize window
    
    for i=winMidSize:(histsize - winMidSize-1)
        mean = 0;
        for j=(i - winMidSize + 1):(i + winMidSize)
             mean = mean + histarray(1,j);
        end
        smoothhist(1,i) = round(mean / histSmoothSize);
    end
end