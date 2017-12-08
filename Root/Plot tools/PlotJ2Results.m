%% 11/26/2017
% by Sunday Aduloju
%% use to plot the alpha, beta,sigma and the tangent stiffness for 
%J2 plasticity
% this could be used to plot 2D and 3D
% note that Beta_33 is only plotted for 3D and not plotted for 2d

figure(1)
clf(1)
%plot alpha
subplot(2,2,1)
plot(times,alphas)
title('alpha vs time')   
xlabel('t')
ylabel(texlabel('alpha(t)'))
 
 %plot beta components
subplot(2,2,2)
plot(times,betas(:,1),'b--')
hold on
plot(times,betas(:,2),'r--')
hold on
plot(times,betas(:,6),'g--')
% hold on
% plot(times,betas(:,3),'m--')
hold off
legend('\beta 11','\beta 22','\beta 12') % for 2D
% legend('\beta 11','\beta 22','\beta 33','\beta 12')  %%%for 3D
title('beta vs time')   
xlabel('t')
ylabel(texlabel('beta(t)'))

 %plot stress components
subplot(2,2,3)
 plot(times,sigmasV(:,1),'r')    
 hold on
 plot(times,sigmasV(:,2),'b--')
 hold on
 plot(times,sigmasV(:,3),'g-')
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
 plot(times,TangentStiffnessPlotted(:,3),'g--')
legend('C1111','C2222','C1212')
title('C vs time')
xlabel('t')
ylabel(texlabel('C(t)'))



