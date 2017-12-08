
%% convert strain to matrix form
  EpsilonMat(1,1)=Epsilon(1);
  EpsilonMat(2,2)=Epsilon(2);
  EpsilonMat(1,2)=Epsilon(3)/2  ;
  EpsilonMat(2,1)=EpsilonMat(1,2);
  

%%material property 

aEpsilon = 0.5 * a * (log(1+trace(EpsilonMat)) + (trace(EpsilonMat)/(1+trace(EpsilonMat))));

 
 
 %% Solve for stress
 sigma = [aEpsilon + 3*b*Epsilon(1);
            aEpsilon + 3*b*Epsilon(2);
            1.5 * b * Epsilon(3)];
        
 
        
traceEpsilon = Epsilon(1) + Epsilon(2);

bEpsilon = 0.5*a*((2+traceEpsilon)/((1+traceEpsilon)^2));
C = [bEpsilon+3*b, bEpsilon, 0;
     bEpsilon, bEpsilon+3*b, 0;
       0, 0, 1.5*b];  
        
        
 