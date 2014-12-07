function plotv(v)

    v = reshape(v', 1, 25);
    pi = zeros(1, 25);
    for s = 1:25
        actions = zeros(1, 4);
        for a = 1:4
            sp = next(s, a);
            actions(a) = v(sp);
        end
        [dummy, pi(s)] = max(actions);
    end

    v = reshape(v, 5, 5)';
    pi = reshape(pi, 5, 5)';
    
    ax = -sign(pi-3).*rem(pi-1, 2);
    ay = sign(pi-2).*rem(pi, 2);
    
    [x, y] = meshgrid(1:5, 1:5);
    
    quiver(x, y, ax, ay, 0.5);
    hold on
    
    for xx=1:5
        for yy=1:5
            text(xx, yy, num2str(v(yy, xx), '%5.1f'), 'horizontalalignment', 'center', 'backgroundcolor', 'white');
        end
    end
    
    hold off
    axis([0 6 0 6]);
    set(gca, 'xtick', 1:5, 'ytick', 1:5, 'ydir', 'reverse');
    
    title('Gridworld V(s) and \pi(s)');
    xlabel('Column');
    ylabel('Row');
    
end

function sp = next(s, a)
    s = s - 1;
    y = fix(s/5);
    x = s-y*5;

    if y == 0
        if x == 1
            sp = 4*5+1+1;
            return
        elseif x == 3
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

    if x < 0
        x = 0;
    elseif x > 4
        x = 4;
    elseif y < 0
        y = 0;
    elseif y > 4
        y = 4;
    end

    sp = y*5+x+1;
end
    