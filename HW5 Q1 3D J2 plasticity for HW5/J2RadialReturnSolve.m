
function [beta_n, a_n,ep_n, sig_n,Cep_n] = J2RadialReturnSolve(K_not,K_prime,K,H_prime,miu,k,a_n_1,beta_n_1,eV_n,ep_n_1,e_n);

 
% K_not=22
% K_prime=2.5
% H_prime=3.5
% K=K_not+K_prime


%%
one=[1;1;1;0;0;0]; %For bold letter 1
ID_stress= diag([1 1 1 0.5 0.5 0.5]); %Identity mapping of strain to stress
ID_strain= diag([1 1 1 2 2 2]); %Inverse identity mapping of stress to strain
%%

    %eV_n= [e_n(1,1); e_n(2,2); e_n(3,3); 2*e_n(2,3); 2*e_n(1,3); 2*e_n(1,2)]
    trace_n= e_n(1,1) + e_n(2,2)+ e_n(3,3);
    
    edev_n =eV_n - 1/3*trace_n*one; %deviatorial srain
    
    s_tr_n=2*miu*ID_stress*(edev_n-ep_n_1);%Trial stress
    
    x_tr_n=s_tr_n - beta_n_1;

norm_x_tr_n = sqrt(   x_tr_n(1)*x_tr_n(1) +    x_tr_n(2)*x_tr_n(2) ...
             +    x_tr_n(3)*x_tr_n(3) + 2*x_tr_n(4)*x_tr_n(4) ...
             + 2*x_tr_n(5)*x_tr_n(5) + 2*x_tr_n(6)*x_tr_n(6));
%      norm_x_tr_n = norm (x_tr_n) ;       
  
     f_tr = norm_x_tr_n -sqrt(2/3)*(K_not + K_prime *a_n_1); 
   
     
     	if f_tr <=1e-12
              a_n =  a_n_1  ;
              beta_n = beta_n_1;
              %Cep_n= k*one*one'   +   2*miu*(diag([1 1 1 1 1 1])-1/3*one*one');
              Cep_n= k*one*one'   +   2*miu*(ID_stress-1/3*one*one');
              ep_n = ep_n_1  ;
              sig_n = k*trace_n*one + s_tr_n;

              
         else
             n_n= x_tr_n/norm_x_tr_n  ;
             d_gam= f_tr/((1+(H_prime+K_prime)/(3*miu))*2*miu);
              a_n=a_n_1 + sqrt(2/3)*d_gam;
              deltaH = sqrt(2/3)*H_prime*d_gam;
            
             d_gam= f_tr/((1+(H_prime+K_prime)/(3*miu))*2*miu);
              a_n=a_n_1 + sqrt(2/3)*d_gam;
              deltaH = sqrt(2/3)*H_prime*d_gam;
              
              %% you could use the formula below with B for 0<B>1
              %deltaH = sqrt(2/3)*(1 - B)*H_prime*d_gam; 
              %%
              beta_n=beta_n_1 + sqrt(2/3)*deltaH*n_n;
              %beta_n=beta_n_1 + sqrt(2/3)*H_prime*n_n
              ep_n = ep_n_1 + d_gam*diag([1 1 1 2 2 2])*n_n;
              sig_n = k*trace_n*one + s_tr_n - 2*miu*d_gam*n_n;
                        
             theta_n = 1 - (2*miu*d_gam)/norm_x_tr_n;
             thetabar_n = 1/(1+(H_prime+K_prime)/(3*miu)) - (1 - theta_n);
             %thetabar_n = 1/(1+H_prime/(3*miu)) - (1 - theta_n);

              Cep1= k*one*one';
              Cep2 = 2*miu*theta_n*(ID_stress - 1/3*one*one');
              Cep3 = 2*miu*thetabar_n*(n_n *n_n');
              Cep_n=Cep1+Cep2-Cep3       ; 
              beta_n=beta_n_1 + sqrt(2/3)*deltaH*n_n;
              ep_n = ep_n_1 + d_gam*diag([1 1 1 2 2 2])*n_n;
              sig_n = k*trace_n*one + s_tr_n - 2*miu*d_gam*n_n;
                        
             theta_n = 1 - (2*miu*d_gam)/norm_x_tr_n;
             thetabar_n = 1/(1+(H_prime+K_prime)/(3*miu)) - (1 - theta_n);
             
              Cep1= k*one*one';
              Cep2 = 2*miu*theta_n*(ID_stress - 1/3*one*one');
              Cep3 = 2*miu*thetabar_n*(n_n *n_n');
              
              Cep_n=Cep1+Cep2-Cep3;
                            
          end
