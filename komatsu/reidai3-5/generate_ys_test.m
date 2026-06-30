function out = generate_ys_test(nin, nout, n,k,ts, te, dt, structure,varargin)
% y = [u1,...,uN,v1,...,vN]^T
vec = varargin{1};
in_vec = vec(1:nin);
out_vec = vec(nin+1:end);
disp(in_vec)
YS = zeros(nout,nin*(n+k+1));
for q = 1:nin
    D = eval(strcat('structure.key',num2str(in_vec(q),'%02d'))); %D(p,q) data obtained at key q at time p where key i is hit
    for t = ts:te
        tid = t-ts+1;
        D(t,out_vec)
        YS(:,(tid-1)*nin+q)
        YS(:,(tid-1)*nin+q) = D(t,out_vec).'; % [y1,...,yn,...,y(n+k)]
    end
end
disp('YS')
YS
disp('YSend')
out = YS;
end