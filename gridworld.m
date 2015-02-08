classdef gridworld < handle
    properties
        state = [1, 1];
    end
    methods
        function grid = gridworld(state)
            grid.state = state;
        end
        function move(grid, action)
            switch action
                case 0
                    if (grid.state(1) > 1)
                        grid.state = grid.state + [-1, 0];
                    end
                case 1
                    if (grid.state(2) < 4)                    
                        grid.state = grid.state + [0, 1];
                    end
                case 2
                    if (grid.state(1) < 4)                          
                        grid.state = grid.state + [1, 0];
                    end
                case 3
                    if (grid.state(2) > 1)
                        grid.state = grid.state + [0, -1];                                        
                    end
                otherwise
                    error('invalid action');            
            end
        end
    end
end