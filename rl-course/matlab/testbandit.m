function [r, o] = testbandit(eps)
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
    tasks = 1;
    plays = 500;

    % Initialize record keeping
    rewards = zeros(1, plays);
    optactions = zeros(1, plays);

    for ii=1:tasks
        % Get a random bandit and its associated optimal action
        [bandit, opt] = getbandit(N);

        % Initialize action counter
        k = zeros(1, N);

        % Initialize Q table
        Q = zeros(1, N);
        a = opt;
        
        for pp=1:plays
            % TODO: Epsilon-greedy action selection
            temp = rand;
            if temp <= eps
                a = randperm(N,1)
            else
                a = opt
            end
            % Run the bandit
            r = bandit(a);
            
            % TODO: Update Q table

            % Update record keeping
            rewards(pp) = rewards(pp) + r;
            if a == opt
                optactions(pp) = optactions(pp) + 1;
            end
            
            % Update action counter
            k(a) = k(a) + 1;
        end
    end

    % Averaging
    r = rewards/tasks;
    o = optactions/tasks;
end
