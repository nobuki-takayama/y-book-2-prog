load("./era_parameters.mat")
load("./svd.mat")
num_trial = 1;
theory = 0;

for trial = 1:num_trial
    name = strcat(num2str(trial),'_n',num2str(n),'_k',num2str(k));
    error = @(tp) error_func(tp, At,Ct, Bt1,Bt2)
    tt0 = rand(N/2,N/2);
    pp0 = rand(1,4);
    tp0 = mat2vec_tp(tt0,pp0,N/2,N); 
    Tt = zeros(N, N);
   
    options = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt','TolFun',1e-10);
    [etp,resnorm,residual,exitflag,output] = lsqnonlin(error,tp0,[],[],options)
    
    Tt(N/2+1:end,1:N/2) = vec2mat_tp(etp,N/2);
    Tt(N/2+1:end,N/2+1:end) = ([0 1; 0 0]-Tt(N/2+1:end,1:N/2)*Bt1)*inv(Bt2);
    Tt(1:2,:) = Ct;
    Ah = Tt*At/Tt;
    Bh = Tt*Bt;
    Ch = Ct/Tt;
    Th = [1 0 0 0;
        0 1 0 0;
        0 etp(end) 1 etp(end-2);
        0 etp(end-1) 0 etp(end-3)];
    Af = Th*Ah/Th;
    Bf = Th*Bh;
    Cf = Ch/Th;
    
    if not(exist('estimation_result','dir'))
        mkdir('estimation_result');
    end
    save(strcat('./estimation_result/',num2str(trial),'_est_result.mat'),'etp','resnorm','residual','exitflag','output','tp0','Af', 'Bf', 'Cf','Th','Tt','Ah','Bh', 'Ch')
    
    norma = norm(Af-A);
    normb = norm(Bf-B);
    normc = norm(Cf-C);
    est_p = [-(Af(1,2)^2)/(Af(1,2)*Af(3,1)-Af(3,4)), (Af(1,4)-Af(3,1))/2, (Af(1,4)+Af(3,1))/2];
    save(strcat('./estimation_result/',num2str(trial),'_est_result.mat'),'est_p','-append')
    
    % Simulation with estimated parameters
    r = N;
    xt0 = zeros(r,nin);
    xt = zeros(r,(n+k)*nin);
    xt(:,1:nin) = xt0;
    if theory ~= 1
        for t = ts:te-1
            tid = t-ts+2;
            if tid == 2
                xt(:,(tid-1)*nin+1:(tid-1)*nin+1+nin-1) = Af*xt0+Bf*eye(nin);
            else
                xt(:,(tid-1)*nin+1:(tid-1)*nin+1+nin-1) = Af*xt(:,(tid-2)*nin+1:(tid-2)*nin+1+nin-1);
            end
        end
        yt = Cf*xt;
    elseif theory == 1
        for t = ts:te-1
            tid = t-ts+2;
            if tid == 2
                xt(:,(tid-1)*nin+1:(tid-1)*nin+1+nin-1) = Ap*xt0+Bp*eye(nin);
            else
                xt(:,(tid-1)*nin+1:(tid-1)*nin+1+nin-1) = Ap*xt(:,(tid-2)*nin+1:(tid-2)*nin+1+nin-1);
            end
        end
        yt = Cp*xt;
    end
    
 
    for h = 1:nin
        yt_ts = zeros(nout,n+k);
        ys_ts = zeros(nout,n+k);
        res_ts = zeros(nout,n+k);
        for t = 1:n+k
            yt_resp_all = select_block(t,yt, nin);
            yt_resp_to_key1 = yt_resp_all(graphs,h);
            yt_ts(:,t) = yt_resp_all(:,h); 
            ys_resp_all = select_block(t,ys,nin);
            ys_resp_to_key1 = ys_resp_all(graphs,h);
            ys_ts(:,t) = ys_resp_all(:,h);
            res_ts(:,t) = (yt_ts(:,t)-ys_ts(:,t)).^2;
        end
        
        fname = strcat(name,'_in',num2str(hitkey(h)));
        
        mkdir(fname);
        cd(strcat('./',fname));
        
        ks = ts:te-1;
        for i = 1:nout
            fi = figure
            set(gca,'FontSize',14);
            hold on
            plot(ks, ys_ts(i,1:end),'k-','LineWidth', 1.5)
            plot(ks, yt_ts(i,1:end),'r-.','LineWidth', 1.5)
            hold off
            legend(strcat('data'), 'est.')
            xlabel('$k$','Interpreter','latex')
            yl = strcat('$y(k)_',num2str(i), '$');
            ylabel(yl,'Interpreter','latex');
            title(strcat('Response to the impulse input to x_',num2str((hitkey(h)))));
            if save_flag == 1
                saveas(fi,strcat('y_yt_',num2str(out_vec(i)),'_',fname,'.fig'));
            end
        end
        
        for i = 1:nout
            fi = figure
            plot((ks), res_ts(graphs(i),1:end),'b:','LineWidth', 1.5);
            xlabel('k','Interpreter','latex')
            yl = strcat('$y(k)_',num2str(graphs(i)), '$');
            ylabel(yl,'Interpreter','latex')
            set(gca,'FontSize',14);
            title(strcat('residual on pulse responses given input to x_',num2str(hitkey(h))));
            if save_flag == 1
                saveas(fi,strcat('residual_',num2str(out_vec(graphs(i))),'_',fname,'.fig'));
            end
        end
        
        res_h1 = norm(h1-Pt*Qt);
        res_h2 = norm(h2-Pt*At*Qt);
        res_y = norm(ys_ts-yt_ts)/4;
        res_t = ys_ts-yt_ts;
        res = [res_h1 res_h2 res_y];
        save('residual_era_dynamics.mat','res','res_t');
        cd ../
    end
    close all
end

function y = select_block(integer, ys, nin)
y = ys(:,(integer-1)*nin+1:(integer-1)*nin+nin);
end

function vec = mat2vec_tp(t1,pp,M,N)
vec = zeros(1,(M^2)+N);
for i =1:M
   vec((i-1)*M+1:i*M) = t1(i,1:M);
end
vec(end-3:end) = pp;
end

function mat = vec2mat_tp(tp,M)
mat = zeros(M,M);
for i =1:M
   mat(i,:) = tp((i-1)*M+1:i*M);
end
end
