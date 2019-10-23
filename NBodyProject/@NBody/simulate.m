function [t,x,p] = simulate( nb)
%simulate: Simulate N-body problem over duration T
%      divided into res timesteps.

dt = nb.T/nb.res;
t = 0:dt:nb.T;
x = zeros(1,nb.N,nb.res+1);
p = zeros(1,nb.N,nb.res+1);
G = 1;
Gmm = repmat(G*nb.m,[1 1 nb.N]);
Gmm = Gmm .* permute(Gmm,[1 3 2]);

% Relative positions of bodies at positions r:
relPos = @(r) ...
    repmat(permute(r,[1 3 2]),[1 nb.N 1]) - ...
    repmat(r,[1 1 nb.N]);

% Initialisation:
x(1,:,1) = nb.xi;
p(1,:,1) = nb.pi;

% Simulation:
for n = 1:nb.res
    % Simulate timestep n:
    x(1,:,n+1) = x(1,:,n) + dt * p(1,:,n)./nb.m;
    
    diff = relPos(x(1,:,n));
    absDiff = sqrt(sum(diff.*diff,1));
    invSq = absDiff.^3 + permute(eye(nb.N),[3 2 1]);
    forces = Gmm.*diff ./ invSq;
    forces = sum(forces,3);
    p(1,:,n+1) = p(1,:,n) + forces * dt;
end;

end