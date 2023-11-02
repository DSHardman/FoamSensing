
clear all;
clc;


t_loc = 'data_new/';
train_x = [];
train_y = [];

%% Thinner
original_files=dir([t_loc, '/*.txt']);
loc_points = [];
for k=1:length(original_files)
    filename=[t_loc '/' original_files(k).name];
    f_data = load(filename);
    loc_points = [loc_points; f_data(1, end-1:end)];
    trn_x = f_data(:, 1:end-8);
    trn_x = mean(trn_x);%reshape(trn_x, 1, size(trn_x, 1)*size(trn_x, 2));
    trn_y = f_data(1, end-1:end);
    train_x = [train_x; trn_x];
    trn_y = f_data(1, end-1:end);
    [theta,rho] = cart2pol(trn_y(:, 1), trn_y(:, 2));
    train_y = [train_y; theta];
end

% loc_rads = loc_points(:, 1).*loc_points(:, 1) + loc_points(:, 2).*loc_points(:, 2);
% [~, min_idx] = min(loc_rads);
% 
% train_x = train_x-train_x(min_idx, :);


loc_rads = loc_points(:, 1).*loc_points(:, 1) + loc_points(:, 2).*loc_points(:, 2);
[~, sort_idx] = sort(loc_rads);
train_x(sort_idx(1:1500), :) = [];
train_y(sort_idx(1:1500), :) = [];

[net, XTrain, YTrain, XVal, YVal, XTest, YTest] = sensorTrain(train_x, train_y, [50], [0.8 0.1 0.1], 1);
Ypredictions = predict(net, XTest);
scatter(Ypredictions(:, 1), Ypredictions(:, 2));
hold on;
scatter(YTest(:, 1), YTest(:, 2));
