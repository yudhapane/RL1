function [v, o] = gridworld()

    gamma = 0.9;
    theta = 10^-5;
    observations = 0;
    
    v = policyiteration();

    v = reshape(v, 5, 5)';
    o = observations;

    function v = policyiteration()
        lastpi = zeros(1, 25);
        pi = lastpi + 1;

        while any(lastpi ~= pi)
            lastpi = pi;
            v = evaluate(pi);
            pi = improve(v);
        end
        
        function v = evaluate(pi)
            % TODO: Implement policy evalation
        end

        function pi = improve(v)
            % TODO: Implement policy improvement
        end
    end

    function [r, sp] = observe(s, a)
        s = s - 1;
        y = fix(s/5);
        x = s-y*5;
        
        observations = observations + 1;

        if y == 0
            if x == 1
                r = 10;
                sp = 4*5+1+1;
                return
            elseif x == 3
                r = 5;
                sp = 2*5+3+1;
                return
            end
        end

        switch a
            case 1
                y = y - 1;
            case 2
                x = x + 1;
            case 3
                y = y + 1;
            case 4
                x = x - 1;
        end

        r = 0;

        if x < 0
            r = -1;
            x = 0;
        elseif x > 4
            r = -1;
            x = 4;
        elseif y < 0
            r = -1;
            y = 0;
        elseif y > 4
            r = -1;
            y = 4;
        end

        sp = y*5+x+1;
    end

end
