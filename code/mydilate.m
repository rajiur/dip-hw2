function dilateimage=mydilate(image, windowsize)
   %get dimension of the image
    [M,N] = size(image);

    padvalue=floor(windowsize/2); %padvalue for windowsize 3 or 5
    
    %adding padding along borders
    padimage = padarray(image,[padvalue,padvalue],'symmetric');
    
    %copy image to dilate image
    dilatepadimage = padimage;    
    
    %dilate only when there's a background pixel
    for i=padvalue+1:M
        for j=padvalue+1:N
            % window operation
            dilate=0;
            for a=i-padvalue:i+padvalue
                for b=j-padvalue:j+padvalue
                   if a~=i && b~=j
                       if padimage(a,b)==1 %if any of the window is foreground(=1), then dilate
                           dilate=1; 
                       end     
                   end    
                end
            end  
            % if any of the neighbor is foreground 
            if dilate==1
                dilatepadimage(i,j)=1; %dilation : set value to foreground(=1)
            end
        end
    end 
    
    %remove the padding
    dilateimage = dilatepadimage(padvalue+1:end-padvalue, padvalue+1:end-padvalue);
    
end