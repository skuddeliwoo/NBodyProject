function [t, x, p, f] = clientNB()
%clientNB: Client test-program for the NBody simulator.

nb = NBody(2, 2000000, 100000);
% TODO check if x and p need to be of size 1 2 or 2 1, just transpone ".'" if so
nb.addBody([4 1], [0 0], 5);
nb.addBody([0 -1], [0 0], 10);
nb.addBody([-1 4], [0 0], 9000);

[t,x, p, f] = nb.simulate();

% TODO needs to be 3d plot
plot(t,squeeze(x(2,1,:)));
hold on
plot(t,squeeze(x(2,2,:)));
plot(t,squeeze(x(2,3,:)));

parametricplot
end