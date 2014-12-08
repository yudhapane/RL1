%EPS_GREEDY calls testbandit.m for various epsilon values and compares
%the cumulative reward
close all; clear;
plays = 500;
tasks = 100;

eps = [0.1 0.01 0 1];
colors =[0, 0, 0;
         1, 0, 0;
         0, 1, 0;
         0, 0, 1];
figure;
for i = 1:length(eps)
    [r,o] = testbandit(eps(i), tasks, plays);
%     cumReward = cumsum(r)./[1:1:500];
%     subplot(6,1,i); 
    subplot(2,1,1);
    plot(r, 'Color', colors(i,:));  hold on;
    subplot(2,1,2);
    plot(o, 'Color', colors(i,:));  hold on;
end
subplot(2,1,1);axis([0 plays -3 3]);
legend(['eps=', num2str(eps(1))],['eps=', num2str(eps(2))],['eps=', ...
    num2str(eps(3))],['eps=', num2str(eps(4))]);

subplot(2,1,2);axis([0 plays 0 1]);
legend(['eps=', num2str(eps(1))],['eps=', num2str(eps(2))],['eps=', ...
    num2str(eps(3))],['eps=', num2str(eps(4))]);