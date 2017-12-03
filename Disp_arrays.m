% code written by Sunday aduloju
%modified on 12/2/2017


%d_temp=del_d_steps(:,1)
%delta_d =del_d(:,loadstep)
delta_d=d_turnup;
%d_new=zeros (numnp*ndf,1)%d_applied;

for i =1:numGNodeUnConstrained
    
    d_new(GNodeUnConstrained(i))=delta_d(i);

end



% %if counter ==1
%  d_new=d_applied+d_new;
% % else
% %     d_new=d_new
% % end
% 
% for i=1:length(d_new)/2;
% 
% ul(i,1)=d_new(i*2-1);
% ul(i,2)=d_new(i*2);
%     
%     
%     
% % ul(i,1)=Unew(i*2-1);
% % ul(i,2)=Unew(i*2);
% end
% 
% for i=1:length(d_new)/2
% 
% u_applied(i,1)=d_applied(i*2-1);
% u_applied(i,2)=d_applied(i*2);
%     
%     
%     
% % ul(i,1)=Unew(i*2-1);
% % ul(i,2)=Unew(i*2);
% end
% 
% u_add=ul-u_applied;
%  ElemU=d_new;


ElemU=d_applied + d_new;

%Unew=d_applied+Unew



% format short
% ElemU=zeros(GIntP*ndf,1);
% 
% 
% % for i=1:numel
% %     m=ixg(i,:);
% %      for j=1:8
% %           ElemU(j,i)=Unew(m(j));
% %  
% %        
% %     end
% % %     
% % end
