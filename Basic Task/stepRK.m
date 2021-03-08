function znext = stepRK(t,z,dt)
%outputs a vector containing the next iteration of the Runge-Kutta Method.
%takes a vector input of  [time, current z vector values, time step]

%Equations to calculate the state Variables A,B,C,D
dzA = stateDeriv(t, z);
A = dt*dzA;
dzB = stateDeriv(t +dt/2, z+A/2);
B = dt*dzB;
dzC = stateDeriv(t +dt/2, z+B/2);
C = dt*dzC;
dzD = stateDeriv(t+dt, z+C);
D = dt*dzD;

%approximates the next z values
znext = z + 1/6*(A+2*B+2*C+D);