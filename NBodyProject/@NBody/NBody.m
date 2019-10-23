classdef NBody < handle
    %NBody A system of N interacting bodies moving in
    %   dim dimensions over time T in res timesteps.
    
    methods
        function nb = NBody(T,resolution)
            % Initialise N-body system.
            if nargin < 2
                resolution = 20000;
            end;
            if nargin < 1
                T = 40;
            end;
            
            nb.N = 0;
            nb.T = T;
            nb.res = resolution;

            nb.xi = zeros(1,nb.N);
            nb.pi = zeros(1,nb.N);
            nb.m = zeros(1,nb.N);
        end
        
        % Add a body to the system:
        function nb = addBody( nb, x, p, m)
            if nargin < 4
                m = 1;
            end;
            nb.xi = [nb.xi x];
            nb.pi = [nb.pi p];
            nb.m = [nb.m m];
            nb.N = nb.N + 1;
        end;
        
        % Run a simulation:
        [t,x] = simulate( nb);
    end
    
    properties (Access = private)
        N;          % Number of bodies
        T;          % Duration of simulation
        res;        % Timestep resolution
        xi;         % Initial position of bodies
        pi;         % Initial momentum of bodies
        m;          % Mass of bodies
    end
    
end

