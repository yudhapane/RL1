% Author: Yudha Pane 
% Created on : 11 Nov 2014 
% Description : Simple trash cleaning robot

% Initialisation
clear; clc;
bot = robot(4);
n = 7; % size of tile
V = zeros(1,n); % value function
u = zeros(1,n); % random action for all states
N = 100; % duration of learning
gamma = 0.5; % discount rate
Q = zeros(N,n,2); % Q-values, the 3rd index indicates u (move left/right)
x0 = 0; % initial state

for i = 2:N
    for j = 1:n
        for k = 1:2
            bot.x = j;
            u = k;
            bot.act(u);
            Q(i,j,k) = reward(bot)+gamma*max(Q(i,bot.x,1),Q(i,bot.x,2)); 
        end
    end
end

V = [Q(N,:,1); Q(N,:,2)];
[maxV,pi_star] = max(V)
    
    
    
    
        





