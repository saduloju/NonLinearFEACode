
miu= E/(2*(1+v));
k=E/(3*(1-2*v));


%% This is all placed in in the initialize zeros script
%%
% %initial history arrays
% sigmasV=zeros(steps+1,6)
% epsilsV=sigmasV
% epsilsplastV=sigmasV
% betas=sigmasV
% alphas= zeros(steps+1,1)
% times = zeros(steps+1,1)
% TangentStiffnessPlotted=zeros(steps+1,3)
% 
% eV_n_1=[ 0; 0; 0; 0; 0; 0]
% sig_n_1=zeros(6,1) % assume elastic
% ep_n_1= zeros(6,1)
% a_n_1 = 0
% beta_n_1=zeros(6,1)



%%
% TangentStiffnessPlotted(1,:)=zeros(1,3)
% sigmasV(1,:)= sig_n_1;
% %epsilsV(1,:)=  eps_n
% epsilsplastV(1,:)= ep_n_1
% betas(1,:)=beta_n_1
% alphas(1)=a_n_1
% times(1)=0


    eV_n=[Epsilon; 0;0;0];

    [beta_n, a_n,ep_n, sig_n,Cep_n] = J2RadialReturnSolve(K_not,K_prime,K,H_prime,miu,k,a_n_1,beta_n_1,eV_n,ep_n_1);
 
      beta_n_1 = beta_n;
      a_n_1 = a_n;
      ep_n_1= ep_n;
     
    
    
    sigma= [sig_n(1); sig_n(2); sig_n(3)];
    C= [Cep_n(1,1) Cep_n(1,2) Cep_n(1,3)
        Cep_n(2,1) Cep_n(2,2) Cep_n(2,3)
        Cep_n(3,1) Cep_n(3,2) Cep_n(3,3)] ;
    

     TangentStiffnessPlotted(loadstep+1,:)=[Cep_n(1,1), Cep_n(2,2), Cep_n(3,3)];
     sigmasV(loadstep+1,:) = sig_n';
     %epsilsV(n+1,:) = eV_n';   %************
     epsilsplastV(loadstep+1,:)= ep_n_1;
     betas(loadstep+1,:)=beta_n_1;
     alphas(loadstep+1)=a_n_1;
     times(loadstep+1) = dt*loadstep;
    
    
    
%end
 
%     plot(times,alphas)
%         
%  plot(times,sigmasV(:,1))    
%  hold on
%  plot(times,sigmasV(:,2))
%  hold on
%  plot(times,sigmasV(:,3))

 
 
%  plot(times, TangentStiffnessPlotted(:,1))    
%  hold on
%  plot(times, TangentStiffnessPlotted(:,2))
%  hold on
%  plot(times,TangentStiffnessPlotted(:,3))

 
 
 
 
