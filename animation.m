function flag = animation()
    %% Settings
    close all;
    anim_fig = figure;        
    AxesHandle = axes('Parent', anim_fig, 'Position' , [0 0 1 1]);
    colors = [0.7 0.5 0.2];
 
    %% Create grid world
    grid1 = rectangle('Parent',AxesHandle,'Position', [0,0,1,1]);   
%     pause
    grid2 = rectangle('Parent',AxesHandle,'Position', [1,0,1,1]);
    grid3 = rectangle('Parent',AxesHandle,'Position', [2,0,1,1]);
    grid4 = rectangle('Parent',AxesHandle,'Position', [3,0,1,1]);
    grid5 = rectangle('Parent',AxesHandle,'Position', [4,0,1,1]);
    grid6 = rectangle('Parent',AxesHandle,'Position', [5,0,1,1]);
    grid7 = rectangle('Parent',AxesHandle,'Position', [6,0,1,1]);
    lin1 = line('Parent',AxesHandle, 'XData', [0.35 0.65],   'YData',[0.35 0.35],'Color',[1 0 0], 'LineWidth',2);
    lin2 = line('Parent',AxesHandle, 'XData', [0.5 0.5],   'YData',[0.25 0.35],'Color',[1 0 0], 'LineWidth',2);    
    lin3 = line('Parent',AxesHandle, 'XData', [0.1 0.9],   'YData',[0.65 0.65],'Color',[1 0 0], 'LineWidth',2);
    lin4 = line('Parent',AxesHandle, 'XData', [0.5 0.5],   'YData',[0.65 0.85],'Color',[1 0 0], 'LineWidth',2);    
    lin5 = line('Parent',AxesHandle, 'XData', [6.25 6.25], 'YData',[0.25 0.75],'Color',[0 0 1], 'LineWidth',2);
    lin6 = line('Parent',AxesHandle, 'XData', [6.75 6.75], 'YData',[0.25 0.75],'Color',[0 0 1], 'LineWidth',2);
    
    hold on;
    El1 = plotEllipse(0.25,0.125, [6.5, 0.25]);
    El2 = plotEllipse(0.25,0.125, [6.5, 0.75]);
    shape = linkshape();
    robot = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    set(robot,'Xdata',shape(1,:),'Ydata',shape(2,:));    
    axis equal;    
    drawnow
    
    %% Objects     
    flag = 1;
    
function shape = linkshape()
    bot_D = 0.4; % robot diameter
    n   = linspace(pi/2,-pi/2,20);
    body    = bot_D*[sin(n);cos(n)];
    wheel_D = 0.1; % wheels diameter
    wheels = [-0.4 -0.2-wheel_D*sin(n) 0.2-wheel_D*sin(n) 0.4;
              -0.3 -0.3-wheel_D*cos(n) -0.3-wheel_D*cos(n) -0.3];         
    shape = [body, wheels];
    shape = move(shape,[6.5 0.5]);

function c = move(a, b)
    c(1,:) = a(1,:) + b(1);
    c(2,:) = a(2,:) + b(2);

        