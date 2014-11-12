% function to calculate reward for given action and state

function r = reward(robot)
    switch robot.x
        case 1
            if (robot.x_prev == 1) 
                r = 0;
            else
                r = 2;
            end
        case 2
            r = 0.5;
        case 3
            r = -0.1;
        case 4
            r = -0.1;
        case 5 
            r = 0.2;
        case 6 
            r = 1;
        case 7
            if (robot.x_prev == 7) % less reward if the robot is already at 7
                r = 2;
            else
                r = 5;
            end
    end
end