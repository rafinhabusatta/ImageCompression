function I_interp = interp_zero(I, scale_factor)
% I - imagem de entrada
% scale_factor - fator de escala

% obter as dimensões da imagem de entrada
[height, width, num_channels] = size(I);

% calcular as dimensões da imagem interpolada
new_height = round(height * scale_factor); % linhas
new_width = round(width * scale_factor); % colunas

% inicializar a imagem interpolada
I_interp = zeros(new_height, new_width, num_channels);

% percorrer cada pixel na imagem interpolada (i,j)
for i = 0:new_height-1
    for j = 0:new_width-1
        % encontrar as coordenadas do pixel mais próximo na imagem original
        i_orig = floor(i / scale_factor); % posição x
        j_orig = floor(j / scale_factor); % posição 
        
        % atribuir o valor do pixel mais próximo na imagem original
        I_interp(i+1, j+1, :) = I(i_orig+1, j_orig+1, :);
    end
end
figure, imshow(I)
title('Imagem Original')
figure, imshow(uint8(I_interp))
title('Imagem Interpolada de Ordem Zero')
end