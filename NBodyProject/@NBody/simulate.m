function [t,x,p] = simulate( nb)
%simulate: Simulate N-body problem over duration T
%      divided into res timesteps.

dt = nb.T/nb.res;
t = 0:dt:nb.T;

x = zeros(nb.dim,nb.N,nb.res+1);
p = zeros(nb.dim,nb.N,nb.res+1);


% TODO whaz iz thiz  -  adjust to nb.dim!
G = 1;
Gmm = repmat(G*nb.m,[1 1 nb.N]);
Gmm = Gmm .* permute(Gmm,[1 3 2]);

% TODO adjust to nb.dim!
% Relative positions of bodies at positions r:
relPos = @(r) ...
    repmat(permute(r,[1 3 2]),[1 nb.N 1]) - ...
    repmat(r,[1 1 nb.N]);

% Initialisation:
x(nb.dim,:,1) = nb.xi;
p(nb.dim,:,1) = nb.pi;

% Simulation:
for n = 1:nb.res
    % Simulate timestep n:
    x(nb.dim,:,n+1) = x(nb.dim,:,n) + dt * p(nb.dim,:,n)./nb.m;
    
    diff = relPos(x(nb.dim,:,n));
    absDiff = sqrt(sum(diff.*diff,1));
    invSq = absDiff.^3 + permute(eye(nb.N),[3 2 1]);
    forces = Gmm.*diff ./ invSq;
    forces = sum(forces,3);
    p(nb.dim,:,n+1) = p(nb.dim,:,n) + forces * dt;
end

end