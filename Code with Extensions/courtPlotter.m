function [box1,box2,box3,box4,box5,line1,line2,net,post1,post2] = courtPlotter()
% creates dimensions for the court
hold on
box1 =[-6.,6.7,6.7,-6.7,-6.7;0,0,0,0,0;-3.05,-3.05,-2.55,-2.55,-3.05];
box2 =[-6.7,6.7,6.7,-6.7,-6.7;0,0,0,0,0;3.05,3.05,2.55,2.55,3.05];
box3 =[-6.7,-5.9,-5.9,-6.7,-6.7;0,0,0,0,0;-3.05,-3.05,3.05,3.05,-3.05];
box4 =[6.7,5.9,5.9,6.7,6.7;0,0,0,0,0;-3.05,-3.05,3.05,3.05,-3.05];
box5 =[-2.02,2.02,2.02,-2.02,-2.02;0,0,0,0,0;-3.05,-3.05,3.05,3.05,-3.05];
line1=[-6.7,-2.02;0,0;0,0];
line2=[6.7,2.02;0,0;0,0];
net = [0,0,0,0,0;1.55,1.55,0.8,0.8,1.55;-3.05,3.05,3.05,-3.05,-3.05];
post1 = [0,0;0.8,0;-3.05,-3.05];
post2 = [0,0;0.8,0;3.05,3.05];
hold off