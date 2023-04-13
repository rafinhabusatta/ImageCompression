function [I_req, SNR, PSNR] = quantizacaoVetorialKmeans(L,K,Img)
%% usando kmeans para achar o dicioario na
%% compressão por quantização vetorial
% entrada:-> imagem em tons de cinza
% -------------------------------------------------------
%clc;
%clear all;
%close all;
tic;
% -------------------------------------------------------
% parametros de entrada L,K
%L = 16; % tamanho do bloco,
% bloco deve ser quadrado 4 = 2x2, 16=4x4. 64=8x8 (sugerido L=4)
%K = 128; % tamanho do dicionário (sugerido K = 16)
% -------------------------------------------------------

Img2D_rows = size(Img,1);
Img2D_cols = size(Img,2);
% -------------------------------------------------------
%% computa o kmeans para achar o dicionario
r1 = floor(rem(Img2D_rows,sqrt(L))); % resto da divisao das linhas pelo tamanho do bloco
r2 = floor(rem(Img2D_cols,sqrt(L))); % resto da divisao das colunas pelo tamanho do bloco
Img1 = zeros(Img2D_rows+r1,Img2D_cols+r2); % imagem com tamanho adequado para reconstruir
% -------------------------------------------------------
% monta a imagem
Img1(1:Img2D_rows,1:Img2D_cols) = Img;
if r1~=0
    Pad_rows = Img(end,:);
    for j = 1:r1
        Pad_rows(j,:) = Pad_rows(1,:); % 1 linha a mais
    end
    Img1(Img2D_rows+1:end,1:Img2D_cols) = Pad_rows;
end
if r2~=0
    Pad_cols = Img1(:,Img2D_cols);
    for j = 1:r2
        Pad_cols(:,j) = Pad_cols(:,1); % 1 coluna a mais
    end
    Img1(1:end,Img2D_cols+1:end) = Pad_cols;
end
if r1~=0 && r2~=0
    Pad_rows = Img1(end,:);
    for j = 1:r1
        Pad_rows(j,:) = Pad_rows(1,:); % 1 linha a mais
    end
    Img1(Img2D_rows+1:end,:) = Pad_rows;
    Pad_cols = Img1(:,end);
    for j = 1:r2
        Pad_cols(:,j) = Pad_cols(:,1); % 1 coluna a mais
    end
    Img1(:,Img2D_cols+1:end) = Pad_cols;
end
% -------------------------------------------------------
% prepara os dados e chama o algoritmo do kmeans
% e salva imagem requantizada na variável de retorno
I_re = Kmeans_Pre_Post(Img1,L,K);

I_re = uint8(I_re);
I_req = I_re;

% -------------------------------------------------------
% calcula o SNR e o PSNR
SNR = 10*log10(std2(double(Img))^2/std2(double(Img)-double(I_re))^2);

I_max = max(max(double(Img)));
I_min = min(min(double(Img)));
A = (I_max-I_min);
PSNR = 10*log10((A^2)/(std2(double(Img)-double(I_re))^2));

% -------------------------------------------------------
toc,

end

