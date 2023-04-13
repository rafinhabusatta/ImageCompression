function [imgQuantizada] = oneChannelImageCompression(image,L,K)
    img = imread(image);
    [imgQuantizada, SNR, PSNR] = quantizacaoVetorialKmeans(L,K,img);
    
    figure;
    imshow(img);
    title('Imagem de entrada ');
    
    figure;
    imshow(imgQuantizada);
    title('Imagem quantizada')
    
    fprintf('SNR = %.2f (dB)\n', SNR);
    disp('');
    fprintf('PSNR = %.2f (dB)\n',PSNR);
    disp('');

    fprintf('tamanho da memoria da imagem de entrada = %d bytes\n', numel(img));
    disp('');
    fprintf('tamanho da memoria da imagem de saida = %d bytes\n',K*L+numel(imgQuantizada)/L);
    disp('');
end