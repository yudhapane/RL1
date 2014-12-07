function obj = odesim(file, varargin)
%ODESIM Open Dynamics Engine interface
%
%   OBJ = ODESIM(FILE) returns an ODE simulator object.
%   OBJ = ODESIM(..., 'nodialog') suppresses the OpenGL dialog window.
%
%   Members:
%      OBJ.SENSOR Get sensor index.
%         S = OBJ.SENSOR(PATH) returns the sensor index for reading the
%         value of PATH. PATH is of the form
%            <object>.<joint>.<angle|anglerate>
%            which reads the angle or angular velocity of a joint
%         or
%            <object>.<body>.<position|velocity>.<x|y|z>
%            which reads the absolute position or velocity of a body in
%            a certain direction
%         or
%            <obj>.<body>.<x|y|z|azimuth|elevation|distance>@<obj2>.<body2>
%            which reads the relative position, angle or distance of a
%            body in the coordinate frame of body2.
%
%      OBJ.ACTUATOR Get actuator index.
%         A = OBJ.ACTUATOR(PATH) returns the actuator index for setting the
%         value of PATH. PATH is of the form
%         <object>.<joint>.torque
%
%      OBJ.SENSE Retrieve sensor data.
%         V = OBJ.SENSE() Waits for the simulator to finish the last
%         step and returns the sensor values.
%
%      OBJ.ACTUATE Dispatch actuator values.
%         V = OBJ.ACTUATE() returns a vector for setting actuator values.
%         OBJ.ACTUATE(V) writes the actuator values V to the simulator
%         and initiates a simulation step.
%
%      OBJ.RESET Reset simulation
%         OBJ.RESET() resets the simulation to the initial condition.
%         OBJ.RESET(SEED) sets the random seed on which the initial
%         condition is based to SEED.
%
%      OBJ.STEP Simulator step time.
%         S = OBJ.STEP is the simulated time between successive steps.
%
%      OBJ.CLOSE Close dialog.
%         OBJ.CLOSE() closes the OpenGL dialog and destroys the simulation.
%
%   Example:
%      sim = odesim('mountaincar.xml');
%      vel = sim.sensor('robot.base.velocity.y');
%      motor = sim.actuator('robot.motorjoint1.torque');
%      actuators = sim.actuate();
%      for i = 1:sim.step():6
%        sensors = sim.sense();
%        if sensors(vel) > 0
%          actuators(motor) = 0.5;
%        else
%          actuators(motor) = -0.5;
%        end
%        sim.actuate(actuators);
%        pause(sim.step());
%      end
%      sim.close();
%
%   Author:
%      Wouter Caarls <w.caarls@tudelft.nl>

    try
        matode('fini');
    end
    try
        clear matode
    end
    opengl neverselect

    matode('init', file, varargin{:});
    obj.sensor = @sensor;
    obj.actuator = @actuator;
    obj.sense = @sense;
    obj.actuate = @actuate;
    obj.reset = @reset;
    obj.step = @step;
    obj.realtime = @realtime;
    obj.close = @close;

    function close()
        matode('fini');
        clear matode;
    end
    function s = sensor(path)
        if nargin < 1
            error('Sensor path required');
        end
        s = matode('sensor', path);
    end
    function a = actuator(path)
        if nargin < 1
            error('Actuator path required');
        end
        a = matode('actuator', path);
    end
    function v = sense()
        v = matode('sense');
    end
    function v = actuate(values)
        if nargin > 0
            matode('actuate', values);
        else
            v = zeros(1, matode('actuators'));
        end
    end
    function v = step()
        v = matode('step');
    end
    function realtime(val)
        if nargin < 1
            val = 1;
        end
        matode('realtime', val);
    end
    function reset(seed)
        if nargin < 1
            seed = 0;
        end
        matode('reset', seed);
    end
end
