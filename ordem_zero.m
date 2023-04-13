function ordem_zero()
fator = 3/7;

imagem = imread('peppers.png');

[lin, col, num_channels] = size(imagem);

saida_lin = round(lin * fator); % linhas
saida_col = round(col * fator); % colunas

%saida_lin = fator*(size(imagem,1));
%saida_col = fator*(size(imagem,2));
%num_channels = 3;

img_saida = uint8(zeros(saida_lin, saida_col, num_channels));

for i = 0:saida_lin-1
    for j = 0:saida_col-1
        x = floor(i/fator);
        y = floor(j/fator);
        for k = 1:num_channels
            img_saida(i+1, j+1, k) = imagem(x+1, y+1, k);
        end
    end
end
figure,imshow(imagem)
title('original');
figure, imshow(img_saida)
title('ordem zero');