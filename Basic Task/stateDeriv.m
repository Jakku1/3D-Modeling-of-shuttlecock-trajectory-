function dz = stateDeriv(t,z)
% Calculate the state derivative for modelling te flight of a shuttlecock
% 
%     DZ = stateDeriv(T,Z) computes the derivative DZ = [A; D2ZX;D2ZY;DZ1X;DZ1Y] of the 
%     state vector Z = [V;VX;VY;X;Y], where X is the horizontal component, Y is the vertical component,
%     and vx is horizontal velocity,vy is vertical velocity, v is total velocity.

transition = 50e-3; %time when flight trasitions from unstable to stable
p = 1.225; %density of air in kg/m^3
g = 9.81; %acceleration due to gravity m/s^2
M=5e-3; %mass of shuttle in kg

dz1x = z(2); %x component of velocity
dz1y = z(3); %y component of velocity


V = -hypot(dz1x,dz1y);%calculate the total velocity

%changes the Area and coefficient of drag depending on the time of the
%flight i.e. before and after transition time
if t < transition
    A=0.012;
    Cd=0.8;
elseif t >= transition
    A=0.009;
    Cd=0.6;
end
    
Drag = -(p*A*Cd*(V^2))/2;%total drag force in opposite direction to velocity
theta = atand(dz1y/dz1x);%current angle of shuttle

% dz2x = (Drag*dz1x)/(2*M);
% dz2y = (Drag*dz1y)/(2*M) - g;

%calculate the x and y components of the drag force
dz2x = (Drag*cosd(theta))/M; 
dz2y = (Drag*sind(theta))/M - g;

v = -hypot(dz2x,dz2y);%calculate total velocity from x and y components
dz = [v;dz2x;dz2y;dz1x;dz1y]; %outputs all components