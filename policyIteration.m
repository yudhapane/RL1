clc; clear all; close all;
V = zeros(4,4);
gridSize = size(V);
policy = [1 1 2 3; 
          0 1 0 0;
          0 2 3 0;
          3 2 0 3];
N = 30;
M = 30;
initState = [1,1];
grid = gridworld(initState);
gamma = 0.3;
R = zeros(1,4);
for h = 1:M
%     V   
%     pause
    for i = 1:N    
        for j = 1:gridSize(1)
            for k = 1:gridSize(2)
                grid.state = [j,k];
                grid.move(policy(j,k));
                V(j,k) = rewardGrid(grid.state) + gamma*V(grid.state(1), grid.state(2));
                V(1,1) = 0; V(end,end) = 0;
            end
        end
    end
    
    for j = 1:gridSize(1)
        for k = 1:gridSize(2)
            for l = 0:3                
                grid.state = [j,k];
                grid.move(l);
                R(l+1) = rewardGrid(grid.state) + gamma*V(grid.state(1), grid.state(2));
            end  
            
%             grid.state = [j,k];
%             grid.move(policy(j,k));
            [dum, policy(j,k)] = max(R);% + gamma*V(grid.state(1), grid.state(2))*ones(1,4));
            policy(j,k) = policy(j,k) - 1;
            R = zeros(1,4);
        end
    end
end

policy
V
            
    