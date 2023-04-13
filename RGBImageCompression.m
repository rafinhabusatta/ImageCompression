function [imgQuantizada] = RGBImageCompression(image,L,K)
    img = imread(image);
    
    % Separação dos canais rgb para cada imagem colorida
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    
    %Quantização de cada canal separadamente
    [kmeansR, snrR, psnrR] = quantizacaoVetorialKmeans(L,K,r);
    [kmeansG, snrG, psnrG] = quantizacaoVetorialKmeans(L,K,g);
    [kmeansB, snrB, psnrB] = quantizacaoVetorialKmeans(L,K,b);
    
    %Reconstrução das imagens coloridas com os canais já quantizados
    imgQuantizada = cat(3,kmeansR,kmeansG,kmeansB);
    
    %Cálculo do SNR e PSNR
    SNR = (snrR + snrG + snrB)/3;
    PSNR = (psnrR + psnrG + psnrB)/3;
    
    figure;
    imshow(img);
    title('Imagem de entrada ');
    
    figure;
    imshow(imgQuantizada);
    title('Imagem quantizada');

    fprintf('SNR = %.2f (dB)\n', SNR);
    disp('');
    fprintf('PSNR = %.2f (dB)\n',PSNR);
    disp('');

    fprintf('tamanho da memoria da imagem de entrada = %d bytes\n', numel(img));
    disp('');
    fprintf('tamanho da memoria da imagem de saida = %d bytes\n',K*L+numel(imgQuantizada)/L);
    disp('');
end

