function I_interp = interp_bilinear(I, scale_factor)
    % Converte a imagem para o tipo double
    %I = im2double(I);
    
    % Obtém as dimensões da imagem
    [rows,cols,num_channels] = size(I);
    
    % Calcula as novas dimensões da imagem interpolada
    rows_interp = round(rows*scale_factor);
    cols_interp = round(cols*scale_factor);
    
    % Inicializa a imagem interpolada
    I_interp = zeros(rows_interp, cols_interp, num_channels);
    
    % Loop pelos pixels da imagem interpolada
    for i = 1:rows_interp
        for j = 1:cols_interp
            % Calcula as coordenadas do pixel na imagem original
            x = j/scale_factor + 0.5;
            y = i/scale_factor + 0.5;

            % Obtém os índices dos pixels vizinhos mais próximos
            x1 = floor(x);
            y1 = floor(y);
            x2 = x1 + 1;
            y2 = y1 + 1;

            % Verifica se os pixels vizinhos estão dentro da imagem
            if x1 >= 1 && x2 <= cols && y1 >= 1 && y2 <= rows
                % Calcula as distâncias entre os pontos e os pixels vizinhos
                dx = x - x1;
                dy = y - y1;

                % Interpola o valor do pixel usando os pixels vizinhos
                I_interp(i,j,:) = (1 - dx) * (1 - dy) * I(y1,x1,:) + ...
                                  dx * (1 - dy) * I(y1,x2,:) + ...
                                  (1 - dx) * dy * I(y2,x1,:) + ...
                                  dx * dy * I(y2,x2,:);
            end
        end
    end
    figure, imshow(I)
title('Imagem Original')
figure, imshow(uint8(I_interp))
title('Imagem Interpolada de Ordem Um')
end
