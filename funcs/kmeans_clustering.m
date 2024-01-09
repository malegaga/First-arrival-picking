function [idx, C, sumd] = kmeans_clustering(X, K, max_iters)
% X: 数据矩阵，每行表示一个样本，每列表示一个特征
% K: 聚类个数
% max_iters: 最大迭代次数
% idx: 每个样本所属的簇编号
% C: 簇中心
% sumd: 每个簇内样本到簇中心的距离的平方和
% % 使用例子：
% load fisheriris;
% X = meas(:, 1:2);
% K = 4;
% max_iters = 100;
% [idx, C, sumd] = kmeans_clustering(X, K, max_iters);


% 数据预处理：归一化
X = normalize(X);

% 随机初始化簇中心
[m, n] = size(X);
C = X(randperm(m, K), :);

% 迭代
for iter = 1:max_iters
    % 簇分配
    idx = zeros(m, 1);
    for i = 1:m
        dist = sum((C - X(i, :)).^2, 2);
        [~, idx(i)] = min(dist);
    end
    
    % 簇中心更新
    for k = 1:K
        C(k, :) = mean(X(idx==k, :), 1);
    end
end

% 计算每个簇内样本到簇中心的距离的平方和
sumd = zeros(K, 1);
for k = 1:K
    sumd(k) = sum(sum((X(idx==k, :) - C(k, :)).^2));
end

% 绘图
plot_kmeans(X, idx, C);

end

function X_norm = normalize(X)
% 归一化
X_norm = (X - min(X)) ./ (max(X) - min(X));
end

function plot_kmeans(X, idx, C)
% 绘图
figure;
scatter(X(:,1), X(:,2), 20, idx, 'filled');
hold on;
scatter(C(:,1), C(:,2), 100, 'k', 'filled');
end

