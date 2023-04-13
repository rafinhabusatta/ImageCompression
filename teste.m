switch_expression = 0;
K = 256;
% leitura de imagem em tons de cinza
function [imgQuantizada] = oneChannelImageCompression(image,L)
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

% leitura de imagem colorida
function [imgQuantizada] = RGBImageCompression(image,L)
    img = imread(image);
    
    % Separa��o dos canais rgb para cada imagem colorida
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    
    %Quantiza��o de cada canal separadamente
    [kmeansR, snrR, psnrR] = quantizacaoVetorialKmeans(L,K,r);
    [kmeansG, snrG, psnrG] = quantizacaoVetorialKmeans(L,K,g);
    [kmeansB, snrB, psnrB] = quantizacaoVetorialKmeans(L,K,b);
    
    %Reconstru��o das imagens coloridas com os canais j� quantizados
    imgQuantizada = cat(3,kmeansR,kmeansG,kmeansB);
    
    %C�lculo do SNR e PSNR
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

while (switch_expression ~= -1)
    fprintf('1. Compress�o de imagem em tons de cinza');
    fprintf('2. Compress�o de imagem colorida');
    fprintf('Digite qualquer valor para sair do programa');
    switch switch_expression
       case 1
          image = input('Digite o nome da imagem com extens�o: ', 's');
          oneChannelImageCompression(image,L);
       case 2
          image = input('Digite o nome da imagem com extens�o: ', 's');
          RGBImageCompression(image,L)
        ...
        otherwise
          disp('Saindo do programa...');
          return;
    end
end