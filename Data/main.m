
clear all;
clc;


t_loc = 'data2/';
%% Thinner
original_files=dir([t_loc, '/*.txt']);
loc_points = [];
for k=1:length(original_files)
    filename=[t_loc '/' original_files(k).name];
    f_data = load(filename);
    loc_points = [loc_points; f_data(1, end-1:end)];
end


scatter(loc_points(:, 1), loc_points(:, 2));
% plot(f_data(:, 1:end-8)');

figure(2);
filename=[t_loc '/' original_files(6).name];
f_data = load(filename);
plot(mean(f_data(:, 1:end-8))');
hold on;


filename=[t_loc '/' original_files(67).name];
f_data = load(filename);
plot(mean(f_data(:, 1:end-8))');


filename=[t_loc '/' original_files(27).name];
f_data = load(filename);
plot(mean(f_data(:, 1:end-8))');

filename=[t_loc '/' original_files(45).name];
f_data = load(filename);
plot(mean(f_data(:, 1:end-8))');

