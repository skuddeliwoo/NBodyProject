function [t,x,p] = simulate( nb)
%simulate: Simulate N-body problem over duration T
%      divided into res timesteps.

dt = nb.T/nb.res;
t = 0:dt:nb.T;

x = zeros(dim,nb.N,nb.res+1);
p = zeros(dim,nb.N,nb.res+1);


% whaz iz thiz  -  adjust to dim!
G = 1;
Gmm = repmat(G*nb.m,[1 1 nb.N]);
Gmm = Gmm .* permute(Gmm,[1 3 2]);

% adjust to dim!
% Relative positions of bodies at positions r:
relPos = @(r) ...
    repmat(permute(r,[1 3 2]),[1 nb.N 1]) - ...
    repmat(r,[1 1 nb.N]);

% Initialisation:
x(dim,:,1) = nb.xi;
p(dim,:,1) = nb.pi;

% Simulation:
for t = 1:nb.res
    % Simulate timestep t:
    x(dim,:,t+1) = x(dim,:,t) + dt * p(dim,:,t)./nb.m;
    
    diff = relPos(x(dim,:,t));
    absDiff = sqrt(sum(diff.*diff,1));
    invSq = absDiff.^3 + permute(eye(nb.N),[3 2 1]);
    forces = Gmm.*diff ./ invSq;
    forces = sum(forces,3);
    p(dim,:,t+1) = p(dim,:,t) + forces * dt;
end;

end