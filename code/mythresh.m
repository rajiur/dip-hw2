function threshold = mythresh(smoothhist, peakStepLength, peakStepHeight)
    % get total peaks 
    % smoothhist - histogram
    % peakStepLength = length back & forward to look for values to check 
    %                   if current value is a peak, higher value to avoid close peaks
    % peakStepHeight =  difference at step to be calculated as peak, 
    %                   higher value to avoid small peaks
    [peaks, totalpeak] = mypeaks(smoothhist,peakStepLength, peakStepHeight);
    
    % if more than one peak is found, take the first 
    % and last one to calculate the threshold
    if totalpeak>1 
        f1 = peaks(1,1);
        f2 = peaks(1,totalpeak);
        threshold1 = round((f1+f2)/2);
        
        threshold2 = round((f1*smoothhist(f1)+f2*smoothhist(f2))/(smoothhist(f1)+smoothhist(f2)));
        
        threshold = round((threshold1+threshold2)/2);
        
        %threshold = round((f1*smoothhist(1,f1)+f2*smoothhist(1,f2)) / (2*(smoothhist(1,f1)+smoothhist(1,f2))));
    % if less than one or no peak by some error, 
    % choose default threshold = 128
    else
        threshold = 128;
    end
end