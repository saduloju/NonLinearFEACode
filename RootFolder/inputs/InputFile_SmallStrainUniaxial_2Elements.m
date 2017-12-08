%%Home work 1
%% NL 691
%Code written by Sunday Aduloju
%Submitted to Prof. Truster
% for CE691
%MatType = 5;  %small strain with strain density function

clear all
clc

MatType = 5; 
th=1; % thickess
ndf=2; %no of degree of freedom
nen=4;  % no of elemental nodes 
NodeTable=[ 0 0 % Coordinates
           0.5 0
            1 0
            0 1
           0.5 1
            1 1];

 ix= [1 2 5 4
     2 3 6 5]; % Nodal arrangements for each elements
 

NodeBC=  [1 1 0
          1 2 0 %Dirichlet bc
          4 1 0
          3 1 0.05
          6 1 0.05];
   numBC=5  ; 
   

 F=0;%1; %if F=0 no nodal load and 
        %F=1 NodeLoad is active
%  NodeLoad=[2 2 1
%              4 2 1];  % Neumann bc] ;
 TotalTime=1 
 steps=2 ;
 
 a=40;
 b=60;
 
 %Program
 

 
 
 %%