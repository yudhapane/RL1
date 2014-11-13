function animation(pi)
    %% Settings
    colors = [0.7 0.5 0.2];

    %% Create grid world
    clf;
    grid1 = rectangle('Position', [0,0,1,1]);
    grid2 = rectangle('Position', [1,0,1,1]);
    grid3 = rectangle('Position', [2,0,1,1]);
    grid4 = rectangle('Position', [3,0,1,1]);
    grid5 = rectangle('Position', [4,0,1,1]);
    grid6 = rectangle('Position', [5,0,1,1]);
    grid7 = rectangle('Position', [6,0,1,1]);
    lin1 = line([0.3 0.7], [0.35 0.35]);
    lin2 = line([0.5 0.5], [0.25 0.35]);    
    lin3 = line([0.1 0.9], [0.65 0.65]);
    lin4 = line([0.5 0.5], [0.65 0.85]);    
    lin5 = line([6.25 6.25], [0.25 0.75]);
    lin6 = line([6.75 6.75], [0.25 0.75]); 
    axis equal;
    
    
    %% Objects    
    fig = figure; axis equal;
    AxesHandle = axes('
    AxesHandle = axes('Parent',animationfig,  'Position',[0 0 1 1]);
    link1 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    link2 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    link3 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    link4 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    floor = line('Parent',AxesHandle, 'Color',[0 0 0], 'LineWidth',2);