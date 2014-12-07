function plotq(Q, cr)

    if nargin > 1
        px = 2;
        py = 2;
    else
        px = 2;
        py = 1;
        pos = get(gcf, 'position');
        set(gcf, 'position', [pos(1:2), pos(4)*2, pos(4)]);
    end

    Q = [Q Q(:,end,:)];
    Q = [Q; Q(end,:,:)];    
    
    [yy, xx] = meshgrid((1:size(Q, 2))-0.5-size(Q, 2)/2, (1:size(Q, 1))-0.5-size(Q, 1)/2);
    
    v = max(Q, [], 3);
    [dummy, p] = max(Q, [], 3);
    
    
    subplot(py, px, 1);
    surf(xx, yy, v);
    view(0, 90);
    axis tight
    colorbar
    title('V(s)');
    xlabel('s(1)');
    ylabel('s(2)');
    
    subplot(py, px, 2);
    surf(xx, yy, p);
    view(0, 90);  
    axis tight
    colorbar
    title('\pi(s)');
    xlabel('s(1)');
    ylabel('s(2)');
    
    if nargin > 1
        subplot(px, py, 3);
        plot(cr);
    end
    
    drawnow;
    