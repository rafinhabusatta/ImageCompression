switch_expression = 0;
K = 256;

while (switch_expression ~= -1)
    fprintf('1. Compressão de imagem em tons de cinza\n');
    fprintf('2. Compressão de imagem colorida\n');
    fprintf('Digite qualquer valor para sair do programa\n');
    switch_expression = input('Digite a opção: ');
    switch switch_expression
       case 1
          image = input('Digite o nome da imagem com extensão: ', 's');
          L = input('Digite o tamanho do bloco (L): ');
          oneChannelImageCompression(image,L,K);
       case 2
          image = input('Digite o nome da imagem com extensão: ', 's');
          L = input('Digite o tamanho do bloco (L): ');
          RGBImageCompression(image,L,K)
        ...
        otherwise
          disp('Saindo do programa...');
          return;
    end
end