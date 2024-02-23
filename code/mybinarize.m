function [binimage,threshold,histarray, smoothhist] = mybinarize(image, peakStepLength, peakStepHeight, histSmoothSize)
    
    %get dimension of the image
    [M,N] = size(image);
    
    % ---- create histogram -----
    histarray = myhist(image);
   
    % ----- histogram smoothing -------
    % histSmoothSize = smoothing window size
    smoothhist = myhistsmoothing(histarray,histSmoothSize);
    
    
    % -------- calculate threshold ----------
    % mythresh(smoothhist, peakStepLength, peakStepHeight)
    % peakStepLength = length back & forward to look for values to check 
    %                   if current value is a peak, higher value to avoid close peaks
    % peakStepHeight =  difference at step to be calculated as peak, 
    %                   higher value to avoid small peaks
    threshold = mythresh(smoothhist, peakStepLength, peakStepHeight);
    
    
    %create binary image
    binimage = zeros(M,N);
    for i=1:M
        for j=1:N
            % pixels darker than threshold
            if image(i,j)>threshold 
                % binary foreground = white
                binimage(i,j) = 1;  
            % pixels lighter than threshold
            else
                % binary background = black
                binimage(i,j) = 0; 
            end
        end
    end
    
end
