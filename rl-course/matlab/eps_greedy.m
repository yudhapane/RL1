%EPS_GREEDY calls testbandit.m for various epsilon values and compares
%the cumulative reward

close all; clear;
eps = [0.1 0.3 0.6 0.9];
colors =[0.1, 0.2, 0.1];

figure;
for i = 1:length(eps)
    [r,o] = testbandit(eps(i));
    cumReward = cumsum(r);
    subplot(4,1,i); 
    plot(cumReward, 'Color', i*colors); legend(['eps=', num2str(eps(i))]); 
    axis([0 500 0 1000]);
end
