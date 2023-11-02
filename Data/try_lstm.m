clear all;
clc;


t_loc = 'data_new/';
train_x = {};
train_y = [];

numChannels = 96;
numResponses = 2;

%% Thinner
original_files=dir([t_loc, '/*.txt']);
loc_points = [];
for k=1:length(original_files)
    filename=[t_loc '/' original_files(k).name];
    f_data = load(filename);
    loc_points = [loc_points; f_data(1, end-1:end)];
    trn_x = f_data(:, 1:end-8)';
    trn_y = f_data(1, end-1:end);
    train_x = [train_x; trn_x];
    % [theta,rho] = cart2pol(trn_y(:, 1), trn_y(:, 2));
    train_y = [train_y; trn_y];
end

numObservations = numel(train_x);
[idxTrain,idxValidation,idxTest] = trainingPartitions(numObservations, [0.8 0.1 0.1]);

XTrain = train_x(idxTrain);
XValidation = train_x(idxValidation);
XTest = train_x(idxTest);

TTrain = train_y(idxTrain, :);
TValidation = train_y(idxValidation, :);
TTest = train_y(idxTest, :);

numHiddenUnits = 100;

layers = [ ...
    sequenceInputLayer(numChannels, Normalization="rescale-zero-one")
    lstmLayer(numHiddenUnits, OutputMode="last")
    dropoutLayer
    fullyConnectedLayer(numResponses)
    regressionLayer];

options = trainingOptions("adam", ...
    MaxEpochs=250, ...
    ValidationData={XValidation TValidation}, ...
    OutputNetwork="best-validation-loss", ...
    InitialLearnRate=0.005, ...
    SequenceLength="shortest", ...
    Plots="training-progress", ...
    Verbose= false);

net = trainNetwork(XTrain, TTrain, layers, options);
YTest = predict(net,XTest, SequenceLength="shortest");

scatter(YTest(:, 1), YTest(:, 2));
hold on;
scatter(TTest(:, 1), TTest(:, 2));



