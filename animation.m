function flag = animation(Ql, Qr, N, robot, Pi_star)
    %% Settings
    close all;
    anim_fig = figure;        
    AxesHandle = axes('Parent', anim_fig, 'Position' , [0 0 1 1]);
    colors = [0.7 0.5 0.2;
              1 0 0;
              0 0 1];
 
    %% Create grid world
    grid1 = rectangle('Parent',AxesHandle,'Position', [0,0,1,1]);   
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
    
    
    font =10;
    tx1l = text(0.2,-0.3,'0','FontSize', font);
    tx2l = text(1.2,-0.3,'0','FontSize', font);
    tx3l = text(2.2,-0.3,'0','FontSize', font);
    tx4l = text(3.2,-0.3,'0','FontSize', font);
    tx5l = text(4.2,-0.3,'0','FontSize', font);
    tx6l = text(5.2,-0.3,'0','FontSize', font);
    tx7l = text(6.2,-0.3,'0','FontSize', font);
	
    tx1r = text(0.2,-0.45,'0','FontSize', font);
    tx2r = text(1.2,-0.45,'0','FontSize', font);
    tx3r = text(2.2,-0.45,'0','FontSize', font);
    tx4r = text(3.2,-0.45,'0','FontSize', font);
    tx5r = text(4.2,-0.45,'0','FontSize', font);
    tx6r = text(5.2,-0.45,'0','FontSize', font);
    tx7r = text(6.2,-0.45,'0','FontSize', font);
    
    txIter = text(2.5, 2, '0', 'FontSize', 2*font);
    
    hold on;
    El1 = plotEllipse(0.25,0.125, [6.5, 0.25]);
    El2 = plotEllipse(0.25,0.125, [6.5, 0.75]);
    
    robot = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    ar1 = patch('Parent',AxesHandle, 'FaceColor',colors(2,:));
    ar2 = patch('Parent',AxesHandle, 'FaceColor',colors(3,:));
    
    for i=1:N        

        shape = linkshape();
        ar1shape = arrowshape(0);
        ar2shape = arrowshape(1);
        
        set(robot,'Xdata',shape(1,:),'Ydata',shape(2,:)); 
        set(ar1,'Xdata',ar1shape(1,:),'Ydata',ar1shape(2,:));
        set(ar2,'Xdata',ar2shape(1,:),'Ydata',ar2shape(2,:));
        
        set(tx1l,'String',['L:', num2str((Ql(i,1)))]);
        set(tx2l,'String',['L:', num2str((Ql(i,2)))]);
        set(tx3l,'String',['L:', num2str((Ql(i,3)))]);
        set(tx4l,'String',['L:', num2str((Ql(i,4)))]);
        set(tx5l,'String',['L:', num2str((Ql(i,5)))]);
        set(tx6l,'String',['L:', num2str((Ql(i,6)))]);
        set(tx7l,'String',['L:', num2str((Ql(i,7)))]);

        set(tx1r,'String',['R:', num2str((Qr(i,1)))]);
        set(tx2r,'String',['R:', num2str((Qr(i,2)))]);
        set(tx3r,'String',['R:', num2str((Qr(i,3)))]);
        set(tx4r,'String',['R:', num2str((Qr(i,4)))]);
        set(tx5r,'String',['R:', num2str((Qr(i,5)))]);
        set(tx6r,'String',['R:', num2str((Qr(i,6)))]);
        set(tx7r,'String',['R:', num2str((Qr(i,7)))]);
        
        set(txIter,'String',['Iteration: ',int2str(i)]);
    
        axis equal;  
        
        drawnow
%         pause(0.1);
    end
    %% Objects     
    flag = 1;
    
function shape = linkshape()
%     pos = robot.x;
    pos = 7;
    bot_D = 0.4; % robot diameter
    wheel_D = 0.1; % wheels diameter

    n   = linspace(pi/2,-pi/2,20);
    body    = bot_D*[sin(n);cos(n)];
    wheels = [-0.4 -0.2-wheel_D*sin(n) 0.2-wheel_D*sin(n) 0.4;
              -0.3 -0.3-wheel_D*cos(n) -0.3-wheel_D*cos(n) -0.3];         
    shape = [body, wheels];
    shape = move(shape,[pos-0.7 0.7]);

function arshape = arrowshape(opt)
    if opt == 1
        arshape = [0 .6 .6 .9 .6 .6 0;
                   0 0 -.1 .15 .4 .3 .3];
        arshape = move(arshape,[1.05 0.35]);
    elseif opt == 0
        arshape = [0 .3 .3 .9 .9 .3 .3;
                   .15 -.1 0 0 .3 .3 .4];
        arshape = move(arshape,[1.05 0.35]);
    else
        disp('Option can not be comprehended! Try again 0=left, 1=right)');
    end
function c = move(a, b)
    c(1,:) = a(1,:) + b(1);
    c(2,:) = a(2,:) + b(2);

        