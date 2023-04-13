% leitura da imagem colorida peppers.png
img = imread('football.jpg');
figure;
imshow(img);
title('Imagem de entrada');

% Separação dos canais rgb
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

K = 256;
L = 4;

%quantização para cada canal rgb
[kmeansR, snrR, psnrR] = quantizacaoVetorialKmeans(L,K,r);
[kmeansG, snrG, psnrG] = quantizacaoVetorialKmeans(L,K,g);
[kmeansB, snrB, psnrB] = quantizacaoVetorialKmeans(L,K,b);

imgQuantizada = cat(3,kmeansR,kmeansG,kmeansB);

figure;
imshow(imgQuantizada);
title('Imagem quantizada');

SNR = (snrR + snrG + snrB)/3;
PSNR = (psnrR + psnrG + psnrB)/3;

fprintf('SNR = %.2f (dB)\n', SNR);
disp('');
fprintf('PSNR = %.2f (dB)\n',PSNR);
disp('');

fprintf('tamanho da memoria da imagem de entrada = %d bytes\n', numel(img));
disp('');
fprintf('tamanho da memoria da imagem de saida = %d bytes\n',K*L+numel(imgQuantizada)/L);
disp('');