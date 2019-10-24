function clientNB()
%clientNB: Client test-program for the NBody simulator.

nb = NBody(2, 2.25, 10000);
% TODO check if x and p need to be of size 1 2 or 2 1, just transpone ".'" if so
nb.addBody([0 1], [0 0]);
nb.addBody([0 -1], [0 0]);

[t,x] = nb.simulate();

% TODO needs to be 3d plot
plot( ...
	t,squeeze(x(1,1,:)),'b', ...
	t,squeeze(x(1,2,:)),'r' ...
);
end