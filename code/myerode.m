function erodeimage=myerode(image, windowsize)
    %get dimension of the image
    [M,N] = size(image);
    
    padvalue=floor(windowsize/2); %padvalue for windowsize 3 or 5

    %adding padding along borders
    padimage = padarray(image,[padvalue,padvalue],'symmetric');
   
    %copy image to erode image
    erodepadimage = padimage;    
    
    %erode only when there's a background pixel
    for i=padvalue+1:M
        for j=padvalue+1:N
            % window operation
            erode=0;
            % chek all the 8 neighboring pixels
            for a=i-padvalue:i+padvalue
                for b=j-padvalue:j+padvalue
                   if a~=i && b~=j
                       if padimage(a,b)==0 %if any of the window is background (=0), then erode
                           erode=1; 
                       end     
                   end    
                end
            end  
            % if any of the neighbor is background
            if erode==1
                erodepadimage(i,j)=0; %erosion : set value to background(=0)
            end
        end
    end
    
    
     %remove the padding
    erodeimage = erodepadimage(padvalue+1:end-padvalue, padvalue+1:end-padvalue);
end
    