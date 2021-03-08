function z = ShootingMethod(u0,theta,r0,dt)
%Inputs given to the program are in the form of 
%shootingMethod(initialVelocity,[Angle1;Angle2],[x;y],timeStep)
%This will return the values of the final value and first two guesses as
%well as the co-ordinates of the transition point and the final angle
tic

%compares the two input angles to check if the are the same, if they are
%the same then the second angle is subtracted from 90 to get a new angle.
if theta(2) == theta(1) %
   theta(2) = 90 - theta(2);
end

%calculate the trajectory for the initlal 2 angles
z1=ivpSolver(u0,theta(1),r0,dt);
z2=ivpSolver(u0,theta(2),r0,dt);

E = []; %Empty array to store all of the error values
Xtarget = 2.1;

% calculates the errors in the intial guesses
E1 = z1(4,end)-Xtarget; 
E2 = z2(4,end)-Xtarget;

%adds the calculated erros to the error array
E(1) = E1;
E(2) = E2;

net = 1.5; %height of the net

z3=[]; % empty array to store the current values of the new estimation
k=2; %counter

while abs(E(k))>=0.001 %absolute value (used to ignore negatives) compared to the ideal margin for error
    theta(k+1) = theta(k)-E(k)*(theta(k)-theta(k-1))/(E(k)-E(k-1)); % calculates the new theta value from the error
    
    %check to see if the value is outside the acceptable range, it it is
    %then it is changed to the nearest limit.
    if abs(theta(k+1)) > 90
        theta(k+1) = 90;
    elseif theta(k+1) < 0
        theta(k+1) = 0;
    end
    
    z3 = ivpSolver(u0,theta(k+1),r0,dt); %calculates the new trajectory
    Ek = z3(4,end) - Xtarget; % finds the difference between 
    E(k+1) = Ek ; %stores new error value in error array
    k=k+1; %increment counter
end

t = length(z3)*dt;
tValues = (0:dt:t);
count = 1;
while count<length(z3)
    if tValues(count) == 0.05
        transitionPoint = [z3(4,count);z3(5,count);0];
        break;
    else
        count = count +1;
    end
end
% compares height of shuttle at the net with the height of the net
netHeight = interp1(z3(4,:),z3(5,:),0); 
if netHeight < net
    count = 1; 
    %if the value does hit the net a while loop runs to search the lenght
    %of the array
    while count<length(z3)
            %finds the position in the array where it reaches the net
            if z3(5,count) >= 0
                 %sets the continuing x and z values for the plot to 0
                 z3(4,count:end)=0;
                 z3(5,count:end)=0;
                    break;
            else
                count =count+1; %increments the loop
            end
    end
     %alterts the user to the problem encountered
     disp('The values you entered found an angle that hit the net! Try again.');
     return;
else
end

z=theta(k); %z set equal the the results of the final approximation

plot(z1(4,:),z1(5,:),'b');
hold on
plot(z2(4,:),z2(5,:),'r');
plot(z3(4,:),z3(5,:),'g');
plot(transitionPoint(1),transitionPoint(2),'*');
hold off
xlim([-2.1 4]);
ylim([0 5]);
axis equal
xlabel('Distance, m')
ylabel('Distance, m')
zlabel('Height, m')
legend('Angle 1','Angle 2','Correct Angle','Transition Point');
toc