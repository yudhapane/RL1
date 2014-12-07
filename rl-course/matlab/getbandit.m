function [b, o] = getbandit(n)
%GETBANDIT Generate random n-armed bandit.
%   B = GETBANDIT(N) returns a random N-armed bandit function with
%   prototype R = BANDIT(A), where A is the number of the arm and
%   R is the reward.
%   [B, O] = GETBANDIT(N) additionally returns the optimal action.
%
%   AUTHOR:
%      Wouter Caarls <w.caarls@tudelft.nl>

    arms = randn(1, n);

    b = @bandit;
    [dummy, o] = max(arms);
    
    function r = bandit(a)
        if a < 1 || a > n
            error(['Arm must be between 1 and ' num2str(n)]);
        end
        
        r = arms(a) + randn(1);
    end
end
