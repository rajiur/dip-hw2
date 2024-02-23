function closeimage=myclose(image,windowsize)
    closeimage =  myerode(mydilate(image,windowsize),windowsize);
end