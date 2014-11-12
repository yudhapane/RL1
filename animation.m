function animation(pi)
    %% Settings
    colors = [0.7 0.5 0.2];

    %% Create grid world
    grid1 = rectangle('Position', [0,0,1,1]);
    grid2 = rectangle('Position', [1,0,1,1]);
    grid3 = rectangle('Position', [2,0,1,1]);
    grid4 = rectangle('Position', [3,0,1,1]);
    grid5 = rectangle('Position', [4,0,1,1]);
    grid6 = rectangle('Position', [5,0,1,1]);
    grid7 = rectangle('Position', [6,0,1,1]);
 
    
    %% Objects    
    fig = figure;
    AxesHandle = axes('
    AxesHandle = axes('Parent',animationfig,  'Position',[0 0 1 1]);
    link1 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    link2 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    link3 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    link4 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:));
    floor = line('Parent',AxesHandle, 'Color',[0 0 0], 'LineWidth',2);