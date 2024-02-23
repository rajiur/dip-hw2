function histarray = myhist(image)
    %get dimension of the image
    [M,N] = size(image);
    
    % ---- create histogram -----
    histarray = zeros(1,256); %intialize hist indexes=0
    for i=1:M
        for j=1:N
            histarray(image(i,j)+1) = histarray(image(i,j)+1)+1;
        end
    end
end