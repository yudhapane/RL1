%EPS_GREEDY calls testbandit.m for various epsilon values and compares
%the cumulative reward
close all; clear;
plays = 1000;
tasks = 100;

eps = [0 0.01 0.1];
colors =[0, 0, 1;
         1, 0, 0;
         0, 0, 0];
figure;
for i = 1:length(eps)
    [r,o,Q,k] = testbandit(eps(i), tasks, plays);
    subplot(2,1,1);
    plot(r, 'Color', colors(i,:));  hold on;
    subplot(2,1,2);
    plot(o, 'Color', colors(i,:));  hold on;
end
Q
k
subplot(2,1,1);axis([0 plays -0.3 2]);
legend(['eps=', num2str(eps(1))],['eps=', num2str(eps(2))],['eps=', ...
    num2str(eps(3))]);

subplot(2,1,2);axis([0 plays 0 1.2]);
legend(['eps=', num2str(eps(1))],['eps=', num2str(eps(2))],['eps=', ...
    num2str(eps(3))]);