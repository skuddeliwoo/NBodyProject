function [t,x,p,f] = simulate( nb)
%simulate: Simulate N-body problem over duration T
%      divided into res timesteps.

dt = nb.T/nb.res;
t = 0:dt:nb.T;

x = zeros(nb.dim,nb.N,nb.res+1);
p = zeros(nb.dim,nb.N,nb.res+1);
f = zeros(nb.dim,nb.N,nb.res+1);

G = 1;
Gmm = repmat(G*nb.m,[1 1 nb.N]);
Gmm = Gmm .* permute(Gmm,[1 3 2]);

% Relative positions of bodies at positions r:
relPos = @(r) ...
    repmat(permute(r,[1 3 2]),[1 nb.N 1]) - ...
    repmat(r,[1 1 nb.N]);

% Initialisation:
x(:,:,1) = nb.xi;
p(:,:,1) = nb.pi;

% Simulation:
for n = 1:nb.res
    % Simulate timestep n:
    % for rk: p/2 forces/2
    
    diff = relPos(x(:,:,n));
    
    absDiff = sqrt(sum(diff.*diff,1));
    
    invSq = absDiff.^3 + permute(eye(nb.N),[3 2 1]);
    forces = Gmm.*diff ./ invSq;
    forces = sum(forces,3);
    f(:,:,n+1)=forces;
    p(:,:,n+1) = p(:,:,n) + forces * dt;
    
    tmpP = p(:,:,n) + forces * dt/2;
    
    x(:,:,n+1) = x(:,:,n) + dt * tmpP(:,:)./nb.m;
end

end