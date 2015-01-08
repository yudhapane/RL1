function [averageRewards, o, QTable, actionCounter] = testbandit(tEps, tasks, plays)
%TESTBANDIT Test evaluative feedback performance on n-armed bandit problem
%   R = testbandit(N, EPS) returns the average performance
%   of evaluative feedback learning on the N-armed bandit with exploration
%   rate EPS and incremental sample averaging.
%   [R, O] = TESTBANDIT(...) additionally returns the average number of
%   optimal actions chosen.
%
%   The averages are calculated over 2000 trials.

    % Set conditions
    N = 10; % number of arms
    
    % epsilon greedy probability array initialization    
    explorationProbability = tEps/(N); % sampling probability of each action
    
%% Self-made code
    % Initialize matrices
    QTable  = zeros(tasks, N);          % Q table
    QSum = zeros(tasks,N);              % sum variable 
    actionCounter = zeros(tasks, N);    % action counter       
    sumRewards = zeros(1, plays);       % reward sum
    optactions = zeros(1, plays);
    
    for taskCounter=1:tasks
%         % Get a random bandit and its associated optimal action
        bandit = randn(1,N);                    % pull all levers
        [dum, opt] = max(bandit); clear dum;    % get the maximum lever
        
        for playCounter=1:plays                        
            % get (current) maximum action    
            [maxR, astar] = max(QTable(taskCounter,:)); clear maxR;

            % Epsilon-greedy action selection
            samplingProbability = explorationProbability*ones(N,1); % reset probability
            samplingProbability(astar) = samplingProbability(astar)+ 1-tEps;
            
            % sample action
            action = sample(samplingProbability);

            % Run the bandit
            immediateReward = bandit(action) + randn(1);
            
            % Update action counter
            actionCounter(taskCounter,action) = actionCounter(taskCounter,action) + 1;  
            
            % Update Q table            
            QSum(taskCounter,action) = QSum(taskCounter,action)+immediateReward;
            
            % find indices of which the action has never been taken
            ind = actionCounter(taskCounter,:)==0;                        
            QTable(taskCounter,ind) = 0; % set its value to zero

            % find the non-zero value's indices
            ind2 = find(actionCounter(taskCounter,:)~=0);
            QTable(taskCounter,ind2) = QSum(taskCounter,ind2)./actionCounter(taskCounter,ind2); % update value table                                  
            
            % Update reward sum
            sumRewards(playCounter) = sumRewards(playCounter) + immediateReward;
            
            if action == astar
                optactions(playCounter) = optactions(playCounter) + 1;
            end           
        end
    end
    
%% Calculate average
    % Averaging
    averageRewards   = sumRewards/tasks;
%     r = allRewards/tasks;
    o = optactions/tasks;
    
    
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
%   
%     avgRew          = mean(allRewards,1);
%     avgReward(ei,:) = avgRew(:).'; 
%     percentOptAction   = mean(pickedMaxAction,1);
%     perOptAction(ei,:) = percentOptAction(:).';


end
