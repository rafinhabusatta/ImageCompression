function I_interp = interp_bicubic(I, scale_factor)
% I - imagem de entrada
% scale_factor - fator de escala

% obter as dimensões da imagem de entrada
[height, width, num_channels] = size(I);

% calcular as dimensões da imagem interpolada
new_height = round(height * scale_factor); % linhas
new_width = round(width * scale_factor); % colunas

% inicializar a imagem interpolada
I_interp = zeros(new_height, new_width, num_channels);

% criar matriz de coeficientes B
B = [0, 1, 0, 0;...    
    -0.5, 0, 0.5, 0;...    
    1, -2.5, 2, -0.5;...    
    -0.5, 1.5, -1.5, 0.5];

% percorrer cada pixel na imagem interpolada (i,j)
for i = 1:new_height
    for j = 1:new_width
        % encontrar as coordenadas do pixel correspondente na imagem original
        x = (j-1) / scale_factor + 1;
        y = (i-1) / scale_factor + 1;
        
        % índices dos 4x4 pixels ao redor do pixel correspondente
        x0 = floor(x) - 1;
        y0 = floor(y) - 1;
        rows = y0 + (1:4);
        cols = x0 + (1:4);
        
        % verificar se os índices dos pixels estão dentro dos limites da imagem
        rows(rows < 1 | rows > height) = 1;
        cols(cols < 1 | cols > width) = 1;
        
        % extrair os 16 pixels do bloco 4x4
        block = I(rows, cols, :);
        
        % calcular as derivadas parciais
        dx = x - (x0+1);
        dy = y - (y0+1);
        hx = [1, dx, dx^2, dx^3];
        hy = [1; dy; dy^2; dy^3];
        
        % interpolar o pixel atual usando a função bicúbica
        if num_channels == 1 % imagem em tons de cinza
            H = hx * B * hy;
            I_interp(i,j) = sum(sum(H .* block));
        else % imagem colorida
            Hr = hx * B * hy;
            Hg = hx * B * hy;
            Hb = hx * B * hy;
            I_interp(i,j,1) = sum(sum(Hr .* block(:,:,1)));
            I_interp(i,j,2) = sum(sum(Hg .* block(:,:,2)));
            I_interp(i,j,3) = sum(sum(Hb .* block(:,:,3)));
        end
    end
end
    figure, imshow(I)
title('Imagem Original')
figure, imshow(uint8(I_interp))
title('Imagem Interpolada de Ordem Três')
end
