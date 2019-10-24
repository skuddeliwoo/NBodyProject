classdef NBody < handle
    %NBody A system of N interacting bodies moving in
    %   dim dimensions over time T in res timesteps.
    
    methods
        function nb = NBody(dim, T,resolution)
            % Initialise N-body system.
            if nargin < 3
                resolution = 20000;
            end;
            if nargin < 2
                T = 40;
            end;
            
            nb.dim = dim
            nb.N = 0;
            nb.T = T;
            nb.res = resolution;

            nb.xi = zeros(dim,nb.N);
            nb.pi = zeros(dim,nb.N);
            nb.m = zeros(dim,nb.N);
        end
        
        % Add a body to the system:
        function nb = addBody(nb, x, p, m)
            % TODO check if x and p are dim-dimensional
            if nargin < 4
                m = 1;
            end;
            nb.xi = [nb.xi x];
            nb.pi = [nb.pi p];
            nb.m = [nb.m m];
            nb.N = nb.N + 1;
        end;
        
        % Run a simulation:
        [t,x] = simulate(nb);
    end
    
    properties (Access = private)
        dim;        % dimensions
        N;          % Number of bodies
        T;          % Duration of simulation
        res;        % Timestep resolution
        xi;         % Initial position of bodies
        pi;         % Initial momentum of bodies
        m;          % Mass of bodies
    end
    
end

