function hw2_1(corrthresh)
    % READ IMAGE FILE & SIZE
    image = imread('car.png'); 
    template = imread('template.png');

    [M,N] = size(image);
    [P,Q] = size(template);

    % FIND CORRELATION
    corr = zeros(M,N);
    for i=1:M-P+1
        for j=1:N-Q+1
            value = corr2(image(i:P+i-1,j:Q+j-1), template);
            if isnan(value)
                corr(i,j) = 0;
            else
                corr(i,j) = value;
            end
        end
    end

    % FIND PEAKS
    % -- with correlation value higher than 0.4
    [X,Y] = find(corr>corrthresh); % X,Y contains the location of peak
    
    [length,c] = size(X);
    
    % -- finding local maxima from set of co-located peaks
    Xnew = X; Ynew = Y; 
    for i=1:length
        for j=1:length
            if i~=j % check for each except self
                if abs(X(i)-X(j)) < round(P/2) && abs(Y(i)-Y(j)) < round(Q/2) % check for distance 
                    if corr(X(i),Y(i)) < corr(X(j),Y(j)) % if value is lower 
                        Xnew(i)=0; Ynew(i)=0; % set the ref to 0
                    end
                end
            end
        end
    end

    Xnew=Xnew(Xnew~=0); % remove values with zero
    Ynew=Ynew(Ynew~=0); % remove values with zero
    [newlength,c] = size(Xnew);
    
    % ----------- MARK PEAKS ------------------
    markedimage = double(cat(3, image, image, image));
    for i=1:newlength

        % find center point of the template, in the image
        posX = Xnew(i,1)+round(P/2);
        posY = Ynew(i,1)+round(Q/2);

        % marking the center point
        markedimage(posX,posY,1) = 255;
        markedimage(posX,posY,2) = 0;
        markedimage(posX,posY,3) = 0;

        % marking 5x5 cross along the center point
        for j=1:2
            markedimage(posX+j,posY,1) = 255;
            markedimage(posX+j,posY,2) = 0;
            markedimage(posX+j,posY,3) = 0;
            markedimage(posX-j,posY,1) = 255;
            markedimage(posX-j,posY,2) = 0;
            markedimage(posX-j,posY,3) = 0;

            markedimage(posX,posY+j,1) = 255;
            markedimage(posX,posY+j,2) = 0;
            markedimage(posX,posY+j,3) = 0;
            markedimage(posX,posY-j,1) = 255;
            markedimage(posX,posY-j,2) = 0;
            markedimage(posX,posY-j,3) = 0;
        end

    end


    % DISPLAY THE FINAL OUTPUT, WITH MARKED TEMPLATE MATCH

    imshow(uint8(markedimage));

    
    fprintf('Maximum Peaks (at pixel location):\n');
    for i=1:newlength
           fprintf('%.2f at (%d,%d)\n', corr(Xnew(i),Ynew(i)),Xnew(i)+round(P/2),Ynew(i)+round(Q/2));
    end
    
end
