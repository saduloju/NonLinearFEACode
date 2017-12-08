
% function[ElemK,Bmat,Nmat,wgt] = SolveElemK(ndf,nen,NodeTable,ix,numel)
% %(mateprop,ul,xl,ElemFlag,hr,nh1,nh2,nh3,ndf,ndm,nst,nel,nelP,nen,iprob)

  %% initialize the matrices that constitutes the Bmatrix ; check 
  %concepts and applications of finite element analysis by Robert Cook pg
  %207& 208
  % B=Bm1*Bm2*Bm3
  Bm1=zeros(4,4);
  Bm2=zeros(4,4);  % initialize 
  Bm3=zeros(4,4);
  

for m=1:numel
%for m=1:1
  ElemF= zeros(ndf*nen,1);
  %ElemK = zeros(ndf*nen)
     xl=[NodeTable(ix(m,1:nen),1:2)];
     %%  2x2 Gauss quadrature
     GIntP=4; %number of gauss integration points
     
     lr=[-1 1 -1 1];%sign of varepsilo
     ls=[-1 -1 1 1];%sign of eta  
     
%      lr=[-1 1 1 -1];%sign of varepsilo
%      ls=[-1 -1 1 1];%sign of eta
     g=1/sqrt(3);
     Wgt=1;
     N=zeros(1,nen);
     Nder=zeros(2,nen);
     
     for j=1:GIntP
            for k=1:GIntP;
                 r(k)=g*lr(k);
                s(k)=g*ls(k);
            end
          r=r(j);
          s=s(j);
        
 %% form N matrix (Nmat)
          N(1,1)=0.25*(1-r)*(1-s) ;
          N(1,2)=0.25*(1+r)*(1-s);
          N(1,3)=0.25*(1+r)*(1+s);
          N(1,4)=0.25*(1-r)*(1+s);
       % arramge the N1, N2,N3,N4 in matrix form (pg 206)
            for i=1:GIntP
                Nmat(1,(i-1)*ndf+1)=N(1,i);
                Nmat(2,(i-1)*ndf+2)=N(1,i);
            end
                
          
 %% form B matrix  (Bmat)   
        Nder(1,1)=-(1-s)*0.25;
        Nder(1,2)=(1-s)*0.25;
        Nder(1,3)=(1+s)*0.25;
        Nder(1,4)=-(1+s)*0.25;
        Nder(2,1)=-(1-r)*0.25;
        Nder(2,2)=-(1+r)*0.25;
        Nder(2,3)=(1+r)*0.25;
        Nder(2,4)=(1-r)*0.25;
        Nder;
        
        Jmat=Nder*xl;
        JmatInv=inv(Jmat);
        J=det(Jmat);
        Bm1=[1 0 0 0
             0 0 0 1
             0 1 1 0];
         
         Bm2(1,1)=JmatInv(1,1);
         Bm2(1,2)=JmatInv(1,2);
         Bm2(2,1)=JmatInv(2,1);
         Bm2(2,2)=JmatInv(2,2);
         Bm2(3,3)=JmatInv(1,1);
         Bm2(3,4)=JmatInv(1,2);
         Bm2(4,3)=JmatInv(2,1);
         Bm2(4,4)=JmatInv(2,2);
         
         for i=1:GIntP
         Bm3(1,(i-1)*ndf+1)=Nder(1,i);
         Bm3(3,(i-1)*ndf+2)=Nder(1,i);
         Bm3(2,(i-1)*ndf+1)=Nder(2,i);
         Bm3(4,(i-1)*ndf+2)=Nder(2,i);
         end
         Bmat=Bm1*Bm2*Bm3;
         
         
         
         MatRout
         
         
    ElemK=ElemK+Bmat'*C*Bmat*th*J*Wgt;
 
     end

end

 ElemK;
 
 