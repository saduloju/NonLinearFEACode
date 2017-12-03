%%Home work 1
%% NL 691
% written by Sunday Aduloju
% 2d linear Quadrilateral element
% can solve for both plane strin and plane stress
% PSPS = 1 plane stress=1,when PSPS = 2 plane strain

numel=size(ix,1); % Total no of elements in the domain
numnp=size(NodeTable,1); % total no of nodes in the domain
 
%%
ElemK = zeros(ndf*nen);
 

 
NodeBC1=NodeBC(:,1);%node
NodeBC2=NodeBC(:,2);%direction
 
   for i=1:numBC
      if NodeBC(i,2)==2
          GNodeConstrained(i)=NodeBC1(i,1)*2;
%           d( NodeBC1(i,1)*2)=NodeBC3(i)
      else
         GNodeConstrained(i)=NodeBC1(i,1)*2-1 ;
        %  d( NodeBC1(i,1)*2-1)=NodeBC3(i)
      end
  end
  
 %% obtain the associated rows for constrained and unconstrained nodes
GNode=[1:numnp*ndf];
GNodeConstrained;
%GNodeUnConstrained

x=GNode;
  for i = 1:numnp*ndf
  y = x;
   y(:,[GNodeConstrained]) = [];
  end
GNodeUnConstrained=y;
numGNode=length(GNode);
numGNodeConstrained=length(GNodeConstrained);
numGNodeUnConstrained=length(GNodeUnConstrained);


InitializeZeros
DispList=zeros(numnp*ndf,steps);

dt=TotalTime/steps

for loadstep = 1:steps
    
      disp('loadstep ')
                disp(loadstep)


NodeBC3=(NodeBC(:,3)/steps)*loadstep;

  d_applied=zeros(numnp*ndf,1);
  for i=1:numBC
      if NodeBC(i,2)==2
          GNodeConstrained(i)=NodeBC1(i,1)*2;
         d_applied( NodeBC1(i,1)*2)=NodeBC3(i);
      else
         GNodeConstrained(i)=NodeBC1(i,1)*2-1 ;;
         d_applied( NodeBC1(i,1)*2-1)=NodeBC3(i);
      end
  end

ElemU = d_applied;


for m=1:numel
% % for m=1:1
%   ElemF= zeros(ndf*nen,1);
%   ElemK = zeros(ndf*nen)
% %      xl=[NodeTable(ix(m,1:nen),1:2)]
 xl=[NodeTable(ix(m,1:nen),1:2)];
end


 F_internal_Solve


F_External_Solve;


%    
%   
 R_not=F_ext-F_int;
 
 normRnot= norm(R_not);
 EpsilMultiplier=1e-12;
 normR=normRnot;


X = sprintf('R_not norm is %s and the EpsilMultiplier is  %d ',normRnot,EpsilMultiplier);
disp(X)


  counter=0;
  d_new=zeros(numnp*ndf,1);
%   d_last=zeros(numnp*ndf,1);
  d_turnup=zeros(numGNodeUnConstrained,1);
  EpsilMultiplier=1e-12
 while normR >EpsilMultiplier*normRnot
  d_turnup;
        % Material_SubroutineTangent
%           Material_Subroutine_Sigma
           ElemRout
           
          SolveElemK
          %del_d=normR/ElemK
          Stiffness_Assembly  

        %%  Displacement increment
          del_d=Kddz2\ (F_ext-F_int);
          d_turnup=del_d + d_turnup;
     %%     solve for the new displacement  
            d_new=zeros(numnp*ndf,1);
           Disp_arrays
             %d_turnup=del_d
%         if counter ==1
%             xl=xl+ul;
%         else
%               xl=xl+u_add;
%          end

        %xl=xl


%%
F_internal_Solve
%%
        F_External_Solve
 %%
 %%
        
         R=F_ext-F_int;

         normR= norm(R);

        counter=counter+1;

        fprintf('iteration #%d\n', counter);

%                 disp('Residual ')
%                 disp(R)
                disp('Residual norm ')
                disp(normR)
                

         end
  d_turnup;
  Disp_arrays
  DispList(:,loadstep)=ElemU
  
    disp('Axial Stress =')
    disp(sigma(1))
%   
end




