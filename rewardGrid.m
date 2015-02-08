function r = rewardGrid(nextState)
    if isequal(nextState,[1,1])
        r = 3;
    elseif isequal(nextState, [4,4])
        r = 3;
    else
        r = -5;
    end
end