%Experimento 2
%Exercicio 2

%PARTE 1 
%TRATAMENTO DE IMAGEM BORRADA E COM RUIDO ADICIONADO
%USANDO FILTRO DE WIENER (DECONVOLUCAO DE WIENER)

%Abertura da Imagem
I = im2double(imread('Lenna.bmp'));
imshow(I);
title('Imagem Original');

%Simular uma distorcao de movimento
%Simula uma imagem borrada que pode ser obtida pelo movimento da camera. Inicialmente, cria uma função de propagação de ponto, (point-spread function) PSF, correspondente ao movimento linear em 21 pixels (LEN = 21), em um ângulo de 11 graus (THETA = 11). Para simular o desfoque, convolui o filtro com a imagem usando a funcao imfilter.


LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'conv', 'circular');
figure;
imshow(blurred);
title('Imagem Borrada');

%Restaurar a imagem borrada
%A sintaxe mais simples para a funcao deconvwnr e deconvwnr(A, PSF, NSR), onde A é a imagem borrada, PSF é a função de propagação de ponto, e NSR é a relação entre a potência do ruído e a potência do sinal. A imagem distorcida anterior não possui ruido, entao usa-se 0 para o NSR.

wnr1 = deconvwnr(blurred, PSF, 0);
figure;
imshow(wnr1);
title('Imagem Restaurada');

%Simular desfoque e ruido
%Agora aplica-se ruido gaussiano com media 0 e variancia 0,0001 a imagem borrada

noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
figure;
imshow(blurred_noisy);
title('Imagem Borrada com Ruido');

%Primeira tentativa de restauracao da imagem borrada e com ruido.
%Na primeira tentativa de restauracao, utiliza-se a funcao deconvwnr sem informacao de ruido (NSR = 0). Quando NSR = 0, o filtro de Wiener e equivalente a um filtro inverso ideal. O filtro inverso ideal pode ser extremamente sensi�vel ao rui�do no sinal de entrada, o que pode ser visto na imagem resultante.

wnr2 = deconvwnr(blurred_noisy, PSF, 0);
figure;
imshow(wnr2);
title('Restauracao da imagem borrada e com ruido - NSR = 0');

%O ruido foi amplificado pelo filtro inverso de tal forma que apenas poucas informacoes da imagem ainda sao visiveis.

%Segunda tentativa de restauracao da imagem borrada e com ruido.
%Na segunda tentativa, fornecemos uma estimativa da relacao de potencias entre o ruido e o sinal (NSR).

signal_var = var(I(:));
wnr3 = deconvwnr(blurred_noisy, PSF, noise_var / signal_var);
figure;
imshow(wnr3);
title('Restauracao da imagem borrada e com ruido - NSR Estimado');

%PARTE 2
%TRATAMENTO DE IMAGEM BORRADA E COM RUIDO DE QUANTIZACAO

%Simular desfoque e ruido de quantizacao de 8 bits
%Quando utiliza-se o filtro de Wiener, mesmo uma quantidade de ruído visualmente imperceptível pode afetar o resultado. Assim, mantendo a imagem de entrada na representação em 8 bits (uint8) em vez de convertê-la para double.

I = imread('Lenna.bmp');
class(I)
%resposta esperada -> ans = 'uint8'

%Se convoluir uma imagem uint8 usando a funcao imfilter, ela ira quantizar a saida para retornar outra imagem uint8.

blurred_quantized = imfilter(I, PSF, 'conv', 'circular');
class(blurred_quantized)
%resposta esperada -> ans = 'uint8'


%Primeira tentativa de restauracao da imagem borrada e quantizada em 8 bits.
%Inicialmente, aplicar a funcao deconvwnr sem informacao de ruido.

wnr4 = deconvwnr(blurred_quantized, PSF, 0);
figure;
imshow(wnr4)
title('Restauracao da imagem borrada e quantizada - NSR = 0');

%Segunda tentativa de restauracao da imagem borrada e quantizada em 8 bits.
%Agora, fornecemos uma estimativa de NSR para a funcao deconvwnr, baseada na variancia da quantizacao e na variancia do sinal (imagem).

uniform_quantization_var = (1/256)^2 / 12;
signal_var = var(im2double(I(:)));
wnr5 = deconvwnr(blurred_quantized, PSF, uniform_quantization_var / signal_var);
figure;
imshow(wnr5);
title('Restauracao da imagem borrada e quantizada - NSR Estimado');