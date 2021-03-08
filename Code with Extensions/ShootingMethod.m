function [z3,z1,z2,transitionPoint,z] = ShootingMethod(u0,theta,phi,r0,dt)

%Inputs given to the program are in the form of 
%shootingMethod(initialVelocity,[Angle1;Angle2],horizontalAngle,[x;y;z]
%,timeStep)
%This will return the values of the final value and first two guesses as
%well as the co-ordinates of the transition point and the final angle
tic

%calculate the trajectory for the inital 2 angles
z1=ivpSolver(u0,theta(1),phi,r0,dt);
z2=ivpSolver(u0,theta(2),phi,r0,dt);

net = 1.5; % height at top of the net

E = []; %Empty array to store all of the error values
Xtarget = 2.1; % target on other side fo the court

% calculates the errors in the intial guesses
E1 = z1(5,end)-Xtarget; 
E2 = z2(5,end)-Xtarget;

%adds the calculated erros to the error array
E(1) = E1;
E(2) = E2;

z3=[]; % empty array to store the current values of the new estimation
k=2; %counter

%absolute value (used to ignore negatives) compared to the ideal margin for
%error
while abs(E(k))>=0.001 
    % calculates the new theta value from the error
    theta(k+1) = theta(k)-E(k)*(theta(k)-theta(k-1))/(E(k)-E(k-1)); 
    %If the calculated theta value is outside of the range due to two very
    %similar guesses, then it will be set to the nearest limit
    if abs(theta(k+1)) > 90
        theta(k+1) = 90;
    elseif theta(k+1) < 0
        theta(k+1) = 0;
    end
    z3 = ivpSolver(u0,theta(k+1),phi,r0,dt); %calculates the new trajectory
    Ek = z3(5,end) - Xtarget; % error value for newest guess
    E(k+1) = Ek ; %stores new error value in error array
    k=k+1; %increment counter
    %if the shooting method has not found a corrent value within 50
    %attemps, the value cannot be reached by the shuttle, typically takes
    %10 attempts
    if k > 50
        f = msgbox("Shuttle can't reach this part of the court!","Not a valid shot");
        return;
    end
end

% finds the z value at the middle of the court i.e x = 0
netHeight = interp1(z3(5,:),z3(7,:),0); 

% compares height of shuttle at the net with the height of the net
if netHeight < net
    count = 1; 
    %if the value does hit the net a while loop runs to search the lenght
    %of the array
    while count<length(z3)
            %finds the position in the array where it reaches the net
            if z3(5,count) >= 0
                 %sets the continuing x and z values for the plot to 0
                 z3(5,count:end)=0;
                 z3(7,count:end)=0;
                    break;
            else
                count =count+1; %increments the loop
            end
    end
     %alterts the user to the problem encountered
     f = msgbox('The values you entered found an angle that hit the net! Try again.','You hit the net');
     return;
else
    
end


t = length(z3)*dt; %time taken for trajectory found
tValues = (0:dt:t); %array of step size dt till the end of the serve

count = 1;
% while loop searches the entire length of the array
while count<length(z3)
    % finds the iteration where the transition point occurs
    if tValues(count) == 0.05
        %transition point co-ordinates
        transitionPoint = [z3(5,count);z3(6,count);z3(7,count)];
        break;
    else
        count = count +1; %counter incremented
    end
end
      
z=theta(k); %z set equal the the results of the final approximation
toc
