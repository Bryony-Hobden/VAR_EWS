function fn = make_analysis_fig(var, par)
%this function does all the computation neccesary for the VAR comparison
%figure

    sub = par.sub;

    vx = var.v(1,1:sub:end)';
    vy = var.v(2,1:sub:end)';
    vt = var.t(1,1:sub:end)';
 
    if par.plot == 1 || par.plot ==3

        % remove end of trajectory if escapes into relaxation oscillation
        j=1;
        lvt=length(vt);
        thresh=1.1;
        while abs(vx(j))<thresh && abs(vy(j))<thresh && j<lvt
            vvx(j)=vx(j);
            vvy(j)=vy(j);
            vvt(j)=vt(j);
            j=j+1;
        end
    else 
        j=1;
        lvt=length(vt);
        thresh=1.5;
        while abs(vx(j))<thresh && abs(vy(j))<thresh && j<lvt
            vvx(j)=vx(j);
            vvy(j)=vy(j);
            vvt(j)=vt(j);
            j=j+1;
        end 
    end

    dt=par.dt;
    bs=par.blocksize;
    
    x0=10;
    y0=10;
    width=1100;
    height=800;
    set(gcf,'position',[x0,y0,width,height])
    tl = tiledlayout(4,1,'TileSpacing','compact','Padding','compact');
    sgtitle(par.Title);
  
    ax1 = nexttile;
    hold on
    plot(vvt, vvx, color='#2580cf', LineWidth=1.5)
    plot(vvt, vvy, Color='#cf25b8', LineWidth=1.5)
    xline(par.lambda_0/par.r, color = 'black', Linewidth=1.5, LineStyle='--')
    ylabel('System Variable', FontSize=11)
    legend('x','y','Location','eastoutside', FontSize=11)
    hold off

    %is t is 300001 and bs is 5000 then we have 60 blocks
    Nblocks=floor(length(vvt)/bs);

    if Nblocks>=1
        for j=1:Nblocks
            % end of each block
            wvt(j)=vvt(j*bs);
            wvx(j)=vvx(j*bs);
            wvy(j)=vvy(j*bs);
    
            % bs points up to end of block
            winvx=vvx((j-1)*bs+1:j*bs);
            winvy=vvy((j-1)*bs+1:j*bs);
    
            % varm creates a Var(1) model composed of 2 response series 
            % varm(numseries, numlags)
            Mdl = varm(2,1);
    
            %fit to VAR(2) for infered eigenvalue real parts
            [EstMdl,EstSE,logL, Tbl1] = estimate(Mdl,[winvx' winvy']);
            
           
            %creates matrix
            ARmat=cell2mat(EstMdl.AR);
    
            % standard errors matrix
            SEmat = cell2mat(EstSE.AR);
    
            Jac=logm(ARmat)/(sub*dt); %matrix logarithm
            eJ=eigs(Jac);
            eJ1R(j)=real(eJ(1));
            eJ2R(j)=real(eJ(2));
    
            % calculate analytical form of Jacobian
            % using last point of block
            %par.system_jac func calculates jac of rhs
            JacA= feval(par.system_jac, wvt(j),[wvx(j) wvy(j)],par);
        
            eJA=eigs(JacA); %analytical eigs
            eJA1R(j)=real(eJA(1)); %real part 1 analytical eigs
            eJA2R(j)=real(eJA(2)); %real part 2 analytical eigs
            
            % Calculating AR1 for comparison in each j window
            [acfx,lagsx] = autocorr(winvx);
            lag1x(j) = acfx(2);

            [acfy,lagsy] = autocorr(winvy);
            lag1y(j) = acfy(2);

           
            % % MC simulation for Standard Error Calculation
            for k=1:1000
                    %for each each block, we sample 1000 new parameters
                    %matrices from distrubtions based on the standard errors 
                    %of the estimated parameter values in
                    %SEmat. From here we calcuate the associated Jacobians and
                    %eigenvalues. We are then able to obtain a standard error,
                    %and max min value on the eignevalues.

                    for n=1:2 %matrix row number
                        for m=1:2 %matric column number
                            %for each parameter estimation in the matrix, make a
                            %probabiltity distribuiton with the mean = estimated
                            %parameter value and variance = the square of the standard
                            %error
                            %block number, then assigining a pd to each parameter
                            %estimate
                            pd = makedist('Normal', 'mu', ARmat(n,m), 'sigma', SEmat(n,m));
                            %new structure dists to store distributions for
                            %each matrix location in a block
                            dists.("block"+ j).("a" + n +m) = pd;
                            %creates new parameters, sampling from the
                            %distrubutions created above
                            newparams.("block" + j).("sample"+k)(n,m)= ...
                                random(dists.("block"+ j).("a" + n +m),1);
                        end
                    end

                    % for each sample 'k' in block 'j' calculate a new
                    % Jacobian, and associated eigenvalues, and calculate real
                    % parts

                    Jacs.("block" + j).("sample"+k) = ...
                        logm(newparams.("block" + j).("sample"+k))/(sub*dt);
                    Eigs.("block" + j).("sample"+k) = ...
                        eigs(Jacs.("block" + j).("sample"+k));
                    eJ1Rs.("block" + j).("sample"+k) = ...
                        real(Eigs.("block" + j).("sample"+k)(1));
                    eJ2Rs.("block" + j).("sample"+k) = ...
                        real(Eigs.("block" + j).("sample"+k)(2));


                %for each block j convert  all k eigs into arrays to find min
                %and max over each block
                arrayej1s = cell2mat(struct2cell(eJ1Rs.("block" + j)));
                arrayej2s = cell2mat(struct2cell(eJ2Rs.("block" + j)));
                minej1(j) = min(arrayej1s);
                maxej1(j) = max(arrayej1s);

                minej2(j) = min(arrayej2s);
                maxej2(j) = max(arrayej2s);

                %calculate mean and standard deviations over the 1000 samples for each
                %block j
                meanej1(j) = mean(arrayej1s);
                meanej2(j) = mean(arrayej2s);
                stdej1(j) = std(arrayej1s);
                stdej2(j) = std(arrayej2s);

            end
        end
    end
    
    %endpoints in time t want to stop when lambda =0
    endpoint = ceil((par.lambda_0/par.r)/(par.dt*par.blocksize*par.sub));

    if endpoint>length(lag1x)
        "RUN DOES NOT PASS THRESHOLD!";
    end

    lag1x=lag1x(1:endpoint);
    lag1y=lag1y(1:endpoint);
    meanej1=meanej1(1:endpoint);
    meanej2=meanej2(1:endpoint);
    stdej1=stdej1(1:endpoint);
    stdej2=stdej2(1:endpoint);
    wvt =wvt(1:endpoint);
    eJA1R = eJA1R(1:endpoint);
    eJA2R = eJA2R(1:endpoint);
    lag1max=max(lag1x,lag1y);
    lag1min=min(lag1x,lag1y);

    ax2 = nexttile;
    hold on
    yline(0)
    %plot for monte carlo simulation
    plot(wvt, meanej2, LineWidth=1.5, color='blue')
    plot(wvt, meanej1, LineWidth=1.5, color='red') 
    %mean approx equal to original calculated values    
    fill([wvt, fliplr(wvt)], [meanej2-stdej2, fliplr(meanej2+stdej2)], ...
         'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none')
    fill([wvt, fliplr(wvt)], [meanej1-stdej1, fliplr(meanej1+stdej1)], ...
         'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none')
    plot(wvt, meanej1-stdej1, color = 'r', LineWidth=0.5)
    plot(wvt, meanej1+stdej1, color = 'r', LineWidth=0.5)
    plot(wvt, meanej2-stdej2, color = 'b', LineWidth=0.5)
    plot(wvt, meanej2+stdej2, color = 'b', LineWidth=0.5)
    plot(wvt, eJA2R, '*', LineWidth=1.5, Color='#4a048f'); %purple
    plot(wvt, eJA1R, '*', LineWidth=1.5, Color='#ff8c00'); %yellow
    xline(par.lambda_0/par.r, color = 'black', Linewidth=1.5, LineStyle='--')
    legend('','$\mathcal{R}(\mu_1)$ estimate', '$\mathcal{R}(\mu_2)$ estimate','SE $\mathcal{R}(\mu_1)$', 'SE $\mathcal{R}(\mu_2)$', ...
        '', '', '', '', '$\mathcal{R}(\mu_1)$ analytical', '$\mathcal{R}(\mu_2)$ analytical','',...
        'Location','eastoutside', 'FontSize',11, 'Interpreter','latex');
    xlabel('t')
    ylabel('$\mathcal{R}(\mu_i)$', 'Interpreter', 'latex')
    hold off

    ax3 = nexttile;
    hold on
    xlabel('t')
    yline(1)
    xline(par.lambda_0/par.r, color = 'black', Linewidth=1.5, LineStyle='--')
    plot(wvt, lag1x, color='#2580cf', LineWidth=1.5)
    plot(wvt, lag1y, Color='#cf25b8', LineWidth=1.5)
    ylabel('AR(1)')
    legend('', '','x', 'y', 'Location','eastoutside', 'FontSize',11);
    hold off

    ax4 = nexttile;
    hold on
    xlabel('t')
    yline(0)
    xline(par.lambda_0/par.r, color = 'black', Linewidth=1.5, LineStyle='--')
    if par.evplot==1 
        % Nonleading EV

        plot(wvt, meanej1, LineWidth=1.5, color='red') %non-leading eigenvalue
        fill([wvt, fliplr(wvt)], [meanej1-stdej1, fliplr(meanej1+stdej1)], ...
         'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none')
        plot(wvt, meanej1-stdej1, color = 'r', LineWidth=0.5)
        plot(wvt, meanej1+stdej1, color = 'r', LineWidth=0.5)
        plot(wvt, eJA1R, '*', LineWidth=1.5, Color='#ff8c00'); %yellow
        plot(wvt, -(1-lag1min)/(par.dt*sub), color='#2580cf', LineWidth=1.5) %AR(1) x
        legend('', '', '$\mathcal{R}(\mu_2)$ estimate','SE $\mathcal{R}(\mu_2)$', '','',...
            '$\mathcal{R}(\mu_2)$ analytical', '-(1- min AR(1))/(\Delta t * sub)', ...
            'Location','eastoutside', 'FontSize',11, 'Interpreter','latex')
   
    elseif par.evplot==2 
        % Leading EV

        plot(wvt, meanej2, LineWidth=1.5, color='blue')
        fill([wvt, fliplr(wvt)], [meanej2-stdej2, fliplr(meanej2+stdej2)], ...
         'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none')
        plot(wvt, meanej2-stdej2, color = 'b', LineWidth=0.5)
        plot(wvt, meanej2+stdej2, color = 'b', LineWidth=0.5)
        plot(wvt, eJA2R, '*', LineWidth=1.5, Color='#4a048f'); %purple
        plot(wvt, -(1-lag1max)/(par.dt*sub), color='#2580cf', LineWidth=1.5) %AR(1) x
        legend('','', '$\mathcal{R}(\mu_1)$ estimate','SE $\mathcal{R}(\mu_1)$', '','',...
            '$\mathcal{R}(\mu_1)$ analytical','-(1- max AR(1))/(\Delta t * sub)',...
            'Location','eastoutside', 'FontSize',11, 'Interpreter','latex')
    
    else
        "par.evplot not set!";

    end
    ylabel('Value')
   
    hold off
    
    linkaxes([ax1 ax2 ax3 ax4],'x')

    fn = gcf();

end

