% Originally created by Jacob
% http://stackoverflow.com/questions/2153768/draw-ellipse-and-ellipsoid-in-matlab

function handle = plotEllipse(a,b,C)

    % range to plot over
    %------------------------------------
    N = 50;
    theta = 0:1/N:2*pi+1/N;

    % Parametric equation of the ellipse
    %----------------------------------------
    state(1,:) = a*cos(theta); 
    state(2,:) = b*sin(theta);

    % Coordinate transform (since your ellipse is axis aligned)
    %----------------------------------------
    X = state;
    X(1,:) = X(1,:) + C(1);
    X(2,:) = X(2,:) + C(2);

    % Plot
    %----------------------------------------
    handle = plot(X(1,:),X(2,:), 'LineWidth',2);
%     hold on;
%     handle = plot(C(1),C(2),'r*');

end