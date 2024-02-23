function hw2_2(freqcutoff)
    % freqcutoff is the circular cutoff frequency which is normalized to [0 1],
    % that is, the highest radian frequency \pi of digital signals is mapped to 1.

    % -------- CREATING THE IMAGE --------------
    IMAGESIZE = 48;

    % creating the stripe 48x48
    frame = zeros(1,IMAGESIZE);
    i=2;
    frame(1,1)=1;
    frame(1,2)=1;
    while i<=IMAGESIZE-2
        frame(1,i)=mod(i+1,2);
        frame(1,i+1)=mod(i,2);
        frame(1,i+2)=mod(i,2);
        i = i+3;
    end    

    stripe = toeplitz(frame);
    
    %display(stripe);
    

    % adding the center white square 32x32
    RGB = insertShape(stripe,'FilledRectangle',[9 9 32 32],'Color','white','Opacity',1);
    image = rgb2gray(RGB);

 %display(image);
    
    % --------- CALCULATING DFT ---------
    DFT = fft2(image);          % FFT Calculation
    shiftedDFT = fftshift(DFT); % shifting

    % ---------- CREATING THE MASK ------------
    % Acknowledgements for creating low pass filter
    % http://digitalimagepro.blogspot.com/2013/11/ideal-low-pass-filter-concept-in-matlab.html
    % https://www.mathworks.com/matlabcentral/fileexchange/36674-ideal-low-pass-filtering-of-an-image

    hr = (IMAGESIZE-1)/2; 
    hc = (IMAGESIZE-1)/2; 
    [x, y] = meshgrid(-hc:hc, -hr:hr);
    grid = sqrt((x/hc).^2 + (y/hr).^2); 
    mask = double(grid <= freqcutoff);
    
    display(mask);
    
    %h = fspecial('gaussian', [48,48], 5)*255;

    % ---------- APPLYING FILTER ---------

    filteredDFT = shiftedDFT.* mask;    % applying mask
    
    imshow(abs(filteredDFT));figure;
    
    filteredimage = abs(ifft2(ifftshift(filteredDFT))); 
                % shifting back and inverse FFT, 
                % and taking absolute values as filteredimage has imaginary values

    display(filteredimage);

    % binarize & running OPEN-CLOS with hw1 programs             
    intermediateimage = filteredimage*255;
    intermediateimage = uint8(intermediateimage);
    [finalimage,threshold,histarray, smoothhist] = mybinarize(intermediateimage, 2,1,  5);            
    finalimage=myopen(myclose(finalimage,5),5);            
        
    
    % -------- SHOWING RESULTS ------------

    fontsize = 10;

    subplot(2,3,1);
    imshow(image); 
    title( 'Generated Image', 'FontSize', fontsize);


    subplot(2,3,2);
    %imshow(abs(shiftedDFT));
    imagesc(log(1+abs(shiftedDFT)));
    title( 'Magnitude', 'FontSize', fontsize);

    subplot(2,3,3);
    %imshow(angle(shiftedDFT)); 
    imagesc(angle(shiftedDFT)); 
    title( 'Phase', 'FontSize', fontsize);

    subplot(2,3,4);
    imshow(mask); 
    title( 'MASK', 'FontSize', fontsize);

    subplot(2,3,5);
    imshow(filteredimage); 
    title( 'Filtered Image', 'FontSize', fontsize);
    
     subplot(2,3,6);
    imshow(finalimage); 
    title( 'Final Image', 'FontSize', fontsize);

end