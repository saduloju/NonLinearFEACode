 
%12/3/2017
%Sunday Aduloju 
%A script for internal force assembly
%It still need serious debbugging!


function [F_Assembly] = Assembly_Force(ix,m,ndf,F_int);


% F_int=[ 1 ;2;3; 4; 5; 6; 7; 8]
     %% assemble force (updated)
     if m== 1
         for forcenum= 1:4
              F_Assembly((ix(m,forcenum)-1)*ndf+1)=F_int(forcenum*ndf-1);
             F_Assembly((ix(m,forcenum)-1)*ndf+2)=F_int(forcenum*ndf);
         end
      else
          for forcenum= 1:4
              %F_in((ix(m,forcenum)-1)*ndf+1)=F_int(forcenum*ndf-1)
             F_Assembly((ix(m,forcenum)-1)*ndf+2)=F_int(forcenum*ndf);
          end
     end