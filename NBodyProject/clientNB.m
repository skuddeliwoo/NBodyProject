function clientNB()
%clientNB: Client test-program for the NBody simulator.

nb = NBody( 2.25, 10000);
nb.addBody( -1, 0);
nb.addBody( 1, 0);

[t,x] = nb.simulate();
plot( ...
	t,squeeze(x(1,1,:)),'b', ...
	t,squeeze(x(1,2,:)),'r' ...
);
end