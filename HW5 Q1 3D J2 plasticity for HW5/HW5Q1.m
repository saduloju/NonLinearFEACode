
% HW5 
%% Question 1
%% Sunday Aduloju
%%  J2 plasticity for 3D
%% given material parameters and strain function 
%% strain function is  e_n_1=e_1*t*[1 0 0;0 1 0;0 0 4/5] + e_2*sin(t)*[0 2 0;2 1 0;0 0 5/3]
%%



E=1200;
v=0.25;
miu= E/(2*(1+v));
k=E/(3*(1-2*v));

% J2 plasticity paramters
K_not=22;
K_prime=2.5;
H_prime=3.5;
K=K_not+K_prime;

% Set epsilon history variables
e_1=0.06;
e_2=0.09;

%time
dt=0.05;
t=0;
T=3;
nstep=T/dt;

%initial history arrays
sigmasV=zeros(nstep+1,6);
epsilsV=sigmasV;
epsilsplastV=sigmasV;
betas=sigmasV;
alphas= zeros(nstep+1,1);
times = zeros(nstep+1,1);
TangentStiffnessPlotted=zeros(nstep+1,3);
%set initial values
e_n_1=e_1*t*[1 0 0;0 1 0;0 0 4/5] + e_2*sin(t)*[0 2 0;2 1 0;0 0 5/3];

    eV_n_1= [e_n_1(1,1); e_n_1(2,2); e_n_1(3,3); 2*e_n_1(2,3); 2*e_n_1(1,3); 2*e_n_1(1,2)];
    trace_n_1= e_n_1(1,1) + e_n_1(2,2)+ e_n_1(3,3);
   % edev_n_1 =eV_n_1 - 1/3*trace_n_1*one; %deviatorial srain
    sig_n_1=zeros(6,1); % assume elastic
    ep_n_1= zeros(6,1);
    a_n_1 = 0;
    beta_n_1=zeros(6,1);



    %%
    TangentStiffnessPlotted(1,:)=zeros(1,3);
    sigmasV(1,:)= sig_n_1;
    %epsilsV(1,:)=  eps_n
    epsilsplastV(1,:)= ep_n_1;
    betas(1,:)=beta_n_1;
    alphas(1)=a_n_1;
    times(1)=0;


for n = 1:nstep
    t = n*dt;
    e_n = e_1*t*[1 0 0;0 1 0;0 0 4/5] + e_2*sin(t)*[0 2 0;2 1 0;0 0 5/3];
    eV_n = [e_n(1,1); e_n(2,2); e_n(3,3); 2*e_n(2,3); 2*e_n(1,3); 2*e_n(1,2)];
  
    [beta_n, a_n,ep_n, sig_n,Cep_n] = J2RadialReturnSolve(K_not,K_prime,H_prime,K,miu,k,a_n_1,beta_n_1,eV_n,ep_n_1,e_n);
 
      beta_n_1 = beta_n;
      a_n_1 = a_n;
      ep_n_1= ep_n;
     
     TangentStiffnessPlotted(n+1,:)=[Cep_n(1,1), Cep_n(2,2), Cep_n(3,3)];
     sigmasV(n+1,:) = sig_n';
     %epsilsV(n+1,:) = eV_n';   %************
     epsilsplastV(n+1,:)= ep_n_1;
     betas(n+1,:)=beta_n_1;
     alphas(n+1)=a_n_1;
     times(n+1) = t;
    
    
    
end


figure(1)
clf(1)
subplot(2,2,1)
plot(times,alphas)
title('alpha vs time')   
xlabel('t')
ylabel(texlabel('alpha(t)'))


 %plot beta components
subplot(2,2,2)
plot(times,betas(:,1),'r')
hold on
plot(times,betas(:,2),'b--')
hold on
plot(times,betas(:,3),'g--')
 hold on
plot(times,betas(:,4),'m--') %uncomment for 2D
hold off
%legend('\beta 11','\beta 22','\beta 12') % for 2D
legend('\beta 11','\beta 22','\beta 33','\beta 12')  %%%for 3D
title('beta vs time')   
xlabel('t')
ylabel(texlabel('beta(t)'))


 %plot stress components
subplot(2,2,3)
 plot(times,sigmasV(:,1),'r')    
 hold on
 plot(times,sigmasV(:,2),'b--')
 hold on
 plot(times,sigmasV(:,3),'g--')
hold off
legend('\sigma 11','\sigma 22','\sigma 12')
title('sigma vs time')
xlabel('t')
ylabel(texlabel('sigma(t)'))


% plot tangent stiffness component
subplot(2,2,4)
 plot(times, TangentStiffnessPlotted(:,1),'r')   
 hold on
 plot(times, TangentStiffnessPlotted(:,2),'b--')
 hold on
 plot(times,TangentStiffnessPlotted(:,3),'g-')
legend('C1111','C2222','C1212')
title('C vs time')
xlabel('t')
ylabel(texlabel('C(t)'))





 
