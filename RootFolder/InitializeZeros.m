

        sigmasV=zeros(steps+1,6)
        epsilsV=sigmasV
        times = zeros(steps+1,1)

   if MatType == 6  % J2 plasticity
        %initial history arrays
        epsilsplastV=sigmasV
        betas=sigmasV
        alphas= zeros(steps+1,1)
        TangentStiffnessPlotted=zeros(steps+1,3)
       %% values at time = 0
        eV_n_1=[ 0; 0; 0; 0; 0; 0]
        sig_n_1=zeros(6,1) % assume elastic
        ep_n_1= zeros(6,1)
        a_n_1 = 0
        beta_n_1=zeros(6,1)
        %% fill in the first values for time=0
        TangentStiffnessPlotted(1,:)=zeros(1,3)
        sigmasV(1,:)= sig_n_1;
        epsilsplastV(1,:)= ep_n_1
        betas(1,:)=beta_n_1
        alphas(1)=a_n_1
        times(1)=0


    else 
    
    
    
end
