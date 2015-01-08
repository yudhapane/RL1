%EPS_GREEDY calls testbandit.m for various epsilon values and compares
%the cumulative reward
clear; clc; close all;
plays = 1000;
tasks = 500;

tEps = [0 0.01 0.1];
colors =[0, 0, 1;
         1, 0, 0;
         0, 0, 0];
clf;
for i = 1:length(tEps)
    [r,o,Q,k] = testbandit(tEps(i), tasks, plays);
    subplot(2,1,1);
    plot(r, 'Color', colors(i,:));  hold on;
    subplot(2,1,2);
    plot(o, 'Color', colors(i,:));  hold on;
end

subplot(2,1,1);axis([0 plays -0.3 2]);
legend(['tEps=', num2str(tEps(1))],['tEps=', num2str(tEps(2))],['tEps=', ...
    num2str(tEps(3))]);

subplot(2,1,2);axis([0 plays 0 1.2]);
legend(['tEps=', num2str(tEps(1))],['tEps=', num2str(tEps(2))],['tEps=', ...
    num2str(tEps(3))]);
