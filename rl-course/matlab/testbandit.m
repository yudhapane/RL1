function [r, o] = testbandit(eps, tasks, plays)
%TESTBANDIT Test evaluative feedback performance on n-armed bandit problem
%   R = testbandit(N, EPS) returns the average performance
%   of evaluative feedback learning on the N-armed bandit with exploration
%   rate EPS and incremental sample averaging.
%   [R, O] = TESTBANDIT(...) additionally returns the average number of
%   optimal actions chosen.
%
%   The averages are calculated over 2000 trials.

    % Set conditions
    N = 10;

    % Initialize record keeping
    rewards = zeros(1, plays);
    optactions = zeros(1, plays);
    
    % epsilon greedy probability array initialization    
    pa = eps/(N); % sampling probability of each action
    
    for ii=1:tasks
        % Get a random bandit and its associated optimal action
        [bandit, opt] = getbandit(N);
        astar = opt;
        % Initialize action counter
        k = zeros(1, N);

        % Initialize Q table
        Q = zeros(1, N);
        
        R = zeros(1,plays);
        for pp=2:plays
            
            % Epsilon-greedy action selection           
            p = pa*ones(N,1); % reset probability
            p(astar) = p(astar)+ 1-eps;
            
            a = sample(p);
            
            % Run the bandit
            r = bandit(a);
            
            % Incremental sample averaging
            R(pp) = R(pp-1) + 1/(pp)*(r-R(pp-1));
            
            % Update action counter
            k(a) = k(a) + 1;
            
            % TODO: Update Q table
            if(k(a) == 0)
                Q(a) = 0;
            else                 
                Q(a) = (r + Q(a))/k(a);
            end
                
            [maxR, astar] = max(Q);
            
            % Update record keeping
%             rewards(pp) = rewards(pp) + r;
            if a == opt
                optactions(pp) = optactions(pp) + 1;
            end
            

        end
        rewards = rewards+R;
    end

    % Averaging
    r = rewards/tasks;
    o = optactions/tasks;
end
