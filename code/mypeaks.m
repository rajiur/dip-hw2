function [peaks,totalpeak]=mypeaks(histarray, peakStepLength, peakStepHeight)
    
    peaks=zeros(1,1);   %empty array to hold total peaks
    totalpeak=0;        %init totalpeak=0
    
    stepsize=floor(peakStepLength/2);  %stepsize to find peak
    [c,histsize]=size(histarray);
    
    % peakStepLength = length back & forward to look for values to check 
    %                   if current value is a peak, higher value to avoid close peaks
    % peakStepHeight =  difference at step to be calculated as peak, 
    %                   higher value to avoid small peaks
    
    i=stepsize+1; % start checking from one step forward
    while i<=histsize-stepsize % check up to one step to last value
        % check one step left and one step right
        % if present point is higher then left and right, it's a peak
        %       (peakStepLength & peakStepHeight are considered
        %       while checking left and right)
        if histarray(1,i-stepsize)<(histarray(1,i)-peakStepHeight) && histarray(1,i)>histarray(1,i+stepsize)+peakStepHeight
           totalpeak=totalpeak+1;
           peaks(1,totalpeak)=i;
           i=i+stepsize; % go to next step once a peak is found
        else % else go to next point
            i=i+1;
        end
        
        
    end
end