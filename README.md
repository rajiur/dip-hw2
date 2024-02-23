1. You are given an object’s template (e.g., wheel), and an image showing many instances of that object (e.g., a car with wheels). Write a MATLAB code for detecting the object in the given image. Detection can be implemented by computing the correlation between the template and the image. The image locations that have maximum correlation values can be interpreted as object detections. The input to your program is: (i) image, and (ii) template.
Your submission and report should include:

1.1 M-file with a well commented code.

1.2 Figure showing the correlation results and the caption.

1.3 List (x, y) coordinates of all your object detections in the image.


2. Generate a toeplitz stripe image of the size 48x48. Place a square of 32x32 in the center of the image. Compute the DFT of the resultant image and center the frequency plot, compress it logarithmically and perform a contrast stretch. Generate a mask for the parts in the Fourier transform that came from the diagonals in the original image. Mask out the frequencies in the Fourier domain and take an inverse transform.

2.1 M-file with a well commented code.

2.2 Figure showing the generated image.

2.3 Figure showing the magnitude and phase plots.

2.4 Figure showing the generated mask image.

2.5 Figure showing the filtered image.
