 
 if F==0
     F=zeros(numnp*ndf,1);
 else
 
      numNodalF=size(NodeLoad,1)  ;
      for i=1:numNodalF
          if NodeLoad(i,2)==1
              NodeF(i)=NodeLoad(i,1)*2-1;

          else
               NodeF(i)=NodeLoad(i,1)*2;
          end
      end

    %% Global Force vector with applied Neumann bc
      F=zeros(numnp*ndf,1);
    for i=1:numNodalF
        F(NodeF(1,i))=NodeLoad(i,3);
    end
  end
    
 
 
 %%reduce the F to the stiffness matrix size (recall that w^h =0 for Known
 %%displacements)
 F([GNodeConstrained])=[];
 
 F_ext=F;
 % 
%  for i=[GNodeConstrained]
% fi=y(:,i)*d_applied(i)
% F=F+fi
% d_applied(i)
%  end
%  
%  F_ext=zeros(3,1);
 