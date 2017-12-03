

traceEpsilon = Epsilon(1) + Epsilon(2);

bEpsilon = 0.5*a*((2+traceEpsilon)/((1+traceEpsilon)^2));
C = [bEpsilon+3*b, bEpsilon, 0;
     bEpsilon, bEpsilon+3*b, 0;
       0, 0, 1.5*b];