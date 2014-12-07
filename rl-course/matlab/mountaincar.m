function [Q, cr] = mountaincar(Q)
%MOUNTAINCAR Solve the mountain car task with SARSA
%   [Q, CR] = MOUNTAINCAR() solves the mountain car task using the
%   tabular SARSA algorithm. Q is the resulting state-action value
%   function, while CR is the cumulative reward learning curve.
%
%   MOUNTAINCAR(Q) replays the policy defined by Q.

    % Don't show simulation dialog when learning
    if nargin < 1
        sim = odesim('mountaincar.xml', 'nodialog');
    else    
        sim = odesim('mountaincar.xml');
    end

    % Define sensors and actuators
    vel = sim.sensor('robot.base.velocity.y');
    motor = sim.actuator('robot.motorjoint1.torque');

    % TODO (4.3): Define goal distance sensor

    % TODO (4.4): Define position sensor

    % Initialize parameters
    states    = [6 6]; % States in the position and velocity dimensions
    actions   = 3;     % Number of actions
    alpha     = 0.25;  % Learning rate
    gamma     = 0.98;  % Discount rate
    eptime    = 20;    % Length of an episode
    maxpos    = 2.5;   % Maximum position deviation from center
    maxvel    = 8;     % Maximum velocity deviation from zero
    maxtorque = 0.5;   % Maximum applicable torque

    if nargin < 1
        % Initialize Q optimistically
        Q = ones([states actions])*100;
        episodes  = 200;
    else
        % Don't initialize Q, but run slowly
        sim.realtime()
        episodes  = 1;
    end

    % Initialize learning curve
    cr = zeros(1, episodes);

    % Initialize actuation vector
    actuators = sim.actuate();

    for ee=1:episodes
        % Show progress
        disp(ee)

        % Reset simulation to initial condition
        sim.sense();
        sim.reset();
        sim.actuate(sim.actuate());

        for tt=0:sim.step():eptime
            % Read sensors
            sensors = sim.sense();

            % TODO (4.4): Discretize position and velocity into a 2-tuple.
            % sp = [..., ...];

            % TODO (4.3): Calculate reward
            % r = ...;

            % TODO (4.5): Greedy action selection
            % ap = ...;

            % TODO (4.4): Calculate actuation
            % actuators(...) = ...;

            % Actuate
            sim.actuate(actuators);

            % Don't learn on the first step
            if (nargin < 1) && (tt > 0)
                % TODO (4.5): Implement SARSA update rule
            end

            % Prepare for next timestep
            s = sp;
            a = ap;

            % Keep track of learning curve
            cr(ee) = cr(ee) + r;

            % TODO (4.3): Implement termination criterion
            %if ...
            %    disp('terminated');
            %    break
            %end
        end
    end

    % Destroy simulation
    sim.close()
end
