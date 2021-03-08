function [z] = ivpSolver(u0,theta,phi,r0,dt)
% ivpSolver    Solve an initial value problem (IVP) and plot the result
% 
%[Z] = ivpSolver(u0,theta,r0,dt) computes the IVP solution using a step 
%size DT, beginning at position r0, where r0 is a 1x3 matrix [x;t;z] and 
%initial velocity u and angle of theta. The solution is output as a matrix 
%of state vectors Z.
    
% Set initial conditions
%total velocity split into xyz components
u = [u0*cosd(theta)*cosd(phi);u0*cosd(theta)*sind(phi);u0*sind(theta)];
%time vector with intial time set to zero
t(1) = 0;
z(:,1) = [u0;u(1);u(2);u(3);r0]; %initial values of array

% Continue stepping until the y component drops below zer/the ground
n=1;
while z(7,n) > 0
    % Increment the time vector by one time step
    t(n+1) = t(n) + dt;
    % Apply Runge Kutta method for one time step
    z(:,n+1) = stepRK(t(n), z(:,n), dt);
    
    n = n+1; %increment counter
end