%% algoritmo do agrupamento por kmeans
function[codebook,ClusterNum]=kmeans_algoritmo(s,L,K)
% 's' � a celula com os vetores de entrada
% -------------------------------------------------------
%inicializa o K vetores (celulas) do dicionario com amostras aleatorias
codebook=cell(1,K);
indx=randsample(length(s),K);
for i=1:K
    codebook{i}=s{indx(i)};
end
% -------------------------------------------------------
% atribui o numero do cluster aos vetores de entrada
% inicializa os valores de distorcao:
    % 1�. elemento � o antigo e o 2�. elemento � o atual
vec_dist = cell(1,length(s));
ClusterNum=zeros(1,length(s));
Distortion=[0 0];
iter=0;
while(iter<=2 || (Distortion(1)-Distortion(2))/Distortion(2) > 0.9)
    iter = iter+1;
    Distortion(1) = Distortion(2);
    Distortion(2) = 0;
    for i=1:length(s)
        % VEC_DIST � uym array de celulas e cada celula � um vetor
        % cada celula � um array de distancias dos vetores de entrada
        % aos K vetores do dicionario
        vec_dist{i}=dist(s{i},reshape(cell2mat(codebook),L,length(codebook)));
        ClusterNum(i) = find(vec_dist{i}==min(vec_dist{i}),1);
        Distortion(2)=Distortion(2)+min(vec_dist{i});
    end
    Distortion(2)=Distortion(2)/length(s);
    % atualiza o discionario substituindo cada vetor pela media do
    % conjunto de vetores de entrada correspondente
    for i=1:K
        temp = reshape(cell2mat(s),L,length(s));
        codebook{i} = mean(temp(:,ClusterNum==i),2)';
    end
end  