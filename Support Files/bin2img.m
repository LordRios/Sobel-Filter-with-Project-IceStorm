function B=bin2img(name,w,h)

file = fopen(name);
A = fread (file,[w,h],'uint8');
B = A.';
fclose(file);

I=mat2gray(B,[01 254]);
imshow(I)
%R = image(B)
%colormap gray
imwrite(I,'img.jpg')
end
