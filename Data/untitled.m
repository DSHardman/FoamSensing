for i = 1:110
scatter(YTest(i,1), YTest(i,2), 20, 'r', 'filled')
hold on
scatter(Ypredictions(i,1), Ypredictions(i,2), 20, 'b', 'filled')
title(string(i));
ylim([-0.2 0.15]);
xlim([-0.2 0.15]);
pause();
clf
end