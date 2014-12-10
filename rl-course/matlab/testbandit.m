function [r, o, Q, k] = testbandit(tEps, tasks, plays)
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
    qStarMeans = mvnrnd( zeros(tasks,plays), eye(plays) );
    % Initialize record keeping
    rewards = zeros(1, plays);
    optactions = zeros(1, plays);
    
    % epsilon greedy probability array initialization    
    pa = tEps/(N); % sampling probability of each action
   
%% Self-made code
    for ii=1:tasks
        % Get a random bandit and its associated optimal action
        [bandit, opt] = getbandit(N);
        
        % Initialize action counter
        k = zeros(1, N);
        
        % Initialize Q table
        Q  = zeros(plays, N);
        QS = zeros(1,N); % sum variable     
        
        for pp=1:plays                        
            % get (current) maximum action
            if pp == 1
                astar = opt;
            else            
                [maxR, astar] = max(Q(pp-1,:));
            end
            
            % Epsilon-greedy action selection
            p = pa*ones(N,1); % reset probability
            p(astar) = p(astar)+ 1-tEps;
            
            % sample action
            a = sample(p);
%             

            % Run the bandit
%             r = bandit(a);
            r = qStarMeans(ii,a) + randn(1);
            
            % Update action counter
            k(a) = k(a) + 1;  
            
            % Update Q table            
            QS(a) = QS(a)+r;
            
            % find indices in which the action has never been taken
            ind = find(k==0);                        
            Q(pp,ind) = 0; % set its value to zero

            % find the non-zero value's indices
            ind2 = find(k~=0);
            Q(pp,ind2) = QS(ind2)./k(ind2); % update value table                      
            
            % Update record keeping
            rewards(pp) = rewards(pp) + r;
            if a == opt
                optactions(pp) = optactions(pp) + 1;
            end           
        end
%         rewards = rewards+R;
    end


%% From the Book
%   nB = tasks; nP = plays; nA = N;
%   %qT = qT0;  % <- initialize to one draw per arm 
%   qT = zeros(tasks,N);  % <- initialize to zero draws per arm (no knowledge)
%   qN = ones( tasks,N ); % keep track of the number draws on this arm 
%   qS = qT;             % keep track of the SUM of the rewards (qT = qS./qN) 
%   Q = 0; k = 0;
%   allRewards      = zeros(nB,nP); sigma = 1.0; randn('seed',0); 
%   pickedMaxAction = zeros(nB,nP); 
%   qStarMeans = mvnrnd( zeros(nB,nA), eye(nA) ); 
%   for bi=1:nB, % pick a bandit
%     for pi=1:nP, % make a play
%       % determine if this move is exploritory or greedy: 
%       if( rand(1) <= tEps ) % pick a RANDOM arm: 
%         [dum,arm] = histc(rand(1),linspace(0,1+tEps,nA+1)); clear dum; 
%       else                  % pick the GREEDY arm:
%         [dum,arm] = max( qT(bi,:) ); clear dum; 
%       end
%       % determine if the arm selected is the best possible: 
%       [dum,bestArm] = max( qStarMeans(bi,:) ); 
%       if( arm==bestArm ) pickedMaxAction(bi,pi) = 1; end
%       % get the reward from drawing on that arm: 
%       reward = qStarMeans(bi,arm) + sigma*randn(1); 
%       allRewards(bi,pi) = reward; 
%       % update qN,qS,qT: 
%       qN(bi,arm) = qN(bi,arm)+1;
%       qS(bi,arm) = qS(bi,arm)+reward; 
%       qT(bi,arm) = qS(bi,arm)/qN(bi,arm); 
%     end
%   end

%% Calculate average
    % Averaging
    r   = rewards/tasks;
%     r = allRewards/tasks;
    o = optactions/tasks;
end
