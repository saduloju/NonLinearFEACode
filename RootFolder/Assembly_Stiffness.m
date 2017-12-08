

function [K_global,Kddz2,d_applied] = Assembly_Stiffness(numel,ix,numnp,ndf,ElemK,NodeBC,NodeBC3);

 %% form global connectivity (NDOFT)
     for i=1:numel
        for g=1:4
            ixg(i,ndf*g)= ix(i,g)*2;
            ixg(i,ndf*g-1)=ix(i,g)*2-1;
         end
     end

  %% form global stiffness matrix   
 Kddy = zeros(numnp*ndf);
    for m=1:numel 

            for i=1:8
                for j=1:8
                    A=ixg(m,i);
                     B=ixg(m,j);
                    Kddy(A,B,m)=ElemK(i,j);
                   Kddz =sum(Kddy,3);
                end
            end

    end
    K_global=Kddz;
    



  %Kddz=ElemK;
  %% find the global node constrained 
  %GNodeConstrained= node constrained by bc
  
  
  
  
  numBC=size(NodeBC,1);
  NodeBC1=NodeBC(:,1);%node
  NodeBC2=NodeBC(:,2);%direction
  %NodeBC3=(NodeBC(:,3)/steps)*loadstep;%assigned displacement
 
  %initiate the applied displacement
  d_applied=zeros(numnp*ndf,1);
  for i=1:numBC
      if NodeBC(i,2)==2
          GNodeConstrained(i)=NodeBC1(i,1)*2;
         d_applied( NodeBC1(i,1)*2)=NodeBC3(i);
      else
         GNodeConstrained(i)=NodeBC1(i,1)*2-1 ;
         d_applied( NodeBC1(i,1)*2-1)=NodeBC3(i);
      end
  end
%    d_applied(5)=d_applied(7)
%   d_applied(7)=0
  %d_applied(5)

   
  
  
%% Remove the rows and the column of the global node constrained by dirichlet bc
%% to reduce the global stiffness matrix (K) to solve Kd=F
  x=Kddz;
         %% remove column
for i = 1:numnp*ndf
  y = x;
   y([GNodeConstrained], :) = [];
  end
 Kddz1=y;
 
        %% remove row
Kddz2=Kddz1;
Kddz2(:,[GNodeConstrained])=[];
%K_global


