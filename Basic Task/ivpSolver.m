function [z] = ivpSolver(u0,theta,r0,dt)
% ivpSolver    Solve an initial value problem (IVP) and plot the result
% 
%     [Z] = ivpSolver(u0,theta,r0,dt) computes the IVP solution using a step 
%     size DT, beginning at position r0 and initial velocity u and angle of theta 
%     The solution is output as a matrix of state vectors Z.
    
% Set initial conditions
u = [u0*cosd(theta);u0*sind(theta)];
t(1) = 0;
z(:,1) = [u0;u(1);u(2);r0]; %initial values of array

% Continue stepping until the y component drops below zer/the ground
n=1;
while z(5,n) > 0
    % Increment the time vector by one time step
    t(n+1) = t(n) + dt;
    z=z;
    % Apply Runge Kutta method for one time step
    z(:,n+1) = stepRK(t(n), z(:,n), dt);
    z=z;
    
    n = n+1;
end
% zValues = zeros(1,length(z));
% plot3(z(4,:),zValues(1,:),z(5,:),'b');
%xlim(-2.1 5);
