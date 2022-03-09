%Experimento 2
%Exercicio 1

%TRATAMENTO DE IMAGEM COM RUIDO ADICIONADO
%USANDO FILTRO DE WIENER 

%Abertura da Imagem
I = imread('Lenna.bmp');
%I = rgb2gray(I)

%Apresenta a imagem aberta
imshow(I);
title('Imagem Original');

%Aplica ruído gaussiano de media 0 e variancia 0,025 a imagem
MEAN = 0;
VAR = 0.025;
J = imnoise(I,'gaussian',0,0.025);

%Apresenta a imagem com ruido
figure;
imshow(J);
title('Imagem com ruido gaussiano adicionado');

%Aplica o filtro de Wiener 
K = wiener2(J,[8 8], 0);

%Apresenta a imagem processada 

figure
imshow(K);
title('Imagem com ruido gaussiano removido pelo filtro de Wiener - Ruido = 0');

%Aplica o filtro de Wiener 
L = wiener2(J,[5 5], 0.005);

%Apresenta a imagem processada 
figure
subplot(2,2,1);
imshow(L);
title('Imagem com ruido gaussiano removido pelo filtro de Wiener - Ruido = 0.005');

%Aplica o filtro de Wiener 
L = wiener2(J,[5 5], 0.015);

%Apresenta a imagem processada 
subplot(2,2,2);
imshow(L);
title('Imagem com ruido gaussiano removido pelo filtro de Wiener - Ruido = 0.015');

%Aplica o filtro de Wiener 
L = wiener2(J,[5 5], 0.025);

%Apresenta a imagem processada 
subplot(2,2,3);
imshow(L);
title('Imagem com ruido gaussiano removido pelo filtro de Wiener - Ruido = 0.025');

%Aplica o filtro de Wiener 
L = wiener2(J,[5 5], 0.095);

%Apresenta a imagem processada 
subplot(2,2,4);
imshow(L);
title('Imagem com ruido gaussiano removido pelo filtro de Wiener - Ruido = 0.095');

