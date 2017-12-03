
function [beta_n, a_n,ep_n, sig_n,Cep_n] = J2RadialReturnSolve5(K_not,K_prime,H_prime1,miu,k,a_n_1,beta_n_1,eV_n,ep_n_1);
% K_not=22
% K_prime=2.5
% H_prime1=3.5
K=K_not+K_prime
H_prime=H_prime1+K

one=[1;1;1;0;0;0];


    %eV_n= [e_n(1,1); e_n(2,2); e_n(3,3); 2*e_n(2,3); 2*e_n(1,3); 2*e_n(1,2)]
    trace_n= e_n(1,1) + e_n(2,2)+ e_n(3,3)
    edev_n =eV_n - 1/3*trace_n*one; %deviatorial srain
    s_tr_n=2*miu*diag([1 1 1 0.5 0.5 0.5])*(edev_n-ep_n_1)%%%%%%%%%check sn it is not in the formula
    %s_trV= [ s_tr(1,1); s_tr(2,2); s_tr(3,3); s_tr(2,3); s_tr(1,3); s_tr(1,2)]
    x_tr_n=s_tr_n - beta_n_1
    norm_x_tr_n= sqrt(x_tr_n(1)*x_tr_n(1) + x_tr_n(2)*x_tr_n(2) + x_tr_n(3)*x_tr_n(3) + 2*x_tr_n(4)*x_tr_n(4)... 
                + 2*x_tr_n(5)*x_tr_n(5) + 2*x_tr_n(6)*x_tr_n(6))
  
     %K=K_not+K_prime
     f_tr = norm_x_tr_n -sqrt(2/3)*K *a_n_1; + 4;
     %f_tr=5;
     
     	if f_tr <=1e-12
              a_n =  a_n_1  
              beta_n = beta_n_1
              Cep_n= k*one*one'   +   2*miu*(diag([1 1 1 0.5 0.5 0.5])-1/3*one*one')
              ep_n = ep_n_1  
              %sig_n =  s_tr_n;
              sig_n = k*trace_n + s_tr_n;

              
         else
             n_n= x_tr_n/norm_x_tr_n  %%%check
             d_gam= f_tr/((1+H_prime/(3*miu))*2*miu)
              a_n=a_n_1 + sqrt(2/3)*d_gam
              dH = sqrt(2/3)*(1 - K/H_prime)*H_prime*d_gam;
              %dH = sqrt(2/3)*H_prime*d_gam;
              %beta_n=beta_n_1 %+ sqrt(2/3)*dH*n_n%H_prime*n_n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              beta_n=beta_n_1 + sqrt(2/3)*dH*n_n
              ep_n = ep_n_1 + d_gam*diag([1 1 1 2 2 2])*n_n;
              sig_n = k*trace_n*one + s_tr_n - 2*miu*d_gam*n_n
              %sig_n = k*trace_n*one + s_tr_n - 2*miu*d_gam*n_n
                         
             theta_n = 1 - (2*miu*d_gam)/norm_x_tr_n
             %th_n1=theta_n
%              thetam=theta_n
%              R1 = 1.0d0;
%             R2 = 2.0d0;
%             R3 = 3.0d0;
%             Hb = H_prime;
%             R3G = R3*miu;
%             a=1/(1+Hb/(3*miu))
%             b=(1 - theta_n);
            thetabar_n = 1/(1+H_prime/(3*miu)) - (1 - theta_n);
            %thetabar_n = 1/(1+Hb/3*miu) - (1 - thetam);
           % thetabau_n = R1/(R1+Hb/R3G) - (R1 - th_n1);
            % theta_bar_n = R1/(R1+H_prime/R3*miu) - (R1 - theta_n);
%              thbar_n1 = R1/(R1+Hb/R3G) - (R1 - th_n1);

              Cep1= k*one*one'
              %Cep2= 2*miu * theta_n* (eye(6)-one*one')
              Cep2 = 2*miu*theta_n*(diag([1 1 1 0.5 0.5 0.5]) - 1/3*one*one')
              Cep3 = 2*miu*thetabar_n*n_n *n_n'
              Cep_n=Cep1+Cep2-Cep3
                            
          end
