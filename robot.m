% Author: Yudha Pane 
% Created on : 11 Nov 2014 
% Description : Robot class 

%% Define robot class
classdef robot < handle
    properties
        x = 4;
        x_prev = 4;
    end
    methods
        function bot = robot(position)
            bot.x = position;
            bot.x_prev = position;
        end
        function moveLeft(bot) 
            if (bot.x ~= 1)
                bot.x_prev = bot.x;
                bot.x = bot.x-1;                
            else
                bot.x_prev = 1;
            end
        end
        function moveRight(bot)
            if (bot.x ~= 7)
                bot.x_prev = bot.x;
                bot.x = bot.x+1;
            else
                bot.x_prev = 7;
            end
        end
        function act(bot,u) % state transition function
            if u == 1
                bot.moveLeft;
            elseif u == 2
                bot.moveRight;
            end                
        end
    end
end

        
        
        
