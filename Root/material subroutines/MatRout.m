  

%%%11/26/2017
%material subroutine to calculate stress
%input is required is Epsilon (strain)


if MatType == 5
  %%  material subroutine for stress
        SmallStrain ; % small strain
  elseif MatType == 6
   % trydis
     J2_Plasticity_Subroutine_Sigma; % J2 plasticity
  else
      SmallStrain;
  end