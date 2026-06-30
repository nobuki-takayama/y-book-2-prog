function [ts, te, dt] = calc_ts_te_dt
global T fs n k sample_flag
if sample_flag == 0
    te = fs*T; % サンプリングの終点
end
if sample_flag == 0
    ts = te-(n+k)+1; % サンプリングの始点
end
if sample_flag == 1
    te = n + k + 1; %n + k -> n + k + 1 : 0524
    ts = 1;
end
dt = 1/fs;
end