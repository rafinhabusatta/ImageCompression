% exercício de segmentação de imagens coloridas com k-mean
% http://www.mathworks.com/help/images/examples/color-based-segmentation-using-k-means-clustering.html?prodcode=IP&language=en

% le imagem de patologia
he = imread('hestain.png');
figure,imshow(he),title('imagem de patologia');
text(size(he,2),size(he,1)+15,...
    'courtesia de Alan Partin, Johns Hopkins University',...
    'FontSize',7,'HorizontalAlignment','right');

% converte a imagem do RGB para o L*a*b*
cform = makecform('srgb2lab');
lab_he = applycform(he,cform);

% agrupa as cores em 'a*b*' usando k-means
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repete o processo de agrupamento 3 vezes para evitar minimos locais
[cluster_idx,cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean',...
    'Replicates',3);

% rotula cada pixel da imagem com os resultados do k-means
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure,imshow(pixel_labels,[]);
title('imagem rotulada pelo indice do agrupamento');

% cria uma imagem para cada cor da imagem de entrada
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

figure_imshow(segmented_images{1}), title('objetos no agrupamento 1');
figure_imshow(segmented_images{2}), title('objetos no agrupamento 2');
figure_imshow(segmented_images{3}), title('objetos no agrupamento 3');

% segmenta os nucleos das celulas em uma imagem separada

mean_cluster_value = mean(cluster_center,2);
[tmp,idx] = sort(mean_cluster_value);
blue_cluster_num = idx(1);

L = lab_he(:,:,1);
blue_idx = find(pixel_labels == blue_cluster_num);
L_blue = L(blue_idx);
is_light_blue = im2bw(L_blue,graythresh(L_blue));

nuclei_labels = repmat(uint8(0),[nrows,ncols]);
nuclei_labels(blue_idx(is_light_blue==false)) = 1;
nuclei_labels = repmat(nuclei_labels,[1 1 3]);
blue_nuclei = he;
blue_nuclei(nuclei_labels ~= 1) = 0;
figure,imshow(blue_nuclei),title('nucleos azuis');