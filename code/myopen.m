function openimage=myopen(image,windowsize)
   openimage = mydilate(myerode(image,windowsize),windowsize);
end