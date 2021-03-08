function dz = stateDeriv(t,z)
% Calculate the state derivative for modelling te flight of a shuttlecock

%DZ = stateDeriv(T,Z) computes the derivative 
%DZ = [A; D2ZX;D2ZY;DZ2Z;DZ1X;DZ1Y;DZ1Z] of the 
%state vector Z = [V;VX;VY;VZ;X;Y;Z], where X is the horizontal component, 
%Y is the vertical component,and vx is horizontal velocity,vy is vertical
%velocity, v is total velocity.

transition = 50e-3; %time when flight trasitions from unstable to stable
p = 1.225; %density of air in kg/m^3
g = 9.81; %acceleration due to gravity m/s^2
M=5e-3; %mass of shuttle in kg

dz1x = z(2); %x component of velocity
dz1y = z(3); %y component of velocity
dz1z = z(4); %z com ponent of velocity


%V = -hypot(dz1x,dz1y);%calculate the total velocity
V = sqrt(dz1x^2 + dz1y^2 + dz1z^2);

%changes the Area and coefficient of drag depending on the time of the
%flight i.e. before and after transition time
if t < transition
    A=0.012;
    Cd=0.8;
elseif t >= transition
    A=0.009;
    Cd=0.6;
end

%total drag force in opposite direction to velocity
Drag = -(p*A*Cd*(V^2))/2;
theta = asind(dz1z/V);%current angle of shuttle

%tan of 0/0 is an asymptote there fore it will never reach it so phi is set
%to 0 instead
if dz1y ==0 && dz1x == 0
    phi = 0;
else
    %phi value calculated
    phi =  atand(dz1y/dz1x);
end


%calculate the xyz components of the drag force
dz2x = (Drag*cosd(theta)*cosd(phi))/M; % 
dz2y = (Drag*cosd(theta)*sind(phi))/M;
dz2z = (Drag*sind(theta))/M - g;

v = -sqrt(dz2x^2 + dz2y^2 + dz2z^2);%calculate total velocity from x and y components
dz = [v;dz2x;dz2y;dz2z;dz1x;dz1y;dz1z]; %outputs all components