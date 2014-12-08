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
    pa = 1/N;
    p = pa*ones(N,1);
    for ii=1:tasks
        % Get a random bandit and its associated optimal action
        [bandit, opt] = getbandit(N);

        % Initialize action counter
        k = zeros(1, N);

        % Initialize Q table
        Q = zeros(1, N);
        Q(1) = 0;
        for pp=2:plays
            % TODO: Epsilon-greedy action selection
            temp = rand;
            if temp <= eps
                a = sample(p);
            else
                a = opt;
            end
            % Run the bandit
            r = bandit(a);
%             Q(pp+1) = Q(pp-1) + 1/(pp)*(r-Q(pp-1));
            
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
