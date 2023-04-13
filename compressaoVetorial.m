% leitura da imagem em tons de cinza concordorthophoto.png
img1 = imread('concordorthophoto.png');
%figure;
%imshow(img1);
%title('Imagem de entrada concordorthophoto');

% leitura da imagem em tons de cinza liftingbody.png
img2 = imread('liftingbody.png');
%figure;
%imshow(img2);
%title('Imagem de entrada liftingbody');

% leitura da imagem colorida nature.jpg
img3 = imread('nature.jpg');
%figure;
%imshow(img3);
%title('Imagem de entrada nature');

% leitura da imagem colorida canions.jpg
img4 = imread('canions.jpg');
%figure;
%imshow(img4);
%title('Imagem de entrada canions');

% Separação dos canais rgb para cada imagem colorida
%r3 = img3(:,:,1);
%g3 = img3(:,:,2);
%b3 = img3(:,:,3);

%r4 = img4(:,:,1);
%g4 = img4(:,:,2);
%b4 = img4(:,:,3);

K = 256;
L = 16;

%quantização para as imagens coloridas
[kmeansIm1, snrIm1, psnrIm1] = quantizacaoVetorialKmeans(L,K,img1);
%[kmeansIm2, snrIm2, psnrIm2] = quantizacaoVetorialKmeans(L,K,img2);

%quantização para cada canal rgb
%[kmeansR3, snrR3, psnrR3] = quantizacaoVetorialKmeans(L,K,r3);
%[kmeansG3, snrG3, psnrG3] = quantizacaoVetorialKmeans(L,K,g3);
%[kmeansB3, snrB3, psnrB3] = quantizacaoVetorialKmeans(L,K,b3);

%[kmeansR4, snrR4, psnrR4] = quantizacaoVetorialKmeans(L,K,r4);
%[kmeansG4, snrG4, psnrG4] = quantizacaoVetorialKmeans(L,K,g4);
%[kmeansB4, snrB4, psnrB4] = quantizacaoVetorialKmeans(L,K,b4);

%Reconstrução das imagens coloridas com os canais já quantizados
%img3Quantizada = cat(3,kmeansR3,kmeansG3,kmeansB3);
%img4Quantizada = cat(3,kmeansR4,kmeansG4,kmeansB4);
imgQuantizada = cat(3,kmeansIm1,kmeansIm1,kmeansIm1);
figure;
imshow(imgQuantizada);
title('Imagem quantizada');

SNR = (snrIm1 + snrIm1 + snrIm1)/3;
PSNR = (psnrIm1 + psnrIm1 + psnrIm1)/3;

fprintf('SNR = %.2f (dB)\n', SNR);
disp('');
fprintf('PSNR = %.2f (dB)\n',PSNR);
disp('');

fprintf('tamanho da memoria da imagem de entrada = %d bytes\n', numel(img));
disp('');
fprintf('tamanho da memoria da imagem de saida = %d bytes\n',K*L+numel(imgQuantizada)/L);
disp('');